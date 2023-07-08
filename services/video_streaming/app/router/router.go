package router

import(
	"net/http"
	. "resolvers"
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

func NewRouter(siteMux *http.ServeMux, requests RouterRequests) *Router {
	return &Router{
		server: siteMux,
		requests: requests,
	}
}

func NewRouters(siteMux *http.ServeMux) *map[string]*Router{
	videosRouter := NewRouter(siteMux, RouterRequests{
			"/videos": NewVideoResolver().StreamVideoResolver,
		},
	)
	routers := &map[string]*Router{
		"/videos": videosRouter,
	}
	return routers
}
