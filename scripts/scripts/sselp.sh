#!/bin/bash
path="$HOME/MyVault/Areas/Dentistry/Dental caries.md"
# echo "- $(sselp)" >> "/media/Maind/MyVault/highlights.md"
echo "- $(wl-paste -p)" >> "/media/Maind/MyVault/highlights.md"
# xsel >> ~/MyVault/highlights.md
# sselp >> ~/MyVault/highlights.md
# printf "\n" >> ~/MyVault/highlights.md
# echo " - $(parcellite)" >> ~/MyVault/highlights.md
# xsel -b >> ~/MyVault/highlights.md
notify-send "text saved to highlights" -t 500
# | dzen2 -fg white -bg black -w 300 -h 50 -p 1 -ta c -sa c
