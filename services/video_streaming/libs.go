package main

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/endpoints"
	session "github.com/aws/aws-sdk-go/aws/session"
)

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
