#!/bin/bash
free -h | grep Mem | awk '{print "used:"$3" | ""free: "$4}' | dzen2 -p 2 -w 200
