// --- Symbol: InitParticles ---
TEXT gopic.(*SimulationState).InitParticles(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) InitParticles(nseed int) {
  0x4bb8a0		493b6610		CMPQ SP, 0x10(R14)	
  0x4bb8a4		0f86ed000000		JBE 0x4bb997		
  0x4bb8aa		55			PUSHQ BP		
  0x4bb8ab		4889e5			MOVQ SP, BP		
  0x4bb8ae		4883ec10		SUBQ $0x10, SP		
	for i := 0; i < nseed; i++ {
  0x4bb8b2		4889442420		MOVQ AX, 0x20(SP)	
  0x4bb8b7		48895c2428		MOVQ BX, 0x28(SP)	
  0x4bb8bc		31c9			XORL CX, CX		
  0x4bb8be		6690			NOPW			
  0x4bb8c0		eb7e			JMP 0x4bb940		
		sim.X_e[i] = L * sim.R01() // initial random position of the electron
  0x4bb8c2		f20f118cc8107e5603	MOVSD_XMM X1, 0x3567e10(AX)(CX*8)	
		sim.Vx_e[i] = 0
  0x4bb8cb		48c784c81090d00300000000	MOVQ $0x0, 0x3d09010(AX)(CX*8)	
		sim.Vy_e[i] = 0
  0x4bb8d7		48c784c810a24a0400000000	MOVQ $0x0, 0x44aa210(AX)(CX*8)	
		sim.Vz_e[i] = 0            // initial velocity components of the electron
  0x4bb8e3		48c784c810b4c40400000000	MOVQ $0x0, 0x4c4b410(AX)(CX*8)	
		sim.X_i[i] = L * sim.R01() // initial random position of the ion
  0x4bb8ef		e8ac200000		CALL gopic.(*SimulationState).R01(SB)	
  0x4bb8f4		f20f100dd4ed0000	MOVSD_XMM 0xedd4(IP), X1		
  0x4bb8fc		f20f59c1		MULSD X1, X0				
  0x4bb900		488b4c2408		MOVQ 0x8(SP), CX			
  0x4bb905		488b442420		MOVQ 0x20(SP), AX			
  0x4bb90a		f20f1184c810c63e05	MOVSD_XMM X0, 0x53ec610(AX)(CX*8)	
		sim.Vx_i[i] = 0
  0x4bb913		48c784c810d8b80500000000	MOVQ $0x0, 0x5b8d810(AX)(CX*8)	
		sim.Vy_i[i] = 0
  0x4bb91f		48c784c810ea320600000000	MOVQ $0x0, 0x632ea10(AX)(CX*8)	
		sim.Vz_i[i] = 0 // initial velocity components of the ion
  0x4bb92b		48c784c810fcac0600000000	MOVQ $0x0, 0x6acfc10(AX)(CX*8)	
	for i := 0; i < nseed; i++ {
  0x4bb937		48ffc1			INCQ CX			
  0x4bb93a		488b5c2428		MOVQ 0x28(SP), BX	
  0x4bb93f		90			NOPL			
  0x4bb940		4839cb			CMPQ BX, CX		
  0x4bb943		7e31			JLE 0x4bb976		
  0x4bb945		48894c2408		MOVQ CX, 0x8(SP)	
		sim.X_e[i] = L * sim.R01() // initial random position of the electron
  0x4bb94a		e851200000		CALL gopic.(*SimulationState).R01(SB)	
  0x4bb94f		488b442420		MOVQ 0x20(SP), AX			
  0x4bb954		8400			TESTB AL, 0(AX)				
  0x4bb956		f20f100d72ed0000	MOVSD_XMM 0xed72(IP), X1		
  0x4bb95e		f20f59c8		MULSD X0, X1				
  0x4bb962		488b4c2408		MOVQ 0x8(SP), CX			
  0x4bb967		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bb96e		0f824effffff		JB 0x4bb8c2				
  0x4bb974		eb16			JMP 0x4bb98c				
	sim.N_e = nseed // initial number of electrons
  0x4bb976		8400			TESTB AL, 0(AX)		
  0x4bb978		488998007e5603		MOVQ BX, 0x3567e00(AX)	
	sim.N_i = nseed // initial number of ions
  0x4bb97f		488998087e5603		MOVQ BX, 0x3567e08(AX)	
}
  0x4bb986		4883c410		ADDQ $0x10, SP		
  0x4bb98a		5d			POPQ BP			
  0x4bb98b		c3			RET			
		sim.X_e[i] = L * sim.R01() // initial random position of the electron
  0x4bb98c		b840420f00		MOVL $0xf4240, AX		
  0x4bb991		e86a5dfcff		CALL runtime.panicBounds(SB)	
  0x4bb996		90			NOPL				
func (sim *SimulationState) InitParticles(nseed int) {
  0x4bb997		4889442408		MOVQ AX, 0x8(SP)				
  0x4bb99c		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bb9a1		e81a41fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bb9a6		488b442408		MOVQ 0x8(SP), AX				
  0x4bb9ab		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bb9b0		e9ebfeffff		JMP gopic.(*SimulationState).InitParticles(SB)	


