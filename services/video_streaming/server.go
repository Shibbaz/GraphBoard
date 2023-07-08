package main

import (
	. "initializers"
)

func main() {
	router, app := Setup()

	boot := Boot{
		App: app,
		Router: router,
	}
	boot.Async(boot.Load)
}
