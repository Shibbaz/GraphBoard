package initializers
import (
	"net/http"
	"fmt"

	. "config"
	. "router"
)

type Boot struct {
	App *App
	Router *Router
}

func Setup()(*Router, *App){
	siteMux := http.NewServeMux()
	router := NewRouter(siteMux)
	configuration := NewConfig(siteMux)
	application := NewApp(configuration)
	return router, application	
}

func (boot *Boot) Load(){
	boot.Router.Listen()
	boot.App.Listen()
}

func (boot *Boot) Async(callback interface{}){
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
		callback.(func())()
	}
	return
}
