#!/bin/bash
# ~/.local/bin/workspace-overview.sh

CACHE_DIR="$HOME/.cache/sway-workspaces"
THUMBNAIL_SIZE="300x200"
ROFI_THEME="$HOME/.config/rofi/workspace-theme.rasi"

# Create cache directory
mkdir -p "$CACHE_DIR"

# Function to take screenshot of a workspace
take_workspace_screenshot() {
  local workspace="$1"
  local output_file="$2"

  # Switch to workspace
  swaymsg workspace "$workspace" >/dev/null 2>&1
  sleep 0.1 # Small delay to ensure workspace switch

  # Take screenshot
  grim "$output_file"

  # Create thumbnail
  convert "$output_file" -resize "$THUMBNAIL_SIZE" "${output_file%.png}_thumb.png"
}

# Function to get current workspace
get_current_workspace() {
  swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name'
}

# Function to generate workspace info with screenshots
generate_workspace_list() {
  local current_ws=$(get_current_workspace)
  local workspace_list=""

  # Get all workspaces
  local workspaces=$(swaymsg -t get_workspaces | jq -r '.[] | .name')

  for ws in $workspaces; do
    local screenshot_path="$CACHE_DIR/ws_${ws}.png"
    local thumbnail_path="$CACHE_DIR/ws_${ws}_thumb.png"

    # Take screenshot if it doesn't exist or is older than 30 seconds
    if [[ ! -f "$thumbnail_path" ]] || [[ $(find "$thumbnail_path" -mtime +30s 2>/dev/null) ]]; then
      take_workspace_screenshot "$ws" "$screenshot_path"
    fi

    # Add to list with thumbnail path
    if [[ "$ws" == "$current_ws" ]]; then
      workspace_list+="● $ws\0icon\x1f$thumbnail_path\n"
    else
      workspace_list+="  $ws\0icon\x1f$thumbnail_path\n"
    fi
  done

  # Switch back to original workspace
  swaymsg workspace "$current_ws" >/dev/null 2>&1

  echo -e "$workspace_list"
}

# Function to show workspace picker
show_workspace_picker() {
  local workspace_list=$(generate_workspace_list)

  # Use rofi to display workspaces with thumbnails
  local choice=$(echo -e "$workspace_list" | rofi \
    -dmenu \
    -i \
    -p "Workspaces" \
    -theme "$ROFI_THEME" \
    -show-icons \
    -kb-accept-entry "Return,KP_Enter" \
    -kb-cancel "Escape,Super_L" \
    -format "s")

  if [[ -n "$choice" ]]; then
    # Extract workspace name (remove bullet point if present)
    local workspace=$(echo "$choice" | sed 's/^[●  ]*//')
    swaymsg workspace "$workspace"
  fi
}

# Main execution
case "${1:-show}" in
"show")
  show_workspace_picker
  ;;
"refresh")
  rm -f "$CACHE_DIR"/*.png
  echo "Workspace screenshots cleared"
  ;;
"help" | *)
  echo "Usage: $0 [show|refresh|help]"
  echo "  show    - Show workspace overview (default)"
  echo "  refresh - Clear cached screenshots"
  echo "  help    - Show this help"
  ;;
esac
