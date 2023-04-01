import numpy as np
import os
import re
import datetime
import openai, tenacity
import base64, requests
import argparse
import configparser
import json
import tiktoken
from get_paper_from_pdf import Paper


# 定义Reader类
class Reader:
    # 初始化方法，设置属性
    def __init__(
        self,
        key_word,
        root_path="./",
        user_name="defualt",
        args=None,
    ):
        self.user_name = user_name  # 读者姓名
        self.key_word = key_word  # 读者感兴趣的关键词
        if args.language == "en":
            self.language = "English"
        elif args.language == "zh":
            self.language = "Chinese"
        else:
            self.language = "Chinese"
        self.root_path = root_path
        # 创建一个ConfigParser对象
        self.config = configparser.ConfigParser()
        # 读取配置文件
        self.config.read("apikey.ini")
        # 获取某个键对应的值
        self.chat_api_list = (
            self.config.get("OpenAI", "OPENAI_API_KEYS")[1:-1]
            .replace("'", "")
            .split(",")
        )
        self.chat_api_list = [api.strip() for api in self.chat_api_list if len(api) > 5]
        self.cur_api = 0
        self.max_token_num = 4096
        self.encoding = tiktoken.get_encoding("gpt2")

    def validateTitle(self, title):
        # 将论文的乱七八糟的路径格式修正
        rstr = r"[\/\\\:\*\?\"\<\>\|]"  # '/ \ : * ? " < > |'
        new_title = re.sub(rstr, "_", title)  # 替换为下划线
        return new_title

    def summary_with_chat(self, paper_list):
        for paper_index, paper in enumerate(paper_list):
            # 第一步根据原文title，abs，和introduction部分进行总结。
            text = ""
            text += "Title:" + paper.title
            text += "Abstrat:" + paper.abs
            text += "Paper_info:" + paper.section_text_dict["paper_info"]
            # intro
            text += list(paper.section_text_dict.values())[0]
            chat_summary_text = ""
            try:
                chat_summary_text = self.chat_summary(text=text)
            except Exception as e:
                print("summary_error:", e)
                if "maximum context" in str(e):
                    current_tokens_index = (
                        str(e).find("your messages resulted in")
                        + len("your messages resulted in")
                        + 1
                    )
                    offset = int(
                        str(e)[current_tokens_index : current_tokens_index + 4]
                    )
                    summary_prompt_token = offset + 1000 + 150
                    chat_summary_text = self.chat_summary(
                        text=text, summary_prompt_token=summary_prompt_token
                    )

            # 第二步结合第一步结果和原文方法段部分进行总结
            # TODO，由于有些文章的方法章节名是算法名，所以简单的通过关键词来筛选，很难获取，后面需要用其他的方案去优化。
            method_key = ""
            for parse_key in paper.section_text_dict.keys():
                if "method" in parse_key.lower() or "approach" in parse_key.lower():
                    method_key = parse_key
                    break

            if method_key != "":
                text = ""
                method_text = ""
                summary_text = ""
                summary_text += "<summary>" + chat_summary_text
                # methods
                method_text += paper.section_text_dict[method_key]
                text = summary_text + "\n\n<Methods>:\n\n" + method_text
                chat_method_text = ""
                try:
                    chat_method_text = self.chat_method(text=text)
                except Exception as e:
                    print("method_error:", e)
                    if "maximum context" in str(e):
                        current_tokens_index = (
                            str(e).find("your messages resulted in")
                            + len("your messages resulted in")
                            + 1
                        )
                        offset = int(
                            str(e)[current_tokens_index : current_tokens_index + 4]
                        )
                        method_prompt_token = offset + 800 + 150
                        chat_method_text = self.chat_method(
                            text=text, method_prompt_token=method_prompt_token
                        )
            else:
                chat_method_text = ""

            # 第三步结合第一步,第二步结果和原文结论部分进行总结，并给出评价
            conclusion_key = ""
            for parse_key in paper.section_text_dict.keys():
                if "conclu" in parse_key.lower():
                    conclusion_key = parse_key
                    break

            text = ""
            conclusion_text = ""
            summary_text = ""
            summary_text += (
                "<summary>"
                + chat_summary_text
                + "\n <Method summary>:\n"
                + chat_method_text
            )
            if conclusion_key != "":
                # conclusion
                conclusion_text += paper.section_text_dict[conclusion_key]
                text = summary_text + "\n\n<Conclusion>:\n\n" + conclusion_text
            else:
                text = summary_text
            chat_conclusion_text = ""
            try:
                chat_conclusion_text = self.chat_conclusion(text=text)
            except Exception as e:
                print("conclusion_error:", e)
                if "maximum context" in str(e):
                    current_tokens_index = (
                        str(e).find("your messages resulted in")
                        + len("your messages resulted in")
                        + 1
                    )
                    offset = int(
                        str(e)[current_tokens_index : current_tokens_index + 4]
                    )
                    conclusion_prompt_token = offset + 800 + 150
                    chat_conclusion_text = self.chat_conclusion(
                        text=text, conclusion_prompt_token=conclusion_prompt_token
                    )

    @tenacity.retry(
        wait=tenacity.wait_exponential(multiplier=1, min=4, max=10),
        stop=tenacity.stop_after_attempt(5),
        reraise=True,
    )
    def chat_conclusion(self, text, conclusion_prompt_token=800):
        openai.api_key = self.chat_api_list[self.cur_api]
        self.cur_api += 1
        self.cur_api = (
            0 if self.cur_api >= len(self.chat_api_list) - 1 else self.cur_api
        )
        text_token = len(self.encoding.encode(text))
        clip_text_index = int(
            len(text) * (self.max_token_num - conclusion_prompt_token) / text_token
        )
        clip_text = text[:clip_text_index]

        messages = [
            {
                "role": "system",
                "content": "You are a reviewer in the field of ["
                + self.key_word
                + "] and you need to critically review this article",
            },  # chatgpt 角色
            {
                "role": "assistant",
                "content": "This is the <summary> and <conclusion> part of an English literature, where <summary> you have already summarized, but <conclusion> part, I need your help to summarize the following questions:"
                + clip_text,
            },  # 背景知识，可以参考OpenReview的审稿流程
            {
                "role": "user",
                "content": """                 
                 3. Make the following summary.Be sure to use {} answers (proper nouns need to be marked in English).
                    - (1):What is the significance of this piece of work?
                    - (2):Summarize the strengths and weaknesses of this article in three dimensions: innovation point, performance, and workload.                   
                    .......
                 Follow the format of the output later: 
                 ## 分析\n
                    - (1) 重点: xxx;\n                     
                    - (2) 创新点: xxx;\n 
                    - (3) 评价: xxx;\n 
                    - (4) 工作量: xxx;\n                      
                 
                 Be sure to use {} answers (proper nouns need to be marked in English), statements as concise and academic as possible, do not repeat the content of the previous <summary>, the value of the use of the original numbers, be sure to strictly follow the format, the corresponding content output to xxx, in accordance with \n line feed, ....... means fill in according to the actual requirements, if not, you can not write.                 
                 """.format(
                    self.language, self.language
                ),
            },
        ]
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            # prompt需要用英语替换，少占用token。
            messages=messages,
        )
        result = ""
        for choice in response.choices:
            result += choice.message.content
        print(result)
        print("")
        return result

    @tenacity.retry(
        wait=tenacity.wait_exponential(multiplier=1, min=4, max=10),
        stop=tenacity.stop_after_attempt(5),
        reraise=True,
    )
    def chat_method(self, text, method_prompt_token=800):
        openai.api_key = self.chat_api_list[self.cur_api]
        self.cur_api += 1
        self.cur_api = (
            0 if self.cur_api >= len(self.chat_api_list) - 1 else self.cur_api
        )
        text_token = len(self.encoding.encode(text))
        clip_text_index = int(
            len(text) * (self.max_token_num - method_prompt_token) / text_token
        )
        clip_text = text[:clip_text_index]
        messages = [
            {
                "role": "system",
                "content": "You are a researcher in the field of ["
                + self.key_word
                + "] who is good at summarizing papers using concise statements",
            },  # chatgpt 角色
            {
                "role": "assistant",
                "content": "This is the <summary> and <Method> part of an English document, where <summary> you have summarized, but the <Methods> part, I need your help to read and summarize the following questions."
                + clip_text,
            },  # 背景知识
            {
                "role": "user",
                "content": """                 
                 4. Describe in detail the methodological idea of this article. Be sure to use {} answers (proper nouns need to be marked in English). For example, its steps are.
                    - (1) ...
                    - (2) ...
                    - (3) ...
                    - .......
                 Follow the format of the output that follows: 
                 ## 方法\n
                    - (1) xxx;\n 
                    - (2) xxx;\n 
                    - (3) xxx;\n  
                    ....... \n\n     
                 
                 Be sure to use {} answers (proper nouns need to be marked in English), statements as concise and academic as possible, do not repeat the content of the previous <summary>, the value of the use of the original numbers, be sure to strictly follow the format, the corresponding content output to xxx, in accordance with \n line feed, ....... means fill in according to the actual requirements, if not, you can not write.                 
                 """.format(
                    self.language, self.language
                ),
            },
        ]
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=messages,
        )
        result = ""
        for choice in response.choices:
            result += choice.message.content
        print(result)
        print("")
        return result

    @tenacity.retry(
        wait=tenacity.wait_exponential(multiplier=1, min=4, max=10),
        stop=tenacity.stop_after_attempt(5),
        reraise=True,
    )
    def chat_summary(self, text, summary_prompt_token=1100):
        openai.api_key = self.chat_api_list[self.cur_api]
        self.cur_api += 1
        self.cur_api = (
            0 if self.cur_api >= len(self.chat_api_list) - 1 else self.cur_api
        )
        text_token = len(self.encoding.encode(text))
        clip_text_index = int(
            len(text) * (self.max_token_num - summary_prompt_token) / text_token
        )
        clip_text = text[:clip_text_index]
        messages = [
            {
                "role": "system",
                "content": "You are a researcher in the field of ["
                + self.key_word
                + "] who is good at summarizing papers using concise statements",
            },
            {
                "role": "assistant",
                "content": "This is the title, author, link, abstract and introduction of an English document. I need your help to read and summarize the following questions: "
                + clip_text,
            },
            {
                "role": "user",
                "content": """                 
                 1. Mark the title of the paper (with Chinese translation)
                 2. summarize according to the following four points.Be sure to use {} answers (proper nouns need to be marked in English)
                    - (1) What is the research background of this article?
                    - (2) What are the past methods? What are the problems with them? Is the approach well motivated?
                    - (3) What is the research methodology proposed in this paper?
                    - (4) On what task and what performance is achieved by the methods in this paper? Can the performance support their goals?
                 Follow the format of the output that follows:                  
                 # xxx\n
                 ## 总结\n
                    - (1) xxx;\n 
                    - (2) xxx;\n 
                    - (3) xxx;\n  
                    - (4) xxx.\n\n     
                 
                 Be sure to use {} answers (proper nouns need to be marked in English), statements as concise and academic as possible, do not have too much repetitive information, numerical values using the original numbers, be sure to strictly follow the format, the corresponding content output to xxx, in accordance with \n line feed.                 
                 """.format(
                    self.language, self.language, self.language
                ),
            },
        ]

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=messages,
        )
        result = ""
        for choice in response.choices:
            result += choice.message.content
        print(result)
        print("")
        return result

    # 定义一个方法，打印出读者信息
    def show_info(self):
        print(f"Key word: {self.key_word}")


def main(args):
    # 创建一个Reader对象，并调用show_info方法
    if args.pdf_path:
        reader1 = Reader(
            key_word=args.key_word,
            args=args,
        )
        # reader1.show_info()
        # 开始判断是路径还是文件：
        paper_list = []
        if args.pdf_path.endswith(".pdf"):
            paper_list.append(Paper(path=args.pdf_path))
        else:
            for root, dirs, files in os.walk(args.pdf_path):
                # print("root:", root, "dirs:", dirs, "files:", files)  # 当前目录路径
                for filename in files:
                    # 如果找到PDF文件，则将其复制到目标文件夹中
                    if filename.endswith(".pdf"):
                        paper_list.append(Paper(path=os.path.join(root, filename)))
        reader1.summary_with_chat(paper_list=paper_list)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--pdf_path",
        type=str,
        default="",
        help="read pdf",
    )
    parser.add_argument(
        "--key_word",
        type=str,
        default="tribology",
        help="the key word of user research fields",
    )
    parser.add_argument(
        "--max_results", type=int, default=1, help="the maximum number of results"
    )
    parser.add_argument(
        "--language",
        type=str,
        default="zh",
        help="The other output lauguage is English, is en",
    )

    args = parser.parse_args()
    main(args=args)
    print("generated time:", datetime.datetime.now())
