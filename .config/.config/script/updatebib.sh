#! /bin/sh

BIB="/home/miuka/papers/bib/mybib.bib"

cd "${BIB%/*}" || exit 1
grep -wv @preamble "$BIB" | python journal_abbrev.py >mybib_abb.bib
notify-send "Bib_abbrev Update"
