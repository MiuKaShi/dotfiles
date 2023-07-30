#/bin/sh -e

# Fcitx5
qdbus "org.fcitx.Fcitx5" "/controller" "org.fcitx.Fcitx.Controller1.CurrentInputMethod"

# Fcitx旧版本
# qdbus "org.fcitx.Fcitx" "/inputmethod" "GetCurrentIM"
