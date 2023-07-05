package main

import (
	"fmt"
	"net/http"
)

type App struct {
	config *Config
	server *http.Server
}

func newApp(config *Config) *App {
	srv := &http.Server{
		Addr:         config.Addr,
		Handler:      config.Handler,
		ReadTimeout:  config.ReadTimeout,
		WriteTimeout: config.WriteTimeout,
		IdleTimeout:  config.IdleTimeout,
		ErrorLog:     config.ErrorLogger,
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
