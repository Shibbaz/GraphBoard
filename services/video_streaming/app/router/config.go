package router

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
			errors <- fmt.Errorf("operation failed")
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

