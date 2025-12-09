#!/usr/bin/env bash

# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                        Theme Switcher Script                              ║
# ║                    Easily switch between rofi themes                      ║
# ╚══════════════════════════════════════════════════════════════════════════╝

THEMES_DIR="$HOME/.config/rofi/themes"
CONFIG_FILE="$HOME/.config/rofi/config.rasi"

# Get available themes
get_themes() {
    ls -1 "$THEMES_DIR"/*.rasi 2>/dev/null | while read -r theme; do
        basename "$theme" .rasi
    done
}

# Show rofi menu to select theme
select_theme() {
    get_themes | rofi -dmenu \
        -p "󰸌 Theme" \
        -mesg "Select a theme to apply" \
        -theme "$THEMES_DIR/catppuccin-mocha.rasi"
}

# Apply selected theme
apply_theme() {
    local theme="$1"
    if [[ -f "$THEMES_DIR/$theme.rasi" ]]; then
        # Update config.rasi to use the selected theme
        sed -i "s|@theme \"themes/.*\"|@theme \"themes/$theme.rasi\"|" "$CONFIG_FILE"
        notify-send "Rofi Theme" "Applied: $theme" -i preferences-desktop-theme
    else
        notify-send "Rofi Theme" "Theme not found: $theme" -i dialog-error
    fi
}

# Main
main() {
    selected=$(select_theme)
    if [[ -n "$selected" ]]; then
        apply_theme "$selected"
    fi
}

main "$@"
