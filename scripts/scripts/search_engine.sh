#!/bin/bash

# declare a associative array
declare -A engine
# engine[engine_name]="query_url"
engine[youtube]="https://www.youtube.com/results?search_query="
engine[brave]="search.brave.com/search?q="
engine[AUR]="https://aur.archlinux.org/packages?O=0&SeB=nd&K="


# select an engine
if [[ "$1" == "youtube" ]]; then
    query=$(echo ''| rofi -dmenu -p "$selected_engine")
    [[ -z $query ]] && exit 0
    brave "${engine[youtube]}""$query"
else
    selected_engine=$(for key in "${!engine[@]}";do echo "$key";done | rofi -dmenu -l 10 -p "Choose engine:" )

    # get the query
    query=$(echo ''| rofi -dmenu -p "$selected_engine")
    [[ -z $query ]] && exit 0

    brave "${engine[$selected_engine]}""$query"
fi
