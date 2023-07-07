package resolvers
import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gavv/httpexpect/v2"
)

func TestReadVideoResolver(t *testing.T) {
	st := Storage{
		Bucket: "files",
		Key: "video_id",
	}
	handler := http.HandlerFunc(st.StreamVideoResolver)
	server := httptest.NewServer(handler)
	defer server.Close()

	// create httpexpect instance
	e := httpexpect.Default(t, server.URL)

	// is it working?
	e.GET("/videos").
		Expect().
		Status(http.StatusOK).
		JSON().Object().ContainsKey("Error").HasValue("Error", "NoTokenProvidedError")
}

func TestTokenReadVideoResolverWithSuccess(t *testing.T) {
	st := Storage{
		Bucket: "files",
		Key: "video_id",
	}
	handler := http.HandlerFunc(st.StreamVideoResolver)
	server := httptest.NewServer(handler)
	defer server.Close()

	// create httpexpect instance
	e := httpexpect.Default(t, server.URL)

	// is it working?
	e.GET("/videos").
		WithHeader("Authorization", "TOKEN").
		Expect().
		Status(http.StatusOK).
		JSON().Object().ContainsKey("Error").HasValue("Error", "NoTokenProvidedError")
}