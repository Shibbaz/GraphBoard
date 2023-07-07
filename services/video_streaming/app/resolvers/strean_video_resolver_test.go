package resolvers

import (
	"net/http"
	"net/http/httptest"
	"testing"
	"models"
	"unsafe"

	. "aws_helpers"
	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/aws/aws-sdk-go/service/s3/s3iface"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/gavv/httpexpect/v2"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/stretchr/testify/assert"
)
func NewS3(uri string) ObjectStore {

	// TODO Add URI to session
	creds := credentials.NewEnvCredentials()

	sess := GetSession(creds, uri)
	client := s3.New(sess)

	return ObjectStore{
		Client: client,
		URL:    uri,
	}
}

type ObjectStore struct {
	Client s3iface.S3API
	URL    string
}

func (svc ObjectStore) GetObject(in *s3.GetObjectInput) (*s3.GetObjectOutput, error) {

	return svc.Client.GetObject(in)
}


func TestReadVideoResolverExpectsFailure(t *testing.T) {
	creds := credentials.NewEnvCredentials()

	sess := GetSession(creds, "https://localhost:9000")
	payload := models.Storage{
		Bucket: "test",
		Key: "video_id",
		Session: sess,
	}
	casted_payload := (*models.Storage)(unsafe.Pointer(&payload))
	resolver := Resolver{Payload: casted_payload}
	// Create mock receiver
	ts := httptest.NewServer(http.HandlerFunc(resolver.StreamVideoResolver))
	defer ts.Close()
	e := httpexpect.Default(t, ts.URL)

	e.GET("/videos?video_id=dce63198-89ca-471e-95fb-092bc4cc92f4.mp4").
		Expect().
		Status(http.StatusOK).
		JSON().Object().ContainsKey("Error").HasValue("Error", "NoTokenProvidedError")
}

func TestReadVideoResolverExpectsSuccess(t *testing.T) {
	creds := credentials.NewEnvCredentials()

	sess := GetSession(creds, "http://localhost:9000")
	payload := models.Storage{
		Bucket: "test",
		Key: "dce63198-89ca-471e-95fb-092bc4cc92f4.mp4",
		Session: sess,
	}
	casted_payload := (*models.Storage)(unsafe.Pointer(&payload))
	resolver := Resolver{Payload: casted_payload}

	// Create mock receiver
	ts := httptest.NewServer(http.HandlerFunc(resolver.StreamVideoResolver))
	defer ts.Close()
	e := httpexpect.Default(t, ts.URL)

	e.GET("/videos?video_id=dce63198-89ca-471e-95fb-092bc4cc92f4.mp4").
		Expect().
		Status(http.StatusOK).
		JSON().Object()
	svc := NewS3("http://localhost:9000")

	input := &s3.GetObjectInput{
		Bucket: aws.String("test"),
		Key:    aws.String("dce63198-89ca-471e-95fb-092bc4cc92f4.mp4"),
	}
	resp, err := svc.GetObject(input)
	if err != nil {

		t.Fatal(err)
	}

	t.Log(resp)
}

func TestReadVideoResolverExpectsNoFile(t *testing.T) {
	creds := credentials.NewEnvCredentials()

	sess := GetSession(creds, "http://localhost:9000")
	payload := models.Storage{
		Bucket: "test",
		Key: "filedoesnotexist",
		Session: sess,
	}
	casted_payload := (*models.Storage)(unsafe.Pointer(&payload))
	resolver := Resolver{Payload: casted_payload}
	// Create mock receiver
	ts := httptest.NewServer(http.HandlerFunc(resolver.StreamVideoResolver))
	defer ts.Close()
	e := httpexpect.Default(t, ts.URL)

	e.GET("/videos?video_id=filedoesnotexist").
		Expect().
		Status(http.StatusOK).
		JSON().Object()
	svc := NewS3("http://localhost:9000")

	input := &s3.GetObjectInput{
		Bucket: aws.String("test"),
		Key:    aws.String("filedoesnotexist"),
	}
	resp, err := svc.GetObject(input)
	if err != nil {
        assert.IsType(t, "NoSuchKey", err.Error())
	}

	t.Log(resp)
}

