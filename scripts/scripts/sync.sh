#!/bin/bash

paths=("$HOME/MyVault" "$HOME/dotfiles")

for((i=0;i<${#paths[*]};i++)){
    cd ${paths[$i]}
    # git pull -q
    #
    # check_changes=$(git status --porcelain | wc -l)
    # if [[ $check_changes -eq 0 ]]; then
    #     continue
    # fi
    git add .
    git commit -q -m 'commit'
    git push -q -u origin master
}
