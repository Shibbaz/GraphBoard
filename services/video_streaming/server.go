package main

import (
	"net/http"
)

func main() {
	siteMux := http.NewServeMux()
	router := newRouter(siteMux)
	config := newConfig(siteMux)
	app := newApp(config)

	router.Listen()
	app.Listen()
	return
}
