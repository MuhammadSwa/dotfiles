#!/bin/bash

test -f "$1" && highlight -O ansi "$1" || cat "$1"
case "$1" in
        # *.png)  feh -o $1 ;;
        # *.pdf) zathura "$1" - ;;
    *.zip) unzip -l "$1" ;;
    *.rar) unrar l "$1" ;;
    *.7z) 7z l "$1" ;;
    *.tar*) tar tf "$1" ;;
        # *.pdf) pdftotext "$1" - ;;
esac
