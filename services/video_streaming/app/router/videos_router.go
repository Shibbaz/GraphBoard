package router
import (
	"resolvers"
	"models"
	"net/http"

	"github.com/aws/aws-sdk-go/aws/credentials"
	. "aws_helpers"
)

func NewVideosRouter(siteMux *http.ServeMux) *Router{
	creds := credentials.NewEnvCredentials()
	storage := &models.Storage{Bucket: "files", Key: "video_id", Session: GetSession(creds, "http://localhost:9000")}
	resolver := resolvers.Resolver{Payload: storage}
	videosRouter := NewRouter(siteMux, RouterRequests{
			"/videos": resolver.StreamVideoResolver,
		},
	)
	return videosRouter
}