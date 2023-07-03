package main

import (
	"log"
	"net/http"
	"time"
)

func main() {
	siteMux := http.NewServeMux()
	st := storageHandler{bucket: "files", key: "video_id"}
	siteMux.HandleFunc("/", st.ServeHTTP)
	srv := &http.Server{
		Addr:         ":8080",
		Handler:      siteMux,
		ReadTimeout:  2 * time.Second,
		WriteTimeout: 5 * time.Second,
		IdleTimeout:  10 * time.Second,
	}
	if err := srv.ListenAndServe(); err != nil {
		panic(err)
	}
	log.Print("Listening...")

}
