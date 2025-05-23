#!/bin/bash

NOTIFICATION_ID=12345

CURRENT_ID=$(notify-send -p -h string:x-dunst-stack-tag:pomodoro "Pomodoro" "Starting..." -r "$NOTIFICATION_ID")

# if no arguments passed use deafult 25m
if [[ $# == 0 ]]; then
  # /media/Maind/goProjects/pomodoro/pomodoro | notify-send
  /media/Maind/goProjects/pomodoro/pomodoro | while read -r time_output; do
    dunstify --replace=$CURRENT_ID "Pomodoro Timer" "$time_output" -a Pomodoro
  done

  # Once the pomodoro program finishes, close the notification.

# if demnu argument passed use dmenu to set pomodoro time
elif [[ $1 == "dmenu" ]]; then
  time=$(echo | dmenu)
  /media/Maind/goProjects/pomodoro/pomodoro "$time" | notify-send -fg white -w 80
fi

dunstctl close "$CURRENT_ID"

# task=$(rofi -dmenu -p "Task: ")
# if [[ $task == "" ]]; then
#   exit 0
# fi

# echo "- $task | completed at: $(date +%I:%M)" >> ~/MyVault/pomodoro/"$(date -I)".md

#### The Bash Version of pomodoro
# hour=0
# min=25
# sec=0
#
# while [ $hour -ge 0 ]; do
#     while [ $min -ge 0 ];do
#         while [ $sec -ge 0 ];do
#             echo "$hour:$min:$sec"
#             sec=$((sec-1))
#             sleep 1
#         done
#         sec=59
#         min=$((min-1))
#     done
#     min=59
#     hour=$((hour-1))
# done | dzen2 -p -fg white -p -w 80
