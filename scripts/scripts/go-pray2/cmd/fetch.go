package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/djherbis/times"
)

const (
	city     = "Cairo"
	country  = "Egypt"
	method   = "5"
	API      = "https://api.aladhan.com/v1/timingsByCity?city=" + city + "&country=" + country + "&method=" + method
	fileName = "/home/alien/goProjects/go-pray/cmd/timings.json"
)

type MyJson struct {
	Data `json:"data"`
}
type Data struct {
	Timings map[string]string `json:"timings"`
}

var prayersTimings MyJson

// get json file from the API
func fetchTimings() {
	resp, err := http.Get(API)

	if err != nil {
		log.Fatalln(err)
	}

	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)

	if err != nil {
		log.Fatalln(err)
	}

	err = ioutil.WriteFile(fileName, body, 0644)

	if err != nil {
		log.Fatalln(err)
	}
}

// if today don't
func shouldFetch() {
	t, err := times.Stat(fileName)

	if err != nil {
		log.Fatalln(err)
	}

	l := t.ChangeTime().Day() == time.Now().Day()
	if !l {
		fetchTimings()
	}

}

func unMarshalJson(prayersTimings *MyJson) {
	file, _ := os.ReadFile(fileName)

	err := json.Unmarshal(file, &prayersTimings)

	if err != nil {
		log.Fatalln(err)
	}
}
