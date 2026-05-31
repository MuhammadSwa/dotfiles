#!/bin/bash

# books=(
#     "~/Books/Powerful Command-Line Applications in GO.epub"
#     "~/Books/A Common-Sense Guide to Data Structures and Algorithms.pdf"
#     "/home/alien/Zotero/storage/BJQE6UY4/Noor-Book.com  ما لا يسع المسلم جهله 2 .pdf"
# )

# chosen_book=$(printf "%s\n" "${books[@]}" | rofi -dmenu -p "books")

# chosen_book=$(find ~/Books/ /media/Maind/كتب2/ /media/Maind/كتب/ /media/Maind/Dental_books/ -type f ! -path "$HOME/Books/site/*" | rofi -dmenu -p "books" -keep-right -i)
# chosen_book=$(find ~/Books/ /media/Maind/كتب2/ /media/Maind/كتب/ /media/Maind/Dental_books/ -type f ! -path "$HOME/Books/site/*" | ~/Mzahrawi/productivity/badi/zig-out/bin/badi)
tmpfile=$(mktemp)
find ~/Books/ /media/Maind/كتب2/ /media/Maind/كتب/ /media/Maind/Dental_books/ -type f ! -path "$HOME/Books/site/*" >"$tmpfile"
chosen_book=$(sed 's|.*/\([^/]*\)/\([^/]*\)$|\1/\2|' "$tmpfile" | ~/Mzahrawi/productivity/badi/zig-out/bin/badi)
chosen_book=$(grep -F "/$chosen_book" "$tmpfile" | head -1)
rm -f "$tmpfile"

[[ $? -eq 1 ]] && exit 1
# echo $chosen_book
# xpdf -z 200 -open "$chosen_book"
sioyek "$chosen_book"
# okular "$chosen_book"
# zathura "$chosen_book"
