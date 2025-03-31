#!/bin/bash

name=$(rbw list | dmenu)
[[ $? -eq 1 ]] && exit 1

pass=$(rbw get "$name")

echo "$pass" | xclip -selection clipboard
