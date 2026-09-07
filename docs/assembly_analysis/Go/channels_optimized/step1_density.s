// =============================================================================
// SYMBOL: Step1ComputeElectronDensity
// =============================================================================

TEXT gopic.(*SimulationState).Step1ComputeElectronDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x1400c3ca0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3ca4		0f8605010000		JBE 0x1400c3daf		
  0x1400c3caa		55			PUSHQ BP		
  0x1400c3cab		4889e5			MOVQ SP, BP		
  0x1400c3cae		4883ec10		SUBQ $0x10, SP		
	w0 := &sim.WorkerEDensity[0]
  0x1400c3cb2		4889442420		MOVQ AX, 0x20(SP)	
	sim.broadcastAndWait(CmdComputeEDensity)
  0x1400c3cb7		31db			XORL BX, BX						
  0x1400c3cb9		e8c2fbffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
	w0 := &sim.WorkerEDensity[0]
  0x1400c3cbe		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c3cc3		4883790800		CMPQ 0x8(CX), $0x0	
  0x1400c3cc8		0f86db000000		JBE 0x1400c3da9		
  0x1400c3cce		488b01			MOVQ 0(CX), AX		
	for p := 0; p < N_G; p++ {
  0x1400c3cd1		31d2			XORL DX, DX		
  0x1400c3cd3		eb11			JMP 0x1400c3ce6		
		sim.E_density[p] = w0[p]
  0x1400c3cd5		f20f1004d0		MOVSD_XMM 0(AX)(DX*8), X0		
  0x1400c3cda		f20f1184d1d0272707	MOVSD_XMM X0, 0x72727d0(CX)(DX*8)	
	for p := 0; p < N_G; p++ {
  0x1400c3ce3		48ffc2			INCQ DX			
  0x1400c3ce6		4881fa90010000		CMPQ DX, $0x190		
  0x1400c3ced		7ce6			JL 0x1400c3cd5		
  0x1400c3cef		b801000000		MOVL $0x1, AX		
  0x1400c3cf4		eb0a			JMP 0x1400c3d00		
	for w := 1; w < sim.NumWorkers; w++ {
  0x1400c3cf6		48ffc0			INCQ AX			
  0x1400c3cf9		0f1f8000000000		NOPL 0(AX)		
  0x1400c3d00		483981482eba07		CMPQ 0x7ba2e48(CX), AX	
  0x1400c3d07		7e43			JLE 0x1400c3d4c		
		wb := &sim.WorkerEDensity[w]
  0x1400c3d09		488b5108		MOVQ 0x8(CX), DX	
  0x1400c3d0d		4839d0			CMPQ AX, DX		
  0x1400c3d10		0f838e000000		JAE 0x1400c3da4		
  0x1400c3d16		488b11			MOVQ 0(CX), DX		
  0x1400c3d19		4869d8800c0000		IMULQ $0xc80, AX, BX	
  0x1400c3d20		4801da			ADDQ BX, DX		
		for p := 0; p < N_G; p++ {
  0x1400c3d23		31db			XORL BX, BX		
  0x1400c3d25		eb1a			JMP 0x1400c3d41		
			sim.E_density[p] += wb[p]
  0x1400c3d27		f20f1004da		MOVSD_XMM 0(DX)(BX*8), X0		
  0x1400c3d2c		f20f5884d9d0272707	ADDSD 0x72727d0(CX)(BX*8), X0		
  0x1400c3d35		f20f1184d9d0272707	MOVSD_XMM X0, 0x72727d0(CX)(BX*8)	
		for p := 0; p < N_G; p++ {
  0x1400c3d3e		48ffc3			INCQ BX			
  0x1400c3d41		4881fb90010000		CMPQ BX, $0x190		
  0x1400c3d48		7cdd			JL 0x1400c3d27		
  0x1400c3d4a		ebaa			JMP 0x1400c3cf6		
	sim.E_density[0] *= 2.0
  0x1400c3d4c		f20f1081d0272707	MOVSD_XMM 0x72727d0(CX), X0	
  0x1400c3d54		f20f58c0		ADDSD X0, X0			
  0x1400c3d58		f20f1181d0272707	MOVSD_XMM X0, 0x72727d0(CX)	
	sim.E_density[N_G-1] *= 2.0
  0x1400c3d60		f20f108148342707	MOVSD_XMM 0x7273448(CX), X0	
  0x1400c3d68		f20f58c0		ADDSD X0, X0			
  0x1400c3d6c		f20f118148342707	MOVSD_XMM X0, 0x7273448(CX)	
	for p := 0; p < N_G; p++ {
  0x1400c3d74		31c0			XORL AX, AX		
  0x1400c3d76		eb1e			JMP 0x1400c3d96		
		sim.Cumul_e_density[p] += sim.E_density[p]
  0x1400c3d78		f20f1084c1d0272707	MOVSD_XMM 0x72727d0(CX)(AX*8), X0	
  0x1400c3d81		f20f5884c1d0402707	ADDSD 0x72740d0(CX)(AX*8), X0		
  0x1400c3d8a		f20f1184c1d0402707	MOVSD_XMM X0, 0x72740d0(CX)(AX*8)	
	for p := 0; p < N_G; p++ {
  0x1400c3d93		48ffc0			INCQ AX			
  0x1400c3d96		483d90010000		CMPQ AX, $0x190		
  0x1400c3d9c		7cda			JL 0x1400c3d78		
}
  0x1400c3d9e		4883c410		ADDQ $0x10, SP		
  0x1400c3da2		5d			POPQ BP			
  0x1400c3da3		c3			RET			
		wb := &sim.WorkerEDensity[w]
  0x1400c3da4		e8d7a6fbff		CALL runtime.panicBounds(SB)	
	w0 := &sim.WorkerEDensity[0]
  0x1400c3da9		e8d2a6fbff		CALL runtime.panicBounds(SB)	
  0x1400c3dae		90			NOPL				
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x1400c3daf		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c3db4		e88788fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c3db9		488b442408		MOVQ 0x8(SP), AX						
  0x1400c3dbe		6690			NOPW								
  0x1400c3dc0		e9dbfeffff		JMP gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	

  0x1400c3dc5		cc			INT $0x3		
  0x1400c3dc6		cc			INT $0x3		
  0x1400c3dc7		cc			INT $0x3		
  0x1400c3dc8		cc			INT $0x3		
  0x1400c3dc9		cc			INT $0x3		
  0x1400c3dca		cc			INT $0x3		
  0x1400c3dcb		cc			INT $0x3		
  0x1400c3dcc		cc			INT $0x3		
  0x1400c3dcd		cc			INT $0x3		
  0x1400c3dce		cc			INT $0x3		
  0x1400c3dcf		cc			INT $0x3		
  0x1400c3dd0		cc			INT $0x3		
  0x1400c3dd1		cc			INT $0x3		
  0x1400c3dd2		cc			INT $0x3		
  0x1400c3dd3		cc			INT $0x3		
  0x1400c3dd4		cc			INT $0x3		
  0x1400c3dd5		cc			INT $0x3		
  0x1400c3dd6		cc			INT $0x3		
  0x1400c3dd7		cc			INT $0x3		
  0x1400c3dd8		cc			INT $0x3		
  0x1400c3dd9		cc			INT $0x3		
  0x1400c3dda		cc			INT $0x3		
  0x1400c3ddb		cc			INT $0x3		
  0x1400c3ddc		cc			INT $0x3		
  0x1400c3ddd		cc			INT $0x3		
  0x1400c3dde		cc			INT $0x3		
  0x1400c3ddf		cc			INT $0x3		


// =============================================================================
// SYMBOL: Step1ComputeIonDensity
// =============================================================================

TEXT gopic.(*SimulationState).Step1ComputeIonDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x1400c3de0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3de4		0f8642010000		JBE 0x1400c3f2c		
  0x1400c3dea		55			PUSHQ BP		
  0x1400c3deb		4889e5			MOVQ SP, BP		
  0x1400c3dee		4883ec10		SUBQ $0x10, SP		
	if (t % N_SUB) == 0 {
  0x1400c3df2		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c3dfc		480fafd9		IMULQ CX, BX			
  0x1400c3e00		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c3e0a		4801d9			ADDQ BX, CX			
  0x1400c3e0d		48c1c13e		ROLQ $0x3e, CX			
  0x1400c3e11		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c3e1b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c3e20		4839ca			CMPQ DX, CX			
  0x1400c3e23		0f82c4000000		JB 0x1400c3eed			
  0x1400c3e29		4889442420		MOVQ AX, 0x20(SP)		
		sim.broadcastAndWait(CmdComputeIDensity)
  0x1400c3e2e		bb01000000		MOVL $0x1, BX						
  0x1400c3e33		e848faffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
		w0 := &sim.WorkerIDensity[0]
  0x1400c3e38		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c3e3d		4883792000		CMPQ 0x20(CX), $0x0	
  0x1400c3e42		0f86de000000		JBE 0x1400c3f26		
  0x1400c3e48		488b4118		MOVQ 0x18(CX), AX	
		for p := 0; p < N_G; p++ {
  0x1400c3e4c		31d2			XORL DX, DX		
  0x1400c3e4e		eb11			JMP 0x1400c3e61		
			sim.I_density[p] = w0[p]
  0x1400c3e50		f20f1004d0		MOVSD_XMM 0(AX)(DX*8), X0		
  0x1400c3e55		f20f1184d150342707	MOVSD_XMM X0, 0x7273450(CX)(DX*8)	
		for p := 0; p < N_G; p++ {
  0x1400c3e5e		48ffc2			INCQ DX			
  0x1400c3e61		4881fa90010000		CMPQ DX, $0x190		
  0x1400c3e68		7ce6			JL 0x1400c3e50		
  0x1400c3e6a		b801000000		MOVL $0x1, AX		
  0x1400c3e6f		eb03			JMP 0x1400c3e74		
		for w := 1; w < sim.NumWorkers; w++ {
  0x1400c3e71		48ffc0			INCQ AX			
  0x1400c3e74		483981482eba07		CMPQ 0x7ba2e48(CX), AX	
  0x1400c3e7b		7e45			JLE 0x1400c3ec2		
			wb := &sim.WorkerIDensity[w]
  0x1400c3e7d		488b5120		MOVQ 0x20(CX), DX	
  0x1400c3e81		4839d0			CMPQ AX, DX		
  0x1400c3e84		0f8397000000		JAE 0x1400c3f21		
  0x1400c3e8a		488b5118		MOVQ 0x18(CX), DX	
  0x1400c3e8e		4869d8800c0000		IMULQ $0xc80, AX, BX	
  0x1400c3e95		4801da			ADDQ BX, DX		
			for p := 0; p < N_G; p++ {
  0x1400c3e98		31db			XORL BX, BX		
  0x1400c3e9a		eb1a			JMP 0x1400c3eb6		
				sim.I_density[p] += wb[p]
  0x1400c3e9c		f20f1004da		MOVSD_XMM 0(DX)(BX*8), X0		
  0x1400c3ea1		f20f5884d950342707	ADDSD 0x7273450(CX)(BX*8), X0		
  0x1400c3eaa		f20f1184d950342707	MOVSD_XMM X0, 0x7273450(CX)(BX*8)	
			for p := 0; p < N_G; p++ {
  0x1400c3eb3		48ffc3			INCQ BX			
  0x1400c3eb6		4881fb90010000		CMPQ BX, $0x190		
  0x1400c3ebd		7cdd			JL 0x1400c3e9c		
  0x1400c3ebf		90			NOPL			
  0x1400c3ec0		ebaf			JMP 0x1400c3e71		
		sim.I_density[0] *= 2.0
  0x1400c3ec2		f20f108150342707	MOVSD_XMM 0x7273450(CX), X0	
  0x1400c3eca		f20f58c0		ADDSD X0, X0			
  0x1400c3ece		f20f118150342707	MOVSD_XMM X0, 0x7273450(CX)	
		sim.I_density[N_G-1] *= 2.0
  0x1400c3ed6		f20f1081c8402707	MOVSD_XMM 0x72740c8(CX), X0	
  0x1400c3ede		f20f58c0		ADDSD X0, X0			
  0x1400c3ee2		f20f1181c8402707	MOVSD_XMM X0, 0x72740c8(CX)	
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x1400c3eea		4889c8			MOVQ CX, AX		
	for p := 0; p < N_G; p++ {
  0x1400c3eed		31c9			XORL CX, CX		
  0x1400c3eef		eb20			JMP 0x1400c3f11		
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x1400c3ef1		8400			TESTB AL, 0(AX)				
  0x1400c3ef3		f20f1084c850342707	MOVSD_XMM 0x7273450(AX)(CX*8), X0	
  0x1400c3efc		f20f5884c8504d2707	ADDSD 0x7274d50(AX)(CX*8), X0		
  0x1400c3f05		f20f1184c8504d2707	MOVSD_XMM X0, 0x7274d50(AX)(CX*8)	
	for p := 0; p < N_G; p++ {
  0x1400c3f0e		48ffc1			INCQ CX			
  0x1400c3f11		4881f990010000		CMPQ CX, $0x190		
  0x1400c3f18		7cd7			JL 0x1400c3ef1		
}
  0x1400c3f1a		4883c410		ADDQ $0x10, SP		
  0x1400c3f1e		5d			POPQ BP			
  0x1400c3f1f		90			NOPL			
  0x1400c3f20		c3			RET			
			wb := &sim.WorkerIDensity[w]
  0x1400c3f21		e85aa5fbff		CALL runtime.panicBounds(SB)	
		w0 := &sim.WorkerIDensity[0]
  0x1400c3f26		e855a5fbff		CALL runtime.panicBounds(SB)	
  0x1400c3f2b		90			NOPL				
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x1400c3f2c		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3f31		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c3f36		e80587fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c3f3b		488b442408		MOVQ 0x8(SP), AX					
  0x1400c3f40		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c3f45		e996feffff		JMP gopic.(*SimulationState).Step1ComputeIonDensity(SB)	

  0x1400c3f4a		cc			INT $0x3		
  0x1400c3f4b		cc			INT $0x3		
  0x1400c3f4c		cc			INT $0x3		
  0x1400c3f4d		cc			INT $0x3		
  0x1400c3f4e		cc			INT $0x3		
  0x1400c3f4f		cc			INT $0x3		
  0x1400c3f50		cc			INT $0x3		
  0x1400c3f51		cc			INT $0x3		
  0x1400c3f52		cc			INT $0x3		
  0x1400c3f53		cc			INT $0x3		
  0x1400c3f54		cc			INT $0x3		
  0x1400c3f55		cc			INT $0x3		
  0x1400c3f56		cc			INT $0x3		
  0x1400c3f57		cc			INT $0x3		
  0x1400c3f58		cc			INT $0x3		
  0x1400c3f59		cc			INT $0x3		
  0x1400c3f5a		cc			INT $0x3		
  0x1400c3f5b		cc			INT $0x3		
  0x1400c3f5c		cc			INT $0x3		
  0x1400c3f5d		cc			INT $0x3		
  0x1400c3f5e		cc			INT $0x3		
  0x1400c3f5f		cc			INT $0x3		


