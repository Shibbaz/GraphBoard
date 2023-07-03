package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/rs/cors"
)

func main() {
	siteMux := http.NewServeMux()
	st := &storageHandler{bucket: "files", key: "video_id"}

	siteMux.HandleFunc("/", st.ServeHTTP)
	handler := cors.Default().Handler(siteMux)

	port := ":8080"
	srv := &http.Server{
		Addr:         port,
		Handler:      handler,
		ReadTimeout:  2 * time.Second,
		WriteTimeout: 5 * time.Second,
		IdleTimeout:  10 * time.Second,
		ErrorLog:     log.Default(),
	}
	fmt.Print("service/streaming listening at port ", port)
	if err := srv.ListenAndServe(); err != nil {
		panic(err)
	}

}
