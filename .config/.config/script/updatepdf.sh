#!/bin/bash

PDF_MEDIA="/home/miuka/papers/pdf/pdf_media"

latest_file=$(find "$PDF_MEDIA" -maxdepth 1 -type f -name "*.md" -newermt "5 seconds ago")

if [[ -n "$latest_file" ]]; then
    while IFS= read -r line; do
        [ -f "$line" ] && notify-send "Update PDF media..."
        if compiler "$line"; then
            rm -rf "$line"
        else
            notify-send "Fail to update PDF media..."
        fi
    done <<<"$latest_file"
fi
