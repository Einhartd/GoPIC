// --- Symbol: Step5CheckBoundariesElectrons ---
TEXT gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
  0x4bc3e0		55			PUSHQ BP		
  0x4bc3e1		4889e5			MOVQ SP, BP		
	for k < sim.N_e { // check boundaries for all electrons in every time step
  0x4bc3e4		31c9			XORL CX, CX		
  0x4bc3e6		8400			TESTB AL, 0(AX)		
  0x4bc3e8		483988007e5603		CMPQ 0x3567e00(AX), CX	
  0x4bc3ef		0f8e3a010000		JLE 0x4bc52f		
  0x4bc3f5		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4bc3fe		6690			NOPW			
		if sim.X_e[k] < 0 {
  0x4bc400		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bc407		0f834c010000		JAE 0x4bc559				
  0x4bc40d		f20f1084c8107e5603	MOVSD_XMM 0x3567e10(AX)(CX*8), X0	
  0x4bc416		0f57c9			XORPS X1, X1				
  0x4bc419		660f2ec8		UCOMISD X0, X1				
  0x4bc41d		7607			JBE 0x4bc426				
			sim.N_e_abs_pow++ // the electron is out at the powered electrode
  0x4bc41f		48ff8010592707		INCQ 0x7275910(AX)	
		if sim.X_e[k] > L {
  0x4bc426		f20f1094c8107e5603	MOVSD_XMM 0x3567e10(AX)(CX*8), X2	
  0x4bc42f		f20f101d99e20000	MOVSD_XMM 0xe299(IP), X3		
  0x4bc437		660f2ed3		UCOMISD X3, X2				
  0x4bc43b		760d			JBE 0x4bc44a				
			sim.N_e_abs_gnd++ // the electron is out at the grounded electrode
  0x4bc43d		48ff8018592707		INCQ 0x7275918(AX)	
		if sim.X_e[k] < 0 {
  0x4bc444		660f2ec8		UCOMISD X0, X1		
			out = true
  0x4bc448		eb04			JMP 0x4bc44e		
		if sim.X_e[k] < 0 {
  0x4bc44a		660f2ec8		UCOMISD X0, X1		
  0x4bc44e		0f97c2			SETA DL			
		if sim.X_e[k] > L {
  0x4bc451		660f2ed3		UCOMISD X3, X2		
  0x4bc455		0f97c3			SETA BL			
		if out { // remove the electron, if out
  0x4bc458		09d3			ORL DX, BX		
  0x4bc45a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bc460		84db			TESTL BL, BL		
  0x4bc462		0f84bf000000		JE 0x4bc527		
			sim.X_e[k] = sim.X_e[sim.N_e-1]
  0x4bc468		488b90007e5603		MOVQ 0x3567e00(AX), DX			
  0x4bc46f		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc473		660f1f840000000000	NOPW 0(AX)(AX*1)			
  0x4bc47c		0f1f4000		NOPL 0(AX)				
  0x4bc480		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc487		0f83c2000000		JAE 0x4bc54f				
  0x4bc48d		f20f1084d0087e5603	MOVSD_XMM 0x3567e08(AX)(DX*8), X0	
  0x4bc496		f20f1184c8107e5603	MOVSD_XMM X0, 0x3567e10(AX)(CX*8)	
			sim.Vx_e[k] = sim.Vx_e[sim.N_e-1]
  0x4bc49f		488b90007e5603		MOVQ 0x3567e00(AX), DX			
  0x4bc4a6		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc4aa		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc4b1		0f838e000000		JAE 0x4bc545				
  0x4bc4b7		f20f1084d00890d003	MOVSD_XMM 0x3d09008(AX)(DX*8), X0	
  0x4bc4c0		f20f1184c81090d003	MOVSD_XMM X0, 0x3d09010(AX)(CX*8)	
			sim.Vy_e[k] = sim.Vy_e[sim.N_e-1]
  0x4bc4c9		488b90007e5603		MOVQ 0x3567e00(AX), DX			
  0x4bc4d0		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc4d4		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc4db		735e			JAE 0x4bc53b				
  0x4bc4dd		f20f1084d008a24a04	MOVSD_XMM 0x44aa208(AX)(DX*8), X0	
  0x4bc4e6		f20f1184c810a24a04	MOVSD_XMM X0, 0x44aa210(AX)(CX*8)	
			sim.Vz_e[k] = sim.Vz_e[sim.N_e-1]
  0x4bc4ef		488b90007e5603		MOVQ 0x3567e00(AX), DX			
  0x4bc4f6		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc4fa		660f1f440000		NOPW 0(AX)(AX*1)			
  0x4bc500		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc507		7328			JAE 0x4bc531				
  0x4bc509		f20f1084d008b4c404	MOVSD_XMM 0x4c4b408(AX)(DX*8), X0	
  0x4bc512		f20f1184c810b4c404	MOVSD_XMM X0, 0x4c4b410(AX)(CX*8)	
			sim.N_e--
  0x4bc51b		48ff88007e5603		DECQ 0x3567e00(AX)	
  0x4bc522		e9bffeffff		JMP 0x4bc3e6		
			k++
  0x4bc527		48ffc1			INCQ CX			
  0x4bc52a		e9b7feffff		JMP 0x4bc3e6		
}
  0x4bc52f		5d			POPQ BP			
  0x4bc530		c3			RET			
			sim.Vz_e[k] = sim.Vz_e[sim.N_e-1]
  0x4bc531		b840420f00		MOVL $0xf4240, AX		
  0x4bc536		e8c551fcff		CALL runtime.panicBounds(SB)	
			sim.Vy_e[k] = sim.Vy_e[sim.N_e-1]
  0x4bc53b		b840420f00		MOVL $0xf4240, AX		
  0x4bc540		e8bb51fcff		CALL runtime.panicBounds(SB)	
			sim.Vx_e[k] = sim.Vx_e[sim.N_e-1]
  0x4bc545		b840420f00		MOVL $0xf4240, AX		
  0x4bc54a		e8b151fcff		CALL runtime.panicBounds(SB)	
			sim.X_e[k] = sim.X_e[sim.N_e-1]
  0x4bc54f		b840420f00		MOVL $0xf4240, AX		
  0x4bc554		e8a751fcff		CALL runtime.panicBounds(SB)	
		if sim.X_e[k] < 0 {
  0x4bc559		b840420f00		MOVL $0xf4240, AX		
  0x4bc55e		6690			NOPW				
  0x4bc560		e89b51fcff		CALL runtime.panicBounds(SB)	
  0x4bc565		90			NOPL				


