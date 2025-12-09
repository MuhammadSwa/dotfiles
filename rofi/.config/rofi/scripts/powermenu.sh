#!/usr/bin/env bash

# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                          Power Menu Script                                ║
# ║                    System power controls via rofi                         ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# Options
shutdown='⏻'
reboot='󰜉'
lock='󰌾'
suspend='󰤄'
logout='󰍃'

# Confirmation
confirm_exit() {
    echo -e "Yes\nNo" | rofi -dmenu \
        -p "Confirm?" \
        -theme ~/.config/rofi/themes/confirm.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu \
        -p "Power" \
        -mesg "System Power Menu" \
        -theme ~/.config/rofi/themes/powermenu.rasi
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "Yes" ]]; then
        case $1 in
            --shutdown)
                systemctl poweroff
                ;;
            --reboot)
                systemctl reboot
                ;;
            --suspend)
                systemctl suspend
                ;;
            --logout)
                # Adjust this for your WM/DE
                if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
                    hyprctl dispatch exit
                elif [[ "$XDG_CURRENT_DESKTOP" == "sway" ]]; then
                    swaymsg exit
                elif [[ "$XDG_CURRENT_DESKTOP" == "i3" ]]; then
                    i3-msg exit
                else
                    pkill -KILL -u "$USER"
                fi
                ;;
        esac
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        # Adjust for your screen locker
        if command -v swaylock &> /dev/null; then
            swaylock
        elif command -v hyprlock &> /dev/null; then
            hyprlock
        elif command -v i3lock &> /dev/null; then
            i3lock -c 1e1e2e
        fi
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
