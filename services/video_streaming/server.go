package main

import (
	"fmt"
	"net/http"
)

func main() {
	siteMux := http.NewServeMux()
	router := newRouter(siteMux)
	config := newConfig(siteMux)
	app := newApp(config)

	errors := make(chan error)
	go func() {
		successful := true
		if !successful {
			errors <- fmt.Errorf("Operation failed")
		}
		close(errors)
	}()
	err := <-errors
	if err != nil {
		fmt.Println(err.Error())
	} else {
		router.Listen()
		app.Listen()
	}
	return
}
