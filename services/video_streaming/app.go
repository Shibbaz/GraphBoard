package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func main() {
	siteMux := http.NewServeMux()
	st := &storageHandler{bucket: "files", key: "video_id"}
	siteMux.HandleFunc("/", st.ServeHTTP)
	port := ":8080"
	srv := &http.Server{
		Addr:         port,
		Handler:      siteMux,
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
