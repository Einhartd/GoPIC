// --- Symbol: Step4MoveIons ---
TEXT gopic.(*SimulationState).Step4MoveIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x4bc160		55			PUSHQ BP		
  0x4bc161		4889e5			MOVQ SP, BP		
	if (t % N_SUB) != 0 {
  0x4bc164		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x4bc16e		480fafca		IMULQ DX, CX			
  0x4bc172		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x4bc17c		4801d1			ADDQ DX, CX			
  0x4bc17f		48c1c13e		ROLQ $0x3e, CX			
  0x4bc183		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x4bc18d		4839ca			CMPQ DX, CX			
  0x4bc190		7204			JB 0x4bc196			
  0x4bc192		31c9			XORL CX, CX			
  0x4bc194		eb3a			JMP 0x4bc1d0			
		return
  0x4bc196		5d			POPQ BP			
  0x4bc197		c3			RET			
		sim.Vx_i[k] += e_x * FACTOR_I
  0x4bc198		f20f59d5		MULSD X5, X2				
  0x4bc19c		f20f5894c810d8b805	ADDSD 0x5b8d810(AX)(CX*8), X2		
  0x4bc1a5		f20f1194c810d8b805	MOVSD_XMM X2, 0x5b8d810(AX)(CX*8)	
		sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x4bc1ae		f20f1084c810c63e05	MOVSD_XMM 0x53ec610(AX)(CX*8), X0	
  0x4bc1b7		f20f101dd1e50000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x4bc1bf		c4e2e1b9c2		VFMADD231SD X2, X3, X0			
  0x4bc1c4		f20f1184c810c63e05	MOVSD_XMM X0, 0x53ec610(AX)(CX*8)	
	for k = 0; k < sim.N_i; k++ {
  0x4bc1cd		48ffc1			INCQ CX			
  0x4bc1d0		8400			TESTB AL, 0(AX)		
  0x4bc1d2		483988087e5603		CMPQ 0x3567e08(AX), CX	
  0x4bc1d9		0f8eba010000		JLE 0x4bc399		
  0x4bc1df		90			NOPL			
		c0 = sim.X_i[k] * INV_DX
  0x4bc1e0		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bc1e7		0f83d1010000		JAE 0x4bc3be				
  0x4bc1ed		f20f1084c810c63e05	MOVSD_XMM 0x53ec610(AX)(CX*8), X0	
  0x4bc1f6		f20f100d3ae70000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bc1fe		f20f59c1		MULSD X1, X0				
		p = int(c0)
  0x4bc202		f2480f2cd0		CVTTSD2SIQ X0, DX	
		c1 = float64(p) + 1.0 - c0
  0x4bc207		0f57d2			XORPS X2, X2				
  0x4bc20a		f2480f2ad2		CVTSI2SDQ DX, X2			
  0x4bc20f		f20f101d21e60000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4bc217		f20f58da		ADDSD X2, X3				
  0x4bc21b		f20f5cd8		SUBSD X0, X3				
		c2 = c0 - float64(p)
  0x4bc21f		f20f5cc2		SUBSD X2, X0		
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4bc223		4881fa90010000		CMPQ DX, $0x190				
  0x4bc22a		0f8384010000		JAE 0x4bc3b4				
  0x4bc230		f20f1094d0100e2707	MOVSD_XMM 0x7270e10(AX)(DX*8), X2	
  0x4bc239		488d7201		LEAQ 0x1(DX), SI			
  0x4bc23d		f20f59d3		MULSD X3, X2				
  0x4bc241		4881fe90010000		CMPQ SI, $0x190				
  0x4bc248		0f8357010000		JAE 0x4bc3a5				
  0x4bc24e		f20f10a4d0180e2707	MOVSD_XMM 0x7270e18(AX)(DX*8), X4	
  0x4bc257		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
		if sim.Measurement_mode {
  0x4bc25c		80b8a020ba0700		CMPB 0x7ba20a0(AX), $0x0	
  0x4bc263		0f8413010000		JE 0x4bc37c			
			mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x4bc269		f20f1025afe50000	MOVSD_XMM $f64.3fe0000000000000(SB), X4	
  0x4bc271		f20f59e2		MULSD X2, X4				
  0x4bc275		f20f102d43e50000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x4bc27d		f20f59e5		MULSD X5, X4				
			sim.Counter_i_xt[p][t_index] += c1
  0x4bc281		4869d240060000		IMULQ $0x640, DX, DX	
			mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x4bc288		f20f58a4c810d8b805	ADDSD 0x5b8d810(AX)(CX*8), X4	
			sim.Counter_i_xt[p][t_index] += c1
  0x4bc291		488d3410		LEAQ 0(AX)(DX*1), SI		
  0x4bc295		488db64098a607		LEAQ 0x7a69840(SI), SI		
  0x4bc29c		0f1f4000		NOPL 0(AX)			
  0x4bc2a0		4881fbc8000000		CMPQ BX, $0xc8			
  0x4bc2a7		0f83ee000000		JAE 0x4bc39b			
  0x4bc2ad		f20f1034de		MOVSD_XMM 0(SI)(BX*8), X6	
  0x4bc2b2		f20f58f3		ADDSD X3, X6			
  0x4bc2b6		f20f1134de		MOVSD_XMM X6, 0(SI)(BX*8)	
			sim.Counter_i_xt[p+1][t_index] += c2
  0x4bc2bb		488d3402		LEAQ 0(DX)(AX*1), SI		
  0x4bc2bf		488db6809ea607		LEAQ 0x7a69e80(SI), SI		
  0x4bc2c6		f20f1034de		MOVSD_XMM 0(SI)(BX*8), X6	
  0x4bc2cb		f20f58f0		ADDSD X0, X6			
  0x4bc2cf		f20f1134de		MOVSD_XMM X6, 0(SI)(BX*8)	
			sim.Ui_xt[p][t_index] += c1 * mean_v
  0x4bc2d4		488d3410		LEAQ 0(AX)(DX*1), SI		
  0x4bc2d8		488db640785807		LEAQ 0x7587840(SI), SI		
  0x4bc2df		0f10f4			MOVUPS X4, X6			
  0x4bc2e2		f20f59e3		MULSD X3, X4			
  0x4bc2e6		f20f5824de		ADDSD 0(SI)(BX*8), X4		
  0x4bc2eb		f20f1124de		MOVSD_XMM X4, 0(SI)(BX*8)	
			sim.Ui_xt[p+1][t_index] += c2 * mean_v
  0x4bc2f0		488d3402		LEAQ 0(DX)(AX*1), SI		
  0x4bc2f4		488db6807e5807		LEAQ 0x7587e80(SI), SI		
  0x4bc2fb		0f10e6			MOVUPS X6, X4			
  0x4bc2fe		f20f59f0		MULSD X0, X6			
  0x4bc302		f20f5834de		ADDSD 0(SI)(BX*8), X6		
  0x4bc307		f20f1134de		MOVSD_XMM X6, 0(SI)(BX*8)	
			v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4bc30c		f20f59e4		MULSD X4, X4				
  0x4bc310		f20f10b4c810ea3206	MOVSD_XMM 0x632ea10(AX)(CX*8), X6	
  0x4bc319		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
  0x4bc31e		f20f10b4c810fcac06	MOVSD_XMM 0x6acfc10(AX)(CX*8), X6	
  0x4bc327		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
  0x4bc32c		f20f1035fce30000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x4bc334		f20f59e6		MULSD X6, X4				
  0x4bc338		f20f103d08e40000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X7	
  0x4bc340		f20f5ee7		DIVSD X7, X4				
			sim.Meanei_xt[p][t_index] += c1 * energy
  0x4bc344		488d3410		LEAQ 0(AX)(DX*1), SI		
  0x4bc348		488db640109307		LEAQ 0x7931040(SI), SI		
  0x4bc34f		f20f59dc		MULSD X4, X3			
  0x4bc353		f20f581cde		ADDSD 0(SI)(BX*8), X3		
  0x4bc358		f20f111cde		MOVSD_XMM X3, 0(SI)(BX*8)	
			sim.Meanei_xt[p+1][t_index] += c2 * energy
  0x4bc35d		488d1402		LEAQ 0(DX)(AX*1), DX			
  0x4bc361		488d9280169307		LEAQ 0x7931680(DX), DX			
  0x4bc368		f20f101cda		MOVSD_XMM 0(DX)(BX*8), X3		
  0x4bc36d		c4e2d9b9d8		VFMADD231SD X0, X4, X3			
  0x4bc372		f20f111cda		MOVSD_XMM X3, 0(DX)(BX*8)		
  0x4bc377		e91cfeffff		JMP 0x4bc198				
  0x4bc37c		f20f102d3ce40000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x4bc384		f20f1035a4e30000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x4bc38c		f20f103db4e30000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X7	
		if sim.Measurement_mode {
  0x4bc394		e9fffdffff		JMP 0x4bc198		
}
  0x4bc399		5d			POPQ BP			
  0x4bc39a		c3			RET			
			sim.Counter_i_xt[p][t_index] += c1
  0x4bc39b		b8c8000000		MOVL $0xc8, AX			
  0x4bc3a0		e85b53fcff		CALL runtime.panicBounds(SB)	
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4bc3a5		b890010000		MOVL $0x190, AX			
  0x4bc3aa		b990010000		MOVL $0x190, CX			
  0x4bc3af		e84c53fcff		CALL runtime.panicBounds(SB)	
  0x4bc3b4		b890010000		MOVL $0x190, AX			
  0x4bc3b9		e84253fcff		CALL runtime.panicBounds(SB)	
		c0 = sim.X_i[k] * INV_DX
  0x4bc3be		b840420f00		MOVL $0xf4240, AX		
  0x4bc3c3		e83853fcff		CALL runtime.panicBounds(SB)	
  0x4bc3c8		90			NOPL				


