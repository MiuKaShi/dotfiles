from qutebrowser.api import interceptor

config.load_autoconfig(False)

# ui
config.source("gruvbox.py")
c.colors.webpage.preferred_color_scheme = "dark"
c.fonts.default_size = "12pt"
c.completion.shrink = True
c.completion.use_best_match = True
c.downloads.position = "bottom"
c.downloads.remove_finished = 10000
c.statusbar.widgets = ["progress", "keypress", "url", "history"]
c.tabs.show = 'multiple'
c.tabs.title.format = "{index}: {audio}{current_title}"
c.tabs.title.format_pinned = "{index}: {audio}{current_title}"

# general
# HDPI(not support WAYLAND)
c.qt.highdpi = True
c.zoom.default = "175%"
c.auto_save.session = True
c.content.default_encoding = "utf-8"
c.content.notifications.enabled = True
c.fileselect.handler = "external"
c.fileselect.single_file.command = ["st", "sh", "-c", "lf > {}"]
c.fileselect.multiple_files.command = ["st", "sh", "-c", "lf > {}"]
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = False
c.input.insert_mode.auto_load = True
c.spellcheck.languages = ["en-US"]
c.tabs.show = "multiple"
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False
# Autoplay off.
config.set("content.autoplay", False)
# Don't automatically leave insert mode. qutebrowser will leave insert mode automatically
config.set("input.insert_mode.auto_leave", False)

# privacy
c.content.cookies.accept = "no-3rdparty"
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.site_specific_quirks.enabled = False
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"

def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
            url.host() == "www.youtube.com"
            and url.path() == "/get_video_info"
            and "&adformat=" in url.query()
        ):
            info.block()

interceptor.register(filter_yt)

# per-domain settings
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# urls
c.url.default_page = 'https://searx.be/'
c.url.start_pages = 'https://searx.be/'
c.tabs.last_close = "startpage"
c.url.searchengines = {'DEFAULT': 'https://searx.be/search?q={}',
        'wiby': 'https://wiby.me/?q={}',
        'lite': 'https://lite.duckduckgo.com/lite/?q={}',
        'arch': 'https://wiki.archlinux.org/?search={}',
        'wiki': 'https://wikiless.org/wiki/{}',
        'ody': 'https://odysee.com/$/search?q={}',
        'yt': 'https://youtube.com/results?search_query={}',
        'ddg': 'https://duckduckgo.com/?q={}'}

# Keys
config.bind('e', 'spawn linkhandler {url}')
config.bind('E', 'hint links spawn linkhandler {hint-url}')
config.bind('I', 'hint images download')
config.bind('yf', 'hint links yank')

config.bind('d', 'run-with-count 10 scroll down', mode = 'normal')
config.bind('u', 'run-with-count 10 scroll up', mode = 'normal')
config.bind('j', 'scroll down', mode = 'normal')
config.bind('k', 'scroll up', mode = 'normal')
config.bind('J', 'zoom-out', mode = 'normal')
config.bind('K', 'zoom-in', mode = 'normal')

config.bind('H', 'back', mode = 'normal')
config.bind('L', 'forward', mode = 'normal')
config.bind('<Ctrl+H>', 'tab-prev', mode = 'normal')
config.bind('<Ctrl+L>', 'tab-next', mode = 'normal')

config.bind('x', 'tab-close', mode = 'normal')
config.bind('yt', 'tab-clone', mode = 'normal')
config.bind('<Space>', 'set-cmd-text /', mode = 'normal')
config.bind('p', 'open -- {clipboard}', mode = 'normal')
config.bind('P', 'open --bg {clipboard}', mode = 'normal')
config.bind('b', 'set-cmd-text -s :bookmark-load', mode = 'normal')
config.bind('B', 'set-cmd-text -s :bookmark-load -t', mode = 'normal')
config.bind('<Ctrl+b>', 'bookmark-list', mode = 'normal')
config.bind('<<', 'tab-move -', mode = 'normal')
config.bind('>>', 'tab-move +', mode = 'normal')
config.bind('o', 'set-cmd-text -s :open -s', mode = 'normal')
config.bind('O', 'set-cmd-text -s :open -t -s', mode = 'normal')
config.bind("<Ctrl-p>", "set-cmd-text -s :tab-select")

config.bind(',o', 'set-cmd-text -s :open -w', mode = 'normal')
config.bind(',t', 'spawn --userscript translate')
config.bind(',b', "hint links tab", mode = 'normal')
config.bind(',c', "config-cycle colors.webpage.bg '#1d2021' 'white'", mode = 'normal')
