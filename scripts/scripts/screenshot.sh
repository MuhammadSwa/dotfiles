#!/bin/bash
[[ -d ~/Pictures/ ]] || mkdir ~/Pictures/

dzen2="dzen2 -p 1 -fg white -h 50 -ta c -sa c -w "

select-clip() {
  # maim -s | xclip -selection clipboard -t image/png && echo "screenshot saved to the clipboard" | $(echo "$dzen2" 300)
  # name=$(date +%s).png
  # slurp | grim -g - /media/Maind/MyVault/$name
  # echo "![[$name]]" | wl-copy -t text/plain
  grim -g "$(slurp)" - | wl-copy
  notify-send "screenshot in clipboard"

}

select-save() {
  maim -s ~/Pictures/$(date +%c | sed 's/ /_/g').png && echo "screenshot saved to ~/Pictures/" | $(echo "$dzen2" 300)
}

save() {
  maim ~/Pictures/$(date +%c | sed 's/ /_/g').png && echo "screenshot saved to ~/Pictures/" | $(echo "$dzen2" 300)
}

clip() {
  maim | xclip -selection clipboard -t image/png && echo "screenshot saved to the clipboard" | $(echo "$dzen2" 300)
}

qr() {
  grim -g "$(slurp)" - | zbarimg -q --raw - | wl-copy
  # maim -qs | zbarimg -q --raw - | xclip -selection clipboard -f
}

ocr() {
  [ -d ~/Pictures/Temporary ] || mkdir -p ~/Pictures/Temporary

  maim -s ~/Pictures/Temporary/ocr_screenshot.png

  tesseract ~/Pictures/Temporary/ocr_screenshot.png stdout -l $1 --oem 1 | xclip -selection clipboard

}

arg=$(printf "%s\n" select-clip select-save save clip qr ocr_eng ocr_ara | rofi -dmenu -l 10)
case "$arg" in
# lets you select an area to capture and save it to clipboard
select-clip) select-clip ;;
  #lets you select and area and save to locally
select-save) select-save ;;
  # lets you save the full screen locally
save) save ;;
  # lets you save the full screen to the clipboard
clip) clip ;;
  # get qr code
qr) qr ;;
  # ocr the screenshot
ocr_eng) ocr eng ;;
ocr_ara) ocr ara ;;
esac

# save to Pictures and to clipboard at once
# maim | tee ~/Pictures/$(date +%s).png | xclip -selection clipboard -t image/png
