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

type storageModel struct {
	bucket string
	key    string
}

func (st *storageModel) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	if authErrorHandle(w, r, &start) {
		return
	}

	key := r.URL.Query().Get(st.key)
	buff, err := st.readMinioObject(key)
	if err != nil {
		return
	}
	loggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(start))
	reader := bytes.NewReader(buff)
	http.ServeContent(w, r, key, time.Now(), reader)
	return
}

func (st *storageModel) readMinioObject(key string) ([]byte, error) {
	creds := credentials.NewEnvCredentials()

	sess := getSession(creds)

	s3c := s3.New(sess)
	bucket := &st.bucket

	output, err := s3c.GetObject(&s3.GetObjectInput{
		Bucket: aws.String(*bucket),
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