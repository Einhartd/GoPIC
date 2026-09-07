//go:build !amd64

package gopic

import "runtime"

func procyield(cycles uint32) {
	runtime.Gosched()
}
