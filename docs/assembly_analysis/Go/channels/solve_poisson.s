// =============================================================================
// SYMBOL: Step2SolvePoisson
// =============================================================================

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3740		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x1400c3748		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400c374c		7671			JBE 0x1400c37bf			
  0x1400c374e		55			PUSHQ BP			
  0x1400c374f		4889e5			MOVQ SP, BP			
  0x1400c3752		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x1400c3759		488d7c2418		LEAQ 0x18(SP), DI	
  0x1400c375e		b990010000		MOVL $0x190, CX		
	for p := range N_G {
  0x1400c3763		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x1400c3766		31c0			XORL AX, AX		
  0x1400c3768		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := range N_G {
  0x1400c376b		31f6			XORL SI, SI		
  0x1400c376d		eb31			JMP 0x1400c37a0		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // GÄ™stoĹ›Ä‡ Ĺ‚adunku przestrzennego
  0x1400c376f		8402			TESTB AL, 0(DX)				
  0x1400c3771		f20f108cf250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X1	
  0x1400c377a		f20f5c8cf2d0272707	SUBSD 0x72727d0(DX)(SI*8), X1		
  0x1400c3783		f20f101585290100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x1400c378b		f20f59ca		MULSD X2, X1				
  0x1400c378f		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := range N_G {
  0x1400c3795		48ffc6			INCQ SI			
  0x1400c3798		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c37a0		4881fe90010000		CMPQ SI, $0x190		
  0x1400c37a7		7cc6			JL 0x1400c376f		
	sim.SolvePoisson(&rho, currentTime) // Obliczenie potencjaĹ‚u i pola E
  0x1400c37a9		4889d0			MOVQ DX, AX					
  0x1400c37ac		488d5c2418		LEAQ 0x18(SP), BX				
  0x1400c37b1		e86aebffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x1400c37b6		4881c4980c0000		ADDQ $0xc98, SP		
  0x1400c37bd		5d			POPQ BP			
  0x1400c37be		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c37bf		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c37c4		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400c37ca		e8718efbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c37cf		488b442408		MOVQ 0x8(SP), AX					
  0x1400c37d4		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400c37da		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	

  0x1400c37df		cc			INT $0x3		


// =============================================================================
// SYMBOL: SolvePoisson
// =============================================================================

TEXT gopic.(*SimulationState).SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/poisson.go
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x1400c2320		4989e4			MOVQ SP, R12		
  0x1400c2323		4981ec90180000		SUBQ $0x1890, R12	
  0x1400c232a		0f8218020000		JB 0x1400c2548		
  0x1400c2330		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c2334		0f860e020000		JBE 0x1400c2548		
  0x1400c233a		55			PUSHQ BP		
  0x1400c233b		4889e5			MOVQ SP, BP		
  0x1400c233e		4881ec08190000		SUBQ $0x1908, SP	
	for i := 1; i <= N_G-2; i++ {
  0x1400c2345		4889842418190000	MOVQ AX, 0x1918(SP)	
  0x1400c234d		48899c2420190000	MOVQ BX, 0x1920(SP)	
	var g, f Xvector
  0x1400c2355		488d7c2408		LEAQ 0x8(SP), DI	
  0x1400c235a		b990010000		MOVL $0x190, CX		
  0x1400c235f		31c0			XORL AX, AX		
  0x1400c2361		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x1400c2364		488dbc24880c0000	LEAQ 0xc88(SP), DI	
  0x1400c236c		b990010000		MOVL $0x190, CX		
  0x1400c2371		f348ab			REP; STOSQ AX, ES:0(DI)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // PotencjaĹ‚ na elektrodzie zasilanej RF (x = 0)
  0x1400c2374		f20f100d9c3f0100	MOVSD_XMM $f64.41945031e30fb945(SB), X1	
  0x1400c237c		f20f59c1		MULSD X1, X0				
	return cos(x)
  0x1400c2380		e8fb17fcff		CALL math.cos(SB)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // PotencjaĹ‚ na elektrodzie zasilanej RF (x = 0)
  0x1400c2385		488b942418190000	MOVQ 0x1918(SP), DX			
  0x1400c238d		8402			TESTB AL, 0(DX)				
  0x1400c238f		f20f100d293d0100	MOVSD_XMM runtime.egcbss+50(SB), X1	
  0x1400c2397		f20f59c8		MULSD X0, X1				
  0x1400c239b		f20f118a501b2707	MOVSD_XMM X1, 0x7271b50(DX)		
	sim.Pot[N_G-1] = 0.0                      // PotencjaĹ‚ na elektrodzie uziemionej (x = L)
  0x1400c23a3		48c782c827270700000000	MOVQ $0x0, 0x72727c8(DX)	
	for i := 1; i <= N_G-2; i++ {
  0x1400c23ae		bb01000000		MOVL $0x1, BX		
  0x1400c23b3		488bb42420190000	MOVQ 0x1920(SP), SI	
  0x1400c23bb		eb23			JMP 0x1400c23e0		
		f[i] = ALPHA * (*rho1)[i]
  0x1400c23bd		8406			TESTB AL, 0(SI)				
  0x1400c23bf		f20f1004de		MOVSD_XMM 0(SI)(BX*8), X0		
  0x1400c23c4		f20f100d9c3f0100	MOVSD_XMM $f64.c07bb63bc6c73374(SB), X1	
  0x1400c23cc		f20f59c1		MULSD X1, X0				
  0x1400c23d0		f20f1184dc880c0000	MOVSD_XMM X0, 0xc88(SP)(BX*8)		
	for i := 1; i <= N_G-2; i++ {
  0x1400c23d9		48ffc3			INCQ BX			
  0x1400c23dc		0f1f4000		NOPL 0(AX)		
  0x1400c23e0		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c23e7		7ed4			JLE 0x1400c23bd		
	f[1] -= sim.Pot[0]
  0x1400c23e9		f20f108424900c0000	MOVSD_XMM 0xc90(SP), X0	
  0x1400c23f2		f20f5c82501b2707	SUBSD 0x7271b50(DX), X0	
  0x1400c23fa		f20f118424900c0000	MOVSD_XMM X0, 0xc90(SP)	
	f[N_G-2] -= sim.Pot[N_G-1]
  0x1400c2403		f20f108c24f8180000	MOVSD_XMM 0x18f8(SP), X1	
  0x1400c240c		f20f5c8ac8272707	SUBSD 0x72727c8(DX), X1		
  0x1400c2414		f20f118c24f8180000	MOVSD_XMM X1, 0x18f8(SP)	
	g[1] = f[1] * sim.ThomasW[1]
  0x1400c241d		f20f108ad8592707	MOVSD_XMM 0x72759d8(DX), X1	
  0x1400c2425		f20f59c8		MULSD X0, X1			
  0x1400c2429		f20f114c2410		MOVSD_XMM X1, 0x10(SP)		
	for i := 2; i <= N_G-2; i++ {
  0x1400c242f		b802000000		MOVL $0x2, AX		
  0x1400c2434		eb20			JMP 0x1400c2456		
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
  0x1400c2436		f20f1084c4880c0000	MOVSD_XMM 0xc88(SP)(AX*8), X0	
  0x1400c243f		f20f5c04c4		SUBSD 0(SP)(AX*8), X0		
  0x1400c2444		f20f5984c2d0592707	MULSD 0x72759d0(DX)(AX*8), X0	
  0x1400c244d		f20f1144c408		MOVSD_XMM X0, 0x8(SP)(AX*8)	
	for i := 2; i <= N_G-2; i++ {
  0x1400c2453		48ffc0			INCQ AX			
  0x1400c2456		483d8e010000		CMPQ AX, $0x18e		
  0x1400c245c		7ed8			JLE 0x1400c2436		
	sim.Pot[N_G-2] = g[N_G-2]
  0x1400c245e		f20f108424780c0000	MOVSD_XMM 0xc78(SP), X0		
  0x1400c2467		f20f1182c0272707	MOVSD_XMM X0, 0x72727c0(DX)	
	for i := N_G - 3; i > 0; i-- {
  0x1400c246f		b88d010000		MOVL $0x18d, AX		
  0x1400c2474		eb2a			JMP 0x1400c24a0		
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1] // PotencjaĹ‚ w wewnÄ™trznych punktach siatki
  0x1400c2476		f20f1044c408		MOVSD_XMM 0x8(SP)(AX*8), X0		
  0x1400c247c		f20f108cc2d0592707	MOVSD_XMM 0x72759d0(DX)(AX*8), X1	
  0x1400c2485		f20f598cc2581b2707	MULSD 0x7271b58(DX)(AX*8), X1		
  0x1400c248e		f20f5cc1		SUBSD X1, X0				
  0x1400c2492		f20f1184c2501b2707	MOVSD_XMM X0, 0x7271b50(DX)(AX*8)	
	for i := N_G - 3; i > 0; i-- {
  0x1400c249b		48ffc8			DECQ AX			
  0x1400c249e		6690			NOPW			
  0x1400c24a0		4885c0			TESTQ AX, AX		
  0x1400c24a3		7fd1			JG 0x1400c2476		
  0x1400c24a5		b801000000		MOVL $0x1, AX		
  0x1400c24aa		eb2a			JMP 0x1400c24d6		
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // RĂłĹĽnice centralne wewnÄ…trz domeny
  0x1400c24ac		f20f1084c2481b2707	MOVSD_XMM 0x7271b48(DX)(AX*8), X0	
  0x1400c24b5		f20f5c84c2581b2707	SUBSD 0x7271b58(DX)(AX*8), X0		
  0x1400c24be		f20f100d323e0100	MOVSD_XMM $f64.40bf2c0000000000(SB), X1	
  0x1400c24c6		f20f59c1		MULSD X1, X0				
  0x1400c24ca		f20f1184c2d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)(AX*8)	
  0x1400c24d3		48ffc0			INCQ AX					
	for i := 1; i <= N_G-2; i++ {
  0x1400c24d6		483d8e010000		CMPQ AX, $0x18e		
  0x1400c24dc		7ece			JLE 0x1400c24ac		
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA
  0x1400c24de		f20f1082501b2707	MOVSD_XMM 0x7271b50(DX), X0		
  0x1400c24e6		f20f5c82581b2707	SUBSD 0x7271b58(DX), X0			
  0x1400c24ee		f20f100d0a3e0100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c24f6		f20f59c1		MULSD X1, X0				
  0x1400c24fa		f20f1016		MOVSD_XMM 0(SI), X2			
  0x1400c24fe		f20f101d0a3e0100	MOVSD_XMM $f64.414afea47ac24bbf(SB), X3	
  0x1400c2506		f20f59d3		MULSD X3, X2				
  0x1400c250a		f20f5cc2		SUBSD X2, X0				
  0x1400c250e		f20f1182d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)		
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA
  0x1400c2516		f20f1082c0272707	MOVSD_XMM 0x72727c0(DX), X0	
  0x1400c251e		f20f5c82c8272707	SUBSD 0x72727c8(DX), X0		
  0x1400c2526		f20f1096780c0000	MOVSD_XMM 0xc78(SI), X2		
  0x1400c252e		f20f59d3		MULSD X3, X2			
  0x1400c2532		c4e2f9b9d1		VFMADD231SD X1, X0, X2		
  0x1400c2537		f20f1192481b2707	MOVSD_XMM X2, 0x7271b48(DX)	
}
  0x1400c253f		4881c408190000		ADDQ $0x1908, SP	
  0x1400c2546		5d			POPQ BP			
  0x1400c2547		c3			RET			
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x1400c2548		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c254d		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c2552		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x1400c2558		e8e3a0fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c255d		488b442408		MOVQ 0x8(SP), AX				
  0x1400c2562		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c2567		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x1400c256d		e9aefdffff		JMP gopic.(*SimulationState).SolvePoisson(SB)	

  0x1400c2572		cc			INT $0x3		
  0x1400c2573		cc			INT $0x3		
  0x1400c2574		cc			INT $0x3		
  0x1400c2575		cc			INT $0x3		
  0x1400c2576		cc			INT $0x3		
  0x1400c2577		cc			INT $0x3		
  0x1400c2578		cc			INT $0x3		
  0x1400c2579		cc			INT $0x3		
  0x1400c257a		cc			INT $0x3		
  0x1400c257b		cc			INT $0x3		
  0x1400c257c		cc			INT $0x3		
  0x1400c257d		cc			INT $0x3		
  0x1400c257e		cc			INT $0x3		
  0x1400c257f		cc			INT $0x3		

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3740		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x1400c3748		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400c374c		7671			JBE 0x1400c37bf			
  0x1400c374e		55			PUSHQ BP			
  0x1400c374f		4889e5			MOVQ SP, BP			
  0x1400c3752		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x1400c3759		488d7c2418		LEAQ 0x18(SP), DI	
  0x1400c375e		b990010000		MOVL $0x190, CX		
	for p := range N_G {
  0x1400c3763		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x1400c3766		31c0			XORL AX, AX		
  0x1400c3768		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := range N_G {
  0x1400c376b		31f6			XORL SI, SI		
  0x1400c376d		eb31			JMP 0x1400c37a0		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // GÄ™stoĹ›Ä‡ Ĺ‚adunku przestrzennego
  0x1400c376f		8402			TESTB AL, 0(DX)				
  0x1400c3771		f20f108cf250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X1	
  0x1400c377a		f20f5c8cf2d0272707	SUBSD 0x72727d0(DX)(SI*8), X1		
  0x1400c3783		f20f101585290100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x1400c378b		f20f59ca		MULSD X2, X1				
  0x1400c378f		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := range N_G {
  0x1400c3795		48ffc6			INCQ SI			
  0x1400c3798		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c37a0		4881fe90010000		CMPQ SI, $0x190		
  0x1400c37a7		7cc6			JL 0x1400c376f		
	sim.SolvePoisson(&rho, currentTime) // Obliczenie potencjaĹ‚u i pola E
  0x1400c37a9		4889d0			MOVQ DX, AX					
  0x1400c37ac		488d5c2418		LEAQ 0x18(SP), BX				
  0x1400c37b1		e86aebffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x1400c37b6		4881c4980c0000		ADDQ $0xc98, SP		
  0x1400c37bd		5d			POPQ BP			
  0x1400c37be		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c37bf		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c37c4		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400c37ca		e8718efbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c37cf		488b442408		MOVQ 0x8(SP), AX					
  0x1400c37d4		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400c37da		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	

  0x1400c37df		cc			INT $0x3		


