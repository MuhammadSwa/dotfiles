#!/bin/bash
sudo pacman -S git xorg-apps xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf
mkdir -p ~/.config/xmonad && cd ~/.config/xmonad
touch xmonad.hs
echo "import XMonad" >> xmonad.hs
echo "main :: IO ()" >> xmonad.hs
echo "main = xmonad def" >> xmonad.hs
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib

curl -sSL https://get.haskellstack.org/ | sh


# stack upgrade
stack init
stack install

paru -S dmenu xterm
