config.unbind("b")
config.unbind("B")
config.unbind("gJ")
config.unbind("gK")
config.unbind("<Ctrl-v>")

config.bind("bb", "spawn --userscript qb-rbuku -s")
config.bind("bn", "spawn --userscript qb-rbuku")
config.bind("ba", "spawn --userscript qb-rbuku -a")
config.bind("br", "spawn --userscript qb-rbuku -r")
# config.bind('<Ctrl+b>', 'bookmark-list -t --jump')

# Keys
config.bind("ee", "hint links spawn linkhandler {hint-url}")
config.bind("el", "spawn librewolf {url}")
config.bind("eL", "hint links spawn librewolf {hint-url}")
config.bind("E", "spawn --userscript url-handler")
config.bind("I", "hint images download")
config.bind("cr", "config-source")

# Download management
config.bind("aa", "hint links userscript dl2aria", "normal")
# config.bind("aa", "download")
config.bind("au", "download-open;;download-remove")
config.bind("ac", "download-clear")
config.bind("ad", "download-delete")
config.bind("as", "download-cancel")
config.bind("ar", "download-retry")

config.bind("d", "scroll-page 0 0.5")
config.bind("u", "scroll-page 0 -0.5")
config.bind("j", "scroll-page 0 0.1")
config.bind("k", "scroll-page 0 -0.1")
config.bind("H", "back")
config.bind("L", "forward")

config.bind("J", "zoom-out")
config.bind("K", "zoom-in")


config.bind("gj", "tab-move -")
config.bind("gk", "tab-move +")
config.bind("<", "tab-move -")
config.bind(">", "tab-move +")
config.bind("<Ctrl+H>", "tab-prev")
config.bind("<Ctrl+L>", "tab-next")
# reload config
config.bind("<Ctrl+r>", "config-source")
config.bind("x", "tab-close")
config.bind("X", "undo")

config.bind("yf", "hint links yank")
config.bind("yt", "tab-clone")

config.bind("p", "open -- {clipboard}")
config.bind("P", "open --bg {clipboard}")

config.bind("o", "cmd-set-text -s :open -s")
config.bind("O", "cmd-set-text -s :open -t -s")
config.bind("<Ctrl-p>", "cmd-set-text -s :tab-select")

# general
config.bind("za", "jseval -qf ~/.config/qutebrowser/js/general-alert.js")
config.bind("zl", "jseval -qf ~/.config/qutebrowser/js/general-save.js")
config.bind("zu", "jseval -qf ~/.config/qutebrowser/js/general-unsave.js")
config.bind("zc", "jseval -qf ~/.config/qutebrowser/js/general-copy.js")
config.bind("zs", "jseval -qf ~/.config/qutebrowser/js/general-sort.js")
config.bind("zh", "jseval -qf ~/.config/qutebrowser/js/general-home.js")
config.bind("zf", "jseval -qf ~/.config/qutebrowser/js/general-filter.js")
config.bind("zx", "jseval -qf ~/.config/qutebrowser/js/close-popup.js")

# Bindings for insert mode
config.bind("<Alt-Backspace>", "fake-key <Ctrl-Backspace>", mode="insert")
config.bind("<Ctrl-a>", "fake-key <Home>", mode="insert")
config.bind("<Ctrl-e>", "fake-key <End>", mode="insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", mode="insert")
config.bind("<Ctrl-h>", "fake-key <Backspace>", mode="insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End> ;; fake-key <Delete>", mode="insert")
config.bind("<Ctrl-u>", "fake-key <Shift+Home> ;; fake-key <BackSpace>", mode="insert")
config.bind("<Ctrl-f>", "fake-key <Right>", mode="insert")
config.bind("<Ctrl-b>", "fake-key <Left>", mode="insert")
config.bind("<Ctrl-n>", "fake-key <Down>", mode="insert")
config.bind("<Ctrl-p>", "fake-key <Up>", mode="insert")
config.bind(
    "<Escape>",
    "spawn fcitx5-remote -c Default ;; mode-leave ;; fake-key <Escape>",
    mode="insert",
)
# config.bind('<Escape>', 'mode-leave ;; fake-key <Escape>', mode='insert')
# config.bind('<Ctrl-[>', 'spawn fcitx5-remote -t ;; mode-leave', mode='insert')

# Unbindings for passthrough mode
# config.bind("<Ctrl-x>", "mode-leave", mode="passthrough")
config.bind("<Ctrl-[>", "mode-leave", mode="insert")

# Leader key: `;`
config.bind(
    ";;",
    "config-cycle statusbar.show always never;;config-cycle tabs.show always switching",
)
config.bind(";c", "config-cycle colors.webpage.bg '#1d2021' 'white'")
config.bind(";p", "config-cycle content.proxy system http://localhost:7890/")

# Leader key: `,`
c.hints.selectors["code"] = [
    # Selects all code tags whose direct parent is not a pre tag
    ":not(pre) > code",
    "pre",
]
config.bind(",c", "hint code userscript code_select")
config.bind(
    ",d", "set content.user_stylesheets ~/.config/qutebrowser/stylesheets/dark.css"
)
config.bind(
    ",l", "set content.user_stylesheets ~/.config/qutebrowser/stylesheets/sepia.css"
)
config.bind(",,", 'set content.user_stylesheets ""')
config.bind(",t", "tab-give")
config.bind(",g", "spawn --userscript git2code")
config.bind(",r", "spawn --userscript readability-js")
config.bind(",s", "hint links userscript doi")
config.bind(",f", "hint links tab")
config.bind(",o", "cmd-set-text -s :open -w")
config.bind(",e", "open -t https://www.deepl.com/translator")
config.bind(",b", "open -t https://bilibili.com")
config.bind(",n", "open -t https://www.nivod.tv")
config.bind(",m", "open -t https://mail.google.com")
config.bind(",v", "open -t https://v2ex.com")
config.bind(",z", "spawn --userscript zotero")
config.bind(",Z", "hint links userscript zotero")

# Bindings for cmd
# Leader key: `\`

config.bind("\\d", "help")
config.bind("\\h", "history")
config.bind("\\m", "messages")
config.bind("\\r", "config-source")
config.bind("\\u", "adblock-update")
