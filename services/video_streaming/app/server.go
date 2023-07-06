package main

import (
	"fmt"
	"net/http"
	configuration "config"
	routers "router"
)

type App struct {
	config *configuration.Config
	server *http.Server
}

func newApp(config *configuration.Config) *App {
	srv := &http.Server{
		Addr:         config.Addr,
		Handler:      config.Handler,
		ReadTimeout:  config.ReadTimeout,
		WriteTimeout: config.WriteTimeout,
		IdleTimeout:  config.IdleTimeout,
	}
	return &App{config: config, server: srv}
}

func (app *App) Listen() {
	fmt.Print("service/streaming listening at port ", app.config.Addr)
	if err := app.server.ListenAndServe(); err != nil {
		panic(err)
	}
	return
}

func main() {
	siteMux := http.NewServeMux()
	router := routers.newRouter(siteMux)
	configuration := configuration.newConfig(siteMux)
	application := newApp(configuration)


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
