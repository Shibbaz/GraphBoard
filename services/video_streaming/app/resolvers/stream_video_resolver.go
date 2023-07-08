package resolvers

import (
	"bytes"
	"net/http"
	"time"
	"library"
	"models"

	"github.com/aws/aws-sdk-go/aws/credentials"
	. "aws_helpers"
)
func NewVideoResolver() *Resolver{
	creds := credentials.NewEnvCredentials()
	storage := &models.Storage{Bucket: "files", Key: "video_id", Session: GetSession(creds, "http://localhost:9000")}
	resolver := Resolver{Payload: storage}
	return &resolver
}

func (resolver *Resolver) StreamVideoResolver(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	storage := resolver.Payload.(*models.Storage)

	if library.AuthErrorHandle(w, r, &start) {
		return
	}

	key := r.URL.Query().Get(storage.Key)
	buff, err := storage.ReadMinioObject(key, storage.Session)
	if err != nil {
		return
	}
	library.LoggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(start))
	reader := bytes.NewReader(buff)
	http.ServeContent(w, r, key, time.Now(), reader)
}

