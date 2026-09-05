TEXT gopic.(*SimulationState).SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/poisson.go
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x1400c2580		4989e4			MOVQ SP, R12		
  0x1400c2583		4981ec90180000		SUBQ $0x1890, R12	
  0x1400c258a		0f8218020000		JB 0x1400c27a8		
  0x1400c2590		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c2594		0f860e020000		JBE 0x1400c27a8		
  0x1400c259a		55			PUSHQ BP		
  0x1400c259b		4889e5			MOVQ SP, BP		
  0x1400c259e		4881ec08190000		SUBQ $0x1908, SP	
	for i := 1; i <= N_G-2; i++ {
  0x1400c25a5		4889842418190000	MOVQ AX, 0x1918(SP)	
  0x1400c25ad		48899c2420190000	MOVQ BX, 0x1920(SP)	
	var g, f Xvector
  0x1400c25b5		488d7c2408		LEAQ 0x8(SP), DI	
  0x1400c25ba		b990010000		MOVL $0x190, CX		
  0x1400c25bf		31c0			XORL AX, AX		
  0x1400c25c1		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x1400c25c4		488dbc24880c0000	LEAQ 0xc88(SP), DI	
  0x1400c25cc		b990010000		MOVL $0x190, CX		
  0x1400c25d1		f348ab			REP; STOSQ AX, ES:0(DI)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencja┼é na elektrodzie zasilanej RF (x = 0)
  0x1400c25d4		f20f100d8c3d0100	MOVSD_XMM $f64.41945031e30fb945(SB), X1	
  0x1400c25dc		f20f59c1		MULSD X1, X0				
	return cos(x)
  0x1400c25e0		e89b15fcff		CALL math.cos(SB)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencja┼é na elektrodzie zasilanej RF (x = 0)
  0x1400c25e5		488b942418190000	MOVQ 0x1918(SP), DX			
  0x1400c25ed		8402			TESTB AL, 0(DX)				
  0x1400c25ef		f20f100d193b0100	MOVSD_XMM runtime.egcbss+50(SB), X1	
  0x1400c25f7		f20f59c8		MULSD X0, X1				
  0x1400c25fb		f20f118a501b2707	MOVSD_XMM X1, 0x7271b50(DX)		
	sim.Pot[N_G-1] = 0.0                      // Potencja┼é na elektrodzie uziemionej (x = L)
  0x1400c2603		48c782c827270700000000	MOVQ $0x0, 0x72727c8(DX)	
	for i := 1; i <= N_G-2; i++ {
  0x1400c260e		bb01000000		MOVL $0x1, BX		
  0x1400c2613		488bb42420190000	MOVQ 0x1920(SP), SI	
  0x1400c261b		eb23			JMP 0x1400c2640		
		f[i] = ALPHA * (*rho1)[i]
  0x1400c261d		8406			TESTB AL, 0(SI)				
  0x1400c261f		f20f1004de		MOVSD_XMM 0(SI)(BX*8), X0		
  0x1400c2624		f20f100d8c3d0100	MOVSD_XMM $f64.c07bb63bc6c73374(SB), X1	
  0x1400c262c		f20f59c1		MULSD X1, X0				
  0x1400c2630		f20f1184dc880c0000	MOVSD_XMM X0, 0xc88(SP)(BX*8)		
	for i := 1; i <= N_G-2; i++ {
  0x1400c2639		48ffc3			INCQ BX			
  0x1400c263c		0f1f4000		NOPL 0(AX)		
  0x1400c2640		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c2647		7ed4			JLE 0x1400c261d		
	f[1] -= sim.Pot[0]
  0x1400c2649		f20f108424900c0000	MOVSD_XMM 0xc90(SP), X0	
  0x1400c2652		f20f5c82501b2707	SUBSD 0x7271b50(DX), X0	
  0x1400c265a		f20f118424900c0000	MOVSD_XMM X0, 0xc90(SP)	
	f[N_G-2] -= sim.Pot[N_G-1]
  0x1400c2663		f20f108c24f8180000	MOVSD_XMM 0x18f8(SP), X1	
  0x1400c266c		f20f5c8ac8272707	SUBSD 0x72727c8(DX), X1		
  0x1400c2674		f20f118c24f8180000	MOVSD_XMM X1, 0x18f8(SP)	
	g[1] = f[1] * sim.ThomasW[1]
  0x1400c267d		f20f108ad8592707	MOVSD_XMM 0x72759d8(DX), X1	
  0x1400c2685		f20f59c8		MULSD X0, X1			
  0x1400c2689		f20f114c2410		MOVSD_XMM X1, 0x10(SP)		
	for i := 2; i <= N_G-2; i++ {
  0x1400c268f		b802000000		MOVL $0x2, AX		
  0x1400c2694		eb20			JMP 0x1400c26b6		
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
  0x1400c2696		f20f1084c4880c0000	MOVSD_XMM 0xc88(SP)(AX*8), X0	
  0x1400c269f		f20f5c04c4		SUBSD 0(SP)(AX*8), X0		
  0x1400c26a4		f20f5984c2d0592707	MULSD 0x72759d0(DX)(AX*8), X0	
  0x1400c26ad		f20f1144c408		MOVSD_XMM X0, 0x8(SP)(AX*8)	
	for i := 2; i <= N_G-2; i++ {
  0x1400c26b3		48ffc0			INCQ AX			
  0x1400c26b6		483d8e010000		CMPQ AX, $0x18e		
  0x1400c26bc		7ed8			JLE 0x1400c2696		
	sim.Pot[N_G-2] = g[N_G-2]
  0x1400c26be		f20f108424780c0000	MOVSD_XMM 0xc78(SP), X0		
  0x1400c26c7		f20f1182c0272707	MOVSD_XMM X0, 0x72727c0(DX)	
	for i := N_G - 3; i > 0; i-- {
  0x1400c26cf		b88d010000		MOVL $0x18d, AX		
  0x1400c26d4		eb2a			JMP 0x1400c2700		
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1] // Potencja┼é w wewn─Ötrznych punktach siatki
  0x1400c26d6		f20f1044c408		MOVSD_XMM 0x8(SP)(AX*8), X0		
  0x1400c26dc		f20f108cc2d0592707	MOVSD_XMM 0x72759d0(DX)(AX*8), X1	
  0x1400c26e5		f20f598cc2581b2707	MULSD 0x7271b58(DX)(AX*8), X1		
  0x1400c26ee		f20f5cc1		SUBSD X1, X0				
  0x1400c26f2		f20f1184c2501b2707	MOVSD_XMM X0, 0x7271b50(DX)(AX*8)	
	for i := N_G - 3; i > 0; i-- {
  0x1400c26fb		48ffc8			DECQ AX			
  0x1400c26fe		6690			NOPW			
  0x1400c2700		4885c0			TESTQ AX, AX		
  0x1400c2703		7fd1			JG 0x1400c26d6		
  0x1400c2705		b801000000		MOVL $0x1, AX		
  0x1400c270a		eb2a			JMP 0x1400c2736		
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // R├│┼╝nice centralne wewn─ůtrz domeny
  0x1400c270c		f20f1084c2481b2707	MOVSD_XMM 0x7271b48(DX)(AX*8), X0	
  0x1400c2715		f20f5c84c2581b2707	SUBSD 0x7271b58(DX)(AX*8), X0		
  0x1400c271e		f20f100d223c0100	MOVSD_XMM $f64.40bf2c0000000000(SB), X1	
  0x1400c2726		f20f59c1		MULSD X1, X0				
  0x1400c272a		f20f1184c2d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)(AX*8)	
  0x1400c2733		48ffc0			INCQ AX					
	for i := 1; i <= N_G-2; i++ {
  0x1400c2736		483d8e010000		CMPQ AX, $0x18e		
  0x1400c273c		7ece			JLE 0x1400c270c		
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA
  0x1400c273e		f20f1082501b2707	MOVSD_XMM 0x7271b50(DX), X0		
  0x1400c2746		f20f5c82581b2707	SUBSD 0x7271b58(DX), X0			
  0x1400c274e		f20f100dfa3b0100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c2756		f20f59c1		MULSD X1, X0				
  0x1400c275a		f20f1016		MOVSD_XMM 0(SI), X2			
  0x1400c275e		f20f101dfa3b0100	MOVSD_XMM $f64.414afea47ac24bbf(SB), X3	
  0x1400c2766		f20f59d3		MULSD X3, X2				
  0x1400c276a		f20f5cc2		SUBSD X2, X0				
  0x1400c276e		f20f1182d00e2707	MOVSD_XMM X0, 0x7270ed0(DX)		
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA
  0x1400c2776		f20f1082c0272707	MOVSD_XMM 0x72727c0(DX), X0	
  0x1400c277e		f20f5c82c8272707	SUBSD 0x72727c8(DX), X0		
  0x1400c2786		f20f1096780c0000	MOVSD_XMM 0xc78(SI), X2		
  0x1400c278e		f20f59d3		MULSD X3, X2			
  0x1400c2792		c4e2f9b9d1		VFMADD231SD X1, X0, X2		
  0x1400c2797		f20f1192481b2707	MOVSD_XMM X2, 0x7271b48(DX)	
}
  0x1400c279f		4881c408190000		ADDQ $0x1908, SP	
  0x1400c27a6		5d			POPQ BP			
  0x1400c27a7		c3			RET			
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x1400c27a8		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c27ad		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c27b2		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x1400c27b8		e8839efbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c27bd		488b442408		MOVQ 0x8(SP), AX				
  0x1400c27c2		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c27c7		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x1400c27cd		e9aefdffff		JMP gopic.(*SimulationState).SolvePoisson(SB)	

  0x1400c27d2		cc			INT $0x3		
  0x1400c27d3		cc			INT $0x3		
  0x1400c27d4		cc			INT $0x3		
  0x1400c27d5		cc			INT $0x3		
  0x1400c27d6		cc			INT $0x3		
  0x1400c27d7		cc			INT $0x3		
  0x1400c27d8		cc			INT $0x3		
  0x1400c27d9		cc			INT $0x3		
  0x1400c27da		cc			INT $0x3		
  0x1400c27db		cc			INT $0x3		
  0x1400c27dc		cc			INT $0x3		
  0x1400c27dd		cc			INT $0x3		
  0x1400c27de		cc			INT $0x3		
  0x1400c27df		cc			INT $0x3		

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c39a0		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x1400c39a8		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400c39ac		7671			JBE 0x1400c3a1f			
  0x1400c39ae		55			PUSHQ BP			
  0x1400c39af		4889e5			MOVQ SP, BP			
  0x1400c39b2		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x1400c39b9		488d7c2418		LEAQ 0x18(SP), DI	
  0x1400c39be		b990010000		MOVL $0x190, CX		
	for p := range N_G {
  0x1400c39c3		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x1400c39c6		31c0			XORL AX, AX		
  0x1400c39c8		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := range N_G {
  0x1400c39cb		31f6			XORL SI, SI		
  0x1400c39cd		eb31			JMP 0x1400c3a00		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // G─Östo┼Ť─ç ┼éadunku przestrzennego
  0x1400c39cf		8402			TESTB AL, 0(DX)				
  0x1400c39d1		f20f108cf250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X1	
  0x1400c39da		f20f5c8cf2d0272707	SUBSD 0x72727d0(DX)(SI*8), X1		
  0x1400c39e3		f20f101575270100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x1400c39eb		f20f59ca		MULSD X2, X1				
  0x1400c39ef		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := range N_G {
  0x1400c39f5		48ffc6			INCQ SI			
  0x1400c39f8		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c3a00		4881fe90010000		CMPQ SI, $0x190		
  0x1400c3a07		7cc6			JL 0x1400c39cf		
	sim.SolvePoisson(&rho, currentTime) // Obliczenie potencja┼éu i pola E
  0x1400c3a09		4889d0			MOVQ DX, AX					
  0x1400c3a0c		488d5c2418		LEAQ 0x18(SP), BX				
  0x1400c3a11		e86aebffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x1400c3a16		4881c4980c0000		ADDQ $0xc98, SP		
  0x1400c3a1d		5d			POPQ BP			
  0x1400c3a1e		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x1400c3a1f		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3a24		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400c3a2a		e8118cfbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c3a2f		488b442408		MOVQ 0x8(SP), AX					
  0x1400c3a34		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400c3a3a		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	

  0x1400c3a3f		cc			INT $0x3		
