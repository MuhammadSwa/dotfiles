#!/bin/bash

# declare a associative array
declare -A path_of
# path_of[name] = path
path_of[nvim]=$HOME/.config/nvim/init.lua
path_of[kitty]=$HOME/.config/kitty/kitty.conf
path_of[lf]=$HOME/.config/lf/lfrc
path_of[fontconf]=$HOME/.config/fontconfig/fonts.conf
path_of[zsh]=$HOME/.config/zsh/
path_of[sxhkd]=$HOME/.config/sxhkd/sxhkdrc
path_of[qtile]=$HOME/.config/qtile/config.py


# get the keys of the array and pipe them to dmenu
name_of_path=$(for key in "${!path_of[@]}"; do echo "$key" ; done | dmenu -l 10 -p "Choose a Conf")

# check if none chosen
[[ -z $name_of_path ]] && exit 0

# get the value of the array (the path of the program)
path=${path_of[$name_of_path]}

# open the path
kitty -e nvim "$path"
