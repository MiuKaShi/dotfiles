# privacy
c.content.cookies.accept = "no-3rdparty"
c.content.geolocation = False
c.content.canvas_reading = True
c.content.media.audio_capture = "ask"
c.content.media.video_capture = "ask"
c.content.tls.certificate_errors = "ask"
c.content.desktop_capture = "ask"
c.content.mouse_lock = "ask"
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.site_specific_quirks.enabled = False
c.content.headers.do_not_track = True
c.content.headers.referer = "same-domain"
c.content.headers.user_agent = "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version} {upstream_browser_key}/122.0.0.0 Safari/{webkit_version}"

url_dict = {
    "js": [
        "*://*.linux.do/*",
        "*://*.youtube.com/*",
        "*://127.0.0.1/*",
        "*://darksky.net/*",
        "*://deepl.com/*",
        "*://duckduckgo.com/*",
        "*://github.com/*",
        "*://linkedin.com/*",
        "*://localhost/*",
        "*://news.ycombinator.com/*",
        "*://reddit.com/*",
        "*://translate.google.com/*",
        "qute://*/*",
        "chrome://*/*",
    ],
    "clipboard": [
        "*://github.com/*",
        "*://*.stackexchange.com/*",
        "*://outlook.office.com/*",
        "*://mail.yahoo.co.jp/*",
    ],
    "mailto": [
        "*://outlook.office.com/*",
        "*://calendar.google.com/*",
        "*://mail.google.com/*",
        "*://mail.yahoo.co.jp/*",
    ],
    "image": [
        "chrome-devtools://*",
        "devtools://*",
    ],
    "cookie": [
        "*://*.google.com/*",
        "*://*.linux.do/*",
        "*://*.office.com/*",
        "*://*.reddit.com/*",
        "*://*.youtube.com/*",
        "*://*.scienceirect.com/*",
        "*://*.id.elsevier.com/*",
        "*://*.elsevier.com/*",
        "*://login.microsoftonline.com/*",
        "https://*.zoom.us/*",
        "chrome-devtools://*",
        "devtools://*",
    ],
}

for url in url_dict.get("js"):
    config.set("content.javascript.enabled", True, url)

for url in url_dict.get("clipboard"):
    config.set("content.javascript.clipboard", "access", url)

for url in url_dict.get("mailto"):
    config.set("content.register_protocol_handler", True, url)

for url in url_dict.get("image"):
    config.set("content.images", True, url)

for url in url_dict.get("cookie"):
    config.set("content.cookies.accept", "all", url)


# per-domain settings
config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0",
    "https://accounts.google.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36",
    "https://*.slack.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0",
    "https://linux.do/*",
)
