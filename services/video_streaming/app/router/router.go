package router

import(
	"net/http"
	"resolvers"
	"github.com/aws/aws-sdk-go/aws/credentials"
	. "aws_helpers"
	"models"
)

func NewRouter(siteMux *http.ServeMux) *Router {
	creds := credentials.NewEnvCredentials()
	storage := &models.Storage{Bucket: "files", Key: "video_id", Session: GetSession(creds, "http://localhost:9000")}
	resolver := resolvers.Resolver{Payload: storage}
	router := Router{
		server: siteMux,
		requests: routerRequests{
			"/videos": resolver.StreamVideoResolver,
		},
	}
	return &router
}
