#! /bin/bash

filename=$1
page=$(($2 + 1))
url="reference://file=$filename&page=$page"
title=$(echo "$filename" | cut -f1 -d'.')

tag_list=$(buku --np -t | awk 'gsub( /\(|\)$/, "" ) { $1 = $NF; $NF = ""; print }' | sed -n 's/ref-//p' | cut -d' ' -f2-)
tag=$(echo "$tag_list" | dmenu -i -p "ref-tag(one word):")
[[ -z "$tag" ]] && exit 1

if [ "$(command -v buku)" ]; then
    buku --nostdin -a "$url" "ref-$tag" --title "$title-page=$page" >/dev/null
fi

echo "[$title-P$page]($url)" | xsel -b

notify-send "$title" "bookmark at page=$page..."
