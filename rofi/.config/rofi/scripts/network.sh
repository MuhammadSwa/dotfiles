#!/usr/bin/env bash

# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                       Network Menu Script                                 ║
# ║              Quick network/WiFi controls via rofi                        ║
# ╚══════════════════════════════════════════════════════════════════════════╝

# Check if NetworkManager is running
if ! systemctl is-active --quiet NetworkManager; then
    notify-send "Network" "NetworkManager is not running" -i network-error
    exit 1
fi

# Get current connection status
get_status() {
    nmcli -t -f WIFI g | head -1
}

# Get list of available WiFi networks
get_wifi_list() {
    nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | \
        awk -F: '{
            if ($1 != "") {
                signal = $2
                security = ($3 != "") ? " 󰌾" : ""
                if (signal >= 75) icon = "󰤨"
                else if (signal >= 50) icon = "󰤥"
                else if (signal >= 25) icon = "󰤢"
                else icon = "󰤟"
                printf "%s %s %s%s\n", icon, $1, signal"%", security
            }
        }'
}

# Get saved connections
get_saved() {
    nmcli -t -f NAME,TYPE connection show | grep wireless | cut -d: -f1
}

# Toggle WiFi
toggle_wifi() {
    status=$(get_status)
    if [[ "$status" == "enabled" ]]; then
        nmcli radio wifi off
        notify-send "WiFi" "Disabled" -i network-wireless-offline
    else
        nmcli radio wifi on
        notify-send "WiFi" "Enabled" -i network-wireless
    fi
}

# Connect to network
connect_wifi() {
    local ssid="$1"
    # Extract just the SSID (remove icon, signal, etc.)
    ssid=$(echo "$ssid" | sed 's/^[^ ]* //' | sed 's/ [0-9]*%.*$//')
    
    # Check if we have a saved connection
    if nmcli connection show "$ssid" &>/dev/null; then
        nmcli connection up "$ssid"
    else
        # Need password
        password=$(rofi -dmenu -p "Password" -password -theme ~/.config/rofi/themes/catppuccin-mocha.rasi)
        if [[ -n "$password" ]]; then
            nmcli device wifi connect "$ssid" password "$password"
        fi
    fi
}

# Main menu
main_menu() {
    local wifi_status
    wifi_status=$(get_status)
    
    local toggle_option
    if [[ "$wifi_status" == "enabled" ]]; then
        toggle_option="󰤮 Disable WiFi"
    else
        toggle_option="󰤨 Enable WiFi"
    fi
    
    echo -e "$toggle_option\n󰁪 Scan Networks\n󰛳 Network Settings"
}

# Show WiFi list
show_wifi() {
    echo "󰑓 Refresh"
    get_wifi_list
}

# Run rofi
run_rofi() {
    rofi -dmenu \
        -p "󰛳 Network" \
        -theme ~/.config/rofi/themes/catppuccin-mocha.rasi
}

# Main
chosen=$(main_menu | run_rofi)

case "$chosen" in
    *"Disable WiFi"*|*"Enable WiFi"*)
        toggle_wifi
        ;;
    *"Scan Networks"*)
        # Rescan
        nmcli device wifi rescan
        sleep 1
        selected=$(show_wifi | run_rofi)
        if [[ "$selected" == *"Refresh"* ]]; then
            nmcli device wifi rescan
            sleep 1
            selected=$(show_wifi | run_rofi)
        fi
        if [[ -n "$selected" && "$selected" != *"Refresh"* ]]; then
            connect_wifi "$selected"
        fi
        ;;
    *"Network Settings"*)
        # Open network settings (adjust for your DE)
        if command -v nm-connection-editor &>/dev/null; then
            nm-connection-editor &
        elif command -v gnome-control-center &>/dev/null; then
            gnome-control-center network &
        fi
        ;;
esac
