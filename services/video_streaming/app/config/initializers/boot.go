package initializers

import(
	. "router"
	. "library"
)

type Boot struct {
	App *App
	Gateway *Gateway
}

func (boot *Boot) Load(){
	Async(boot.Gateway.Listen)
	Async(boot.App.Listen)
}