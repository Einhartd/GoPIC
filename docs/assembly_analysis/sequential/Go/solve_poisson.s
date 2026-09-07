// --- Symbol: Step2SolvePoisson ---
TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x4bbcc0		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x4bbcc8		4d3b6610		CMPQ R12, 0x10(R14)		
  0x4bbccc		7671			JBE 0x4bbd3f			
  0x4bbcce		55			PUSHQ BP			
  0x4bbccf		4889e5			MOVQ SP, BP			
  0x4bbcd2		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x4bbcd9		488d7c2418		LEAQ 0x18(SP), DI	
  0x4bbcde		b990010000		MOVL $0x190, CX		
	for p := 0; p < N_G; p++ {
  0x4bbce3		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x4bbce6		31c0			XORL AX, AX		
  0x4bbce8		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := 0; p < N_G; p++ {
  0x4bbceb		31f6			XORL SI, SI		
  0x4bbced		eb31			JMP 0x4bbd20		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // get charge density
  0x4bbcef		8402			TESTB AL, 0(DX)				
  0x4bbcf1		f20f108cf290332707	MOVSD_XMM 0x7273390(DX)(SI*8), X1	
  0x4bbcfa		f20f5c8cf210272707	SUBSD 0x7272710(DX)(SI*8), X1		
  0x4bbd03		f20f10153dea0000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x4bbd0b		f20f59ca		MULSD X2, X1				
  0x4bbd0f		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := 0; p < N_G; p++ {
  0x4bbd15		48ffc6			INCQ SI			
  0x4bbd18		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4bbd20		4881fe90010000		CMPQ SI, $0x190		
  0x4bbd27		7cc6			JL 0x4bbcef		
	sim.SolvePoisson(&rho, currentTime) // compute potential and electric field
  0x4bbd29		4889d0			MOVQ DX, AX					
  0x4bbd2c		488d5c2418		LEAQ 0x18(SP), BX				
  0x4bbd31		e84af2ffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x4bbd36		4881c4980c0000		ADDQ $0xc98, SP		
  0x4bbd3d		5d			POPQ BP			
  0x4bbd3e		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x4bbd3f		4889442408		MOVQ AX, 0x8(SP)					
  0x4bbd44		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x4bbd4a		e8713dfcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bbd4f		488b442408		MOVQ 0x8(SP), AX					
  0x4bbd54		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x4bbd5a		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	


// --- Symbol: SolvePoisson ---
TEXT gopic.(*SimulationState).SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/poisson.go
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x4baf80		4989e4			MOVQ SP, R12		
  0x4baf83		4981ec10250000		SUBQ $0x2510, R12	
  0x4baf8a		0f827a020000		JB 0x4bb20a		
  0x4baf90		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4baf94		0f8670020000		JBE 0x4bb20a		
  0x4baf9a		55			PUSHQ BP		
  0x4baf9b		4889e5			MOVQ SP, BP		
  0x4baf9e		4881ec88250000		SUBQ $0x2588, SP	
	for i := 1; i <= N_G-2; i++ {
  0x4bafa5		4889842498250000	MOVQ AX, 0x2598(SP)	
  0x4bafad		48899c24a0250000	MOVQ BX, 0x25a0(SP)	
	var g, w, f Xvector
  0x4bafb5		488dbc24880c0000	LEAQ 0xc88(SP), DI	
  0x4bafbd		b990010000		MOVL $0x190, CX		
  0x4bafc2		31c0			XORL AX, AX		
  0x4bafc4		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x4bafc7		488d7c2408		LEAQ 0x8(SP), DI	
  0x4bafcc		b990010000		MOVL $0x190, CX		
  0x4bafd1		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x4bafd4		488dbc2408190000	LEAQ 0x1908(SP), DI	
  0x4bafdc		b990010000		MOVL $0x190, CX		
  0x4bafe1		f348ab			REP; STOSQ AX, ES:0(DI)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // potential at the powered electrode
  0x4bafe4		f20f100d5cf90000	MOVSD_XMM $f64.41945031e30fb945(SB), X1	
  0x4bafec		f20f59c1		MULSD X1, X0				
	return cos(x)
  0x4baff0		e86b9dfcff		CALL math.cos(SB)	
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // potential at the powered electrode
  0x4baff5		488b942498250000	MOVQ 0x2598(SP), DX		
  0x4baffd		8402			TESTB AL, 0(DX)			
  0x4bafff		f20f100df1f60000	MOVSD_XMM 0xf6f1(IP), X1	
  0x4bb007		f20f59c8		MULSD X0, X1			
  0x4bb00b		f20f118a901a2707	MOVSD_XMM X1, 0x7271a90(DX)	
	sim.Pot[N_G-1] = 0.0                      // potential at the grounded electrode
  0x4bb013		48c7820827270700000000	MOVQ $0x0, 0x7272708(DX)	
	for i := 1; i <= N_G-2; i++ {
  0x4bb01e		bb01000000		MOVL $0x1, BX		
  0x4bb023		488bb424a0250000	MOVQ 0x25a0(SP), SI	
  0x4bb02b		eb1f			JMP 0x4bb04c		
		f[i] = ALPHA * (*rho1)[i]
  0x4bb02d		8406			TESTB AL, 0(SI)				
  0x4bb02f		f20f1004de		MOVSD_XMM 0(SI)(BX*8), X0		
  0x4bb034		f20f100d4cf90000	MOVSD_XMM $f64.c07bb63bc6c73374(SB), X1	
  0x4bb03c		f20f59c1		MULSD X1, X0				
  0x4bb040		f20f1184dc08190000	MOVSD_XMM X0, 0x1908(SP)(BX*8)		
	for i := 1; i <= N_G-2; i++ {
  0x4bb049		48ffc3			INCQ BX			
  0x4bb04c		4881fb8e010000		CMPQ BX, $0x18e		
  0x4bb053		7ed8			JLE 0x4bb02d		
	f[1] -= sim.Pot[0]
  0x4bb055		f20f10842410190000	MOVSD_XMM 0x1910(SP), X0	
  0x4bb05e		f20f5c82901a2707	SUBSD 0x7271a90(DX), X0		
  0x4bb066		f20f11842410190000	MOVSD_XMM X0, 0x1910(SP)	
	f[N_G-2] -= sim.Pot[N_G-1]
  0x4bb06f		f20f108c2478250000	MOVSD_XMM 0x2578(SP), X1	
  0x4bb078		f20f5c8a08272707	SUBSD 0x7272708(DX), X1		
  0x4bb080		f20f118c2478250000	MOVSD_XMM X1, 0x2578(SP)	
	w[1] = C / B
  0x4bb089		48b8000000000000e0bf	MOVQ $0xbfe0000000000000, AX	
  0x4bb093		4889442410		MOVQ AX, 0x10(SP)		
	g[1] = f[1] / B
  0x4bb098		f20f100dd0f80000	MOVSD_XMM $f64.bfe0000000000000(SB), X1	
  0x4bb0a0		f20f59c8		MULSD X0, X1				
  0x4bb0a4		f20f118c24900c0000	MOVSD_XMM X1, 0xc90(SP)			
	for i := 2; i <= N_G-2; i++ {
  0x4bb0ad		b802000000		MOVL $0x2, AX		
  0x4bb0b2		eb56			JMP 0x4bb10a		
		w[i] = C / (B - A*w[i-1])
  0x4bb0b4		f20f1004c4		MOVSD_XMM 0(SP)(AX*8), X0		
  0x4bb0b9		f20f100dbff80000	MOVSD_XMM $f64.c000000000000000(SB), X1	
  0x4bb0c1		f20f5cc8		SUBSD X0, X1				
  0x4bb0c5		f20f10056bf70000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x4bb0cd		f20f5ec1		DIVSD X1, X0				
  0x4bb0d1		f20f1144c408		MOVSD_XMM X0, 0x8(SP)(AX*8)		
		g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
  0x4bb0d7		f20f1084c408190000	MOVSD_XMM 0x1908(SP)(AX*8), X0		
  0x4bb0e0		f20f5c84c4800c0000	SUBSD 0xc80(SP)(AX*8), X0		
  0x4bb0e9		f20f100cc4		MOVSD_XMM 0(SP)(AX*8), X1		
  0x4bb0ee		f20f10158af80000	MOVSD_XMM $f64.c000000000000000(SB), X2	
  0x4bb0f6		f20f5cd1		SUBSD X1, X2				
  0x4bb0fa		f20f5ec2		DIVSD X2, X0				
  0x4bb0fe		f20f1184c4880c0000	MOVSD_XMM X0, 0xc88(SP)(AX*8)		
	for i := 2; i <= N_G-2; i++ {
  0x4bb107		48ffc0			INCQ AX			
  0x4bb10a		483d8e010000		CMPQ AX, $0x18e		
  0x4bb110		7ea2			JLE 0x4bb0b4		
	sim.Pot[N_G-2] = g[N_G-2]
  0x4bb112		f20f108424f8180000	MOVSD_XMM 0x18f8(SP), X0	
  0x4bb11b		f20f118200272707	MOVSD_XMM X0, 0x7272700(DX)	
	for i := N_G - 3; i > 0; i-- {
  0x4bb123		b88d010000		MOVL $0x18d, AX		
  0x4bb128		eb28			JMP 0x4bb152		
		sim.Pot[i] = g[i] - w[i]*sim.Pot[i+1] // potential at the grid points between the electrodes
  0x4bb12a		f20f1084c4880c0000	MOVSD_XMM 0xc88(SP)(AX*8), X0		
  0x4bb133		f20f104cc408		MOVSD_XMM 0x8(SP)(AX*8), X1		
  0x4bb139		f20f598cc2981a2707	MULSD 0x7271a98(DX)(AX*8), X1		
  0x4bb142		f20f5cc1		SUBSD X1, X0				
  0x4bb146		f20f1184c2901a2707	MOVSD_XMM X0, 0x7271a90(DX)(AX*8)	
	for i := N_G - 3; i > 0; i-- {
  0x4bb14f		48ffc8			DECQ AX			
  0x4bb152		4885c0			TESTQ AX, AX		
  0x4bb155		7fd3			JG 0x4bb12a		
  0x4bb157		b801000000		MOVL $0x1, AX		
  0x4bb15c		eb2a			JMP 0x4bb188		
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // electric field at the grid points between the electrodes
  0x4bb15e		f20f1084c2881a2707	MOVSD_XMM 0x7271a88(DX)(AX*8), X0	
  0x4bb167		f20f5c84c2981a2707	SUBSD 0x7271a98(DX)(AX*8), X0		
  0x4bb170		f20f100db8f70000	MOVSD_XMM $f64.40bf2c0000000000(SB), X1	
  0x4bb178		f20f59c1		MULSD X1, X0				
  0x4bb17c		f20f1184c2100e2707	MOVSD_XMM X0, 0x7270e10(DX)(AX*8)	
  0x4bb185		48ffc0			INCQ AX					
	for i := 1; i <= N_G-2; i++ {
  0x4bb188		483d8e010000		CMPQ AX, $0x18e		
  0x4bb18e		7ece			JLE 0x4bb15e		
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)                 // powered electrode
  0x4bb190		f20f1082901a2707	MOVSD_XMM 0x7271a90(DX), X0		
  0x4bb198		f20f5c82981a2707	SUBSD 0x7271a98(DX), X0			
  0x4bb1a0		f20f100d90f70000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bb1a8		f20f59c1		MULSD X1, X0				
  0x4bb1ac		f20f1016		MOVSD_XMM 0(SI), X2			
  0x4bb1b0		f20f101df8f50000	MOVSD_XMM $f64.3f106cd0e80106cd(SB), X3	
  0x4bb1b8		f20f59d3		MULSD X3, X2				
  0x4bb1bc		f20f1025bcf50000	MOVSD_XMM $f64.3db37876f105f438(SB), X4	
  0x4bb1c4		f20f5ed4		DIVSD X4, X2				
  0x4bb1c8		f20f5cc2		SUBSD X2, X0				
  0x4bb1cc		f20f1182100e2707	MOVSD_XMM X0, 0x7270e10(DX)		
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0) // grounded electrode
  0x4bb1d4		f20f108200272707	MOVSD_XMM 0x7272700(DX), X0	
  0x4bb1dc		f20f5c8208272707	SUBSD 0x7272708(DX), X0		
  0x4bb1e4		f20f1096780c0000	MOVSD_XMM 0xc78(SI), X2		
  0x4bb1ec		f20f59d3		MULSD X3, X2			
  0x4bb1f0		f20f5ed4		DIVSD X4, X2			
  0x4bb1f4		c4e2f9b9d1		VFMADD231SD X1, X0, X2		
  0x4bb1f9		f20f1192881a2707	MOVSD_XMM X2, 0x7271a88(DX)	
}
  0x4bb201		4881c488250000		ADDQ $0x2588, SP	
  0x4bb208		5d			POPQ BP			
  0x4bb209		c3			RET			
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
  0x4bb20a		4889442408		MOVQ AX, 0x8(SP)				
  0x4bb20f		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bb214		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x4bb21a		e8a148fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bb21f		488b442408		MOVQ 0x8(SP), AX				
  0x4bb224		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bb229		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x4bb22f		e94cfdffff		JMP gopic.(*SimulationState).SolvePoisson(SB)	

TEXT gopic.(*SimulationState).Step2SolvePoisson(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x4bbcc0		4c8da424e0f3ffff	LEAQ 0xfffff3e0(SP), R12	
  0x4bbcc8		4d3b6610		CMPQ R12, 0x10(R14)		
  0x4bbccc		7671			JBE 0x4bbd3f			
  0x4bbcce		55			PUSHQ BP			
  0x4bbccf		4889e5			MOVQ SP, BP			
  0x4bbcd2		4881ec980c0000		SUBQ $0xc98, SP			
	var rho Xvector
  0x4bbcd9		488d7c2418		LEAQ 0x18(SP), DI	
  0x4bbcde		b990010000		MOVL $0x190, CX		
	for p := 0; p < N_G; p++ {
  0x4bbce3		4889c2			MOVQ AX, DX		
	var rho Xvector
  0x4bbce6		31c0			XORL AX, AX		
  0x4bbce8		f348ab			REP; STOSQ AX, ES:0(DI)	
	for p := 0; p < N_G; p++ {
  0x4bbceb		31f6			XORL SI, SI		
  0x4bbced		eb31			JMP 0x4bbd20		
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // get charge density
  0x4bbcef		8402			TESTB AL, 0(DX)				
  0x4bbcf1		f20f108cf290332707	MOVSD_XMM 0x7273390(DX)(SI*8), X1	
  0x4bbcfa		f20f5c8cf210272707	SUBSD 0x7272710(DX)(SI*8), X1		
  0x4bbd03		f20f10153dea0000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x4bbd0b		f20f59ca		MULSD X2, X1				
  0x4bbd0f		f20f114cf418		MOVSD_XMM X1, 0x18(SP)(SI*8)		
	for p := 0; p < N_G; p++ {
  0x4bbd15		48ffc6			INCQ SI			
  0x4bbd18		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4bbd20		4881fe90010000		CMPQ SI, $0x190		
  0x4bbd27		7cc6			JL 0x4bbcef		
	sim.SolvePoisson(&rho, currentTime) // compute potential and electric field
  0x4bbd29		4889d0			MOVQ DX, AX					
  0x4bbd2c		488d5c2418		LEAQ 0x18(SP), BX				
  0x4bbd31		e84af2ffff		CALL gopic.(*SimulationState).SolvePoisson(SB)	
}
  0x4bbd36		4881c4980c0000		ADDQ $0xc98, SP		
  0x4bbd3d		5d			POPQ BP			
  0x4bbd3e		c3			RET			
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
  0x4bbd3f		4889442408		MOVQ AX, 0x8(SP)					
  0x4bbd44		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x4bbd4a		e8713dfcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bbd4f		488b442408		MOVQ 0x8(SP), AX					
  0x4bbd54		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x4bbd5a		e961ffffff		JMP gopic.(*SimulationState).Step2SolvePoisson(SB)	


