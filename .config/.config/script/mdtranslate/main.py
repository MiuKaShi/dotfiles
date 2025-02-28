import os
import sys
from md_translate import process_markdown


# Select translators
# avialbel = ["openai", "ollama", "deepseek", "deeplx", "deepl", "google"]
# translate_use = "deepseek"
# api_file = os.path.expanduser("~/.api_keys/DEEPSEEK_V3_KEY")

translate_use = "gemini"
api_file = os.path.expanduser("~/.api_keys/Gemini_KEY")

# translate_use = "deeplx"
# api_file = os.path.expanduser("~/.api_keys/DEEPLX_KEY")


if not os.path.isfile(api_file):
    print(f"no {api_file} file，exit!")
    sys.exit(1)
with open(api_file, "r", encoding="utf-8") as f:
    apikey = f.read().strip()


# translator settings
threads = 10
#
# avialbel = ["zh", "zh-en", "en-zh"]
style = "zh-en"


# ========Google==========
google_src = "en"
google_dest = "zh-cn"

# ========Deeplx==========
deeplx_src = "EN"
deeplx_dest = "ZH"

# ========Deepl==========
deepl_dest = "ZH"

# ========OpenAI==========
openai_baseurl = "https://api.openai.com/v1"
openai_model = "gpt-4o-mini"

# ========Gemini==========
gemini_model = "gemini-2.0-flash"
deepseek_baseurl = "https://generativelanguage.googleapis.com/v1beta/openai/"

# ========Deepseek==========
deepseek_baseurl = "https://ark.cn-beijing.volces.com/api/v3"
deepseek_model = "deepseek-v3-241226"

# ========Ollama==========
ollama_baseurl = "http://localhost:11434/v1"
ollama_model = "qwen2.5"

# LLM common settings
# Read prompt
with open("system_prompt.txt", "r", encoding="utf-8") as file:
    system_prompt = file.read()

with open("input_prompt.txt", "r", encoding="utf-8") as file:
    input_prompt = file.read()


temperature = 0.4
extra_type = "markdown"
llm_src = "English"
llm_dest = "中文"

system_prompt = None if system_prompt == "" else system_prompt
input_prompt = None if input_prompt == "" else input_prompt


def create_translator(name):

    if name == "openai":
        from Translator.OpenAI import openai_translate

        openai_apikey = apikey
        if not openai_apikey:
            print("Error: OpenAI API key not set")
            raise Exception("OpenAI API key not set")
        return openai_translate(
            api_key=openai_apikey,
            base_url=openai_baseurl,
            src=llm_src,
            dest=llm_dest,
            model=openai_model,
            tempterature=temperature,
            system_prompt=system_prompt if system_prompt else None,
            input_prompt=input_prompt if input_prompt else None,
            extra_type=extra_type,
        )
    elif name == "gemini":
        from Translator.Gemini import gemini_translate

        gemini_api = apikey
        if not gemini_api:
            print("Error: Gemini API key not set")
            raise Exception("Gemini API key not set")
        return gemini_translate(
            api_key=gemini_api,
            src=llm_src,
            dest=llm_dest,
            model=gemini_model,
            tempterature=temperature,
            system_prompt=system_prompt if system_prompt else None,
            input_prompt=input_prompt if input_prompt else None,
            extra_type=extra_type,
        )
    elif name == "ollama":
        from Translator.Ollama import ollama_translate

        return ollama_translate(
            base_url=ollama_baseurl,
            src=llm_src,
            dest=llm_dest,
            model=ollama_model,
            tempterature=temperature,
            system_prompt=system_prompt if system_prompt else None,
            input_prompt=input_prompt if input_prompt else None,
            extra_type=extra_type,
        )
    elif name == "deepseek":
        from Translator.DeepSeek import deepseek_translate

        deepseek_api = apikey
        if not deepseek_api:
            print("Error: DeepSeek API key not set")
            raise Exception("DeepSeek API key not set")
        return deepseek_translate(
            api_key=deepseek_api,
            base_url=deepseek_baseurl,
            src=llm_src,
            dest=llm_dest,
            model=deepseek_model,
            tempterature=temperature,
            system_prompt=system_prompt if system_prompt else None,
            input_prompt=input_prompt if input_prompt else None,
            extra_type=extra_type,
        )
    elif name == "deeplx":
        from Translator.DeepLX import deeplx_translate

        deeplx_url = apikey
        return deeplx_translate(base_url=deeplx_url, src=deeplx_src, dest=deeplx_dest)
    elif name == "deepl":
        from Translator.DeepL import deepl_translate

        deepl_apikey = apikey
        if not deepl_apikey:
            print("Error: DeepL API key not set")
            raise Exception("DeepL API key not set")
        return deepl_translate(api_key=deepl_apikey, dest=deepl_dest)
    elif name == "google":
        from Translator.Google import google_translate

        return google_translate(src=google_src, dest=google_dest)
    else:
        print(f"Unknown translator: {name}")
        raise Exception(f"Unknown translator: {name}")


def Process_MD(
    md_file: str, output_md_file: str, translate: callable, thread: int = 10
):
    print(f"Processing markdown file: {md_file}")
    with open(md_file, "r", encoding="utf-8") as f:
        input_md = f.read()
    output_md = process_markdown(
        input_markdown=input_md, translate=translate, thread=thread, style=style
    )
    with open(output_md_file, "w", encoding="utf-8") as f:
        f.write(output_md)


def main():
    # Get translator
    translator = create_translator(translate_use)

    # Get file path from user
    if len(sys.argv) < 3:
        print("用法: python main.py <输入MD文件> <输出MD_ZH文件>")
        sys.exit(1)

    # 输入 MD 文件
    file_path = sys.argv[1]
    # 输出 MD 文件
    output_path = sys.argv[2]

    if not os.path.exists(file_path):
        print(f"Error: File {file_path} does not exist")
        raise FileNotFoundError(f"File {file_path} does not exist")

    if not file_path.endswith(".md"):
        print("Error: File must be a markdown file (.md)")
        raise ValueError("File must be a markdown file (.md)")
    # Process the file
    Process_MD(
        md_file=file_path,
        output_md_file=output_path,
        translate=translator,
        thread=threads,
    )


if __name__ == "__main__":
    main()
