TEXT gopic.(*SimulationState).DoOneCycle(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) DoOneCycle() {
  0x4bd4a0		4c8d6424c0		LEAQ -0x40(SP), R12	
  0x4bd4a5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4bd4a9		0f8687030000		JBE 0x4bd836		
  0x4bd4af		55			PUSHQ BP		
  0x4bd4b0		4889e5			MOVQ SP, BP		
  0x4bd4b3		4881ecb8000000		SUBQ $0xb8, SP		
	for t = range N_T { // Okres RF jest dzielony na N_T jednakowych przedzia┼é├│w czasowych DT_E
  0x4bd4ba		48898424c8000000	MOVQ AX, 0xc8(SP)	
  0x4bd4c2		31c9			XORL CX, CX		
  0x4bd4c4		eb03			JMP 0x4bd4c9		
  0x4bd4c6		48ffc1			INCQ CX			
  0x4bd4c9		4881f9a00f0000		CMPQ CX, $0xfa0		
  0x4bd4d0		0f8dfa010000		JGE 0x4bd6d0		
  0x4bd4d6		48894c2440		MOVQ CX, 0x40(SP)	
		sim.Time += DT_E    // Aktualizacja fizycznego czasu symulacji
  0x4bd4db		8400			TESTB AL, 0(AX)				
  0x4bd4dd		f20f1080a02dba07	MOVSD_XMM 0x7ba2da0(AX), X0		
  0x4bd4e5		f20f100db3030100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X1	
  0x4bd4ed		f20f58c1		ADDSD X1, X0				
  0x4bd4f1		f20f1180a02dba07	MOVSD_XMM X0, 0x7ba2da0(AX)		
		sim.Step1ComputeElectronDensity()
  0x4bd4f9		e822ebffff		CALL gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	
		sim.Step1ComputeIonDensity(t)
  0x4bd4fe		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bd506		488b5c2440		MOVQ 0x40(SP), BX						
  0x4bd50b		e870edffff		CALL gopic.(*SimulationState).Step1ComputeIonDensity(SB)	
		t_index = t / N_BIN // Indeks dla rozk┼éad├│w czasoprzestrzennych XT
  0x4bd510		48b8cdcccccccccccccc	MOVQ $0xcccccccccccccccd, AX	
  0x4bd51a		488b4c2440		MOVQ 0x40(SP), CX		
  0x4bd51f		48f7e1			MULQ CX				
  0x4bd522		48c1ea04		SHRQ $0x4, DX			
  0x4bd526		4889542438		MOVQ DX, 0x38(SP)		
		sim.Step2SolvePoisson(sim.Time)
  0x4bd52b		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x4bd533		f20f1080a02dba07	MOVSD_XMM 0x7ba2da0(AX), X0				
  0x4bd53b		0f1f440000		NOPL 0(AX)(AX*1)					
  0x4bd540		e8dbefffff		CALL gopic.(*SimulationState).Step2SolvePoisson(SB)	
		sim.Step3MoveElectrons(t_index)
  0x4bd545		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x4bd54d		488b5c2438		MOVQ 0x38(SP), BX					
  0x4bd552		e869f0ffff		CALL gopic.(*SimulationState).Step3MoveElectrons(SB)	
		sim.Step4MoveIons(t_index, t)
  0x4bd557		488b8424c8000000	MOVQ 0xc8(SP), AX				
  0x4bd55f		488b5c2438		MOVQ 0x38(SP), BX				
  0x4bd564		488b4c2440		MOVQ 0x40(SP), CX				
  0x4bd569		e8f2f3ffff		CALL gopic.(*SimulationState).Step4MoveIons(SB)	
		sim.Step5CheckBoundariesElectrons()
  0x4bd56e		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bd576		e8c5f6ffff		CALL gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB)	
		sim.Step6CheckBoundariesIons(t)
  0x4bd57b		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bd583		488b5c2440		MOVQ 0x40(SP), BX						
  0x4bd588		e853faffff		CALL gopic.(*SimulationState).Step6CheckBoundariesIons(SB)	
		sim.Step7CollisionsElectrons()
  0x4bd58d		488b8424c8000000	MOVQ 0xc8(SP), AX						
  0x4bd595		e8e6070000		CALL gopic.(*SimulationState).Step7CollisionsElectrons(SB)	
		sim.Step8CollisionIons(t)
  0x4bd59a		488b8424c8000000	MOVQ 0xc8(SP), AX					
  0x4bd5a2		488b5c2440		MOVQ 0x40(SP), BX					
  0x4bd5a7		e8d40b0000		CALL gopic.(*SimulationState).Step8CollisionIons(SB)	
		sim.Step9CollectXtData(t_index)
  0x4bd5ac		90			NOPL			
	if !sim.Measurement_mode {
  0x4bd5ad		488b8424c8000000	MOVQ 0xc8(SP), AX		
  0x4bd5b5		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x4bd5bc		740c			JE 0x4bd5ca			
  0x4bd5be		31c9			XORL CX, CX			
  0x4bd5c0		488b542438		MOVQ 0x38(SP), DX		
  0x4bd5c5		e95a020000		JMP 0x4bd824			
		if (t % 1000) == 0 {
  0x4bd5ca		488b4c2440		MOVQ 0x40(SP), CX		
  0x4bd5cf		48bad578e9263108ac1c	MOVQ $0x1cac083126e978d5, DX	
  0x4bd5d9		480fafd1		IMULQ CX, DX			
  0x4bd5dd		48c1c23d		ROLQ $0x3d, DX			
  0x4bd5e1		48bbefa7c64b37894100	MOVQ $0x4189374bc6a7ef, BX	
  0x4bd5eb		4839d3			CMPQ BX, DX			
  0x4bd5ee		0f82d2feffff		JB 0x4bd4c6			
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x4bd5f4		488d4c2448		LEAQ 0x48(SP), CX		
  0x4bd5f9		440f1139		MOVUPS X15, 0(CX)		
  0x4bd5fd		440f117910		MOVUPS X15, 0x10(CX)		
  0x4bd602		440f117920		MOVUPS X15, 0x20(CX)		
  0x4bd607		440f117930		MOVUPS X15, 0x30(CX)		
  0x4bd60c		488b80a82dba07		MOVQ 0x7ba2da8(AX), AX		
  0x4bd613		e8a8cffbff		CALL runtime.convT64(SB)	
  0x4bd618		488d0da9090f00		LEAQ 0xf09a9(IP), CX		
  0x4bd61f		48894c2448		MOVQ CX, 0x48(SP)		
  0x4bd624		4889442450		MOVQ AX, 0x50(SP)		
  0x4bd629		488b442440		MOVQ 0x40(SP), AX		
  0x4bd62e		e88dcffbff		CALL runtime.convT64(SB)	
  0x4bd633		488d0d8e090f00		LEAQ 0xf098e(IP), CX		
  0x4bd63a		48894c2458		MOVQ CX, 0x58(SP)		
  0x4bd63f		4889442460		MOVQ AX, 0x60(SP)		
  0x4bd644		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bd64c		488b81c07e5603		MOVQ 0x3567ec0(CX), AX		
  0x4bd653		e868cffbff		CALL runtime.convT64(SB)	
  0x4bd658		488d0d69090f00		LEAQ 0xf0969(IP), CX		
  0x4bd65f		48894c2468		MOVQ CX, 0x68(SP)		
  0x4bd664		4889442470		MOVQ AX, 0x70(SP)		
  0x4bd669		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bd671		488b81c87e5603		MOVQ 0x3567ec8(CX), AX		
  0x4bd678		e843cffbff		CALL runtime.convT64(SB)	
  0x4bd67d		488d0d44090f00		LEAQ 0xf0944(IP), CX		
  0x4bd684		48894c2478		MOVQ CX, 0x78(SP)		
  0x4bd689		4889842480000000	MOVQ AX, 0x80(SP)		
	return Fprintf(os.Stdout, format, a...)
  0x4bd691		488b1dd0ee1000		MOVQ os.Stdout(SB), BX	
  0x4bd698		488d05091f1000		LEAQ 0x101f09(IP), AX	
  0x4bd69f		488d0d26c00000		LEAQ 0xc026(IP), CX	
  0x4bd6a6		bf26000000		MOVL $0x26, DI		
  0x4bd6ab		488d742448		LEAQ 0x48(SP), SI	
  0x4bd6b0		41b804000000		MOVL $0x4, R8		
  0x4bd6b6		4589c1			MOVL R8, R9		
  0x4bd6b9		e8229efeff		CALL fmt.Fprintf(SB)	
		sim.Time += DT_E    // Aktualizacja fizycznego czasu symulacji
  0x4bd6be		488b8424c8000000	MOVQ 0xc8(SP), AX	
	for t = range N_T { // Okres RF jest dzielony na N_T jednakowych przedzia┼é├│w czasowych DT_E
  0x4bd6c6		488b4c2440		MOVQ 0x40(SP), CX	
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x4bd6cb		e9f6fdffff		JMP 0x4bd4c6		
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
  0x4bd6d0		488d8c2488000000	LEAQ 0x88(SP), CX		
  0x4bd6d8		440f1139		MOVUPS X15, 0(CX)		
  0x4bd6dc		440f117910		MOVUPS X15, 0x10(CX)		
  0x4bd6e1		440f117920		MOVUPS X15, 0x20(CX)		
  0x4bd6e6		8400			TESTB AL, 0(AX)			
  0x4bd6e8		488b80a82dba07		MOVQ 0x7ba2da8(AX), AX		
  0x4bd6ef		e8cccefbff		CALL runtime.convT64(SB)	
  0x4bd6f4		488d0dcd080f00		LEAQ 0xf08cd(IP), CX		
  0x4bd6fb		48898c2488000000	MOVQ CX, 0x88(SP)		
  0x4bd703		4889842490000000	MOVQ AX, 0x90(SP)		
  0x4bd70b		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bd713		488b81c07e5603		MOVQ 0x3567ec0(CX), AX		
  0x4bd71a		e8a1cefbff		CALL runtime.convT64(SB)	
  0x4bd71f		488d0da2080f00		LEAQ 0xf08a2(IP), CX		
  0x4bd726		48898c2498000000	MOVQ CX, 0x98(SP)		
  0x4bd72e		48898424a0000000	MOVQ AX, 0xa0(SP)		
  0x4bd736		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bd73e		488b81c87e5603		MOVQ 0x3567ec8(CX), AX		
  0x4bd745		e876cefbff		CALL runtime.convT64(SB)	
  0x4bd74a		488d0d77080f00		LEAQ 0xf0877(IP), CX		
  0x4bd751		48898c24a8000000	MOVQ CX, 0xa8(SP)		
  0x4bd759		48898424b0000000	MOVQ AX, 0xb0(SP)		
  0x4bd761		488b8c24c8000000	MOVQ 0xc8(SP), CX		
  0x4bd769		488b99d82dba07		MOVQ 0x7ba2dd8(CX), BX		
  0x4bd770		488d05311e1000		LEAQ 0x101e31(IP), AX		
  0x4bd777		488d0db8610000		LEAQ 0x61b8(IP), CX		
  0x4bd77e		bf0e000000		MOVL $0xe, DI			
  0x4bd783		488db42488000000	LEAQ 0x88(SP), SI		
  0x4bd78b		41b803000000		MOVL $0x3, R8			
  0x4bd791		4589c1			MOVL R8, R9			
  0x4bd794		e8479dfeff		CALL fmt.Fprintf(SB)		
}
  0x4bd799		4881c4b8000000		ADDQ $0xb8, SP		
  0x4bd7a0		5d			POPQ BP			
  0x4bd7a1		c3			RET			
		sim.Pot_xt[p][t_index] += sim.Pot[p]
  0x4bd7a2		4869d940060000		IMULQ $0x640, CX, BX			
  0x4bd7a9		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x4bd7ad		488db680b12707		LEAQ 0x727b180(SI), SI			
  0x4bd7b4		f20f1084c8501b2707	MOVSD_XMM 0x7271b50(AX)(CX*8), X0	
  0x4bd7bd		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x4bd7c2		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Efield_xt[p][t_index] += sim.Efield[p]
  0x4bd7c7		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x4bd7cb		488db680753107		LEAQ 0x7317580(SI), SI			
  0x4bd7d2		f20f1084c8d00e2707	MOVSD_XMM 0x7270ed0(AX)(CX*8), X0	
  0x4bd7db		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x4bd7e0		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Ne_xt[p][t_index] += sim.E_density[p]
  0x4bd7e5		488d3418		LEAQ 0(AX)(BX*1), SI			
  0x4bd7e9		488db680393b07		LEAQ 0x73b3980(SI), SI			
  0x4bd7f0		f20f1084c8d0272707	MOVSD_XMM 0x72727d0(AX)(CX*8), X0	
  0x4bd7f9		f20f5804d6		ADDSD 0(SI)(DX*8), X0			
  0x4bd7fe		f20f1104d6		MOVSD_XMM X0, 0(SI)(DX*8)		
		sim.Ni_xt[p][t_index] += sim.I_density[p]
  0x4bd803		488d1c18		LEAQ 0(AX)(BX*1), BX			
  0x4bd807		488d9b80fd4407		LEAQ 0x744fd80(BX), BX			
  0x4bd80e		f20f1084c850342707	MOVSD_XMM 0x7273450(AX)(CX*8), X0	
  0x4bd817		f20f5804d3		ADDSD 0(BX)(DX*8), X0			
  0x4bd81c		f20f1104d3		MOVSD_XMM X0, 0(BX)(DX*8)		
	for p := 0; p < N_G; p++ {
  0x4bd821		48ffc1			INCQ CX			
  0x4bd824		4881f990010000		CMPQ CX, $0x190		
  0x4bd82b		0f8c71ffffff		JL 0x4bd7a2		
  0x4bd831		e994fdffff		JMP 0x4bd5ca		
func (sim *SimulationState) DoOneCycle() {
  0x4bd836		4889442408		MOVQ AX, 0x8(SP)				
  0x4bd83b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x4bd840		e81b26fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bd845		488b442408		MOVQ 0x8(SP), AX				
  0x4bd84a		e951fcffff		JMP gopic.(*SimulationState).DoOneCycle(SB)	
