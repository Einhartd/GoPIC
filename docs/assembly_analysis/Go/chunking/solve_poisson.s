TEXT gopic.(*SimulationState).SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/poisson.go
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x4bc140		4989e4			MOVQ SP, R12		
  0x4bc143		4981ec90180000		SUBQ $0x1890, R12	
  0x4bc14a		0f821b020000		JB 0x4bc36b		
  0x4bc150		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4bc154		0f8611020000		JBE 0x4bc36b		
  0x4bc15a		55			PUSHQ BP		
  0x4bc15b		4889e5			MOVQ SP, BP		
  0x4bc15e		4881ec08190000		SUBQ $0x1908, SP	
	for i := 1; i <= N_G-2; i++ {
  0x4bc165		4889842418190000	MOVQ AX, 0x1918(SP)	
  0x4bc16d		48899c2420190000	MOVQ BX, 0x1920(SP)	
	var g, f Xvector
  0x4bc175		488d7c2408		LEAQ 0x8(SP), DI	
  0x4bc17a		b990010000		MOVL $0x190, CX		
  0x4bc17f		31c0			XORL AX, AX		
  0x4bc181		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x4bc184		488dbc24880c0000	LEAQ 0xc88(SP), DI	
  0x4bc18c		b990010000		MOVL $0x190, CX		
  0x4bc191		f348ab			REP; STOSQ AX, ES:0(DI)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencjał na elektrodzie zasilanej RF (x = 0)
  0x4bc194		f20f100d1c190100	MOVSD_XMM $f64.41945031e30fb945(SB), X1	
  0x4bc19c		f20f59c1		MULSD X1, X0				
	return cos(x)
  0x4bc1a0		e83b98fcff		CALL math.cos(SB)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencjał na elektrodzie zasilanej RF (x = 0)
  0x4bc1a5		488b942418190000	MOVQ 0x1918(SP), DX		
  0x4bc1ad		8402			TESTB AL, 0(DX)			
  0x4bc1af		f20f100db1160100	MOVSD_XMM 0x116b1(IP), X1	
  0x4bc1b7		f20f59c8		MULSD X0, X1			
  0x4bc1bb		f20f118a501b2707	MOVSD_XMM X1, 0x7271b50(DX)	
	sim.Pot[N_G-1] = 0.0                      // Potencjał na elektrodzie uziemionej (x = L)
  0x4bc1c3		48c782c827270700000000	MOVQ $0x0, 0x72727c8(DX)	
	for i := 1; i <= N_G-2; i++ {
  0x4bc1ce		bb01000000		MOVL $0x1, BX		
  0x4bc1d3		488bb42420190000	MOVQ 0x1920(SP), SI	
  0x4bc1db		eb23			JMP 0x4bc200		
		f[i] = ALPHA * (*rho1)[i]
  0x4bc1dd		8406			TESTB AL, 0(SI)				
  0x4bc1df		f20f1004de		MOVSD_XMM 0(SI)(BX*8), X0		
  0x4bc1e4		f20f100d1c190100	MOVSD_XMM $f64.c07bb63bc6c73374(SB), X1	
  0x4bc1ec		f20f59c1		MULSD X1, X0				
  0x4bc1f0		f20f1184dc880c0000	MOVSD_XMM X0, 0xc88(SP)(BX*8)		
	for i := 1; i <= N_G-2; i++ {
  0x4bc1f9		48ffc3			INCQ BX			
  0x4bc1fc		0f1f4000		NOPL 0(AX)		
  0x4bc200		4881fb8e010000		CMPQ BX, $0x18e		
  0x4bc207		7ed4			JLE 0x4bc1dd		
	f[1] -= sim.Pot[0]
  0x4bc209		f20f108424900c0000	MOVSD_XMM 0xc90(SP), X0	
  0x4bc212		f20f5c82501b2707	SUBSD 0x7271b50(DX), X0	
  0x4bc21a		f20f118424900c0000	MOVSD_XMM X0, 0xc90(SP)	
	f[N_G-2] -= sim.Pot[N_G-1]
  0x4bc223		f20f108c24f8180000	MOVSD_XMM 0x18f8(SP), X1	
  0x4bc22c		f20f5c8ac8272707	SUBSD 0x72727c8(DX), X1		
  0x4bc234		f20f118c24f8180000	MOVSD_XMM X1, 0x18f8(SP)	
	g[1] = f[1] * sim.ThomasW[1]
  0x4bc23d		f20f108ad8592707	MOVSD_XMM 0x72759d8(DX), X1	
  0x4bc245		f20f59c8		MULSD X0, X1			
  0x4bc249		f20f114c2410		MOVSD_XMM X1, 0x10(SP)		
	for i := 2; i <= N_G-2; i++ {
  0x4bc24f		b802000000		MOVL $0x2, AX		
  0x4bc254		eb20			JMP 0x4bc276		
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
  0x4bc256		f20f1084c4880c0000	MOVSD_XMM 0xc88(SP)(AX*8), X0	
  0x4bc25f		f20f5c04c4		SUBSD 0(SP)(AX*8), X0		
  0x4bc264		f20f5984c2d0592707	MULSD 0x72759d0(DX)(AX*8), X0	
  0x4bc26d		f20f1144c408		MOVSD_XMM X0, 0x8(SP)(AX*8)	
	for i := 2; i <= N_G-2; i++ {
  0x4bc273		48ffc0			INCQ AX			
  0x4bc276		483d8e010000		CMPQ AX, $0x18e		
  0x4bc27c		7ed8			JLE 0x4bc256		
	sim.Pot[N_G-2] = g[N_G-2]
  0x4bc27e		f20f108424780c0000	MOVSD_XMM 0xc78(SP), X0		
  0x4bc287		f20f1182c0272707	MOVSD_XMM X0, 0x72727c0(DX)	
	for i := N_G - 3; i > 0; i-- {
  0x4bc28f		b88d010000		MOVL $0x18d, AX		
  0x4bc294		eb2a			JMP 0x4bc2c0		
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1] // Potencjał w wewnętrznych punktach siatki
  0x4bc296		f20f1044c408		MOVSD_XMM 0x8(SP)(AX*8), X0		
  0x4bc29c		f20f108cc2d0592707	MOVSD_XMM 0x72759d0(DX)(AX*8), X1	
  0x4bc2a5		f20f598cc2581b2707	MULSD 0x7271b58(DX)(AX*8), X1		
  0x4bc2ae		f20f5cc1		SUBSD X1, X0				
  0x4bc2b2		f20f1184c2501b2707	MOVSD_XMM X0, 0x7271b50(DX)(AX*8)	
	for i := N_G - 3; i > 0; i-- {
  0x4bc2bb		48ffc8			DECQ AX			
  0x4bc2be		6690			NOPW			
  0x4bc2c0		4885c0			TESTQ AX, AX		
  0x4bc2c3		7fd1			JG 0x4bc296		
  0x4bc2c5		b801000000		MOVL $0x1, AX		
  0x4bc2ca		eb2a			JMP 0x4bc2f6		
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // Różnice centralne wewnątrz domeny
  0x4bc2cc		f20f1084c2481b2707	MOVSD_XMM 0x7271b48(DX)(AX*8), X0	
  0x4bc2d5		f20f5c84c2581b2707	SUBSD 0x7271b58(DX)(AX*8), X0		
  0x4bc2de		f20f100db2170100	MOVSD_XMM $f64.40bf2c0000000000(SB), X1	
  0x4bc2e6		f20f59c1		MULSD X1, X0				
  0x4bc2ea		f20f1184c2d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)(AX*8)	
  0x4bc2f3		48ffc0			INCQ AX					
	for i := 1; i <= N_G-2; i++ {
  0x4bc2f6		483d8e010000		CMPQ AX, $0x18e		
  0x4bc2fc		7ece			JLE 0x4bc2cc		
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA
  0x4bc2fe		f20f1082501b2707	MOVSD_XMM 0x7271b50(DX), X0		
  0x4bc306		f20f5c82581b2707	SUBSD 0x7271b58(DX), X0			
  0x4bc30e		f20f100d8a170100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bc316		f20f59c1		MULSD X1, X0				
  0x4bc31a		f20f1016		MOVSD_XMM 0(SI), X2			
  0x4bc31e		f20f101d8a170100	MOVSD_XMM $f64.414afea47ac24bbf(SB), X3	
  0x4bc326		f20f59d3		MULSD X3, X2				
  0x4bc32a		f20f5cc2		SUBSD X2, X0				
  0x4bc32e		f20f1182d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)		
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA
  0x4bc336		f20f1082c0272707	MOVSD_XMM 0x72727c0(DX), X0	
  0x4bc33e		f20f5c82c8272707	SUBSD 0x72727c8(DX), X0		
  0x4bc346		f20f59c8		MULSD X0, X1			
  0x4bc34a		f20f1086780c0000	MOVSD_XMM 0xc78(SI), X0		
  0x4bc352		f20f59c3		MULSD X3, X0			
  0x4bc356		f20f58c8		ADDSD X0, X1			
  0x4bc35a		f20f118a481b2707	MOVSD_XMM X1, 0x7271b48(DX)	
}
  0x4bc362		4881c408190000		ADDQ $0x1908, SP	
  0x4bc369		5d			POPQ BP			
  0x4bc36a		c3			RET			
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x4bc36b		4889442408		MOVQ AX, 0x8(SP)				
  0x4bc370		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bc375		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x4bc37b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x4bc380		e83b45fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bc385		488b442408		MOVQ 0x8(SP), AX				
  0x4bc38a		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bc38f		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x4bc395		e9a6fdffff		JMP gopic.(*SimulationState).SolvePoisson(SB)	
