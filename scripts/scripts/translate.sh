#!/bin/bash
to_translate=$(sselp)
response=$(curl -d '{"q":"'"$to_translate"' ","source":"en","target":"ar","format":"text"}' -H "Content-Type: application/json; charset=UTF-8" https://libretranslate.de/translate | jq .translatedText)

case "$1" in
    short)  notify-send "$response" ;;
    long) echo "$response" | zenity --text-info --width 300 --height 300 ;;
esac
