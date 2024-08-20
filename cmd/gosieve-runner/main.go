ypackage main

import (
	"github.com/neeml/gosieve-runner/internal/brain"
	"github.com/emersion/go-imap/client"
	"github.com/emersion/go-imap"
  "os"
  "log"
)

func main() {
  brain.Run()
}
