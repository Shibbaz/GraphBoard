package initializers

import(
	"fmt"
	"net/http"
	. "config"
)

type App struct {
	config *Config
	server *http.Server
}

func NewApp(config *Config) *App {
	srv := NewServer(config)
	return &App{config: config, server: srv}
}

func (app *App) Listen() {
	fmt.Print("service/streaming listening at port ", app.config.Addr)
	if err := app.server.ListenAndServe(); err != nil {
		panic(err)
	}
}