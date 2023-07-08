package main

import (
	. "initializers"
	. "library"
)

func main() {
	gateway, app := Setup()

	boot := Boot{
		App: app,
		Gateway: gateway,
	}
	Async(boot.Load)
}
