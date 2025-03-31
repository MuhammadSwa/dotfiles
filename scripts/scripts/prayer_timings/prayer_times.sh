#!/bin/bash

# run fetch_prayeer_timings every day
fileDate=$(find ~/scripts/prayer_timings/*.json \
        | awk -F'/' '{print $NF}' \
        | awk -F'.' '{print $1}'
)
[[ "$fileDate" = "$(date +%d)" ]] || "$HOME/scripts/prayer_timings/fetch_prayeer_timings.sh"


data="$HOME/scripts/prayer_timings/*.json"

declare -A prayer
prayer[Fajr]=$(jq ".data.timings.Fajr" $data | sed 's/"//g')
prayer[Sunrise]=$(jq ".data.timings.Sunrise" $data | sed 's/"//g')
prayer[Dhuhr]=$(jq ".data.timings.Dhuhr" $data | sed 's/"//g')
prayer[Asr]=$(jq ".data.timings.Asr" $data | sed 's/"//g')
prayer[Maghrib]=$(jq ".data.timings.Maghrib" $data | sed 's/"//g')
prayer[Isha]=$(jq ".data.timings.Isha" $data | sed 's/"//g')
prayer[Hijri_day]=$(jq ".data.date.hijri.date" $data | sed 's/"//g')

time_now=$(date +%s)

declare -A times_in_seconds

times_in_seconds[Fajr]=$(date --date ${prayer[Fajr]} +%s)
times_in_seconds[Sunrise]=$(date --date ${prayer[Sunrise]} +%s)
times_in_seconds[Dhuhr]=$(date --date ${prayer[Dhuhr]} +%s)
times_in_seconds[Asr]=$(date --date ${prayer[Asr]} +%s)
times_in_seconds[Maghrib]=$(date --date ${prayer[Maghrib]} +%s)
times_in_seconds[Isha]=$(date --date ${prayer[Isha]} +%s)

# prayer times in ordered array
times_in_seconds_array=(${times_in_seconds[Fajr]} ${times_in_seconds[Sunrise]} ${times_in_seconds[Dhuhr]} \
    ${times_in_seconds[Asr]} ${times_in_seconds[Maghrib]} ${times_in_seconds[Isha]}    )

# find out what prayer is next
for i in ${times_in_seconds_array[*]}
do
    if [[ $i -ge $time_now ]]; then
        next_prayer=$i
        break
    else
        next_prayer=$i
    fi
done

#next_prayer_name
for key in ${!times_in_seconds[*]}
do
    [[ ${times_in_seconds[$key]} -eq $next_prayer ]] && next_prayer_name=$key && break
done


# calc how much time left for next prayer
delta=$((next_prayer - time_now))
h=0
m=0
while [[ $delta -ge 3600 ]]; do
    h=$((h + 1))
    delta=$((delta-3600))
done
while [[ $delta -ge 60 ]]; do
    m=$((m+1))
    delta=$((delta-60))
done

left(){
    echo "Time left for $next_prayer_name: $h:$m:$delta" " :: ""${prayer[Hijri_day]}"
}

# to show prayer times in dmenu
list(){
    for i in "${!prayer[@]}"
    do
        printf "$i: "${prayer[$i]}"\n"
    done
    # dmenu -p "Next Prayer:$next_prayer_name"
}
case "$1" in
    list) list ;;
    left) left ;;
esac

exit 0
