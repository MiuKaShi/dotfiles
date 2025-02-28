import json
import tiktoken
from typing import Tuple
from openai import OpenAI


def deepseek_translate(
    api_key: str,
    base_url: str = "https://api.deepseek.com",
    src: str = "English",
    dest: str = "中文",
    model="deepseek-chat",
    tempterature=0.8,
    system_prompt: str = None,
    input_prompt: str = None,
    extra_type="markdown",
) -> callable:
    if system_prompt is None:
        system_prompt = "You are a specialized language model trained to translate Markdown documents while preserving their formatting. Your task is to translate a given Markdown text from {{src}} to {{dest}}, ensuring academic precision, clarity, and logical consistency."
    if input_prompt is None:
        input_prompt = """
The Markdown text to translate:
"""

    if "{{text}}" not in input_prompt:
        raise ValueError("input_prompt must contain {{text}} placeholder")

    def count_tokens(string: str, model_name: str = "cl100k_base") -> int:
        encoding = tiktoken.get_encoding(model_name)
        return len(encoding.encode(string))

    def translate(text: str, prev_text: str, next_text: str) -> Tuple[str, dict]:
        retry_count = 0
        max_retries = 10

        while retry_count <= max_retries:
            try:
                client = OpenAI(api_key=api_key, base_url=base_url)
                messages = [
                    {
                        "role": "system",
                        "content": system_prompt.replace("{{src}}", src).replace(
                            "{{dest}}", dest
                        ),
                    },
                    {
                        "role": "user",
                        "content": input_prompt.replace("{{prev_text}}", prev_text)
                        .replace("{{dest}}", dest)
                        .replace("{{text}}", text)
                        .replace("{{next_text}}", next_text),
                    },
                ]

                response = client.chat.completions.create(
                    model=model,
                    messages=messages,
                    temperature=tempterature,
                    stream=False,
                )
                result = response.choices[0].message.content
                # get the send and receive tokens
                sent_tokens = sum(count_tokens(msg["content"]) for msg in messages)
                received_tokens = count_tokens(result)
                tokens = {
                    "sent_tokens": sent_tokens,
                    "received_tokens": received_tokens,
                }

                if extra_type == "json":
                    try:
                        translated = json.loads(result)["translated"]
                    except Exception as e:
                        print(f"Having trouble extracting JSON: {e}")
                        translated = result
                    return translated, tokens
                elif extra_type == "markdown":
                    try:
                        translated = result[
                            result.find("```") + 3 : result.rfind("```")
                        ]
                    except Exception as e:
                        print(f"Having trouble extracting markdown: {e}")
                        translated = result
                    return translated, tokens
                else:
                    return result, tokens
            except Exception as e:
                retry_count += 1
                if retry_count <= max_retries:
                    print(
                        f"Error occurred: {e}. Retrying... (Attempt {retry_count} of {max_retries})"
                    )
                    continue
                else:
                    print(f"Error after {max_retries} retries: {e}")
                    # 错误时仅计算发送的 tokens
                    sent_tokens = sum(count_tokens(msg["content"]) for msg in messages)
                    tokens = {"sent_tokens": sent_tokens, "received_tokens": 0}
                    return text, tokens

    return translate
