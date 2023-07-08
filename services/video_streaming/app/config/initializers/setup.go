package initializers
import (
	. "config"
	. "router"
)

func Setup()(*Router, *App){
	siteMux := http.NewServeMux()
	router := NewRouter(siteMux)
	configuration := NewConfig(siteMux)
	application := NewApp(configuration)
	return router, application	
}
