package main

import (
	"fmt"
	"net/http"
	configuration "config"
	"router"
	"app"
)

func main() {
	siteMux := http.NewServeMux()
	router := router.NewRouter(siteMux)
	configuration := configuration.NewConfig(siteMux)
	application := app.NewApp(configuration)


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
		application.Listen()
	}
	return
}
