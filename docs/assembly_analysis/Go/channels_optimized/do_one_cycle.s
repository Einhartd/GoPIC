// =============================================================================
// SYMBOL: DoOneCycle
// =============================================================================

TEXT gopic.(*SimulationState).DoOneCycle(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) DoOneCycle() {
  0x1400c4900		4c8d6424c0		LEAQ -0x40(SP), R12	
  0x1400c4905		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c4909		0f8687030000		JBE 0x1400c4c96		
  0x1400c490f		55			PUSHQ BP		
  0x1400c4910		4889e5			MOVQ SP, BP		
  0x1400c4913		4881ecb8000000		SUBQ $0xb8, SP		
	for t = 0; t < N_T; t++ {
  0x1400c491a		48898424c8000000	MOVQ AX, 0xc8(SP)	
  0x1400c4922		31c9			XORL CX, CX		
  0x1400c4924		eb03			JMP 0x1400c4929		
  0x1400c4926		48ffc1			INCQ CX			
  0x1400c4929		4881f9a00f0000		CMPQ CX, $0xfa0		
  0x1400c4930		0f8dfa010000		JGE 0x1400c4b30		
  0x1400c4936		48894c2440		MOVQ CX, 0x40(SP)	
		sim.Time += DT_E
  0x1400c493b		8400			TESTB AL, 0(AX)				
  0x1400c493d		f20f1080a02dba07	MOVSD_XMM 0x7ba2da0(AX), X0		
  0x1400c4945		f20f100d43280100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X1	
  0x1400c494d		f20f58c1		ADDSD X1, X0				
  0x1400c4951		f20f1180a02dba07	MOVSD_XMM X0, 0x7ba2da0(AX)		
		sim.Step1ComputeElectronDensity()
  0x1400c4959		e842f3ffff		CALL gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	
		sim.Step1ComputeIonDensity(t)
  0x1400c495e		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x1400c4966		488b5c2440		MOVQ 0x40(SP), BX						
  0x1400c496b		e870f4ffff		CALL gopic.(*SimulationState).Step1ComputeIonDensity(SB)	
		t_index = t / N_BIN
  0x1400c4970		48b8cdcccccccccccccc	MOVQ $0xcccccccccccccccd, AX	
  0x1400c497a		488b4c2440		MOVQ 0x40(SP), CX		
  0x1400c497f		48f7e1			MULQ CX				
  0x1400c4982		48c1ea04		SHRQ $0x4, DX			
  0x1400c4986		4889542438		MOVQ DX, 0x38(SP)		
		sim.Step2SolvePoisson(sim.Time)
  0x1400c498b		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x1400c4993		f20f1080a02dba07	MOVSD_XMM 0x7ba2da0(AX), X0				
  0x1400c499b		0f1f440000		NOPL 0(AX)(AX*1)					
  0x1400c49a0		e8bbf5ffff		CALL gopic.(*SimulationState).Step2SolvePoisson(SB)	
		sim.Step3MoveAndBoundariesElectrons(t_index)
  0x1400c49a5		488b8424c8000000	MOVQ 0xc8(SP), AX							
  0x1400c49ad		488b5c2438		MOVQ 0x38(SP), BX							
  0x1400c49b2		e849f6ffff		CALL gopic.(*SimulationState).Step3MoveAndBoundariesElectrons(SB)	
		sim.Step4MoveAndBoundariesIons(t_index, t)
  0x1400c49b7		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x1400c49bf		488b5c2438		MOVQ 0x38(SP), BX						
  0x1400c49c4		488b4c2440		MOVQ 0x40(SP), CX						
  0x1400c49c9		e812f8ffff		CALL gopic.(*SimulationState).Step4MoveAndBoundariesIons(SB)	
		sim.Step5CompactElectrons()
  0x1400c49ce		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x1400c49d6		e885f9ffff		CALL gopic.(*SimulationState).Step5CompactElectrons(SB)	
		sim.Step6CompactIons(t)
  0x1400c49db		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x1400c49e3		488b5c2440		MOVQ 0x40(SP), BX					
  0x1400c49e8		e8f3fbffff		CALL gopic.(*SimulationState).Step6CompactIons(SB)	
		sim.Step7CollisionsElectrons()
  0x1400c49ed		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x1400c49f5		e8e6070000		CALL gopic.(*SimulationState).Step7CollisionsElectrons(SB)	
		sim.Step8CollisionIons(t)
  0x1400c49fa		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x1400c4a02		488b5c2440		MOVQ 0x40(SP), BX					
  0x1400c4a07		e8b40a0000		CALL gopic.(*SimulationState).Step8CollisionIons(SB)	
		sim.Step9CollectXtData(t_index)
  0x1400c4a0c		90			NOPL			
	if !sim.Measurement_mode {
  0x1400c4a0d		488b8424c8000000	MOVQ 0xc8(SP), AX		
  0x1400c4a15		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x1400c4a1c		740c			JE 0x1400c4a2a			
  0x1400c4a1e		31c9			XORL CX, CX			
  0x1400c4a20		488b542438		MOVQ 0x38(SP), DX		
  0x1400c4a25		e95a020000		JMP 0x1400c4c84			
		if (t % 1000) == 0 {
  0x1400c4a2a		488b4c2440		MOVQ 0x40(SP), CX		
  0x1400c4a2f		48bad578e9263108ac1c	MOVQ $0x1cac083126e978d5, DX	
  0x1400c4a39		480fafd1		IMULQ CX, DX			
  0x1400c4a3d		48c1c23d		ROLQ $0x3d, DX			
  0x1400c4a41		48bbefa7c64b37894100	MOVQ $0x4189374bc6a7ef, BX	
  0x1400c4a4b		4839d3			CMPQ BX, DX			
  0x1400c4a4e		0f82d2feffff		JB 0x1400c4926			
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x1400c4a54		488d4c2448		LEAQ 0x48(SP), CX		
  0x1400c4a59		440f1139		MOVUPS X15, 0(CX)		
  0x1400c4a5d		440f117910		MOVUPS X15, 0x10(CX)		
  0x1400c4a62		440f117920		MOVUPS X15, 0x20(CX)		
  0x1400c4a67		440f117930		MOVUPS X15, 0x30(CX)		
  0x1400c4a6c		488b80a82dba07		MOVQ 0x7ba2da8(AX), AX		
  0x1400c4a73		e8c822fbff		CALL runtime.convT64(SB)	
  0x1400c4a78		488d0df98f0f00		LEAQ type:*+95168(SB), CX	
  0x1400c4a7f		48894c2448		MOVQ CX, 0x48(SP)		
  0x1400c4a84		4889442450		MOVQ AX, 0x50(SP)		
  0x1400c4a89		488b442440		MOVQ 0x40(SP), AX		
  0x1400c4a8e		e8ad22fbff		CALL runtime.convT64(SB)	
  0x1400c4a93		488d0dde8f0f00		LEAQ type:*+95168(SB), CX	
  0x1400c4a9a		48894c2458		MOVQ CX, 0x58(SP)		
  0x1400c4a9f		4889442460		MOVQ AX, 0x60(SP)		
  0x1400c4aa4		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x1400c4aac		488b81c07e5603		MOVQ 0x3567ec0(CX), AX		
  0x1400c4ab3		e88822fbff		CALL runtime.convT64(SB)	
  0x1400c4ab8		488d0db98f0f00		LEAQ type:*+95168(SB), CX	
  0x1400c4abf		48894c2468		MOVQ CX, 0x68(SP)		
  0x1400c4ac4		4889442470		MOVQ AX, 0x70(SP)		
  0x1400c4ac9		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x1400c4ad1		488b81c87e5603		MOVQ 0x3567ec8(CX), AX		
  0x1400c4ad8		e86322fbff		CALL runtime.convT64(SB)	
  0x1400c4add		488d0d948f0f00		LEAQ type:*+95168(SB), CX	
  0x1400c4ae4		48894c2478		MOVQ CX, 0x78(SP)		
  0x1400c4ae9		4889842480000000	MOVQ AX, 0x80(SP)		
	return Fprintf(os.Stdout, format, a...)
  0x1400c4af1		488b1d70981100		MOVQ os.Stdout(SB), BX			
  0x1400c4af8		488d05d9ae1000		LEAQ type:*+168736(SB), AX		
  0x1400c4aff		488d0dbde00000		LEAQ runtime.rodata+35779(SB), CX	
  0x1400c4b06		bf26000000		MOVL $0x26, DI				
  0x1400c4b0b		488d742448		LEAQ 0x48(SP), SI			
  0x1400c4b10		41b804000000		MOVL $0x4, R8				
  0x1400c4b16		4589c1			MOVL R8, R9				
  0x1400c4b19		e8c2d0feff		CALL fmt.Fprintf(SB)			
		sim.Time += DT_E
  0x1400c4b1e		488b8424c8000000	MOVQ 0xc8(SP), AX	
	for t = 0; t < N_T; t++ {
  0x1400c4b26		488b4c2440		MOVQ 0x40(SP), CX	
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x1400c4b2b		e9f6fdffff		JMP 0x1400c4926		
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
  0x1400c4b30		488d8c2488000000	LEAQ 0x88(SP), CX			
  0x1400c4b38		440f1139		MOVUPS X15, 0(CX)			
  0x1400c4b3c		440f117910		MOVUPS X15, 0x10(CX)			
  0x1400c4b41		440f117920		MOVUPS X15, 0x20(CX)			
  0x1400c4b46		8400			TESTB AL, 0(AX)				
  0x1400c4b48		488b80a82dba07		MOVQ 0x7ba2da8(AX), AX			
  0x1400c4b4f		e8ec21fbff		CALL runtime.convT64(SB)		
  0x1400c4b54		488d0d1d8f0f00		LEAQ type:*+95168(SB), CX		
  0x1400c4b5b		48898c2488000000	MOVQ CX, 0x88(SP)			
  0x1400c4b63		4889842490000000	MOVQ AX, 0x90(SP)			
  0x1400c4b6b		488b8c24c8000000	MOVQ 0xc8(SP), CX			
  0x1400c4b73		488b81c07e5603		MOVQ 0x3567ec0(CX), AX			
  0x1400c4b7a		e8c121fbff		CALL runtime.convT64(SB)		
  0x1400c4b7f		488d0df28e0f00		LEAQ type:*+95168(SB), CX		
  0x1400c4b86		48898c2498000000	MOVQ CX, 0x98(SP)			
  0x1400c4b8e		48898424a0000000	MOVQ AX, 0xa0(SP)			
  0x1400c4b96		488b8c24c8000000	MOVQ 0xc8(SP), CX			
  0x1400c4b9e		488b81c87e5603		MOVQ 0x3567ec8(CX), AX			
  0x1400c4ba5		e89621fbff		CALL runtime.convT64(SB)		
  0x1400c4baa		488d0dc78e0f00		LEAQ type:*+95168(SB), CX		
  0x1400c4bb1		48898c24a8000000	MOVQ CX, 0xa8(SP)			
  0x1400c4bb9		48898424b0000000	MOVQ AX, 0xb0(SP)			
  0x1400c4bc1		488b8c24c8000000	MOVQ 0xc8(SP), CX			
  0x1400c4bc9		488b99d82dba07		MOVQ 0x7ba2dd8(CX), BX			
  0x1400c4bd0		488d0501ae1000		LEAQ type:*+168736(SB), AX		
  0x1400c4bd7		488d0d6b700000		LEAQ runtime.rodata+7241(SB), CX	
  0x1400c4bde		bf0e000000		MOVL $0xe, DI				
  0x1400c4be3		488db42488000000	LEAQ 0x88(SP), SI			
  0x1400c4beb		41b803000000		MOVL $0x3, R8				
  0x1400c4bf1		4589c1			MOVL R8, R9				
  0x1400c4bf4		e8e7cffeff		CALL fmt.Fprintf(SB)			
}
  0x1400c4bf9		4881c4b8000000		ADDQ $0xb8, SP		
  0x1400c4c00		5d			POPQ BP			
  0x1400c4c01		c3			RET			
		sim.Pot_xt[p][t_index] += sim.Pot[p]
  0x1400c4c02		4869d940060000		IMULQ $0x640, CX, BX			
  0x1400c4c09		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x1400c4c0d		488db680b12707		LEAQ 0x727b180(SI), SI			
  0x1400c4c14		f20f1084c8501b2707	MOVSD_XMM 0x7271b50(AX)(CX*8), X0	
  0x1400c4c1d		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x1400c4c22		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Efield_xt[p][t_index] += sim.Efield[p]
  0x1400c4c27		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x1400c4c2b		488db680753107		LEAQ 0x7317580(SI), SI			
  0x1400c4c32		f20f1084c8d00e2707	MOVSD_XMM 0x7270ed0(AX)(CX*8), X0	
  0x1400c4c3b		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x1400c4c40		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Ne_xt[p][t_index] += sim.E_density[p]
  0x1400c4c45		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x1400c4c49		488db680393b07		LEAQ 0x73b3980(SI), SI			
  0x1400c4c50		f20f1084c8d0272707	MOVSD_XMM 0x72727d0(AX)(CX*8), X0	
  0x1400c4c59		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x1400c4c5e		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Ni_xt[p][t_index] += sim.I_density[p]
  0x1400c4c63		488d1c18		LEAQ 0(AX)(BX*1), BX			
  0x1400c4c67		488d9b80fd4407		LEAQ 0x744fd80(BX), BX			
  0x1400c4c6e		f20f1084c850342707	MOVSD_XMM 0x7273450(AX)(CX*8), X0	
  0x1400c4c77		f20f5804d3		ADDSD 0(BX)(DX*8), X0			
  0x1400c4c7c		f20f1104d3		MOVSD_XMM X0, 0(BX)(DX*8)		
	for p := 0; p < N_G; p++ {
  0x1400c4c81		48ffc1			INCQ CX			
  0x1400c4c84		4881f990010000		CMPQ CX, $0x190		
  0x1400c4c8b		0f8c71ffffff		JL 0x1400c4c02		
  0x1400c4c91		e994fdffff		JMP 0x1400c4a2a		
func (sim *SimulationState) DoOneCycle() {
  0x1400c4c96		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c4c9b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x1400c4ca0		e89b79fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c4ca5		488b442408		MOVQ 0x8(SP), AX				
  0x1400c4caa		e951fcffff		JMP gopic.(*SimulationState).DoOneCycle(SB)	

  0x1400c4caf		cc			INT $0x3		
  0x1400c4cb0		cc			INT $0x3		
  0x1400c4cb1		cc			INT $0x3		
  0x1400c4cb2		cc			INT $0x3		
  0x1400c4cb3		cc			INT $0x3		
  0x1400c4cb4		cc			INT $0x3		
  0x1400c4cb5		cc			INT $0x3		
  0x1400c4cb6		cc			INT $0x3		
  0x1400c4cb7		cc			INT $0x3		
  0x1400c4cb8		cc			INT $0x3		
  0x1400c4cb9		cc			INT $0x3		
  0x1400c4cba		cc			INT $0x3		
  0x1400c4cbb		cc			INT $0x3		
  0x1400c4cbc		cc			INT $0x3		
  0x1400c4cbd		cc			INT $0x3		
  0x1400c4cbe		cc			INT $0x3		
  0x1400c4cbf		cc			INT $0x3		


