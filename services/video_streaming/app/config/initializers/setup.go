package initializers

import (
	"net/http"

	. "config"
	. "router"
)

func Setup() *Boot {
	siteMux := http.NewServeMux()
	routers := NewRouters(siteMux)
	gateway := Gateway{
		Routers: routers,

	}
	configuration := NewConfig(siteMux)
	app := NewApp(configuration)
	
	return &Boot{
		App: app,
		Gateway: &gateway,
	}
}
