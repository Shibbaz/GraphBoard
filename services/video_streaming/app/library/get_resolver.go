package library
import(
	"github.com/aws/aws-sdk-go/aws/endpoints"
)
func GetResolver(url string) endpoints.ResolverFunc {
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