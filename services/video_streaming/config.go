package main

import (
	"net/http"
	"time"

	"github.com/rs/cors"
)

type Config struct {
	Addr         string
	Handler      http.Handler
	ReadTimeout  time.Duration
	WriteTimeout time.Duration
	IdleTimeout  time.Duration
}

func newConfig(siteMux *http.ServeMux) *Config {
	handler := cors.Default().Handler(siteMux)
	config := &Config{
		Addr:         ":8080",
		Handler:      handler,
		ReadTimeout:  2 * time.Second,
		WriteTimeout: 5 * time.Second,
		IdleTimeout:  10 * time.Second,
	}
	return config
}
