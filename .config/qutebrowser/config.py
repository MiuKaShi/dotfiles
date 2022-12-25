from qutebrowser.api import interceptor

config.load_autoconfig(False)

# themes
config.source("themes/pyqute/draw.py")

# ui
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
c.content.autoplay = False
c.auto_save.session = True
c.zoom.default = "175%"
c.content.default_encoding = "utf-8"
c.content.notifications.enabled = True
c.fileselect.handler = "external"
c.fileselect.folder.command = ["st", "-e", "lfrun", "-last-dir-path={}"]
c.fileselect.single_file.command = ["st", "-e", "lfrun", "-selection-path={}"]
c.fileselect.multiple_files.command = ["st", "-e", "lfrun", "-selection-path={}"]
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = False
c.confirm_quit = ['downloads']
# pacman -S pdfjs-legacy 
c.content.pdfjs = True
c.input.insert_mode.auto_load = True
c.spellcheck.languages = ["en-US"]
c.editor.command = ["st", "-e", "nvim", "{}"]
c.completion.height = "30%"
c.tabs.show = "multiple"
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False

# enable GPU acceleration
# see https://github.com/qutebrowser/qutebrowser/discussions/6573
# see https://github.com/qutebrowser/qutebrowser/issues/5378]
c.qt.args += [
    "ignore-gpu-blocklist",
    "enable-gpu-rasterization",
    "enable-native-gpu-memory-buffers",
    "num-raster-threads=4",
    "enable-accelerated-video-decode",
]

# Don't automatically leave insert mode. qutebrowser will leave insert mode automatically
config.set("input.insert_mode.auto_leave", False)
c.hints.next_regexes = [
    '\\bnext\\b',
    '\\bmore\\b',
    '\\bnewer\\b',
    '\\b[>→≫]\\b',
    '\\b(>>|»)\\b',
    '\\bcontinue\\b',
    '\\b下一?页\\b'
]
# Comma-separated list of regular expressions to use for 'prev' links.
c.hints.prev_regexes = [
    '\\bprev(ious)?\\b',
    '\\bback\\b',
    '\\bolder\\b',
    '\\b[<←≪]\\b',
    '\\b(<<|«)\\b',
    '\\b上一?页\\b'
]

c.content.blocking.method = "both"
c.content.blocking.adblock.lists =[
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist-downloads.adblockplus.org/easylistdutch.txt",
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist-downloads.adblockplus.org/easylistchina.txt",
     "https://www.i-dont-care-about-cookies.eu/abp/",
     "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
]

# privacy
c.content.cookies.accept = "no-3rdparty"
c.content.media.audio_capture = 'ask'
c.content.media.video_capture = 'ask'
c.content.tls.certificate_errors = 'ask'
c.content.desktop_capture = 'ask'
c.content.mouse_lock = 'ask'
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.site_specific_quirks.enabled = False
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"


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
c.url.default_page = 'https://search.miukashi.xyz/'
c.url.start_pages = 'https://search.miukashi.xyz/'
c.tabs.last_close = "startpage"
c.url.searchengines = {
        'DEFAULT': 'https://search.miukashi.xyz/search?q={}',
        'wiby': 'https://wiby.me/?q={}',
        'gg': 'https://google.com/search?q={}',
        'ar': 'https://wiki.archlinux.org/?search={}',
        'gh': 'https://github.com/search?q={}',
        'bd': 'https://baidu.com/s?wd={}',
        'zh': 'https://zhihu.com/search?q={}',
        'yt': 'https://youtube.com/results?search_query={}',
}

# bookmarks
c.aliases = {
    "ba": "spawn --userscript qb-rbuku -a",
    "br": "spawn --userscript qb-rbuku -r",
}
config.bind('b', 'spawn --userscript qb-rbuku -s')
config.bind('B', 'spawn --userscript qb-rbuku')
# config.bind('<Ctrl+b>', 'bookmark-list -t --jump')
config.bind('<Ctrl+b>', 'spawn --userscript qb-rbuku -a')

# Keys
config.bind('ee', 'hint links spawn linkhandler {hint-url}')
config.bind('el', "spawn librewolf {url}")
config.bind('eL', "hint links spawn librewolf {hint-url}")
config.bind('E', 'spawn --userscript url-handler')
config.bind('I', 'hint images download')

config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('j', 'scroll-page 0 0.1')
config.bind('k', 'scroll-page 0 -0.1')
config.bind('H', 'back')
config.bind('L', 'forward')

config.bind('J', 'zoom-out')
config.bind('K', 'zoom-in')

config.unbind('gJ')
config.unbind('gK')
config.bind('gj', 'tab-move -')
config.bind('gk', 'tab-move +')
config.bind('<', 'tab-move -')
config.bind('>', 'tab-move +')
config.bind('<Ctrl+H>', 'tab-prev')
config.bind('<Ctrl+L>', 'tab-next')
config.bind('x', 'tab-close')
config.bind('X', 'undo')

config.bind('yf', 'hint links yank')
config.bind('yt', 'tab-clone')

config.bind('p', 'open -- {clipboard}')
config.bind('P', 'open --bg {clipboard}')

config.bind('o', 'set-cmd-text -s :open -s')
config.bind('O', 'set-cmd-text -s :open -t -s')
config.bind("<Ctrl-p>", "set-cmd-text -s :tab-select")

# general
config.bind('za', 'jseval -qf ~/.config/qutebrowser/js/general-alert.js')
config.bind('zl', 'jseval -qf ~/.config/qutebrowser/js/general-save.js') 
config.bind('zu', 'jseval -qf ~/.config/qutebrowser/js/general-unsave.js') 
config.bind('zc', 'jseval -qf ~/.config/qutebrowser/js/general-copy.js') 
config.bind('zs', 'jseval -qf ~/.config/qutebrowser/js/general-sort.js') 
config.bind('zh', 'jseval -qf ~/.config/qutebrowser/js/general-home.js')
config.bind('zf', 'jseval -qf ~/.config/qutebrowser/js/general-filter.js')
config.bind('zx', 'jseval -qf ~/.config/qutebrowser/js/close-popup.js')

# Bindings for insert mode
config.bind('<Alt-Backspace>', 'fake-key <Ctrl-Backspace>', mode='insert')
config.bind('<Ctrl-a>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl-e>', 'fake-key <End>', mode='insert')
config.bind('<Ctrl-d>', 'fake-key <Delete>', mode='insert')
config.bind('<Ctrl-h>', 'fake-key <Backspace>', mode='insert')
config.bind('<Ctrl-k>', 'fake-key <Shift-End> ;; fake-key <Delete>', mode='insert')
config.bind('<Ctrl-u>', 'fake-key <Shift+Home> ;; fake-key <BackSpace>', mode='insert')
config.bind('<Ctrl-f>', 'fake-key <Right>', mode='insert')
config.bind('<Ctrl-b>', 'fake-key <Left>', mode='insert')
config.bind('<Ctrl-n>', 'fake-key <Down>', mode='insert')
config.bind('<Ctrl-p>', 'fake-key <Up>', mode='insert')
config.bind('<Escape>', 'spawn fcitx5-remote -c Default ;; mode-leave ;; fake-key <Escape>', mode='insert')
#config.bind('<Escape>', 'mode-leave ;; fake-key <Escape>', mode='insert')
# config.bind('<Ctrl-[>', 'spawn fcitx5-remote -t ;; mode-leave', mode='insert')
config.bind('<Ctrl-[>', 'mode-leave', mode='insert')

# Leader key: `;`
config.bind(';x', 'config-cycle statusbar.show always never;;config-cycle tabs.show always never')
config.bind(';c', "config-cycle colors.webpage.bg '#1d2021' 'white'")
config.bind(';p', 'config-cycle content.proxy system http://localhost:7890/')

# Leader key: `,`
c.hints.selectors["code"] = [
    # Selects all code tags whose direct parent is not a pre tag
    ":not(pre) > code",
    "pre"
]
config.bind(',c', 'hint code userscript code_select')
config.bind(',d', 'set content.user_stylesheets ~/.config/qutebrowser/stylesheets/dark.css')
config.bind(',l', 'set content.user_stylesheets ~/.config/qutebrowser/stylesheets/sepia.css')
config.bind(',,', 'set content.user_stylesheets ""')
config.bind(',t', 'tab-give')
config.bind(',r', 'spawn --userscript readability-js')
config.bind(',s', 'hint links userscript doi.py')
config.bind(',f', 'hint links tab')
config.bind(',o', 'set-cmd-text -s :open -w')
config.bind(',b', 'open -t https://bilibili.com')
config.bind(',n', 'open -t https://www.nivod.tv')
config.bind(',g', 'open -t https://github.com')
config.bind(',m', 'open -t https://mail.google.com')
config.bind(',v', 'open -t https://v2ex.com')
config.bind(',z', 'spawn --userscript zotero')
config.bind(',Z', 'hint links userscript zotero')

# Bindings for cmd
# Leader key: `\`

config.bind('\\d', 'help')
config.bind('\\h', 'history')
config.bind('\\m', 'messages')
config.bind('\\r', 'config-source')
config.bind('\\u', 'adblock-update')
