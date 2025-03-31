#!/bin/bash
echo $(curl "wttr.in/Egypt?format="%C%t"") | dzen2 -p 3 -w 200 -fn "Hack Nerd Font"
