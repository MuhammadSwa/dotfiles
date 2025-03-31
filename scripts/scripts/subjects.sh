#!/bin/bash

subject=$(find ~/college/* -type d | rofi -dmenu -p "Subject: ")
[[ -z $subject ]] && exit 1

lecture=$(find "$subject"/* | rofi -dmenu -p "Lecture: ")
[[ -z $lecture ]] && exit 1

sioyek "$lecture"

