#!/bin/bash

# Get all workspace info from Sway IPC
sway_workspaces=$(swaymsg -t get_workspaces | jq -c '.[]')
sway_outputs=$(swaymsg -t get_outputs | jq -c '.[]')

# --- Header for the overview ---
echo "<h2>Workspaces & Windows</h2>"
echo "<hr>"

# Iterate through outputs (monitors)
echo "<h3>Monitors:</h3>"
echo "<ul>"
echo "$sway_outputs" | while read -r output; do
  output_name=$(echo "$output" | jq -r '.name')
  output_active=$(echo "$output" | jq -r '.active')
  output_focused=$(echo "$output" | jq -r '.focused')

  if [ "$output_active" = "true" ]; then
    output_status="<span style='color: #40a02b;'>Active</span>" # Green
  else
    output_status="<span style='color: #a8a9ad;'>Inactive</span>" # Subtle
  fi

  if [ "$output_focused" = "true" ]; then
    output_status="<span style='color: #ffd700;'>Focused</span>" # Gold
  fi

  echo "<li><strong>$output_name</strong> ($output_status)</li>"
done
echo "</ul>"
echo "<hr>"

# Iterate through workspaces
echo "<h3>Workspaces:</h3>"
echo "<ul>"
echo "$sway_workspaces" | while read -r ws; do
  ws_name=$(echo "$ws" | jq -r '.name')
  ws_output=$(echo "$ws" | jq -r '.output')
  ws_focused=$(echo "$ws" | jq -r '.focused')
  ws_layout=$(echo "$ws" | jq -r '.layout')                  # e.g., "splith", "splitv", "stacked", "tabbed", "auto"
  ws_present_windows=$(echo "$ws" | jq -r '.nodes | length') # Number of windows

  ws_status=""
  if [ "$ws_focused" = "true" ]; then
    ws_status="<span style='color: #4b0082;'>[FOCUSED]</span>" # Deep Indigo
  fi
  if [ "$ws_present_windows" -gt 0 ]; then
    ws_status+=" <span style='color: #a8a9ad;'>($ws_present_windows windows)</span>" # Subtle
  fi

  echo "<li><strong>$ws_name</strong> on $ws_output ($ws_layout) $ws_status"
  echo "  <ul>"
  # Iterate through windows in the workspace
  echo "$ws" | jq -c '.nodes[] | select(.name) | .name, .app_id, .window_properties.class' | while IFS=$'\n' read -r window_info; do
    window_name=$(echo "$window_info" | head -n1)
    window_app_id=$(echo "$window_info" | tail -n2 | head -n1) # app_id or class
    window_class=$(echo "$window_info" | tail -n1)

    display_name="${window_name}"
    if [ "$window_app_id" != "null" ]; then
      display_name+=" ($window_app_id)"
    elif [ "$window_class" != "null" ]; then
      display_name+=" ($window_class)"
    fi

    echo "<li>- $display_name</li>"
  done
  echo "  </ul>"
  echo "</li>"
done
echo "</ul>"
