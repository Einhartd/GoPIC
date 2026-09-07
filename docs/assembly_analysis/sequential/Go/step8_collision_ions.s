// --- Symbol: Step8CollisionIons ---
TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4bd440		4c8d6424e8		LEAQ -0x18(SP), R12	
  0x4bd445		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4bd449		0f86f7020000		JBE 0x4bd746		
  0x4bd44f		55			PUSHQ BP		
  0x4bd450		4889e5			MOVQ SP, BP		
  0x4bd453		4881ec90000000		SUBQ $0x90, SP		
	if (t % N_SUB) != 0 {
  0x4bd45a		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x4bd464		480fafd9		IMULQ CX, BX			
  0x4bd468		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x4bd472		4801d9			ADDQ BX, CX			
  0x4bd475		48c1c13e		ROLQ $0x3e, CX			
  0x4bd479		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x4bd483		4839ca			CMPQ DX, CX			
  0x4bd486		7265			JB 0x4bd4ed			
  0x4bd488		48898424a0000000	MOVQ AX, 0xa0(SP)		
	nCollStar := sim.sampleBinomial(sim.N_i, sim.PStarI)
  0x4bd490		8400			TESTB AL, 0(AX)						
  0x4bd492		488b98087e5603		MOVQ 0x3567e08(AX), BX					
  0x4bd499		f20f1080d020ba07	MOVSD_XMM 0x7ba20d0(AX), X0				
  0x4bd4a1		e81afbffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
	if nCollStar > sim.N_i {
  0x4bd4a6		488b8c24a0000000	MOVQ 0xa0(SP), CX	
  0x4bd4ae		488b99087e5603		MOVQ 0x3567e08(CX), BX	
  0x4bd4b5		4839d8			CMPQ AX, BX		
	if nCollStar == 0 {
  0x4bd4b8		480f4fc3		CMOVG BX, AX		
  0x4bd4bc		0f1f4000		NOPL 0(AX)		
  0x4bd4c0		4885c0			TESTQ AX, AX		
	if nCollStar > sim.N_i {
  0x4bd4c3		741f			JE 0x4bd4e4		
	if nCollStar == 0 {
  0x4bd4c5		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4bd4c8		4889c8			MOVQ CX, AX					
  0x4bd4cb		4889d1			MOVQ DX, CX					
  0x4bd4ce		e8edf9ffff		CALL gopic.(*SimulationState).randomSample(SB)	
  0x4bd4d3		4889842488000000	MOVQ AX, 0x88(SP)				
  0x4bd4db		48895c2470		MOVQ BX, 0x70(SP)				
  0x4bd4e0		31c9			XORL CX, CX					
	for _, k := range candidates {
  0x4bd4e2		eb27			JMP 0x4bd50b		
		return
  0x4bd4e4		4881c490000000		ADDQ $0x90, SP		
  0x4bd4eb		5d			POPQ BP			
  0x4bd4ec		c3			RET			
		return
  0x4bd4ed		4881c490000000		ADDQ $0x90, SP		
  0x4bd4f4		5d			POPQ BP			
  0x4bd4f5		c3			RET			
	for _, k := range candidates {
  0x4bd4f6		488b4c2478		MOVQ 0x78(SP), CX	
  0x4bd4fb		48ffc1			INCQ CX			
  0x4bd4fe		488b842488000000	MOVQ 0x88(SP), AX	
  0x4bd506		488b5c2470		MOVQ 0x70(SP), BX	
  0x4bd50b		4839cb			CMPQ BX, CX		
  0x4bd50e		0f8e11020000		JLE 0x4bd725		
  0x4bd514		48894c2478		MOVQ CX, 0x78(SP)	
  0x4bd519		488b0cc8		MOVQ 0(AX)(CX*8), CX	
  0x4bd51d		48894c2468		MOVQ CX, 0x68(SP)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd522		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4bd52a		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4bd531		e88a81ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd536		f20f5905daa61200	MULSD gopic.RMB_sigma(SB), X0		
		vxA := sim.RMB()
  0x4bd53e		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd544		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4bd54c		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4bd553		e86881ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd558		f20f5905b8a61200	MULSD gopic.RMB_sigma(SB), X0		
		vyA := sim.RMB()
  0x4bd560		f20f11442450		MOVSD_XMM X0, 0x50(SP)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd566		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4bd56e		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4bd575		e84681ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd57a		f20f590596a61200	MULSD gopic.RMB_sigma(SB), X0		
		vzA := sim.RMB()
  0x4bd582		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
		gx := sim.Vx_i[k] - vxA
  0x4bd588		488b4c2468		MOVQ 0x68(SP), CX			
  0x4bd58d		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bd594		0f839e010000		JAE 0x4bd738				
  0x4bd59a		488b9424a0000000	MOVQ 0xa0(SP), DX			
  0x4bd5a2		f20f108cca10d8b805	MOVSD_XMM 0x5b8d810(DX)(CX*8), X1	
  0x4bd5ab		f20f5c4c2458		SUBSD 0x58(SP), X1			
		gy := sim.Vy_i[k] - vyA
  0x4bd5b1		f20f1094ca10ea3206	MOVSD_XMM 0x632ea10(DX)(CX*8), X2	
  0x4bd5ba		f20f5c542450		SUBSD 0x50(SP), X2			
		gz := sim.Vz_i[k] - vzA
  0x4bd5c0		f20f109cca10fcac06	MOVSD_XMM 0x6acfc10(DX)(CX*8), X3	
  0x4bd5c9		f20f5cd8		SUBSD X0, X3				
		gSqr := gx*gx + gy*gy + gz*gz
  0x4bd5cd		f20f59d2		MULSD X2, X2		
  0x4bd5d1		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x4bd5d6		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
		energy := 0.5 * MU_ARAR * gSqr / EV_TO_J
  0x4bd5db		f20f100545d10000	MOVSD_XMM $f64.3a94879de14d0b24(SB), X0	
  0x4bd5e3		f20f59c2		MULSD X2, X0				
  0x4bd5e7		f20f100d59d10000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X1	
  0x4bd5ef		f20f5ec1		DIVSD X1, X0				
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bd5f3		f20f100dcdd10000	MOVSD_XMM $f64.3f50624dd2f1a9fc(SB), X1	
  0x4bd5fb		f20f5ec1		DIVSD X1, X0				
  0x4bd5ff		f20f100d19d20000	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x4bd607		f20f58c8		ADDSD X0, X1				
  0x4bd60b		f2480f2cd9		CVTTSD2SIQ X1, BX			
		g := math.Sqrt(gSqr)
  0x4bd610		90			NOPL			
	if a < b {
  0x4bd611		4881fb3f420f00		CMPQ BX, $0xf423f	
  0x4bd618		7c06			JL 0x4bd620		
  0x4bd61a		bb3f420f00		MOVL $0xf423f, BX	
  0x4bd61f		90			NOPL			
		realNu := sim.SigmaTotI[eIdx] * g
  0x4bd620		4881fb40420f00		CMPQ BX, $0xf4240	
  0x4bd627		0f8301010000		JAE 0x4bd72e		
	return sqrt(x)
  0x4bd62d		f20f51c2		SQRTSD X2, X0		
		realNu := sim.SigmaTotI[eIdx] * g
  0x4bd631		f20f5984da006cdc02	MULSD 0x2dc6c00(DX)(BX*8), X0	
		pAccept := realNu / sim.NuStarI
  0x4bd63a		f20f5e82c820ba07	DIVSD 0x7ba20c8(DX), X0	
		if pAccept > 1.0 {
  0x4bd642		f20f100deed10000	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4bd64a		660f2ec1		UCOMISD X1, X0				
  0x4bd64e		7608			JBE 0x4bd658				
  0x4bd650		f20f1005e0d10000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bd658		48895c2440		MOVQ BX, 0x40(SP)	
		if sim.Rng.Float64() < pAccept {
  0x4bd65d		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
  0x4bd663		488bb2a820ba07		MOVQ 0x7ba20a8(DX), SI	
  0x4bd66a		4889b42480000000	MOVQ SI, 0x80(SP)	
again:
  0x4bd672		eb08			JMP 0x4bd67c		
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x4bd674		488bb42480000000	MOVQ 0x80(SP), SI	
  0x4bd67c		488b0e			MOVQ 0(SI), CX		
  0x4bd67f		488b4608		MOVQ 0x8(SI), AX	
  0x4bd683		488b4918		MOVQ 0x18(CX), CX	
  0x4bd687		ffd1			CALL CX			
	f := float64(r.Int63()) / (1 << 63)
  0x4bd689		0f57c0			XORPS X0, X0				
  0x4bd68c		f2480f2ac0		CVTSI2SDQ AX, X0			
  0x4bd691		f20f100da7d00000	MOVSD_XMM $f64.3c00000000000000(SB), X1	
  0x4bd699		f20f59c8		MULSD X0, X1				
	if f == 1 {
  0x4bd69d		f20f100593d10000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x4bd6a5		660f2ec8		UCOMISD X0, X1				
  0x4bd6a9		7502			JNE 0x4bd6ad				
  0x4bd6ab		7bc7			JNP 0x4bd674				
		if sim.Rng.Float64() < pAccept {
  0x4bd6ad		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x4bd6b3		660f2ec1		UCOMISD X1, X0		
  0x4bd6b7		770d			JA 0x4bd6c6		
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd6b9		488b9424a0000000	MOVQ 0xa0(SP), DX	
		if sim.Rng.Float64() < pAccept {
  0x4bd6c1		e930feffff		JMP 0x4bd4f6		
			sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx)
  0x4bd6c6		488b542468		MOVQ 0x68(SP), DX				
  0x4bd6cb		488b8424a0000000	MOVQ 0xa0(SP), AX				
  0x4bd6d3		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x4bd6d7		488d9b10d8b805		LEAQ 0x5b8d810(BX), BX				
  0x4bd6de		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x4bd6e2		488d8910ea3206		LEAQ 0x632ea10(CX), CX				
  0x4bd6e9		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x4bd6ed		488dbf10fcac06		LEAQ 0x6acfc10(DI), DI				
  0x4bd6f4		488d742458		LEAQ 0x58(SP), SI				
  0x4bd6f9		4c8d442450		LEAQ 0x50(SP), R8				
  0x4bd6fe		4c8d4c2448		LEAQ 0x48(SP), R9				
  0x4bd703		4c8b542440		MOVQ 0x40(SP), R10				
  0x4bd708		e81398ffff		CALL gopic.(*SimulationState).CollisionIon(SB)	
			sim.N_i_coll++
  0x4bd70d		488b9424a0000000	MOVQ 0xa0(SP), DX	
  0x4bd715		48ff825820ba07		INCQ 0x7ba2058(DX)	
  0x4bd71c		0f1f4000		NOPL 0(AX)		
  0x4bd720		e9d1fdffff		JMP 0x4bd4f6		
}
  0x4bd725		4881c490000000		ADDQ $0x90, SP		
  0x4bd72c		5d			POPQ BP			
  0x4bd72d		c3			RET			
		realNu := sim.SigmaTotI[eIdx] * g
  0x4bd72e		b840420f00		MOVL $0xf4240, AX		
  0x4bd733		e8c83ffcff		CALL runtime.panicBounds(SB)	
		gx := sim.Vx_i[k] - vxA
  0x4bd738		b840420f00		MOVL $0xf4240, AX		
  0x4bd73d		0f1f00			NOPL 0(AX)			
  0x4bd740		e8bb3ffcff		CALL runtime.panicBounds(SB)	
  0x4bd745		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4bd746		4889442408		MOVQ AX, 0x8(SP)					
  0x4bd74b		48895c2410		MOVQ BX, 0x10(SP)					
  0x4bd750		e86b23fcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bd755		488b442408		MOVQ 0x8(SP), AX					
  0x4bd75a		488b5c2410		MOVQ 0x10(SP), BX					
  0x4bd75f		90			NOPL							
  0x4bd760		e9dbfcffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	


