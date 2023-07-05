package main

import "net/http"

type Router struct {
	server    *http.ServeMux
	endpoints map[string]func(w http.ResponseWriter, r *http.Request)
}

func (router *Router) Listen() {
	for index, element := range router.endpoints {
		router.server.HandleFunc(index, element)
	}
}

func newRouter(siteMux *http.ServeMux) *Router {
	st := &storageModel{bucket: "files", key: "video_id"}

	router := Router{
		server: siteMux,
		endpoints: map[string]func(w http.ResponseWriter, r *http.Request){
			"/": st.ServeHTTP,
		},
	}
	return &router
}
