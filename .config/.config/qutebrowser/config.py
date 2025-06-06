# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# fonts
font_name = "16pt MonoLisa Nerd Font"
c.fonts.tabs.selected = font_name
c.fonts.tabs.unselected = font_name
c.fonts.statusbar = font_name
c.fonts.messages.info = font_name
c.fonts.downloads = c.fonts.statusbar
c.fonts.prompts = font_name
c.fonts.keyhint = c.fonts.messages.info
c.fonts.messages.warning = c.fonts.messages.info
c.fonts.messages.error = c.fonts.messages.info
c.fonts.completion.entry = font_name
c.fonts.completion.category = c.fonts.statusbar
# c.fonts.hints = "18px MonoLisa Nerd Font"
# c.fonts.default_size = "18pt"

# ui
c.completion.shrink = True
c.completion.use_best_match = True
c.downloads.position = "bottom"
c.downloads.remove_finished = 10000
c.statusbar.widgets = ["progress", "keypress", "url", "history"]
c.statusbar.show = "never"
c.tabs.show = "multiple"
c.tabs.show = "switching"
c.tabs.title.format = "{index}: {audio}{current_title}"
c.tabs.title.format_pinned = "{index}: {audio}{current_title}"

# general
# HDPI(not support WAYLAND)
c.qt.highdpi = True
c.content.images = True
c.content.autoplay = False
c.auto_save.session = True
c.zoom.default = "100%"
c.content.default_encoding = "utf-8"
c.content.notifications.enabled = True
c.editor.command = ["st", "-e", "nvim", "{}"]
c.fileselect.handler = "external"
c.fileselect.folder.command = ["st", "-e", "lfub", "-last-dir-path", "{}"]
c.fileselect.single_file.command = ["st", "-e", "lfub", "-selection-path", "{}"]
c.fileselect.multiple_files.command = [
    "st",
    "-e",
    "lfub",
    "-selection-path",
    "{}",
]
c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.confirm_quit = ["multiple-tabs", "downloads"]
# pacman -S pdfjs-legacy
c.content.pdfjs = False
c.input.insert_mode.auto_load = True
c.spellcheck.languages = ["en-US"]
c.completion.height = "30%"
c.tabs.mousewheel_switching = False
c.scrolling.bar = "never"
c.backend = "webengine"
c.changelog_after_upgrade = "major"
# DNS prefetching
c.content.dns_prefetch = True

# urls
c.url.default_page = "https://google.com/"
c.url.start_pages = "https://google.com/"
c.tabs.last_close = "close"
# c.tabs.last_close = "startpage"

c.qt.force_software_rendering = 'chromium'

## Fix for crashes
c.qt.workarounds.remove_service_workers = True

# enable GPU acceleration
# see https://github.com/qutebrowser/qutebrowser/discussions/6573
# see https://github.com/qutebrowser/qutebrowser/issues/5378
# for webopt see https://github.com/qutebrowser/qutebrowser/issues/8222
c.qt.args = [
    "ignore-gpu-blocklist",
    "enable-gpu-rasterization",
    "enable-webrtc-pipewire-capturer",
    "enable-native-gpu-memory-buffers",
    "enable-accelerated-video-decode",
    "enable-zero-copy",
    "disable-blink-features=WebOTP",
    # 'num-raster-threads=4',
    # 'disable-accelerated-2d-canvas',
]

# Don't automatically leave insert mode. qutebrowser will leave insert mode automatically
config.set("input.insert_mode.auto_leave", False)
c.hints.next_regexes = [
    "\\bnext\\b",
    "\\bmore\\b",
    "\\bnewer\\b",
    "\\b[>→≫]\\b",
    "\\b(>>|»)\\b",
    "\\bcontinue\\b",
    "\\b下一?页\\b",
]
# Comma-separated list of regular expressions to use for 'prev' links.
c.hints.prev_regexes = [
    "\\bprev(ious)?\\b",
    "\\bback\\b",
    "\\bolder\\b",
    "\\b[<←≪]\\b",
    "\\b(<<|«)\\b",
    "\\b上一?页\\b",
]


# cmd aliases
c.aliases = {
    "ba": "spawn --userscript qb-rbuku -a",
    "br": "spawn --userscript qb-rbuku -r",
}

config.source("bindings.py")
config.source("search.py")
config.source("privacy.py")
config.source("blocks.py")
config.source("themes/pyqute/draw.py")
