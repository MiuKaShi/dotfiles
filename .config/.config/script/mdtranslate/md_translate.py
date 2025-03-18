import re
import copy
from dataclasses import dataclass
from typing import List, Tuple
import concurrent.futures
from tqdm import tqdm
from sentence_splitter import SentenceSplitter


@dataclass
class Block:
    position: int
    sub_position: int = 1
    type: str = ""
    content: str = ""


def split_markdown(content: str) -> List[Block]:
    A = []
    block_formula_pattern = (
        r"(?P<block_formula>"
        r"^ *\$\$ *$\n"  # 开头 $$ 独占一行
        r"([\s\S]*?)\n"  # 中间内容
        r"^ *\$\$ *$"  # 结尾 $$ 独占一行
        r")"
    )
    pattern = re.compile(
        r"(?P<title>^#{1,6} .+?$)|"
        r"(?P<table><table[\s\S]*?<\/table>)|"
        rf"{block_formula_pattern}|"
        r'(?P<img><img src="[^"]+"\/?>)|'
        r"(?P<link_img>!\[.*?\]\([^\)]+\))|"
        r"(?P<link>\[[^\]]+\]\([^\)]+\))",
        flags=re.MULTILINE,
    )

    # 拆分text内换行部分
    def split_text_blocks(text: str):
        parts = text.split("\n\n")
        for part in parts:
            part = part.strip()
            if part:
                A.append(Block(position=len(A) + 1, type="text", content=part))

    pos = 0
    for match in pattern.finditer(content):
        start, end = match.span()
        if start > pos:
            text = content[pos:start].strip()
            if text:
                # A.append(Block(position=len(A) + 1, type="text", content=text))
                split_text_blocks(text)
        if match.group("title"):
            A.append(
                Block(
                    position=len(A) + 1,
                    type="title",
                    content=match.group("title"),
                )
            )
        elif match.group("table"):
            A.append(
                Block(
                    position=len(A) + 1,
                    type="table",
                    content=match.group("table"),
                )
            )
        elif match.group("block_formula"):
            A.append(
                Block(
                    position=len(A) + 1,
                    type="block_formula",
                    content=match.group("block_formula"),
                )
            )
        elif match.group("img"):
            A.append(
                Block(
                    position=len(A) + 1,
                    type="image",
                    content=match.group("img"),
                )
            )
        elif match.group("link_img"):
            A.append(
                Block(
                    position=len(A) + 1,
                    type="link_image",
                    content=match.group("link_img"),
                )
            )
        elif match.group("link"):
            A.append(
                Block(
                    position=len(A) + 1,
                    type="link",
                    content=match.group("link"),
                )
            )
        pos = end
    if pos < len(content):
        text = content[pos:].strip()
        if text:
            A.append(Block(position=len(A) + 1, type="text", content=text))
    return A


def split_text_blocks(
    A: List[Block], min_length: int
) -> Tuple[List[Block], int]:
    new_blocks = []

    def adjust_sentences_length(sentence_list, min_length):
        new_sentence = []
        index = 0
        total_index = len(sentence_list)

        while index < total_index:
            current_sentence = sentence_list[index]
            # 添加满足长度的元素
            if len(current_sentence) >= min_length:
                new_sentence.append(current_sentence)
                index += 1
            else:
                # 合并后续元素直至达到最小长度或遍历完
                next_index = index + 1
                while (
                    next_index < total_index
                    and len(current_sentence) < min_length
                ):
                    current_sentence += " " + sentence_list[next_index]
                    next_index += 1
                new_sentence.append(current_sentence)
                index = next_index  # 跳转至未处理元素
        return new_sentence

    splitter = SentenceSplitter(
        language="en", non_breaking_prefix_file="non_breaking_prefixes.txt"
    )
    for block in A:
        if block.type == "text":
            text = block.content
            sentence_unit = splitter.split(text=text)
            sentence_parts = adjust_sentences_length(sentence_unit, min_length)
            for content in sentence_parts:
                new_blocks.append(
                    Block(
                        position=block.position,
                        sub_position=len(new_blocks) + 1,
                        type="text",
                        content=content,
                    )
                )
        else:
            new_blocks.append(block)
    return new_blocks


def replace_inline_formula(
    text: str, placeholder_counter: int, placeholders: dict
) -> str:
    inline_formula_pattern = re.compile(r"\$[^$]+\$")

    def replacer(match):
        nonlocal placeholder_counter
        placeholder = f"🐱{placeholder_counter}🐱"
        placeholders[placeholder] = match.group()
        placeholder_counter += 1
        return placeholder

    return inline_formula_pattern.sub(replacer, text)


def concurrent_translate(
    A: List[Block], translate: callable, thread: int
) -> Tuple[List[Block], dict]:
    placeholders = {}
    token_counter = {"sent_tokens": 0, "received_tokens": 0}
    placeholder_counter = 1

    def process_block(block: Block):
        nonlocal placeholder_counter
        nonlocal token_counter
        if block.type in [
            "title",
            "table",
            "block_formula",
            "image",
            "link_image",
            "link",
        ]:
            return block
        elif block.type == "text":
            prev_block = None
            next_block = None
            if block.sub_position > 1:
                for b in reversed(A[: A.index(block)]):
                    if (
                        b.position == block.position
                        and b.sub_position == block.sub_position - 1
                    ):
                        prev_block = b.content
                        break
            else:
                for b in reversed(A[: A.index(block)]):
                    if b.position == block.position - 1:
                        prev_block = b.content
                        break
            for b in A[A.index(block) + 1 :]:
                if (
                    b.position == block.position
                    and b.sub_position == block.sub_position + 1
                ):
                    next_block = b.content
                    break
                elif b.position == block.position + 1:
                    next_block = b.content
                    break
            # 处理行内公式替换
            translated_content = replace_inline_formula(
                block.content, placeholder_counter, placeholders
            )
            placeholder_counter += len(placeholders)
            # 调用翻译函数，返回翻译后的文本以及累计 tokens 数
            translated, tokens = translate(
                translated_content, prev_block or "", next_block or ""
            )
            # 合并 token_counter
            token_counter["sent_tokens"] += tokens["sent_tokens"]
            token_counter["received_tokens"] += tokens["received_tokens"]
            # 移除换行符
            translated = re.sub(r"\n", "", translated)
            for placeholder, formula in placeholders.items():
                # Remove spaces $ 2 $ to $2$
                formula = re.sub(r"\$\s*(.*?)\s*\$", r"$\1$", formula)
                translated = translated.replace(placeholder, f" {formula} ")
                # 移除连续的多余空格
                translated = re.sub(r"\s+", " ", translated)
            if "🐱" in translated:
                sentences = re.split(r"(?<=[。？！.!?;；])", block.content)
                translated_sentences = [translate(s, "", "") for s in sentences]
                translated = "".join(translated_sentences)
            block.content = translated
            return block
        return block

    total_blocks = len(A)
    with concurrent.futures.ThreadPoolExecutor(max_workers=thread) as executor:
        A = list(
            tqdm(
                executor.map(process_block, A),
                total=total_blocks,
                desc="Translating blocks",
                unit="block",
            )
        )
    return A, token_counter


def combine_blocks(A: List[Block], raw: List[Block], style: str) -> str:
    combined = []
    i = 0
    count = 0
    while i < len(A):
        # zh-en 混排
        if style == "zh-en":
            if A[i].type == "text":
                count += 1
                if count == 1:
                    combined.append("> " + raw[i].content)
                else:
                    combined.append(raw[i].content)
                if i == len(A) - 1 or A[i].position != A[i + 1].position:
                    start = i - count + 1
                    end = i + 1
                    combined.append("\n\n")
                    for j in range(start, end):
                        combined.append(A[j].content)
                    count = 0  # 重置计数器
            else:
                combined.append(raw[i].content)
        # en-zh 混排
        elif style == "en-zh":
            if A[i].type == "text":
                if A[i].type == A[i - 1].type:
                    combined.append("\n\n")
                    combined.append(raw[i].content)
                    combined.append("\n\n")
                else:
                    combined.append(raw[i].content)
                    combined.append("\n\n")
                combined.append("> " + A[i].content)
            else:
                combined.append(raw[i].content)
        # zh 排
        elif style == "zh":
            combined.append(A[i].content)

        # 空行
        if i < len(A) - 1 and A[i].position != A[i + 1].position:
            combined.append("\n\n")
        i += 1

    return "".join(combined)


def fix_dollar_signs(output_markdown: str) -> str:
    # remove_space_in_dollar_pattern = re.compile(r"\$\s*(.*?)\s*\$")
    # output_markdown = remove_space_in_dollar_pattern.sub(r"$\1$", output_markdown)
    output_markdown = re.sub(r"\$\s*(.*?)\s*\$", r"$\1$", output_markdown)
    return output_markdown


def process_markdown(
    input_markdown: str,
    translate: callable,
    style: str,
    thread: int = 10,
    min_length: int = 1024,
) -> Tuple[str, int]:
    # Process blocks
    blocks = split_markdown(input_markdown)
    blocks = split_text_blocks(blocks, min_length=min_length)
    raw_blocks = copy.deepcopy(blocks)
    blocks, tokens = concurrent_translate(
        A=blocks, translate=translate, thread=thread
    )
    output_markdown = combine_blocks(blocks, raw=raw_blocks, style=style)
    # 移除函数多余空格
    output_markdown = fix_dollar_signs(output_markdown)
    return output_markdown, tokens
