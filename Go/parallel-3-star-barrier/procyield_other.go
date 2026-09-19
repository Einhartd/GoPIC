//go:build !amd64

package gopic

import "runtime"

func procyield(cycles uint32) {
	runtime.Gosched()
}


// https://github.com/golang/go/blob/master/src/runtime/asm_amd64.s#L832-L841