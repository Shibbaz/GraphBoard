package models

import (
	"fmt"
	"io/ioutil"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/s3"
	session "github.com/aws/aws-sdk-go/aws/session"
)

type Storage struct {
	Bucket string
	Key    string
	Session *session.Session
}

func (storage *Storage) ReadMinioObject(key string, sess *session.Session) ([]byte, error) {
	s3c := s3.New(sess)
	bucket := storage.Bucket

	output, err := s3c.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
	})
	if err != nil {
		fmt.Println(err)
		return nil, err
	}
	buff, buffErr := ioutil.ReadAll(output.Body)
	if buffErr != nil {
		fmt.Println(buffErr)
		return nil, buffErr
	}
	return buff, nil
}