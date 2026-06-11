#!/bin/bash

tmpfile=$(mktemp)
find ~/Books/ /media/Maind/كتب2/ /media/Maind/كتب/ /media/Maind/Dental_books/ -type f ! -path "$HOME/Books/site/*" >"$tmpfile"
chosen_book=$(sed 's|.*/\([^/]*\)/\([^/]*\)$|\1/\2|' "$tmpfile" | ~/Mzahrawi/productivity/badi/zig-out/bin/badi)
chosen_book=$(grep -F "/$chosen_book" "$tmpfile" | head -1)
rm -f "$tmpfile"

[[ $? -eq 1 ]] && exit 1
sioyek "$chosen_book"
