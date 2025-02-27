import re
from dataclasses import dataclass
from typing import List
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

    pos = 0
    for match in pattern.finditer(content):
        start, end = match.span()
        if start > pos:
            text = content[pos:start].strip()
            if text:
                A.append(Block(position=len(A) + 1, type="text", content=text))
        if match.group("title"):
            A.append(
                Block(position=len(A) + 1, type="title", content=match.group("title"))
            )
        elif match.group("table"):
            A.append(
                Block(position=len(A) + 1, type="table", content=match.group("table"))
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
                Block(position=len(A) + 1, type="image", content=match.group("img"))
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
                Block(position=len(A) + 1, type="link", content=match.group("link"))
            )
        pos = end
    if pos < len(content):
        text = content[pos:].strip()
        if text:
            A.append(Block(position=len(A) + 1, type="text", content=text))
    return A


def split_text_blocks(A: List[Block]) -> List[Block]:
    new_blocks = []

    def adjust_sentences_length(sentence_list, min_length=512):
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
                while next_index < total_index and len(current_sentence) < min_length:
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
            sentence_parts = adjust_sentences_length(sentence_unit)
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
        placeholder = f"⚛️{placeholder_counter}⚛️"
        placeholders[placeholder] = match.group()
        placeholder_counter += 1
        return placeholder

    return inline_formula_pattern.sub(replacer, text)


def concurrent_translate(
    A: List[Block], translate: callable, thread: int
) -> List[Block]:
    placeholders = {}
    placeholder_counter = 1

    def process_block(block: Block):
        nonlocal placeholder_counter
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
            translated_content = replace_inline_formula(
                block.content, placeholder_counter, placeholders
            )
            placeholder_counter += len(placeholders)
            translated = translate(
                translated_content, prev_block or "", next_block or ""
            )
            for placeholder, formula in placeholders.items():
                # Remove spaces between $ and formula content
                formula = re.sub(r"\$\s*(.*?)\s*\$", r"$\1$", formula)
                translated = translated.replace(placeholder, f" {formula} ")
            if "⚛️" in translated:
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
    return A


def combine_blocks(A: List[Block]) -> str:
    combined = []
    special_types = ["title", "table", "block_formula", "image", "link_image", "link"]
    for i, block in enumerate(A):
        # Add newline before special blocks
        if i != 0 and block.type in special_types:
            if block.type == "title" and A[i - 1].type == "title":
                combined.append("\n\n")
            if block.type != A[i - 1].type:
                combined.append("\n\n")

        combined.append(block.content)

        # Add newline after special blocks
        if block.type in special_types:
            if block.type == "block_formula" and A[i + 1].type == "block_formula":
                combined.append("\n\n")
            if block.type != A[i + 1].type:
                combined.append("\n\n")

    return "".join(combined)


def fix_dollar_signs(output_markdown: str) -> str:
    # remove_space_in_dollar_pattern = re.compile(r"\$\s*(.*?)\s*\$")
    # output_markdown = remove_space_in_dollar_pattern.sub(r"$\1$", output_markdown)
    output_markdown = re.sub(r"\$\s*(.*?)\s*\$", r"$\1$", output_markdown)
    return output_markdown


def process_markdown(input_markdown: str, translate: callable, thread: int = 10) -> str:
    # Process blocks
    blocks = split_markdown(input_markdown)
    blocks = split_text_blocks(blocks)
    blocks = concurrent_translate(A=blocks, translate=translate, thread=thread)
    output_markdown = combine_blocks(blocks)
    # 移除函数多余空格
    output_markdown = fix_dollar_signs(output_markdown)
    return output_markdown
