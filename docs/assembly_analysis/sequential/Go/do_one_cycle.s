// --- Symbol: DoOneCycle ---
TEXT gopic.(*SimulationState).DoOneCycle(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) DoOneCycle() {
  0x4bc820		4c8d6424c0		LEAQ -0x40(SP), R12	
  0x4bc825		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4bc829		0f8687030000		JBE 0x4bcbb6		
  0x4bc82f		55			PUSHQ BP		
  0x4bc830		4889e5			MOVQ SP, BP		
  0x4bc833		4881ecb8000000		SUBQ $0xb8, SP		
	for t = 0; t < N_T; t++ { // the RF period is divided into N_T equal time intervals (time step DT_E)
  0x4bc83a		48898424c8000000	MOVQ AX, 0xc8(SP)	
  0x4bc842		31c9			XORL CX, CX		
  0x4bc844		eb03			JMP 0x4bc849		
  0x4bc846		48ffc1			INCQ CX			
  0x4bc849		4881f9a00f0000		CMPQ CX, $0xfa0		
  0x4bc850		0f8dfa010000		JGE 0x4bca50		
  0x4bc856		48894c2440		MOVQ CX, 0x40(SP)	
		sim.Time += DT_E    // update of the total simulated time
  0x4bc85b		8400			TESTB AL, 0(AX)				
  0x4bc85d		f20f10806020ba07	MOVSD_XMM 0x7ba2060(AX), X0		
  0x4bc865		f20f100d1bdf0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X1	
  0x4bc86d		f20f58c1		ADDSD X1, X0				
  0x4bc871		f20f11806020ba07	MOVSD_XMM X0, 0x7ba2060(AX)		
		sim.Step1ComputeElectronDensity()
  0x4bc879		e842f1ffff		CALL gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	
		sim.Step1ComputeIonDensity(t)
  0x4bc87e		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bc886		488b5c2440		MOVQ 0x40(SP), BX						
  0x4bc88b		e890f2ffff		CALL gopic.(*SimulationState).Step1ComputeIonDensity(SB)	
		t_index = t / N_BIN // index for XT distributions
  0x4bc890		48b8cdcccccccccccccc	MOVQ $0xcccccccccccccccd, AX	
  0x4bc89a		488b4c2440		MOVQ 0x40(SP), CX		
  0x4bc89f		48f7e1			MULQ CX				
  0x4bc8a2		48c1ea04		SHRQ $0x4, DX			
  0x4bc8a6		4889542438		MOVQ DX, 0x38(SP)		
		sim.Step2SolvePoisson(sim.Time)
  0x4bc8ab		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x4bc8b3		f20f10806020ba07	MOVSD_XMM 0x7ba2060(AX), X0				
  0x4bc8bb		0f1f440000		NOPL 0(AX)(AX*1)					
  0x4bc8c0		e8fbf3ffff		CALL gopic.(*SimulationState).Step2SolvePoisson(SB)	
		sim.Step3MoveElectrons(t_index)
  0x4bc8c5		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x4bc8cd		488b5c2438		MOVQ 0x38(SP), BX					
  0x4bc8d2		e889f4ffff		CALL gopic.(*SimulationState).Step3MoveElectrons(SB)	
		sim.Step4MoveIons(t_index, t)
  0x4bc8d7		488b8424c8000000	MOVQ 0xc8(SP), AX				
  0x4bc8df		488b5c2438		MOVQ 0x38(SP), BX				
  0x4bc8e4		488b4c2440		MOVQ 0x40(SP), CX				
  0x4bc8e9		e872f8ffff		CALL gopic.(*SimulationState).Step4MoveIons(SB)	
		sim.Step5CheckBoundariesElectrons()
  0x4bc8ee		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bc8f6		e8e5faffff		CALL gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB)	
		sim.Step6CheckBoundariesIons(t)
  0x4bc8fb		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bc903		488b5c2440		MOVQ 0x40(SP), BX						
  0x4bc908		e873fcffff		CALL gopic.(*SimulationState).Step6CheckBoundariesIons(SB)	
		sim.Step7CollisionsElectrons()
  0x4bc90d		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bc915		e8e6080000		CALL gopic.(*SimulationState).Step7CollisionsElectrons(SB)	
		sim.Step8CollisionIons(t)
  0x4bc91a		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x4bc922		488b5c2440		MOVQ 0x40(SP), BX					
  0x4bc927		e8140b0000		CALL gopic.(*SimulationState).Step8CollisionIons(SB)	
		sim.Step9CollectXtData(t_index)
  0x4bc92c		90			NOPL			
	if !sim.Measurement_mode {
  0x4bc92d		488b8424c8000000	MOVQ 0xc8(SP), AX		
  0x4bc935		80b8a020ba0700		CMPB 0x7ba20a0(AX), $0x0	
  0x4bc93c		740c			JE 0x4bc94a			
  0x4bc93e		31c9			XORL CX, CX			
  0x4bc940		488b542438		MOVQ 0x38(SP), DX		
  0x4bc945		e95a020000		JMP 0x4bcba4			
		if (t % 1000) == 0 {
  0x4bc94a		488b4c2440		MOVQ 0x40(SP), CX		
  0x4bc94f		48bad578e9263108ac1c	MOVQ $0x1cac083126e978d5, DX	
  0x4bc959		480fafd1		IMULQ CX, DX			
  0x4bc95d		48c1c23d		ROLQ $0x3d, DX			
  0x4bc961		48bbefa7c64b37894100	MOVQ $0x4189374bc6a7ef, BX	
  0x4bc96b		4839d3			CMPQ BX, DX			
  0x4bc96e		0f82d2feffff		JB 0x4bc846			
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x4bc974		488d4c2448		LEAQ 0x48(SP), CX		
  0x4bc979		440f1139		MOVUPS X15, 0(CX)		
  0x4bc97d		440f117910		MOVUPS X15, 0x10(CX)		
  0x4bc982		440f117920		MOVUPS X15, 0x20(CX)		
  0x4bc987		440f117930		MOVUPS X15, 0x30(CX)		
  0x4bc98c		488b806820ba07		MOVQ 0x7ba2068(AX), AX		
  0x4bc993		e8e8d9fbff		CALL runtime.convT64(SB)	
  0x4bc998		488d0dd9cd0e00		LEAQ 0xecdd9(IP), CX		
  0x4bc99f		48894c2448		MOVQ CX, 0x48(SP)		
  0x4bc9a4		4889442450		MOVQ AX, 0x50(SP)		
  0x4bc9a9		488b442440		MOVQ 0x40(SP), AX		
  0x4bc9ae		e8cdd9fbff		CALL runtime.convT64(SB)	
  0x4bc9b3		488d0dbecd0e00		LEAQ 0xecdbe(IP), CX		
  0x4bc9ba		48894c2458		MOVQ CX, 0x58(SP)		
  0x4bc9bf		4889442460		MOVQ AX, 0x60(SP)		
  0x4bc9c4		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bc9cc		488b81007e5603		MOVQ 0x3567e00(CX), AX		
  0x4bc9d3		e8a8d9fbff		CALL runtime.convT64(SB)	
  0x4bc9d8		488d0d99cd0e00		LEAQ 0xecd99(IP), CX		
  0x4bc9df		48894c2468		MOVQ CX, 0x68(SP)		
  0x4bc9e4		4889442470		MOVQ AX, 0x70(SP)		
  0x4bc9e9		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bc9f1		488b81087e5603		MOVQ 0x3567e08(CX), AX		
  0x4bc9f8		e883d9fbff		CALL runtime.convT64(SB)	
  0x4bc9fd		488d0d74cd0e00		LEAQ 0xecd74(IP), CX		
  0x4bca04		48894c2478		MOVQ CX, 0x78(SP)		
  0x4bca09		4889842480000000	MOVQ AX, 0x80(SP)		
	return Fprintf(os.Stdout, format, a...)
  0x4bca11		488b1d70ab1000		MOVQ os.Stdout(SB), BX	
  0x4bca18		488d0541db0f00		LEAQ 0xfdb41(IP), AX	
  0x4bca1f		488d0dbe9c0000		LEAQ 0x9cbe(IP), CX	
  0x4bca26		bf26000000		MOVL $0x26, DI		
  0x4bca2b		488d742448		LEAQ 0x48(SP), SI	
  0x4bca30		41b804000000		MOVL $0x4, R8		
  0x4bca36		4589c1			MOVL R8, R9		
  0x4bca39		e822a5feff		CALL fmt.Fprintf(SB)	
		sim.Time += DT_E    // update of the total simulated time
  0x4bca3e		488b8424c8000000	MOVQ 0xc8(SP), AX	
	for t = 0; t < N_T; t++ { // the RF period is divided into N_T equal time intervals (time step DT_E)
  0x4bca46		488b4c2440		MOVQ 0x40(SP), CX	
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x4bca4b		e9f6fdffff		JMP 0x4bc846		
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
  0x4bca50		488d8c2488000000	LEAQ 0x88(SP), CX		
  0x4bca58		440f1139		MOVUPS X15, 0(CX)		
  0x4bca5c		440f117910		MOVUPS X15, 0x10(CX)		
  0x4bca61		440f117920		MOVUPS X15, 0x20(CX)		
  0x4bca66		8400			TESTB AL, 0(AX)			
  0x4bca68		488b806820ba07		MOVQ 0x7ba2068(AX), AX		
  0x4bca6f		e80cd9fbff		CALL runtime.convT64(SB)	
  0x4bca74		488d0dfdcc0e00		LEAQ 0xeccfd(IP), CX		
  0x4bca7b		48898c2488000000	MOVQ CX, 0x88(SP)		
  0x4bca83		4889842490000000	MOVQ AX, 0x90(SP)		
  0x4bca8b		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bca93		488b81007e5603		MOVQ 0x3567e00(CX), AX		
  0x4bca9a		e8e1d8fbff		CALL runtime.convT64(SB)	
  0x4bca9f		488d0dd2cc0e00		LEAQ 0xeccd2(IP), CX		
  0x4bcaa6		48898c2498000000	MOVQ CX, 0x98(SP)		
  0x4bcaae		48898424a0000000	MOVQ AX, 0xa0(SP)		
  0x4bcab6		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bcabe		488b81087e5603		MOVQ 0x3567e08(CX), AX		
  0x4bcac5		e8b6d8fbff		CALL runtime.convT64(SB)	
  0x4bcaca		488d0da7cc0e00		LEAQ 0xecca7(IP), CX		
  0x4bcad1		48898c24a8000000	MOVQ CX, 0xa8(SP)		
  0x4bcad9		48898424b0000000	MOVQ AX, 0xb0(SP)		
  0x4bcae1		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bcae9		488b999820ba07		MOVQ 0x7ba2098(CX), BX		
  0x4bcaf0		488d0569da0f00		LEAQ 0xfda69(IP), AX		
  0x4bcaf7		488d0d243e0000		LEAQ 0x3e24(IP), CX		
  0x4bcafe		bf0e000000		MOVL $0xe, DI			
  0x4bcb03		488db42488000000	LEAQ 0x88(SP), SI		
  0x4bcb0b		41b803000000		MOVL $0x3, R8			
  0x4bcb11		4589c1			MOVL R8, R9			
  0x4bcb14		e847a4feff		CALL fmt.Fprintf(SB)		
}
  0x4bcb19		4881c4b8000000		ADDQ $0xb8, SP		
  0x4bcb20		5d			POPQ BP			
  0x4bcb21		c3			RET			
		sim.Pot_xt[p][t_index] += sim.Pot[p]
  0x4bcb22		4869d940060000		IMULQ $0x640, CX, BX			
  0x4bcb29		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x4bcb2d		488db640a42707		LEAQ 0x727a440(SI), SI			
  0x4bcb34		f20f1084c8901a2707	MOVSD_XMM 0x7271a90(AX)(CX*8), X0	
  0x4bcb3d		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x4bcb42		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Efield_xt[p][t_index] += sim.Efield[p]
  0x4bcb47		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x4bcb4b		488db640683107		LEAQ 0x7316840(SI), SI			
  0x4bcb52		f20f1084c8100e2707	MOVSD_XMM 0x7270e10(AX)(CX*8), X0	
  0x4bcb5b		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x4bcb60		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Ne_xt[p][t_index] += sim.E_density[p]
  0x4bcb65		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x4bcb69		488db6402c3b07		LEAQ 0x73b2c40(SI), SI			
  0x4bcb70		f20f1084c810272707	MOVSD_XMM 0x7272710(AX)(CX*8), X0	
  0x4bcb79		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x4bcb7e		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Ni_xt[p][t_index] += sim.I_density[p]
  0x4bcb83		488d1c18		LEAQ 0(AX)(BX*1), BX			
  0x4bcb87		488d9b40f04407		LEAQ 0x744f040(BX), BX			
  0x4bcb8e		f20f1084c890332707	MOVSD_XMM 0x7273390(AX)(CX*8), X0	
  0x4bcb97		f20f5804d3		ADDSD 0(BX)(DX*8), X0			
  0x4bcb9c		f20f1104d3		MOVSD_XMM X0, 0(BX)(DX*8)		
	for p := 0; p < N_G; p++ {
  0x4bcba1		48ffc1			INCQ CX			
  0x4bcba4		4881f990010000		CMPQ CX, $0x190		
  0x4bcbab		0f8c71ffffff		JL 0x4bcb22		
  0x4bcbb1		e994fdffff		JMP 0x4bc94a		
func (sim *SimulationState) DoOneCycle() {
  0x4bcbb6		4889442408		MOVQ AX, 0x8(SP)				
  0x4bcbbb		0f1f440000		NOPL 0(AX)(AX*1)				
  0x4bcbc0		e8fb2efcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bcbc5		488b442408		MOVQ 0x8(SP), AX				
  0x4bcbca		e951fcffff		JMP gopic.(*SimulationState).DoOneCycle(SB)	


