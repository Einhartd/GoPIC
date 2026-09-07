TEXT gopic.(*SimulationState).SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/poisson.go
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x4bb360		4989e4			MOVQ SP, R12		
  0x4bb363		4981ec90180000		SUBQ $0x1890, R12	
  0x4bb36a		0f8218020000		JB 0x4bb588		
  0x4bb370		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4bb374		0f860e020000		JBE 0x4bb588		
  0x4bb37a		55			PUSHQ BP		
  0x4bb37b		4889e5			MOVQ SP, BP		
  0x4bb37e		4881ec08190000		SUBQ $0x1908, SP	
	for i := 1; i <= N_G-2; i++ {
  0x4bb385		4889842418190000	MOVQ AX, 0x1918(SP)	
  0x4bb38d		48899c2420190000	MOVQ BX, 0x1920(SP)	
	var g, f Xvector
  0x4bb395		488d7c2408		LEAQ 0x8(SP), DI	
  0x4bb39a		b990010000		MOVL $0x190, CX		
  0x4bb39f		31c0			XORL AX, AX		
  0x4bb3a1		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x4bb3a4		488dbc24880c0000	LEAQ 0xc88(SP), DI	
  0x4bb3ac		b990010000		MOVL $0x190, CX		
  0x4bb3b1		f348ab			REP; STOSQ AX, ES:0(DI)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencja┼é na elektrodzie zasilanej RF (x = 0)
  0x4bb3b4		f20f100dfc260100	MOVSD_XMM $f64.41945031e30fb945(SB), X1	
  0x4bb3bc		f20f59c1		MULSD X1, X0				
	return cos(x)
  0x4bb3c0		e8bb99fcff		CALL math.cos(SB)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencja┼é na elektrodzie zasilanej RF (x = 0)
  0x4bb3c5		488b942418190000	MOVQ 0x1918(SP), DX		
  0x4bb3cd		8402			TESTB AL, 0(DX)			
  0x4bb3cf		f20f100d91240100	MOVSD_XMM 0x12491(IP), X1	
  0x4bb3d7		f20f59c8		MULSD X0, X1			
  0x4bb3db		f20f118a501b2707	MOVSD_XMM X1, 0x7271b50(DX)	
	sim.Pot[N_G-1] = 0.0                      // Potencja┼é na elektrodzie uziemionej (x = L)
  0x4bb3e3		48c782c827270700000000	MOVQ $0x0, 0x72727c8(DX)	
	for i := 1; i <= N_G-2; i++ {
  0x4bb3ee		bb01000000		MOVL $0x1, BX		
  0x4bb3f3		488bb42420190000	MOVQ 0x1920(SP), SI	
  0x4bb3fb		eb23			JMP 0x4bb420		
		f[i] = ALPHA * (*rho1)[i]
  0x4bb3fd		8406			TESTB AL, 0(SI)				
  0x4bb3ff		f20f1004de		MOVSD_XMM 0(SI)(BX*8), X0		
  0x4bb404		f20f100dfc260100	MOVSD_XMM $f64.c07bb63bc6c73374(SB), X1	
  0x4bb40c		f20f59c1		MULSD X1, X0				
  0x4bb410		f20f1184dc880c0000	MOVSD_XMM X0, 0xc88(SP)(BX*8)		
	for i := 1; i <= N_G-2; i++ {
  0x4bb419		48ffc3			INCQ BX			
  0x4bb41c		0f1f4000		NOPL 0(AX)		
  0x4bb420		4881fb8e010000		CMPQ BX, $0x18e		
  0x4bb427		7ed4			JLE 0x4bb3fd		
	f[1] -= sim.Pot[0]
  0x4bb429		f20f108424900c0000	MOVSD_XMM 0xc90(SP), X0	
  0x4bb432		f20f5c82501b2707	SUBSD 0x7271b50(DX), X0	
  0x4bb43a		f20f118424900c0000	MOVSD_XMM X0, 0xc90(SP)	
	f[N_G-2] -= sim.Pot[N_G-1]
  0x4bb443		f20f108c24f8180000	MOVSD_XMM 0x18f8(SP), X1	
  0x4bb44c		f20f5c8ac8272707	SUBSD 0x72727c8(DX), X1		
  0x4bb454		f20f118c24f8180000	MOVSD_XMM X1, 0x18f8(SP)	
	g[1] = f[1] * sim.ThomasW[1]
  0x4bb45d		f20f108ad8592707	MOVSD_XMM 0x72759d8(DX), X1	
  0x4bb465		f20f59c8		MULSD X0, X1			
  0x4bb469		f20f114c2410		MOVSD_XMM X1, 0x10(SP)		
	for i := 2; i <= N_G-2; i++ {
  0x4bb46f		b802000000		MOVL $0x2, AX		
  0x4bb474		eb20			JMP 0x4bb496		
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
  0x4bb476		f20f1084c4880c0000	MOVSD_XMM 0xc88(SP)(AX*8), X0	
  0x4bb47f		f20f5c04c4		SUBSD 0(SP)(AX*8), X0		
  0x4bb484		f20f5984c2d0592707	MULSD 0x72759d0(DX)(AX*8), X0	
  0x4bb48d		f20f1144c408		MOVSD_XMM X0, 0x8(SP)(AX*8)	
	for i := 2; i <= N_G-2; i++ {
  0x4bb493		48ffc0			INCQ AX			
  0x4bb496		483d8e010000		CMPQ AX, $0x18e		
  0x4bb49c		7ed8			JLE 0x4bb476		
	sim.Pot[N_G-2] = g[N_G-2]
  0x4bb49e		f20f108424780c0000	MOVSD_XMM 0xc78(SP), X0		
  0x4bb4a7		f20f1182c0272707	MOVSD_XMM X0, 0x72727c0(DX)	
	for i := N_G - 3; i > 0; i-- {
  0x4bb4af		b88d010000		MOVL $0x18d, AX		
  0x4bb4b4		eb2a			JMP 0x4bb4e0		
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1] // Potencja┼é w wewn─Ötrznych punktach siatki
  0x4bb4b6		f20f1044c408		MOVSD_XMM 0x8(SP)(AX*8), X0		
  0x4bb4bc		f20f108cc2d0592707	MOVSD_XMM 0x72759d0(DX)(AX*8), X1	
  0x4bb4c5		f20f598cc2581b2707	MULSD 0x7271b58(DX)(AX*8), X1		
  0x4bb4ce		f20f5cc1		SUBSD X1, X0				
  0x4bb4d2		f20f1184c2501b2707	MOVSD_XMM X0, 0x7271b50(DX)(AX*8)	
	for i := N_G - 3; i > 0; i-- {
  0x4bb4db		48ffc8			DECQ AX			
  0x4bb4de		6690			NOPW			
  0x4bb4e0		4885c0			TESTQ AX, AX		
  0x4bb4e3		7fd1			JG 0x4bb4b6		
  0x4bb4e5		b801000000		MOVL $0x1, AX		
  0x4bb4ea		eb2a			JMP 0x4bb516		
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // R├│┼╝nice centralne wewn─ůtrz domeny
  0x4bb4ec		f20f1084c2481b2707	MOVSD_XMM 0x7271b48(DX)(AX*8), X0	
  0x4bb4f5		f20f5c84c2581b2707	SUBSD 0x7271b58(DX)(AX*8), X0		
  0x4bb4fe		f20f100d92250100	MOVSD_XMM $f64.40bf2c0000000000(SB), X1	
  0x4bb506		f20f59c1		MULSD X1, X0				
  0x4bb50a		f20f1184c2d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)(AX*8)	
  0x4bb513		48ffc0			INCQ AX					
	for i := 1; i <= N_G-2; i++ {
  0x4bb516		483d8e010000		CMPQ AX, $0x18e		
  0x4bb51c		7ece			JLE 0x4bb4ec		
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA
  0x4bb51e		f20f1082501b2707	MOVSD_XMM 0x7271b50(DX), X0		
  0x4bb526		f20f5c82581b2707	SUBSD 0x7271b58(DX), X0			
  0x4bb52e		f20f100d6a250100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bb536		f20f59c1		MULSD X1, X0				
  0x4bb53a		f20f1016		MOVSD_XMM 0(SI), X2			
  0x4bb53e		f20f101d6a250100	MOVSD_XMM $f64.414afea47ac24bbf(SB), X3	
  0x4bb546		f20f59d3		MULSD X3, X2				
  0x4bb54a		f20f5cc2		SUBSD X2, X0				
  0x4bb54e		f20f1182d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)		
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA
  0x4bb556		f20f1082c0272707	MOVSD_XMM 0x72727c0(DX), X0	
  0x4bb55e		f20f5c82c8272707	SUBSD 0x72727c8(DX), X0		
  0x4bb566		f20f1096780c0000	MOVSD_XMM 0xc78(SI), X2		
  0x4bb56e		f20f59d3		MULSD X3, X2			
  0x4bb572		c4e2f9b9d1		VFMADD231SD X1, X0, X2		
  0x4bb577		f20f1192481b2707	MOVSD_XMM X2, 0x7271b48(DX)	
}
  0x4bb57f		4881c408190000		ADDQ $0x1908, SP	
  0x4bb586		5d			POPQ BP			
  0x4bb587		c3			RET			
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x4bb588		4889442408		MOVQ AX, 0x8(SP)				
  0x4bb58d		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bb592		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x4bb598		e8c348fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bb59d		488b442408		MOVQ 0x8(SP), AX				
  0x4bb5a2		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bb5a7		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x4bb5ad		e9aefdffff		JMP gopic.(*SimulationState).SolvePoisson(SB)	

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x4bc780		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x4bc788		4d3b6610		CMPQ R12, 0x10(R14)		
  0x4bc78c		7671			JBE 0x4bc7ff			
  0x4bc78e		55			PUSHQ BP			
  0x4bc78f		4889e5			MOVQ SP, BP			
  0x4bc792		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x4bc799		488d7c2418		LEAQ 0x18(SP), DI	
  0x4bc79e		b990010000		MOVL $0x190, CX		
	for p := 0; p < N_G; p++ {
  0x4bc7a3		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x4bc7a6		31c0			XORL AX, AX		
  0x4bc7a8		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := 0; p < N_G; p++ {
  0x4bc7ab		31f6			XORL SI, SI		
  0x4bc7ad		eb31			JMP 0x4bc7e0		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // G─Östo┼Ť─ç ┼éadunku przestrzennego
  0x4bc7af		8402			TESTB AL, 0(DX)				
  0x4bc7b1		f20f108cf250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X1	
  0x4bc7ba		f20f5c8cf2d0272707	SUBSD 0x72727d0(DX)(SI*8), X1		
  0x4bc7c3		f20f1015e5100100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x4bc7cb		f20f59ca		MULSD X2, X1				
  0x4bc7cf		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := 0; p < N_G; p++ {
  0x4bc7d5		48ffc6			INCQ SI			
  0x4bc7d8		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4bc7e0		4881fe90010000		CMPQ SI, $0x190		
  0x4bc7e7		7cc6			JL 0x4bc7af		
	sim.SolvePoisson(&rho, currentTime) // Obliczenie potencja┼éu i pola E
  0x4bc7e9		4889d0			MOVQ DX, AX					
  0x4bc7ec		488d5c2418		LEAQ 0x18(SP), BX				
  0x4bc7f1		e86aebffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x4bc7f6		4881c4980c0000		ADDQ $0xc98, SP		
  0x4bc7fd		5d			POPQ BP			
  0x4bc7fe		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x4bc7ff		4889442408		MOVQ AX, 0x8(SP)					
  0x4bc804		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x4bc80a		e85136fcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bc80f		488b442408		MOVQ 0x8(SP), AX					
  0x4bc814		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x4bc81a		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	
