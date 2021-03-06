package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"path"
	"strings"
)

/*
 * script to download given url's
 * need to: fix local, borks on index.htm
 */
func fetch(url string) (filename string, n int64, err error) {
	resp, err := http.Get(url)
	if err != nil {
		return "", 0, err
	}
	defer resp.Body.Close()
	fmt.Printf("\nFetching %s \n", resp.Request.URL)
	local := path.Base(resp.Request.URL.Path)
	if local == "/" {
		prefix := strings.Trim(url, "https://")
		local = fmt.Sprintf("%s.index.html", prefix)
	}
	f, err := os.Create(local)
	if err != nil {
		return "", 0, err
	}
	n, err = io.Copy(f, resp.Body)
	if closeErr := f.Close(); err == nil {
		err = closeErr
	}
	return local, n, err
}

func main() {
	for _, url := range os.Args[1:] {
		file, size, err := fetch(url)
		if err != nil {
			fmt.Printf("\nget %s failed\n", url)
		}
		fmt.Printf("\n[+] %s written ", file)
		fmt.Printf("\n[+] %d bytes total ", size)
	}
	os.Exit(0)
}
