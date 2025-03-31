package main

import (
	"time"
)

var prayersOrder = [...]string{"Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"}

func parseTimings(prayers map[string]string) map[string]time.Time {
	prayersParsed := make(map[string]time.Time, 6)

	for key, value := range prayers {
		parsedTime, _ := time.Parse("15:04", value)
		prayersParsed[key] = parsedTime
	}
	return prayersParsed
}

// var prayers = map[string]string{
// 	"Fajr":    "04:46",
// 	"Sunrise": "06:15",
// 	"Dhuhr":   "11:39",
// 	"Asr":     "14:42",
// 	"Maghrib": "17:02",
// 	"Isha":    "18:22",
// }
