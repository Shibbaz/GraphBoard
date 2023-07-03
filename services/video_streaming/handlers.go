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

type authErrorResponse struct {
	message string
}

func (st *storageHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	header_authorization := r.Header.Get("HTTP_AUTHORIZATION")
	if header_authorization == "" {
		message := "Error: You cannot access, no token provided."
		loggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(start))
		fmt.Printf(" Request { %s }", message)
		w.Header().Set("Content-Type", "application/json")
		http.Error(w, fmt.Sprintf("%s", message), http.StatusInternalServerError)
		return
	}
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
	loggerRequest(r.RemoteAddr, r.Method, r.URL.Path, time.Since(start))
	reader := bytes.NewReader(buff)
	http.ServeContent(w, r, key, time.Now(), reader)
	return
}
