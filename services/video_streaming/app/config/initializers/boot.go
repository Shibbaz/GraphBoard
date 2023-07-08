package initializers

import (
	. "library"
	. "router"
)

type Boot struct {
	App *App
	Router *Router
}

func (boot *Boot) Load(){
	Async(boot.Router.Listen)
	Async(boot.App.Listen)
}