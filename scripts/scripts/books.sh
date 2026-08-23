#!/bin/bash

#
# tmpfile=$(mktemp)
# find /media/Maind/كتب2/ /media/Maind/كتب/ /media/Maind/Dental_books/ -type f ! -path "$HOME/Books/site/*" >"$tmpfile"
# # chosen_book=$(sed 's|.*/\([^/]*\)/\([^/]*\)$|\1/\2|' "$tmpfile" | ~/Mzahrawi/productivity/badi/zig-out/bin/badi)
# chosen_book=$(sed 's|.*/\([^/]*\)/\([^/]*\)$|\1/\2|' "$tmpfile" | ~/Mzahrawi/ongoing/badi/zig-out/bin/gtk-zig)
# chosen_book=$(grep -F "/$chosen_book" "$tmpfile" | head -1)
# rm -f "$tmpfile"
#
# [[ $? -eq 1 ]] && exit 1
# sioyek "$chosen_book"
tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT

chosen=$(
    fd --type f --hidden --no-ignore -E 'site' \
        . /media/Maind/كتب2 /media/Maind/كتب /media/Maind/Dental_books \
    | tee "$tmpfile" \
    | sed 's|.*/\([^/]*\)/\([^/]*\)$|\1/\2|' \
    | ~/Mzahrawi/ongoing/badi/zig-out/bin/gtk-zig
    # | ~/Mzahrawi/productivity/badi/zig-out/bin/badi
) || exit 1

[[ -n $chosen ]] || exit 1

path=$(grep -F "/$chosen" "$tmpfile" | head -n1)
[[ -n $path ]] && exec sioyek "$path"
