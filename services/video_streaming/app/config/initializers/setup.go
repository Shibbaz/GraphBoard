package initializers

import (
	"net/http"

	. "config"
	. "router"
)

func Setup() *Boot {
	siteMux := http.NewServeMux()
	gateway := Gateway{
		Routers: NewRouters(siteMux),

	}
	app := NewApp(NewConfig(siteMux))
	
	return &Boot{
		App: app,
		Gateway: &gateway,
	}
}
