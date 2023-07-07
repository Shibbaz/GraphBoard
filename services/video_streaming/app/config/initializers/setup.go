package initializers
import (
	"net/http"
	"fmt"

	. "config"
	. "router"
)

type Boot struct {}

func (boot *Boot) Setup() (*Router, *App){
	siteMux := http.NewServeMux()
	router := NewRouter(siteMux)
	configuration := NewConfig(siteMux)
	application := NewApp(configuration)
	return router, application	
}

func (boot *Boot) Load(app *App, router *Router){
	router.Listen()
	app.Listen()
}

func (boot *Boot) Async(callback interface{}, app *App, router *Router){
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
		callback.(func(app *App, router *Router))(app, router)
	}
	return
}
