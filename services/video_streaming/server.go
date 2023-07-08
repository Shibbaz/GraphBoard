package main

import (
	. "initializers"
	. "library"
)

func main() {
	boot := Setup()
	Async(boot.Load)
}
