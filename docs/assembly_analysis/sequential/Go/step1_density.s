// --- Symbol: Step1ComputeElectronDensity ---
TEXT gopic.(*SimulationState).Step1ComputeElectronDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x4bb9c0		55			PUSHQ BP		
  0x4bb9c1		4889e5			MOVQ SP, BP		
	for p = 0; p < N_G; p++ {
  0x4bb9c4		31c9			XORL CX, CX		
  0x4bb9c6		eb18			JMP 0x4bb9e0		
		sim.E_density[p] = 0 // electron density - computed in every time step
  0x4bb9c8		8400				TESTB AL, 0(AX)			
  0x4bb9ca		48c784c81027270700000000	MOVQ $0x0, 0x7272710(AX)(CX*8)	
	for p = 0; p < N_G; p++ {
  0x4bb9d6		48ffc1			INCQ CX			
  0x4bb9d9		0f1f8000000000		NOPL 0(AX)		
  0x4bb9e0		4881f990010000		CMPQ CX, $0x190		
  0x4bb9e7		7cdf			JL 0x4bb9c8		
  0x4bb9e9		31c9			XORL CX, CX		
  0x4bb9eb		eb1d			JMP 0x4bba0a		
		sim.E_density[p+1] += (c0 - float64(p)) * FACTOR_W
  0x4bb9ed		f20f5cc2		SUBSD X2, X0				
  0x4bb9f1		f20f59c4		MULSD X4, X0				
  0x4bb9f5		f20f5884d018272707	ADDSD 0x7272718(AX)(DX*8), X0		
  0x4bb9fe		f20f1184d018272707	MOVSD_XMM X0, 0x7272718(AX)(DX*8)	
	for k = 0; k < sim.N_e; k++ {
  0x4bba07		48ffc1			INCQ CX			
  0x4bba0a		8400			TESTB AL, 0(AX)		
  0x4bba0c		483988007e5603		CMPQ 0x3567e00(AX), CX	
  0x4bba13		0f8e84000000		JLE 0x4bba9d		
  0x4bba19		0f1f8000000000		NOPL 0(AX)		
		c0 = sim.X_e[k] * INV_DX
  0x4bba20		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bba27		0f83e2000000		JAE 0x4bbb0f				
  0x4bba2d		f20f1084c8107e5603	MOVSD_XMM 0x3567e10(AX)(CX*8), X0	
  0x4bba36		f20f100dfaee0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bba3e		f20f59c1		MULSD X1, X0				
		p = int(c0)
  0x4bba42		f2480f2cd0		CVTTSD2SIQ X0, DX	
		sim.E_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
  0x4bba47		4881fa90010000		CMPQ DX, $0x190				
  0x4bba4e		0f83b1000000		JAE 0x4bbb05				
  0x4bba54		0f57d2			XORPS X2, X2				
  0x4bba57		f2480f2ad2		CVTSI2SDQ DX, X2			
  0x4bba5c		f20f101dd4ed0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4bba64		f20f58da		ADDSD X2, X3				
  0x4bba68		f20f5cd8		SUBSD X0, X3				
  0x4bba6c		f20f1025dcee0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X4	
  0x4bba74		f20f59dc		MULSD X4, X3				
  0x4bba78		f20f589cd010272707	ADDSD 0x7272710(AX)(DX*8), X3		
  0x4bba81		f20f119cd010272707	MOVSD_XMM X3, 0x7272710(AX)(DX*8)	
		sim.E_density[p+1] += (c0 - float64(p)) * FACTOR_W
  0x4bba8a		488d5a01		LEAQ 0x1(DX), BX	
  0x4bba8e		4881fb90010000		CMPQ BX, $0x190		
  0x4bba95		0f8252ffffff		JB 0x4bb9ed		
  0x4bba9b		eb55			JMP 0x4bbaf2		
	sim.E_density[0] *= 2.0
  0x4bba9d		f20f108010272707	MOVSD_XMM 0x7272710(AX), X0	
  0x4bbaa5		f20f58c0		ADDSD X0, X0			
  0x4bbaa9		f20f118010272707	MOVSD_XMM X0, 0x7272710(AX)	
	sim.E_density[N_G-1] *= 2.0
  0x4bbab1		f20f108088332707	MOVSD_XMM 0x7273388(AX), X0	
  0x4bbab9		f20f58c0		ADDSD X0, X0			
  0x4bbabd		f20f118088332707	MOVSD_XMM X0, 0x7273388(AX)	
	for p = 0; p < N_G; p++ {
  0x4bbac5		31c9			XORL CX, CX		
  0x4bbac7		eb1e			JMP 0x4bbae7		
		sim.Cumul_e_density[p] += sim.E_density[p]
  0x4bbac9		f20f1084c810272707	MOVSD_XMM 0x7272710(AX)(CX*8), X0	
  0x4bbad2		f20f5884c810402707	ADDSD 0x7274010(AX)(CX*8), X0		
  0x4bbadb		f20f1184c810402707	MOVSD_XMM X0, 0x7274010(AX)(CX*8)	
	for p = 0; p < N_G; p++ {
  0x4bbae4		48ffc1			INCQ CX			
  0x4bbae7		4881f990010000		CMPQ CX, $0x190		
  0x4bbaee		7cd9			JL 0x4bbac9		
}
  0x4bbaf0		5d			POPQ BP			
  0x4bbaf1		c3			RET			
		sim.E_density[p+1] += (c0 - float64(p)) * FACTOR_W
  0x4bbaf2		b890010000		MOVL $0x190, AX			
  0x4bbaf7		b990010000		MOVL $0x190, CX			
  0x4bbafc		0f1f4000		NOPL 0(AX)			
  0x4bbb00		e8fb5bfcff		CALL runtime.panicBounds(SB)	
		sim.E_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
  0x4bbb05		b890010000		MOVL $0x190, AX			
  0x4bbb0a		e8f15bfcff		CALL runtime.panicBounds(SB)	
		c0 = sim.X_e[k] * INV_DX
  0x4bbb0f		b840420f00		MOVL $0xf4240, AX		
  0x4bbb14		e8e75bfcff		CALL runtime.panicBounds(SB)	
  0x4bbb19		90			NOPL				


// --- Symbol: Step1ComputeIonDensity ---
TEXT gopic.(*SimulationState).Step1ComputeIonDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x4bbb20		55			PUSHQ BP		
  0x4bbb21		4889e5			MOVQ SP, BP		
	if (t % N_SUB) == 0 { // ion density - computed in every N_SUB-th time steps (subcycling)
  0x4bbb24		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x4bbb2e		480fafd9		IMULQ CX, BX			
  0x4bbb32		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x4bbb3c		4801d9			ADDQ BX, CX			
  0x4bbb3f		48c1c13e		ROLQ $0x3e, CX			
  0x4bbb43		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x4bbb4d		4839ca			CMPQ DX, CX			
  0x4bbb50		7204			JB 0x4bbb56			
  0x4bbb52		31c9			XORL CX, CX			
  0x4bbb54		eb4a			JMP 0x4bbba0			
	for p = 0; p < N_G; p++ {
  0x4bbb56		31c9			XORL CX, CX		
  0x4bbb58		eb26			JMP 0x4bbb80		
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x4bbb5a		8400			TESTB AL, 0(AX)				
  0x4bbb5c		f20f1084c890332707	MOVSD_XMM 0x7273390(AX)(CX*8), X0	
  0x4bbb65		f20f5884c8904c2707	ADDSD 0x7274c90(AX)(CX*8), X0		
  0x4bbb6e		f20f1184c8904c2707	MOVSD_XMM X0, 0x7274c90(AX)(CX*8)	
	for p = 0; p < N_G; p++ {
  0x4bbb77		48ffc1			INCQ CX			
  0x4bbb7a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bbb80		4881f990010000		CMPQ CX, $0x190		
  0x4bbb87		7cd1			JL 0x4bbb5a		
}
  0x4bbb89		5d			POPQ BP			
  0x4bbb8a		c3			RET			
			sim.I_density[p] = 0
  0x4bbb8b		8400				TESTB AL, 0(AX)			
  0x4bbb8d		48c784c89033270700000000	MOVQ $0x0, 0x7273390(AX)(CX*8)	
		for p = 0; p < N_G; p++ {
  0x4bbb99		48ffc1			INCQ CX			
  0x4bbb9c		0f1f4000		NOPL 0(AX)		
  0x4bbba0		4881f990010000		CMPQ CX, $0x190		
  0x4bbba7		7ce2			JL 0x4bbb8b		
  0x4bbba9		31c9			XORL CX, CX		
  0x4bbbab		eb1d			JMP 0x4bbbca		
			sim.I_density[p+1] += (c0 - float64(p)) * FACTOR_W
  0x4bbbad		f20f5cc2		SUBSD X2, X0				
  0x4bbbb1		f20f59c4		MULSD X4, X0				
  0x4bbbb5		f20f5884d098332707	ADDSD 0x7273398(AX)(DX*8), X0		
  0x4bbbbe		f20f1184d098332707	MOVSD_XMM X0, 0x7273398(AX)(DX*8)	
		for k = 0; k < sim.N_i; k++ {
  0x4bbbc7		48ffc1			INCQ CX			
  0x4bbbca		8400			TESTB AL, 0(AX)		
  0x4bbbcc		483988087e5603		CMPQ 0x3567e08(AX), CX	
  0x4bbbd3		0f8e84000000		JLE 0x4bbc5d		
  0x4bbbd9		0f1f8000000000		NOPL 0(AX)		
			c0 = sim.X_i[k] * INV_DX
  0x4bbbe0		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bbbe7		0f83b8000000		JAE 0x4bbca5				
  0x4bbbed		f20f1084c810c63e05	MOVSD_XMM 0x53ec610(AX)(CX*8), X0	
  0x4bbbf6		f20f100d3aed0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bbbfe		f20f59c1		MULSD X1, X0				
			p = int(c0)
  0x4bbc02		f2480f2cd0		CVTTSD2SIQ X0, DX	
			sim.I_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
  0x4bbc07		4881fa90010000		CMPQ DX, $0x190				
  0x4bbc0e		0f8385000000		JAE 0x4bbc99				
  0x4bbc14		0f57d2			XORPS X2, X2				
  0x4bbc17		f2480f2ad2		CVTSI2SDQ DX, X2			
  0x4bbc1c		f20f101d14ec0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4bbc24		f20f58da		ADDSD X2, X3				
  0x4bbc28		f20f5cd8		SUBSD X0, X3				
  0x4bbc2c		f20f10251ced0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X4	
  0x4bbc34		f20f59dc		MULSD X4, X3				
  0x4bbc38		f20f589cd090332707	ADDSD 0x7273390(AX)(DX*8), X3		
  0x4bbc41		f20f119cd090332707	MOVSD_XMM X3, 0x7273390(AX)(DX*8)	
			sim.I_density[p+1] += (c0 - float64(p)) * FACTOR_W
  0x4bbc4a		488d5a01		LEAQ 0x1(DX), BX	
  0x4bbc4e		4881fb90010000		CMPQ BX, $0x190		
  0x4bbc55		0f8252ffffff		JB 0x4bbbad		
  0x4bbc5b		eb2d			JMP 0x4bbc8a		
		sim.I_density[0] *= 2.0
  0x4bbc5d		f20f108090332707	MOVSD_XMM 0x7273390(AX), X0	
  0x4bbc65		f20f58c0		ADDSD X0, X0			
  0x4bbc69		f20f118090332707	MOVSD_XMM X0, 0x7273390(AX)	
		sim.I_density[N_G-1] *= 2.0
  0x4bbc71		f20f108008402707	MOVSD_XMM 0x7274008(AX), X0	
  0x4bbc79		f20f58c0		ADDSD X0, X0			
  0x4bbc7d		f20f118008402707	MOVSD_XMM X0, 0x7274008(AX)	
  0x4bbc85		e9ccfeffff		JMP 0x4bbb56			
			sim.I_density[p+1] += (c0 - float64(p)) * FACTOR_W
  0x4bbc8a		b890010000		MOVL $0x190, AX			
  0x4bbc8f		b990010000		MOVL $0x190, CX			
  0x4bbc94		e8675afcff		CALL runtime.panicBounds(SB)	
			sim.I_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
  0x4bbc99		b890010000		MOVL $0x190, AX			
  0x4bbc9e		6690			NOPW				
  0x4bbca0		e85b5afcff		CALL runtime.panicBounds(SB)	
			c0 = sim.X_i[k] * INV_DX
  0x4bbca5		b840420f00		MOVL $0xf4240, AX		
  0x4bbcaa		e8515afcff		CALL runtime.panicBounds(SB)	
  0x4bbcaf		90			NOPL				


