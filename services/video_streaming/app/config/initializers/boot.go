package initializers

import (
	"fmt"

	. "router"
)

type Boot struct {
	App *App
	Router *Router
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