package app

import(
	configuration "config"
	"fmt"
	"net/http"
)

type App struct {
	config *configuration.Config
	server *http.Server
}

func NewApp(config *configuration.Config) *App {
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