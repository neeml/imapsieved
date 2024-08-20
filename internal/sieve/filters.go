package sieve

import (
	sieve "github.com/foxcpp/go-sieve"
	"io"
)

func LoadSieveFilter(fd io.Reader) (*sieve.Script, error) {
	sieve, err := sieve.Load(fd, sieve.DefaultOptions())
	if err != nil {
		return nil, err
	}

	return sieve, nil
}
