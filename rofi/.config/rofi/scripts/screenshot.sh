#!/usr/bin/env bash

# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                       Screenshot Menu Script                              ║
# ║                 Quick screenshot options via rofi                         ║
# ╚══════════════════════════════════════════════════════════════════════════╝

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Options
fullscreen='󰍹 Full Screen'
selection='󰩭 Selection'
window='󰖯 Active Window'
timer='󰔛 Timer (5s)'
clipboard='󰅌 Selection to Clipboard'

# Show menu
run_rofi() {
    echo -e "$fullscreen\n$selection\n$window\n$timer\n$clipboard" | rofi -dmenu \
        -p "󰹑 Screenshot" \
        -theme ~/.config/rofi/themes/catppuccin-mocha.rasi
}

# Get filename
get_filename() {
    echo "$SCREENSHOT_DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"
}

# Take screenshot
take_screenshot() {
    local file
    file=$(get_filename)
    
    case $1 in
        fullscreen)
            if command -v grim &> /dev/null; then
                grim "$file"
            elif command -v scrot &> /dev/null; then
                scrot "$file"
            elif command -v maim &> /dev/null; then
                maim "$file"
            fi
            ;;
        selection)
            if command -v grim &> /dev/null && command -v slurp &> /dev/null; then
                grim -g "$(slurp)" "$file"
            elif command -v scrot &> /dev/null; then
                scrot -s "$file"
            elif command -v maim &> /dev/null; then
                maim -s "$file"
            fi
            ;;
        window)
            if command -v grim &> /dev/null; then
                if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
                    grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$file"
                else
                    grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$file"
                fi
            elif command -v scrot &> /dev/null; then
                scrot -u "$file"
            elif command -v maim &> /dev/null; then
                maim -i "$(xdotool getactivewindow)" "$file"
            fi
            ;;
        timer)
            sleep 5
            if command -v grim &> /dev/null; then
                grim "$file"
            elif command -v scrot &> /dev/null; then
                scrot "$file"
            elif command -v maim &> /dev/null; then
                maim "$file"
            fi
            ;;
        clipboard)
            if command -v grim &> /dev/null && command -v slurp &> /dev/null; then
                grim -g "$(slurp)" - | wl-copy
            elif command -v maim &> /dev/null; then
                maim -s | xclip -selection clipboard -t image/png
            fi
            notify-send "Screenshot" "Copied to clipboard" -i camera-photo
            return
            ;;
    esac
    
    if [[ -f "$file" ]]; then
        notify-send "Screenshot" "Saved to $file" -i camera-photo
    fi
}

# Main
chosen="$(run_rofi)"
case ${chosen} in
    "$fullscreen")
        take_screenshot fullscreen
        ;;
    "$selection")
        take_screenshot selection
        ;;
    "$window")
        take_screenshot window
        ;;
    "$timer")
        take_screenshot timer
        ;;
    "$clipboard")
        take_screenshot clipboard
        ;;
esac
