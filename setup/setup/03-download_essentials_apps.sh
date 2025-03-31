#!/bin/bash
# tools=( "kitty" "zsh" "bgs" )
# for x in ${tools[*]}
# do
#     paru -S $x
# done
# paru -S kitty zsh bgs sxhkd dzen2 jq cronie libnotify dunst bat zenity sselp gotop-bin figlet neofetch openssh cronie maim xclip zbar clipmenu
# paru -S neovim unzip npm beautysh stylelint prettierd shellcheck autopep8 stylua flake8 xarchiver go qbittorrent
# sudo npm install -g emmet-ls
# paru -S brave-bin obsidian zotero-bin sioyek thunar flameshot imagemagick
installPkg(){
    pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
}
while read line
do
    installPkg "$line"
done < ~/setup/app_list.txt
