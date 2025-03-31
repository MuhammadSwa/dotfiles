#!/bin/bash
# read -p 'Do you want to shut down?' answer
# if test "$answer" = 'y'
# then
#     poweroff
# fi
# # cat ~/dotfiles/file | dzen2 -l 2-m -p -fg "black" -bg "white"
# exit 0
[ $(echo -e "Yes\nNo" | rofi -dmenu) == "Yes" ] && poweroff
