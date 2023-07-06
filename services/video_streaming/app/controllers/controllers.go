package controllers

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
	"library"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/service/s3"
)

type StorageModel struct {
	Bucket string
	Key    string
}

func (st *StorageModel) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	if library.AuthErrorHandle(w, r, &start) {
		return
	}

	key := r.URL.Query().Get(st.Key)
	buff, err := st.readMinioObject(key)
	if err != nil {
		return
	}
	library.LoggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(start))
	reader := bytes.NewReader(buff)
	http.ServeContent(w, r, key, time.Now(), reader)
	return
}

func (st *StorageModel) readMinioObject(key string) ([]byte, error) {
	creds := credentials.NewEnvCredentials()
	sess := library.GetSession(creds)

	s3c := s3.New(sess)
	bucket := &st.Bucket

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
