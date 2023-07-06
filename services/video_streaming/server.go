package main

import (
	"fmt"
	"net/http"

	. "config"
	. "router"
	. "app"
)

func main() {
	siteMux := http.NewServeMux()
	router := NewRouter(siteMux)
	configuration := NewConfig(siteMux)
	application := NewApp(configuration)


	errors := make(chan error)
	go func() {
		successful := true
		if !successful {
			errors <- fmt.Errorf("operation failed")
		}
		close(errors)
	}()
	err := <-errors
	if err != nil {
		fmt.Println(err.Error())
	} else {
		router.Listen()
		application.Listen()
	}
	return
}
