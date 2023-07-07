package router

import(
	"net/http"
	resolvers "resolvers"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"library"
)

func NewRouter(siteMux *http.ServeMux) *Router {
	creds := credentials.NewEnvCredentials()
	st := &resolvers.Storage{Bucket: "files", Key: "video_id", Session: library.GetSession(creds, "http://localhost:9000")}
	router := Router{
		server: siteMux,
		requests: routerRequests{
			"/videos": st.StreamVideoResolver,
		},
	}
	return &router
}