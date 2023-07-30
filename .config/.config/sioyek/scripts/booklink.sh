#! /bin/bash

#set as follow to handl the link
#xdg-mime default sioyek-link.desktop x-scheme-handler/sioyek

filename=$1
page=$(($2 + 1))
url="reference://file=$filename&page=$page"
title=$(echo "$filename" | cut -f1 -d'.')

echo "[$title-P$page]($url)" | xsel -b && notify-send -t 2000 "add booklink" "bookmark at page=$page..."
