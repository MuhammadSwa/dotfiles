#!/bin/sh

# update mirros
paru -S reflector
sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist

# install terminal , texteditor, stow 
paru -S kitty xstow neovim 
# paru -S lf newsboat htop obsidian zotero thunar dzen2 sselp zenity notify-send dunst vnstat bat
