#!/bin/bash
# ~/.local/bin/workspace-overview-wofi.sh

CACHE_DIR="$HOME/.cache/sway-workspaces"
THUMBNAIL_SIZE="200x150"

# Create cache directory
mkdir -p "$CACHE_DIR"

# Get current workspace
current_ws=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

# Create HTML content for wofi
html_content="<style>
body { 
    background: #1e1e1e; 
    color: white; 
    font-family: Inter, sans-serif; 
    margin: 0; 
    padding: 20px;
}
.workspace {
    display: inline-block;
    margin: 10px;
    padding: 15px;
    border: 2px solid #444;
    border-radius: 8px;
    text-align: center;
    cursor: pointer;
    background: #2d2d2d;
    transition: all 0.3s;
}
.workspace:hover {
    border-color: #64a6ff;
    background: #3d3d3d;
}
.workspace.current {
    border-color: #64a6ff;
    background: #1a3a5c;
}
.workspace img {
    display: block;
    margin: 0 auto 10px;
    border-radius: 4px;
    max-width: 200px;
    max-height: 150px;
}
.workspace-name {
    margin-top: 10px;
    font-weight: bold;
}
</style>
<div>"

# Generate screenshots and HTML for each workspace
swaymsg -t get_workspaces | jq -r '.[] | .name' | while read -r ws; do
  screenshot_path="$CACHE_DIR/ws_${ws}.png"
  thumbnail_path="$CACHE_DIR/ws_${ws}_thumb.png"

  # Take screenshot if needed
  if [[ ! -f "$thumbnail_path" ]] || [[ $(find "$thumbnail_path" -mmin +5 2>/dev/null) ]]; then
    swaymsg workspace "$ws" >/dev/null 2>&1
    sleep 0.2
    grim "$screenshot_path"
    convert "$screenshot_path" -resize "$THUMBNAIL_SIZE" "$thumbnail_path"
  fi

  # Add to HTML
  current_class=""
  if [[ "$ws" == "$current_ws" ]]; then
    current_class=" current"
  fi

  html_content+="<div class='workspace${current_class}' onclick='selectWorkspace(\"$ws\")'>
        <img src='$thumbnail_path' alt='Workspace $ws'>
        <div class='workspace-name'>$ws</div>
    </div>"
done

html_content+="</div>
<script>
function selectWorkspace(ws) {
    console.log(ws);
    window.close();
}
</script>"

# Switch back to original workspace
swaymsg workspace "$current_ws" >/dev/null 2>&1

# Create temporary HTML file
temp_html="/tmp/workspace-overview.html"
echo "$html_content" >"$temp_html"

# Show with wofi or alternative
if command -v wofi >/dev/null; then
  swaymsg -t get_workspaces | jq -r '.[] | .name' | wofi \
    --dmenu \
    --prompt "Select Workspace" \
    --width 600 \
    --height 400 \
    --cache-file /dev/null | while read -r selected_ws; do
    if [[ -n "$selected_ws" ]]; then
      swaymsg workspace "$selected_ws"
    fi
  done
else
  echo "Wofi not found. Please install wofi."
fi
