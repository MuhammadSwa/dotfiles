#!/bin/bash
paru -S lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm

[ -d /usr/share/xsessions/ ] || sudo mkdir /usr/share/xsessions/
[ -f /usr/share/xsessions/xmonad.desktop ] || sudo cp ~/dotfiles/Data/Data/xmonad.desktop /usr/share/xsessions/
