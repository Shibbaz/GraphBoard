package library

import(
	"net/http"
	"time"
)
func AuthErrorHandle(w http.ResponseWriter, r *http.Request, start *time.Time) bool {
	header_authorization := r.Header.Get("HTTP_AUTHORIZATION")
	if header_authorization == "" {
		LoggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(*start))
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte("{\"Error\": \"NoTokenProvidedError\"}"))
		return true
	}
	return false
}