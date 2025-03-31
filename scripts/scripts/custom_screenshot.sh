#!/bin/bash

# Take a screenshot with non-rectangle selection
scrot --select "$HOME/screenshot_temp.png"

# Add a delay to allow time for selecting
sleep 1

# Get the window ID of the selection
WINDOW_ID=$(xdotool getactivewindow)

# Move the selected region to the top-left corner
xdotool windowmove $WINDOW_ID 0 0

# Resize the selected region
xdotool windowsize $WINDOW_ID 800 600

# Rename the screenshot file
mv "$HOME/screenshot_temp.png" "$HOME/custom_screenshot.png"
