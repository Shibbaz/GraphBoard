package resolvers

import (
	"bytes"
	"net/http"
	"time"
	"library"
	"models"
)

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

