package main

import (
	. "initializers"
	. "library"
)

func main() {
	router, app := Setup()

	boot := Boot{
		App: app,
		Router: router,
	}
	Async(boot.Load)
}
