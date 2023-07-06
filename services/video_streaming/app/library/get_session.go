package library

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/endpoints"
	session "github.com/aws/aws-sdk-go/aws/session"
)

func GetSession(creds *credentials.Credentials) *session.Session {
	data := session.Must(session.NewSessionWithOptions(session.Options{
		Config: aws.Config{
			S3ForcePathStyle: aws.Bool(true),
			Credentials:      creds,

			EndpointResolver: endpoints.ResolverFunc(GetResolver("http://localhost:9000")),
		},
		SharedConfigState: session.SharedConfigEnable,
	}))
	return data
}