package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"

	"github.com/aws/aws-sdk-go/service/s3"
)

type storageHandler struct {
	bucket string
	key    string
}

func (st *storageHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	key := r.URL.Query().Get(st.key)

	creds := credentials.NewEnvCredentials()

	sess := getSession(creds)

	s3c := s3.New(sess)
	bucket := st.bucket

	output, err := s3c.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
	})
	if err != nil {
		fmt.Println(err)
		return
	}
	buff, buffErr := ioutil.ReadAll(output.Body)
	if buffErr != nil {
		fmt.Println(buffErr)
		return
	}
	reader := bytes.NewReader(buff)

	http.ServeContent(w, r, key, time.Now(), reader)
	return
}
