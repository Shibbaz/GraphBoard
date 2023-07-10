package models

import (
	"fmt"
	"io/ioutil"

	. "aws_helpers"
	session "github.com/aws/aws-sdk-go/aws/session"
)

type Storage struct {
	Bucket  string
	Key     string
	Session *session.Session
}

func (storage *Storage) ReadMinioObject(key string, sess *session.Session) ([]byte, error) {
	bucket := storage.Bucket

	output, err := GetObject(sess, bucket, key)

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
