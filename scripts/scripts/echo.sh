#!/bin/bash
IFS=" "
echo $1
unquotedPosition=$(sed -e 's/^"//' -e 's/"$//' <<< $1)
echo $unquotedPosition
pageNumber=$(echo $unquotedPosition | awk '{print $1}')
left=$(echo $unquotedPosition | awk '{print $2}')
left=$(printf %.0f "$left")
top=$(echo $unquotedPosition | awk '{print $3}')
top=$(printf %.0f "$top")
cpdf \
	-add-text "allah akbar" \
	-topleft "$top" "$left" \
	-font "Helvetica" \
	-font-size 12 \
	~/Tooth_Wear.pdf \
	"$pageNumber" -o ~/Tooth_Wear.pdf

echo "pageNumber" $pageNumber
echo "left" $left
echo "top" $top
