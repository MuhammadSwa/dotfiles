#!/bin/bash
vnstat --oneline | awk -F";" '{print "D",$4,"|","M",$9}' | dzen2 -p 3 -w 200
