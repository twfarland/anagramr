package main

import (
	"fmt"
	"bytes"
	"os"
	"bufio"
	"io"
)

func elem(b byte, bs []byte) bool {
	return bytes.IndexByte(bs, b) > -1
}

func without(b byte, bs []byte) []byte {
	i := bytes.IndexByte(bs, b)
	if i > -1 {
		bs2 := make([]byte, len(bs)-1)
		copy(bs2, bs[:i])
		copy(bs2[i:], bs[i+1:])
		return bs2
	}
	return bs
}


func permOf(w []byte, t []byte, lenw int, lent int) bool {

	if lenw == 0 && lent == 0 { 
		return true 
	} else if lenw == lent {
		c := w[0]
		lenw--
		return elem(c, t) && permOf(w[1:], without(c, t), lenw, lenw)
	} 
	return false
}


func main() {

	target  := []byte(os.Args[1])
	targetl := len(target)
	file, _ := os.Open("/usr/share/dict/words")
	reader  := bufio.NewReader(file)

	for {
		word, _, err := reader.ReadLine(); 
		if err == io.EOF { break }
		if permOf(word, target, len(word), targetl) {
			fmt.Println(string(word))
		}
	}
}


