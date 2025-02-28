from openai import OpenAI
import json


def ollama_translate(
    api_key: str = "ollama",
    base_url: str = "http://localhost:11434/v1",
    src: str = "English",
    dest: str = "中文",
    model="qwen2.5",
    tempterature=0.8,
    system_prompt: str = None,
    input_prompt: str = None,
    extra_type="markdown",
) -> callable:
    """Initialize and return the translate function

    Args:
        api_key: The openai API authentication key
        src: Source language code, defaults to "English"
        dest: Destination language code, defaults to "中文"
        extra_type: How to extract translated text from LLM response, defaults to "json"
                   "json": Extract from JSON format with key "translated"
                   "markdown": Extract text wrapped in ```
                   Otherwise use raw response text

    Returns:
        callable: The translate function that can be used for translation
    """
    if system_prompt is None:
        system_prompt = "You are a specialized language model trained to translate Markdown documents while preserving their formatting. Your task is to translate a given Markdown text from {{src}} to {{dest}}, ensuring academic precision, clarity, and logical consistency."
    if input_prompt is None:
        input_prompt = """
The Markdown text to translate:
<markdown_text>
{{text}}
</markdown_text>
Ensure only shows the translated text and format your output as follows:
```
[Your translated Markdown text here, preserving all original Markdown formatting]
```
"""

    if "{{text}}" not in input_prompt:
        raise ValueError("input_prompt must contain {{text}} placeholder")

    def translate(text: str, prev_text: str, next_text: str) -> str:
        try:
            client = OpenAI(api_key=api_key, base_url=base_url)
            response = client.chat.completions.create(
                model=model,
                messages=[
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
                ],
                temperature=tempterature,
                stream=False,
            )
            result = response.choices[0].message.content

            if extra_type == "json":
                try:
                    return json.loads(result)["translated"]
                except Exception as e:
                    print(f"Having trouble extracting JSON: {e}")
                    return result
            elif extra_type == "markdown":
                try:
                    return result[result.find("```") + 3 : result.rfind("```")]
                except Exception as e:
                    print(f"Having trouble extracting markdown: {e}")
                    return result
            return result
        except Exception as e:
            print(f"Error: {e}")
            return text

    return translate
