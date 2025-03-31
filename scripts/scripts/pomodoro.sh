#!/bin/bash
### The go version of pomodoro

# if no arguments passed use deafult 25m
if [[ $# == 0 ]];then
    /media/Maind/goProjects/pomodoro/pomodoro | dzen2 -p -fg white -w 80

    # if demnu argument passed use dmenu to set pomodoro time
    elif [[ $1 == "dmenu" ]];then
    time=$(echo |dmenu)
    /media/Maind/goProjects/pomodoro/pomodoro "$time" | dzen2 -fg white -w 80
fi

task=$(rofi -dmenu -p "Task: ")
if [[ $task == "" ]];then
    exit 0
fi

echo "- $task | completed at: $(date +%I:%M)" >> ~/MyVault/pomodoro/"$(date -I)".md

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
