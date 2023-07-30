import requests
from bs4 import BeautifulSoup

def extract_m3u_links(url):
    response = requests.get(url)
    page_content = response.content

    soup = BeautifulSoup(page_content, 'html.parser')
    m3u_links = []

    for link in soup.find_all('a'):
        href = link.get('href')
        if href and href.endswith('.m3u'):
            m3u_links.append(href)

    return m3u_links

if __name__ == '__main__':
    target_url = 'https://www.nivod4.tv/lrxATrTpfvXEjNi3ZMHvYaBQKhMHwxmO-5-0-0-0-play.html?x=1'  # 替换成你想要抓取的网站的网址
    links = extract_m3u_links(target_url)
    print('M3U 播放链接：')
    for link in links:
        print(link)
