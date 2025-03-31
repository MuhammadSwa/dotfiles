package main

import (
	"fmt"
	"os"

	// "go/format"
	"time"
)

// when passed argument is help
func help() {
	// TODO : refactor
	fmt.Println(
		"Valid arguments:\n- list => To list all prayers Fajr to Isha\n- next => To know the coming prayer ",
	)
}

// when passed argument is list
func printTimings(prayers map[string]string) {
	for _, name := range prayersOrder {
		fmt.Printf("%s:%s\n", name, prayers[name])
	}
}

// when passed argument is next
func nextPrayer(p map[string]time.Time, order [6]string) {
	// TODO : know exactly what's left
	var nextPrayer string
	var timeLeftForNextPrayer time.Duration

	now := time.Now().Format("15:04:05")
	nowParsed, _ := time.Parse("15:04:05", now)

	for _, name := range order {

		// TODO time.Now() is the main problem
		if p[name].After(nowParsed) {
			// if p[name].After(timej) {
			nextPrayer = name
			timeLeftForNextPrayer = p[name].Sub(nowParsed)
			// timeLeft = p[name].Sub(timej)
			break
		} else {
			// It's fajr next day
			nextPrayer = order[0]
			// now is the day before
			fajrNextDay := p["Fajr"].AddDate(0, 0, 1)
			timeLeftForNextPrayer = fajrNextDay.Sub(nowParsed)
			// now is the day after
			continue
		}
	}

	fmt.Printf("Next Prayer is: %s-> %v\n", nextPrayer, timeLeftForNextPrayer)
}

// func subtractTime(time1, time2 time.Time) time.Duration {
// 	diff := time2.Sub(time1)
// 	fmt.Println(diff)
// 	return diff
// }

func main() {
	shouldFetch()
	unMarshalJson(&prayersTimings)

	prayers := parseTimings(prayersTimings.Data.Timings)

	if len(os.Args) > 1 {
		switch os.Args[1] {
		case "list":
			printTimings(prayersTimings.Data.Timings)
		case "next":
			nextPrayer(prayers, prayersOrder)
		case "help":
			help()
		default:
			fmt.Fprintln(os.Stderr, "Please provide a valid argument")
			help()
		}
	} else {
		help()

	}
}
