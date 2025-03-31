#!/bin/bash
city="Cairo"
country="Egypt"
method=5
output=$HOME/scripts/prayer_timings/$(date +%d | sed 's/ /_/g').json
mv ~/scripts/prayer_timings/*.json ~/scripts/prayer_timings/bak
# rm -f $HOME/scripts/prayer_timings/*.json
curl -s "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=$method" -o $output
