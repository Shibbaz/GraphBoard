package library

import (
	"fmt"
	"time"
)

func LoggerRequest(addr string, method string, url string, duration time.Duration) {
	fmt.Println("\nRequest { Elapsed: ", duration, " Method: ", method, " Endpoint:", url, "}")
}
