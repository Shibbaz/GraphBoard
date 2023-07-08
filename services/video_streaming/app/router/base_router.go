package router

import (
	"net/http"
)
type RouterRequests map[string]func(w http.ResponseWriter, r *http.Request)

type Router struct {
	server   *http.ServeMux
	requests RouterRequests
}

func (router *Router) Listen() {
	for index, element := range router.requests {
			router.server.HandleFunc(index, element)
	}
}
