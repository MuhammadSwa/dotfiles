#!/bin/bash
ssh-keygen -t ed25519 -C "muhammadsw@protonmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
git config --global user.email "muhammadsw@protonmail.com"
git config --global user.name "muhammadSw"
