package router

import(
	"net/http"
)

func NewRouter(siteMux *http.ServeMux, requests RouterRequests) *Router {
	return &Router{
		server: siteMux,
		requests: requests,
	}
}
