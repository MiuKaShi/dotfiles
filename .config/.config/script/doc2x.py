import json
import time
import requests as rq
import os
import sys

base_url = "https://v2.doc2x.noedgeai.com"
secret = os.getenv("DOC2X_APIKEY")


def preupload():
    url = f"{base_url}/api/v2/parse/preupload"
    headers = {"Authorization": f"Bearer {secret}"}
    res = rq.post(url, headers=headers)
    res.raise_for_status()  # Check if HTTP request is successful
    data = res.json()
    if data.get("code") == "success":
        return data["data"]
    raise Exception(f"get preupload url failed: {data}")


def put_file(path: str, url: str):
    with open(path, "rb") as f:
        res = rq.put(url, data=f)  # Body is binary file stream
        res.raise_for_status()  # Check if HTTP request is successful


def get_status(uid: str):
    url = f"{base_url}/api/v2/parse/status?uid={uid}"
    headers = {"Authorization": f"Bearer {secret}"}
    res = rq.get(url, headers=headers)
    res.raise_for_status()  # Check if HTTP request is successful
    data = res.json()
    if data.get("code") == "success":
        return data["data"]
    raise Exception(f"get status failed: {data}")


def main():
    if len(sys.argv) < 3:
        print("用法: python get_markdown.py <输入PDF文件> <输出MD文件>")
        sys.exit(1)

    # 输入 PDF 文件
    input_file = sys.argv[1]
    # 输出 MD 文件
    output_md = sys.argv[2]

    upload_data = preupload()
    # print(upload_data)
    url, uid = upload_data["url"], upload_data["uid"]

    put_file(input_file, url)

    max_retries = 100
    for retries in range(max_retries):
        status_data = get_status(uid)
        status = status_data.get("status")
        if status == "success":
            pages = status_data["result"]["pages"]
            # 收集所有 md 字段内容
            all_md_contents = []
            for page in pages:
                if "md" in page:
                    all_md_contents.append(page["md"])
            # 输出 MD 文件
            with open(output_md, "w", encoding="utf-8") as out_file:
                for md in all_md_contents:
                    out_file.write(md)
            return
        elif status == "failed":
            # print(status_data)
            os.system('notify-send "PDF2MD" "failed!"')
            raise Exception(f"parse failed: {status_data.get('detail')}")
        elif status == "processing":
            # print(status_data)
            # print(f"progress: {status_data.get('progress')}")
            os.system('notify-send "PDF2MD" "processing..."')
            time.sleep(3)
    raise Exception(f"Fails to deal with uid: {uid} after {max_retries} retries")


if __name__ == "__main__":
    main()
