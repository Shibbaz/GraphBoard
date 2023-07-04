package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/endpoints"
	session "github.com/aws/aws-sdk-go/aws/session"
)

func authErrorHandle(w http.ResponseWriter, r *http.Request, start *time.Time) bool {
	header_authorization := r.Header.Get("HTTP_AUTHORIZATION")
	if header_authorization == "" {
		loggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(*start))
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte("{\"Error\": \"NoTokenProvidedError\"}"))
		return true
	}
	return false
}

func getResolver(url string) endpoints.ResolverFunc {
	defaultResolver := endpoints.DefaultResolver()

	resolver := func(service, region string, optFns ...func(*endpoints.Options)) (endpoints.ResolvedEndpoint, error) {
		var svcURL string
		switch service {
		case endpoints.S3ServiceID:
			svcURL = url
		default:
			return defaultResolver.EndpointFor(service, region, optFns...)
		}

		return endpoints.ResolvedEndpoint{
			URL:           svcURL,
			SigningRegion: "us-east-1",
		}, nil
	}
	return resolver
}

func getSession(creds *credentials.Credentials) *session.Session {
	data := session.Must(session.NewSessionWithOptions(session.Options{
		Config: aws.Config{
			S3ForcePathStyle: aws.Bool(true),
			Credentials:      creds,

			EndpointResolver: endpoints.ResolverFunc(getResolver("http://localhost:9000")),
		},
		SharedConfigState: session.SharedConfigEnable,
	}))
	return data
}

func loggerRequest(addr string, method string, url string, duration time.Duration) {
	fmt.Println("\nRequest { Elapsed: ", duration, " Method: ", method, " Endpoint:", url, "}")
}
