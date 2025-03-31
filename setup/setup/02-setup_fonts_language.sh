#!/bin/bash
paru -S noto-fonts noto-fonts-emoji noto-fonts-ar
sudo cp ~/dotfiles/Data/fonts/Hack\ Regular\ Nerd\ Font\ Complete.ttf /usr/share/fonts
fc-cache

[ -d /etc/X11/xorg.conf.d ] || mkdir /etc/X11/xorg.conf.d/
sudo cp ~/dotfiles/Data/Data/00-keyboard.conf /etc/X11/xorg.conf.d/
