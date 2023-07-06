package main

import (
	"fmt"
	"net/http"
)

type routerRequests map[string]func(w http.ResponseWriter, r *http.Request)

type Router struct {
	server   *http.ServeMux
	requests routerRequests
}

func (router *Router) Listen() {
	errors := make(chan error)
	go func() {
		successful := true
		if !successful {
			errors <- fmt.Errorf("Operation failed")
		}
		close(errors)
	}()
	err := <-errors
	if err != nil {
		fmt.Println(err.Error())
	} else {
		for index, element := range router.requests {
			router.server.HandleFunc(index, element)
		}
	}
}

func newRouter(siteMux *http.ServeMux) *Router {
	st := &storageModel{bucket: "files", key: "video_id"}

	router := Router{
		server: siteMux,
		requests: routerRequests{
			"/videos": st.ServeHTTP,
		},
	}
	return &router
}
