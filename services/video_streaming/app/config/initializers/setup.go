package initializers
import (
	"net/http"
	"resolvers"
	"models"

	. "config"
	. "router"
	"github.com/aws/aws-sdk-go/aws/credentials"
	. "aws_helpers"
)

func Setup()(*Gateway, *App){
	siteMux := http.NewServeMux()
	creds := credentials.NewEnvCredentials()
	storage := &models.Storage{Bucket: "files", Key: "video_id", Session: GetSession(creds, "http://localhost:9000")}
	resolver := resolvers.Resolver{Payload: storage}
	videosRouter := NewRouter(siteMux, RouterRequests{
			"/videos": resolver.StreamVideoResolver,
		},
	)
	routers := map[string]*Router{
		"/videos": videosRouter,
	}
	gateway := Gateway{
		Routers: routers,

	}
	configuration := NewConfig(siteMux)
	application := NewApp(configuration)
	return &gateway, application	
}
