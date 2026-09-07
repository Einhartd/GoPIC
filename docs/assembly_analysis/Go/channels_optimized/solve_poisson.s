// =============================================================================
// SYMBOL: Step2SolvePoisson
// =============================================================================

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3f60		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x1400c3f68		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400c3f6c		7671			JBE 0x1400c3fdf			
  0x1400c3f6e		55			PUSHQ BP			
  0x1400c3f6f		4889e5			MOVQ SP, BP			
  0x1400c3f72		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x1400c3f79		488d7c2418		LEAQ 0x18(SP), DI	
  0x1400c3f7e		b990010000		MOVL $0x190, CX		
	for p := 0; p < N_G; p++ {
  0x1400c3f83		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x1400c3f86		31c0			XORL AX, AX		
  0x1400c3f88		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := 0; p < N_G; p++ {
  0x1400c3f8b		31f6			XORL SI, SI		
  0x1400c3f8d		eb31			JMP 0x1400c3fc0		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p])
  0x1400c3f8f		8402			TESTB AL, 0(DX)				
  0x1400c3f91		f20f108cf250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X1	
  0x1400c3f9a		f20f5c8cf2d0272707	SUBSD 0x72727d0(DX)(SI*8), X1		
  0x1400c3fa3		f20f1015ad310100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x1400c3fab		f20f59ca		MULSD X2, X1				
  0x1400c3faf		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := 0; p < N_G; p++ {
  0x1400c3fb5		48ffc6			INCQ SI			
  0x1400c3fb8		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c3fc0		4881fe90010000		CMPQ SI, $0x190		
  0x1400c3fc7		7cc6			JL 0x1400c3f8f		
	sim.SolvePoisson(&rho, currentTime)
  0x1400c3fc9		4889d0			MOVQ DX, AX					
  0x1400c3fcc		488d5c2418		LEAQ 0x18(SP), BX				
  0x1400c3fd1		e82ae9ffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x1400c3fd6		4881c4980c0000		ADDQ $0xc98, SP		
  0x1400c3fdd		5d			POPQ BP			
  0x1400c3fde		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3fdf		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3fe4		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400c3fea		e85186fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c3fef		488b442408		MOVQ 0x8(SP), AX					
  0x1400c3ff4		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400c3ffa		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	

  0x1400c3fff		cc			INT $0x3		


// =============================================================================
// SYMBOL: SolvePoisson
// =============================================================================

TEXT gopic.(*SimulationState).SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/poisson.go
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x1400c2900		4989e4			MOVQ SP, R12		
  0x1400c2903		4981ec90180000		SUBQ $0x1890, R12	
  0x1400c290a		0f8218020000		JB 0x1400c2b28		
  0x1400c2910		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c2914		0f860e020000		JBE 0x1400c2b28		
  0x1400c291a		55			PUSHQ BP		
  0x1400c291b		4889e5			MOVQ SP, BP		
  0x1400c291e		4881ec08190000		SUBQ $0x1908, SP	
	for i := 1; i <= N_G-2; i++ {
  0x1400c2925		4889842418190000	MOVQ AX, 0x1918(SP)	
  0x1400c292d		48899c2420190000	MOVQ BX, 0x1920(SP)	
	var g, f Xvector
  0x1400c2935		488d7c2408		LEAQ 0x8(SP), DI	
  0x1400c293a		b990010000		MOVL $0x190, CX		
  0x1400c293f		31c0			XORL AX, AX		
  0x1400c2941		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x1400c2944		488dbc24880c0000	LEAQ 0xc88(SP), DI	
  0x1400c294c		b990010000		MOVL $0x190, CX		
  0x1400c2951		f348ab			REP; STOSQ AX, ES:0(DI)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // PotencjaĹ‚ na elektrodzie zasilanej RF (x = 0)
  0x1400c2954		f20f100d044a0100	MOVSD_XMM $f64.41945031e30fb945(SB), X1	
  0x1400c295c		f20f59c1		MULSD X1, X0				
	return cos(x)
  0x1400c2960		e89b12fcff		CALL math.cos(SB)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // PotencjaĹ‚ na elektrodzie zasilanej RF (x = 0)
  0x1400c2965		488b942418190000	MOVQ 0x1918(SP), DX			
  0x1400c296d		8402			TESTB AL, 0(DX)				
  0x1400c296f		f20f100d99470100	MOVSD_XMM runtime.egcbss+50(SB), X1	
  0x1400c2977		f20f59c8		MULSD X0, X1				
  0x1400c297b		f20f118a501b2707	MOVSD_XMM X1, 0x7271b50(DX)		
	sim.Pot[N_G-1] = 0.0                      // PotencjaĹ‚ na elektrodzie uziemionej (x = L)
  0x1400c2983		48c782c827270700000000	MOVQ $0x0, 0x72727c8(DX)	
	for i := 1; i <= N_G-2; i++ {
  0x1400c298e		bb01000000		MOVL $0x1, BX		
  0x1400c2993		488bb42420190000	MOVQ 0x1920(SP), SI	
  0x1400c299b		eb23			JMP 0x1400c29c0		
		f[i] = ALPHA * (*rho1)[i]
  0x1400c299d		8406			TESTB AL, 0(SI)				
  0x1400c299f		f20f1004de		MOVSD_XMM 0(SI)(BX*8), X0		
  0x1400c29a4		f20f100d0c4a0100	MOVSD_XMM $f64.c07bb63bc6c73374(SB), X1	
  0x1400c29ac		f20f59c1		MULSD X1, X0				
  0x1400c29b0		f20f1184dc880c0000	MOVSD_XMM X0, 0xc88(SP)(BX*8)		
	for i := 1; i <= N_G-2; i++ {
  0x1400c29b9		48ffc3			INCQ BX			
  0x1400c29bc		0f1f4000		NOPL 0(AX)		
  0x1400c29c0		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c29c7		7ed4			JLE 0x1400c299d		
	f[1] -= sim.Pot[0]
  0x1400c29c9		f20f108424900c0000	MOVSD_XMM 0xc90(SP), X0	
  0x1400c29d2		f20f5c82501b2707	SUBSD 0x7271b50(DX), X0	
  0x1400c29da		f20f118424900c0000	MOVSD_XMM X0, 0xc90(SP)	
	f[N_G-2] -= sim.Pot[N_G-1]
  0x1400c29e3		f20f108c24f8180000	MOVSD_XMM 0x18f8(SP), X1	
  0x1400c29ec		f20f5c8ac8272707	SUBSD 0x72727c8(DX), X1		
  0x1400c29f4		f20f118c24f8180000	MOVSD_XMM X1, 0x18f8(SP)	
	g[1] = f[1] * sim.ThomasW[1]
  0x1400c29fd		f20f108ad8592707	MOVSD_XMM 0x72759d8(DX), X1	
  0x1400c2a05		f20f59c8		MULSD X0, X1			
  0x1400c2a09		f20f114c2410		MOVSD_XMM X1, 0x10(SP)		
	for i := 2; i <= N_G-2; i++ {
  0x1400c2a0f		b802000000		MOVL $0x2, AX		
  0x1400c2a14		eb20			JMP 0x1400c2a36		
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
  0x1400c2a16		f20f1084c4880c0000	MOVSD_XMM 0xc88(SP)(AX*8), X0	
  0x1400c2a1f		f20f5c04c4		SUBSD 0(SP)(AX*8), X0		
  0x1400c2a24		f20f5984c2d0592707	MULSD 0x72759d0(DX)(AX*8), X0	
  0x1400c2a2d		f20f1144c408		MOVSD_XMM X0, 0x8(SP)(AX*8)	
	for i := 2; i <= N_G-2; i++ {
  0x1400c2a33		48ffc0			INCQ AX			
  0x1400c2a36		483d8e010000		CMPQ AX, $0x18e		
  0x1400c2a3c		7ed8			JLE 0x1400c2a16		
	sim.Pot[N_G-2] = g[N_G-2]
  0x1400c2a3e		f20f108424780c0000	MOVSD_XMM 0xc78(SP), X0		
  0x1400c2a47		f20f1182c0272707	MOVSD_XMM X0, 0x72727c0(DX)	
	for i := N_G - 3; i > 0; i-- {
  0x1400c2a4f		b88d010000		MOVL $0x18d, AX		
  0x1400c2a54		eb2a			JMP 0x1400c2a80		
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1] // PotencjaĹ‚ w wewnÄ™trznych punktach siatki
  0x1400c2a56		f20f1044c408		MOVSD_XMM 0x8(SP)(AX*8), X0		
  0x1400c2a5c		f20f108cc2d0592707	MOVSD_XMM 0x72759d0(DX)(AX*8), X1	
  0x1400c2a65		f20f598cc2581b2707	MULSD 0x7271b58(DX)(AX*8), X1		
  0x1400c2a6e		f20f5cc1		SUBSD X1, X0				
  0x1400c2a72		f20f1184c2501b2707	MOVSD_XMM X0, 0x7271b50(DX)(AX*8)	
	for i := N_G - 3; i > 0; i-- {
  0x1400c2a7b		48ffc8			DECQ AX			
  0x1400c2a7e		6690			NOPW			
  0x1400c2a80		4885c0			TESTQ AX, AX		
  0x1400c2a83		7fd1			JG 0x1400c2a56		
  0x1400c2a85		b801000000		MOVL $0x1, AX		
  0x1400c2a8a		eb2a			JMP 0x1400c2ab6		
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // RĂłĹĽnice centralne wewnÄ…trz domeny
  0x1400c2a8c		f20f1084c2481b2707	MOVSD_XMM 0x7271b48(DX)(AX*8), X0	
  0x1400c2a95		f20f5c84c2581b2707	SUBSD 0x7271b58(DX)(AX*8), X0		
  0x1400c2a9e		f20f100d9a480100	MOVSD_XMM $f64.40bf2c0000000000(SB), X1	
  0x1400c2aa6		f20f59c1		MULSD X1, X0				
  0x1400c2aaa		f20f1184c2d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)(AX*8)	
  0x1400c2ab3		48ffc0			INCQ AX					
	for i := 1; i <= N_G-2; i++ {
  0x1400c2ab6		483d8e010000		CMPQ AX, $0x18e		
  0x1400c2abc		7ece			JLE 0x1400c2a8c		
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA
  0x1400c2abe		f20f1082501b2707	MOVSD_XMM 0x7271b50(DX), X0		
  0x1400c2ac6		f20f5c82581b2707	SUBSD 0x7271b58(DX), X0			
  0x1400c2ace		f20f100d72480100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c2ad6		f20f59c1		MULSD X1, X0				
  0x1400c2ada		f20f1016		MOVSD_XMM 0(SI), X2			
  0x1400c2ade		f20f101d72480100	MOVSD_XMM $f64.414afea47ac24bbf(SB), X3	
  0x1400c2ae6		f20f59d3		MULSD X3, X2				
  0x1400c2aea		f20f5cc2		SUBSD X2, X0				
  0x1400c2aee		f20f1182d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)		
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA
  0x1400c2af6		f20f1082c0272707	MOVSD_XMM 0x72727c0(DX), X0	
  0x1400c2afe		f20f5c82c8272707	SUBSD 0x72727c8(DX), X0		
  0x1400c2b06		f20f1096780c0000	MOVSD_XMM 0xc78(SI), X2		
  0x1400c2b0e		f20f59d3		MULSD X3, X2			
  0x1400c2b12		c4e2f9b9d1		VFMADD231SD X1, X0, X2		
  0x1400c2b17		f20f1192481b2707	MOVSD_XMM X2, 0x7271b48(DX)	
}
  0x1400c2b1f		4881c408190000		ADDQ $0x1908, SP	
  0x1400c2b26		5d			POPQ BP			
  0x1400c2b27		c3			RET			
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x1400c2b28		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c2b2d		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c2b32		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x1400c2b38		e8039bfbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c2b3d		488b442408		MOVQ 0x8(SP), AX				
  0x1400c2b42		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c2b47		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x1400c2b4d		e9aefdffff		JMP gopic.(*SimulationState).SolvePoisson(SB)	

  0x1400c2b52		cc			INT $0x3		
  0x1400c2b53		cc			INT $0x3		
  0x1400c2b54		cc			INT $0x3		
  0x1400c2b55		cc			INT $0x3		
  0x1400c2b56		cc			INT $0x3		
  0x1400c2b57		cc			INT $0x3		
  0x1400c2b58		cc			INT $0x3		
  0x1400c2b59		cc			INT $0x3		
  0x1400c2b5a		cc			INT $0x3		
  0x1400c2b5b		cc			INT $0x3		
  0x1400c2b5c		cc			INT $0x3		
  0x1400c2b5d		cc			INT $0x3		
  0x1400c2b5e		cc			INT $0x3		
  0x1400c2b5f		cc			INT $0x3		

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3f60		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x1400c3f68		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400c3f6c		7671			JBE 0x1400c3fdf			
  0x1400c3f6e		55			PUSHQ BP			
  0x1400c3f6f		4889e5			MOVQ SP, BP			
  0x1400c3f72		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x1400c3f79		488d7c2418		LEAQ 0x18(SP), DI	
  0x1400c3f7e		b990010000		MOVL $0x190, CX		
	for p := 0; p < N_G; p++ {
  0x1400c3f83		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x1400c3f86		31c0			XORL AX, AX		
  0x1400c3f88		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := 0; p < N_G; p++ {
  0x1400c3f8b		31f6			XORL SI, SI		
  0x1400c3f8d		eb31			JMP 0x1400c3fc0		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p])
  0x1400c3f8f		8402			TESTB AL, 0(DX)				
  0x1400c3f91		f20f108cf250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X1	
  0x1400c3f9a		f20f5c8cf2d0272707	SUBSD 0x72727d0(DX)(SI*8), X1		
  0x1400c3fa3		f20f1015ad310100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x1400c3fab		f20f59ca		MULSD X2, X1				
  0x1400c3faf		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := 0; p < N_G; p++ {
  0x1400c3fb5		48ffc6			INCQ SI			
  0x1400c3fb8		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c3fc0		4881fe90010000		CMPQ SI, $0x190		
  0x1400c3fc7		7cc6			JL 0x1400c3f8f		
	sim.SolvePoisson(&rho, currentTime)
  0x1400c3fc9		4889d0			MOVQ DX, AX					
  0x1400c3fcc		488d5c2418		LEAQ 0x18(SP), BX				
  0x1400c3fd1		e82ae9ffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x1400c3fd6		4881c4980c0000		ADDQ $0xc98, SP		
  0x1400c3fdd		5d			POPQ BP			
  0x1400c3fde		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3fdf		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3fe4		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400c3fea		e85186fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c3fef		488b442408		MOVQ 0x8(SP), AX					
  0x1400c3ff4		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400c3ffa		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	

  0x1400c3fff		cc			INT $0x3		


