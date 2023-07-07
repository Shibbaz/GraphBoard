package main

import (
	. "initializers"
)

func main() {
	boot := Boot{}
	router, app := boot.Setup()
	boot.Async(boot.Load, app, router)
}
