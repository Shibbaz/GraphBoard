package initializers

import(
	"net/http"
	. "config"
)

func NewServer(config *Config) *http.Server{
	srv := &http.Server{
		Addr:         config.Addr,
		Handler:      config.Handler,
		ReadTimeout:  config.ReadTimeout,
		WriteTimeout: config.WriteTimeout,
		IdleTimeout:  config.IdleTimeout,
	}
	return srv
}