package aws_helpers

import (
	"github.com/aws/aws-sdk-go/aws"
	session "github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func GetObject(sess *session.Session, bucket string, key string) (*s3.GetObjectOutput, error) {
	s3c := s3.New(sess)

	output, err := s3c.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
	})
	return output, err
}
