//go:build amd64
#include "textflag.h"

// func procyield(cycles uint32)
TEXT ·procyield(SB), NOSPLIT, $0-4
	MOVL cycles+0(FP), AX
again:
	PAUSE
	SUBL $1, AX
	JNZ again
	RET
