package router

import(
	"net/http"
	resolvers "resolvers"
)

func NewRouter(siteMux *http.ServeMux) *Router {
	st := &resolvers.Storage{Bucket: "files", Key: "video_id"}

	router := Router{
		server: siteMux,
		requests: routerRequests{
			"/videos": st.StreamVideoResolver,
		},
	}
	return &router
}