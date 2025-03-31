#!/bin/bash
name=$(echo "$2" | awk -F"/" '{print $NF}')
# name=$(echo "/media/clutter/كتب/سيرة\ شريفة/فقه_السيرة_النبوية_مع_موجز_لتاريخ_الخلافة_الراشدة.pdf" | awk -F"/" '{print $NF}')
highlighted=$(sselp)
printf "- %s\n\t- %s ص%s" "$highlighted" "$name" "$1" | xclip -selection clipboard
# printf "- %s\n\t- %s ص%s" "$highlighted" "$name" "$1"  >> ~/MyVault/highlights.md
# echo "$highlighted" >> ~/MyVault/highlights.md
# [ -d ~/Pictures/ ] || mkdir ~/Pictures/
# cd ~/Pictures/
# [ -d "$name" ] || mkdir "$name"
# maim -s ~/Pictures/"$name"/صفحة_"$1"_"$name"

# check ~/.xpdfrc
