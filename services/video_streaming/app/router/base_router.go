package router

import (
	"net/http"
)

type routerRequests map[string]func(w http.ResponseWriter, r *http.Request)

type Router struct {
	server   *http.ServeMux
	requests routerRequests
}

func (router *Router) Listen() {
	for index, element := range router.requests {
			router.server.HandleFunc(index, element)
	}
}

