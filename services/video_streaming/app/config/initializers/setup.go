package initializers
import (
	"net/http"

	. "config"
	. "router"
)

func Setup()(*Gateway, *App){
	siteMux := http.NewServeMux()
	routers := NewRouters(siteMux)
	gateway := Gateway{
		Routers: routers,

	}
	configuration := NewConfig(siteMux)
	application := NewApp(configuration)
	return &gateway, application	
}
