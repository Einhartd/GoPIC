// +build amd64

#include "textflag.h"

// func LeapFrogPushAVX2(x, vx []float64, efield []float64, s, e int, factorE, dtE, invDx float64)
TEXT ·LeapFrogPushAVX2(SB), NOSPLIT, $0-112
	MOVQ x_base+0(FP), R8
	MOVQ vx_base+24(FP), R9
	MOVQ efield_base+48(FP), R10
	MOVQ s+72(FP), R11
	MOVQ e+80(FP), R12

	// Sprawdzenie czy jest co najmniej 4 cząstki
	MOVQ R12, R13
	SUBQ $4, R13
	CMPQ R11, R13
	JG tail_loop_prep

	// Broadcast stałych float64 do rejestrów YMM
	VBROADCASTSD invDx+104(FP), Y11
	VBROADCASTSD factorE+88(FP), Y12
	VBROADCASTSD dtE+96(FP), Y13

	// Stałe int32 dla klamrowania komórek siatki (p): [0, 398]
	VPXOR X14, X14, X14             // X14 = [0, 0, 0, 0]
	MOVL $398, AX
	MOVD AX, X15
	VPBROADCASTD X15, X15           // X15 = [398, 398, 398, 398]
	MOVL $1, AX
	MOVD AX, X8
	VPBROADCASTD X8, X8             // X8 = [1, 1, 1, 1]

vector_loop:
	// 1. Ładowanie x[k..k+3]
	VMOVUPD (R8)(R11*8), Y0

	// 2. c0 = x * invDx
	VMULPD Y11, Y0, Y1

	// 3. p = int(c0) -> 32-bitowe inty w XMM
	VCVTTPD2DQY Y1, X9

	// 4. Klamrowanie p w [0, 398]
	VPMAXSD X14, X9, X9
	VPMINSD X15, X9, X9

	// 5. float64(p)
	VCVTDQ2PD X9, Y3

	// 6. d = c0 - float64(p)
	VSUBPD Y3, Y1, Y2

	// 7. Sprzętowy Gather E[p] z siatki (bezpośrednio z L1 Cache)
	VPCMPEQD Y5, Y5, Y5
	VGATHERDPD Y5, (R10)(X9*8), Y6  // Y6 = E[p]

	// 8. Sprzętowy Gather E[p+1] z siatki
	VPADDD X8, X9, X7               // X7 = p + 1
	VPCMPEQD Y5, Y5, Y5
	VGATHERDPD Y5, (R10)(X7*8), Y4  // Y4 = E[p+1]

	// 9. Interpolacja CIC: Ex = E[p] + d * (E[p+1] - E[p])
	VSUBPD Y6, Y4, Y4               // Y4 = E[p+1] - E[p]
	VFMADD213PD Y6, Y2, Y4          // Y4 = d * (E[p+1] - E[p]) + E[p] = Ex

	// 10. Aktualizacja vx = vx - Ex * factorE
	VMOVUPD (R9)(R11*8), Y10
	VFNMADD231PD Y4, Y12, Y10
	VMOVUPD Y10, (R9)(R11*8)

	// 11. Aktualizacja x = x + vx * dtE
	VFMADD231PD Y10, Y13, Y0
	VMOVUPD Y0, (R8)(R11*8)

	// Inkrementacja indeksu cząstek o 4
	ADDQ $4, R11
	CMPQ R11, R13
	JLE vector_loop

tail_loop_prep:
	VZEROUPPER

tail_loop:
	CMPQ R11, R12
	JGE done

	// Skalarna pętla resztkowa dla pozostałych cząstek (tail loop)
	MOVSD (R8)(R11*8), X0
	MULSD invDx+104(FP), X0
	CVTTSD2SQ X0, AX
	TESTQ AX, AX
	JGE clamp_max
	XORQ AX, AX
clamp_max:
	CMPQ AX, $398
	JLE clamped
	MOVQ $398, AX
clamped:
	XORPS X1, X1
	CVTSQ2SD AX, X1
	SUBSD X1, X0                    // X0 = d = c0 - float64(p)

	MOVSD (R10)(AX*8), X1           // X1 = E[p]
	MOVSD 8(R10)(AX*8), X2          // X2 = E[p+1]
	SUBSD X1, X2                    // X2 = E[p+1] - E[p]
	MULSD X0, X2
	ADDSD X1, X2                    // X2 = Ex

	MOVSD (R9)(R11*8), X3           // X3 = vx
	MOVSD factorE+88(FP), X4
	MULSD X2, X4
	SUBSD X4, X3                    // X3 = vx - Ex*factorE
	MOVSD X3, (R9)(R11*8)

	MULSD dtE+96(FP), X3
	ADDSD (R8)(R11*8), X3
	MOVSD X3, (R8)(R11*8)

	INCQ R11
	JMP tail_loop

done:
	RET
