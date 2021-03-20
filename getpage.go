package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"path"
)

/*
 * script to download given url
 */
func fetch(url string) (filename string, n int64, err error) {
	resp, err := http.Get(url)
	if err != nil {
		return "", 0, err
	}
	defer resp.Body.Close()
	fmt.Printf("\nFetching %s ", resp.Request.URL)
	local := path.Base(resp.Request.URL.Path)
	if local == "/" {
		local = "index.html"
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
			fmt.Println("get page failed")
			os.Exit(1)
		}
		fmt.Printf("\n[+] %s written ", file)
		fmt.Printf("\n[+] %d bytes total ", size)
	}
	os.Exit(0)
}
