#!/bin/bash
du -a ~/scripts/ ~/dotfiles/ ~/setup/ | awk '{print $2}' | fzf | xargs $EDITOR
