// --- Symbol: Step7CollisionsElectrons ---
TEXT gopic.(*SimulationState).Step7CollisionsElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation_null.go
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x4bd200		493b6610		CMPQ SP, 0x10(R14)	
  0x4bd204		0f8616020000		JBE 0x4bd420		
  0x4bd20a		55			PUSHQ BP		
  0x4bd20b		4889e5			MOVQ SP, BP		
  0x4bd20e		4883ec68		SUBQ $0x68, SP		
	if nCollStar > sim.N_e {
  0x4bd212		4889442478		MOVQ AX, 0x78(SP)	
	nCollStar := sim.sampleBinomial(sim.N_e, sim.PStarE)
  0x4bd217		8400			TESTB AL, 0(AX)						
  0x4bd219		488b98007e5603		MOVQ 0x3567e00(AX), BX					
  0x4bd220		f20f1080c020ba07	MOVSD_XMM 0x7ba20c0(AX), X0				
  0x4bd228		e893fdffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
	if nCollStar > sim.N_e {
  0x4bd22d		488b4c2478		MOVQ 0x78(SP), CX	
  0x4bd232		488b99007e5603		MOVQ 0x3567e00(CX), BX	
  0x4bd239		4839d8			CMPQ AX, BX		
	if nCollStar == 0 {
  0x4bd23c		480f4fc3		CMOVG BX, AX		
  0x4bd240		4885c0			TESTQ AX, AX		
	if nCollStar > sim.N_e {
  0x4bd243		741d			JE 0x4bd262		
	if nCollStar == 0 {
  0x4bd245		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_e, nCollStar)
  0x4bd248		4889c8			MOVQ CX, AX					
  0x4bd24b		4889d1			MOVQ DX, CX					
  0x4bd24e		e86dfcffff		CALL gopic.(*SimulationState).randomSample(SB)	
  0x4bd253		4889442460		MOVQ AX, 0x60(SP)				
  0x4bd258		48895c2448		MOVQ BX, 0x48(SP)				
  0x4bd25d		31c9			XORL CX, CX					
  0x4bd25f		90			NOPL						
	for _, k := range candidates {
  0x4bd260		eb1e			JMP 0x4bd280		
		return
  0x4bd262		4883c468		ADDQ $0x68, SP		
  0x4bd266		5d			POPQ BP			
  0x4bd267		c3			RET			
	for _, k := range candidates {
  0x4bd268		488b4c2450		MOVQ 0x50(SP), CX	
  0x4bd26d		48ffc1			INCQ CX			
  0x4bd270		488b442460		MOVQ 0x60(SP), AX	
  0x4bd275		488b5c2448		MOVQ 0x48(SP), BX	
  0x4bd27a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bd280		4839cb			CMPQ BX, CX		
  0x4bd283		0f8e7c010000		JLE 0x4bd405		
  0x4bd289		488b14c8		MOVQ 0(AX)(CX*8), DX	
		vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4bd28d		4881fa40420f00		CMPQ DX, $0xf4240			
  0x4bd294		0f837b010000		JAE 0x4bd415				
  0x4bd29a		488b742478		MOVQ 0x78(SP), SI			
  0x4bd29f		f20f1084d61090d003	MOVSD_XMM 0x3d09010(SI)(DX*8), X0	
  0x4bd2a8		f20f108cd610a24a04	MOVSD_XMM 0x44aa210(SI)(DX*8), X1	
  0x4bd2b1		f20f59c9		MULSD X1, X1				
  0x4bd2b5		c4e2f9b9c8		VFMADD231SD X0, X0, X1			
  0x4bd2ba		f20f1084d610b4c404	MOVSD_XMM 0x4c4b410(SI)(DX*8), X0	
  0x4bd2c3		c4e2f9b9c8		VFMADD231SD X0, X0, X1			
		energy := 0.5 * E_MASS * vSqr / EV_TO_J
  0x4bd2c8		f20f100548d40000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x4bd2d0		f20f59c1		MULSD X1, X0				
  0x4bd2d4		f20f10156cd40000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X2	
  0x4bd2dc		f20f5ec2		DIVSD X2, X0				
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bd2e0		f20f101de0d40000	MOVSD_XMM $f64.3f50624dd2f1a9fc(SB), X3	
  0x4bd2e8		f20f5ec3		DIVSD X3, X0				
  0x4bd2ec		f20f10252cd50000	MOVSD_XMM $f64.3fe0000000000000(SB), X4	
  0x4bd2f4		f20f58c4		ADDSD X4, X0				
  0x4bd2f8		f2480f2cf8		CVTTSD2SIQ X0, DI			
		velocity := math.Sqrt(vSqr)
  0x4bd2fd		90			NOPL			
  0x4bd2fe		6690			NOPW			
	if a < b {
  0x4bd300		4881ff3f420f00		CMPQ DI, $0xf423f	
  0x4bd307		7c05			JL 0x4bd30e		
  0x4bd309		bf3f420f00		MOVL $0xf423f, DI	
		realNu := sim.SigmaTotE[eIdx] * velocity
  0x4bd30e		4881ff40420f00		CMPQ DI, $0xf4240	
  0x4bd315		0f83f0000000		JAE 0x4bd40b		
	return sqrt(x)
  0x4bd31b		f20f51c1		SQRTSD X1, X0		
		realNu := sim.SigmaTotE[eIdx] * velocity
  0x4bd31f		f20f5984fe005a6202	MULSD 0x2625a00(SI)(DI*8), X0	
		pAccept := realNu / sim.NuStarE
  0x4bd328		f20f5e86b820ba07	DIVSD 0x7ba20b8(SI), X0	
		if pAccept > 1.0 {
  0x4bd330		f20f100d00d50000	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4bd338		660f2ec1		UCOMISD X1, X0				
  0x4bd33c		7608			JBE 0x4bd346				
  0x4bd33e		f20f1005f2d40000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
	for _, k := range candidates {
  0x4bd346		48894c2450		MOVQ CX, 0x50(SP)	
  0x4bd34b		4889542440		MOVQ DX, 0x40(SP)	
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bd350		48897c2430		MOVQ DI, 0x30(SP)	
		if sim.Rng.Float64() < pAccept {
  0x4bd355		f20f11442438		MOVSD_XMM X0, 0x38(SP)	
  0x4bd35b		4c8b86a820ba07		MOVQ 0x7ba20a8(SI), R8	
  0x4bd362		4c89442458		MOVQ R8, 0x58(SP)	
again:
  0x4bd367		eb05			JMP 0x4bd36e		
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x4bd369		4c8b442458		MOVQ 0x58(SP), R8	
  0x4bd36e		498b08			MOVQ 0(R8), CX		
  0x4bd371		498b4008		MOVQ 0x8(R8), AX	
  0x4bd375		488b4918		MOVQ 0x18(CX), CX	
  0x4bd379		ffd1			CALL CX			
	f := float64(r.Int63()) / (1 << 63)
  0x4bd37b		0f57c0			XORPS X0, X0				
  0x4bd37e		f2480f2ac0		CVTSI2SDQ AX, X0			
  0x4bd383		f20f100db5d30000	MOVSD_XMM $f64.3c00000000000000(SB), X1	
  0x4bd38b		f20f59c8		MULSD X0, X1				
	if f == 1 {
  0x4bd38f		f20f1005a1d40000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x4bd397		660f2ec8		UCOMISD X0, X1				
  0x4bd39b		7502			JNE 0x4bd39f				
  0x4bd39d		7bca			JNP 0x4bd369				
		if sim.Rng.Float64() < pAccept {
  0x4bd39f		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x4bd3a5		660f2ed1		UCOMISD X1, X2		
  0x4bd3a9		770a			JA 0x4bd3b5		
		vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4bd3ab		488b542478		MOVQ 0x78(SP), DX	
		if sim.Rng.Float64() < pAccept {
  0x4bd3b0		e9b3feffff		JMP 0x4bd268		
			sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx)
  0x4bd3b5		488b542440		MOVQ 0x40(SP), DX					
  0x4bd3ba		488b442478		MOVQ 0x78(SP), AX					
  0x4bd3bf		f20f1084d0107e5603	MOVSD_XMM 0x3567e10(AX)(DX*8), X0			
  0x4bd3c8		488d1cd0		LEAQ 0(AX)(DX*8), BX					
  0x4bd3cc		488d9b1090d003		LEAQ 0x3d09010(BX), BX					
  0x4bd3d3		488d0cd0		LEAQ 0(AX)(DX*8), CX					
  0x4bd3d7		488d8910a24a04		LEAQ 0x44aa210(CX), CX					
  0x4bd3de		488d3cd0		LEAQ 0(AX)(DX*8), DI					
  0x4bd3e2		488dbf10b4c404		LEAQ 0x4c4b410(DI), DI					
  0x4bd3e9		488b742430		MOVQ 0x30(SP), SI					
  0x4bd3ee		e82d8fffff		CALL gopic.(*SimulationState).CollisionElectron(SB)	
			sim.N_e_coll++
  0x4bd3f3		488b542478		MOVQ 0x78(SP), DX	
  0x4bd3f8		48ff825020ba07		INCQ 0x7ba2050(DX)	
  0x4bd3ff		90			NOPL			
  0x4bd400		e963feffff		JMP 0x4bd268		
}
  0x4bd405		4883c468		ADDQ $0x68, SP		
  0x4bd409		5d			POPQ BP			
  0x4bd40a		c3			RET			
		realNu := sim.SigmaTotE[eIdx] * velocity
  0x4bd40b		b840420f00		MOVL $0xf4240, AX		
  0x4bd410		e8eb42fcff		CALL runtime.panicBounds(SB)	
		vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4bd415		b840420f00		MOVL $0xf4240, AX		
  0x4bd41a		e8e142fcff		CALL runtime.panicBounds(SB)	
  0x4bd41f		90			NOPL				
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x4bd420		4889442408		MOVQ AX, 0x8(SP)						
  0x4bd425		e89626fcff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x4bd42a		488b442408		MOVQ 0x8(SP), AX						
  0x4bd42f		e9ccfdffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons(SB)	


// --- Symbol: sampleBinomial ---
TEXT gopic.(*SimulationState).sampleBinomial(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation_null.go
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
  0x4bcfc0		493b6610		CMPQ SP, 0x10(R14)	
  0x4bcfc4		0f86f7010000		JBE 0x4bd1c1		
  0x4bcfca		55			PUSHQ BP		
  0x4bcfcb		4889e5			MOVQ SP, BP		
  0x4bcfce		4883ec30		SUBQ $0x30, SP		
	if n <= 0 || p <= 0.0 {
  0x4bcfd2		4885db			TESTQ BX, BX		
  0x4bcfd5		0f8e54010000		JLE 0x4bd12f		
  0x4bcfdb		0f57c9			XORPS X1, X1		
  0x4bcfde		660f2ec8		UCOMISD X0, X1		
  0x4bcfe2		0f8347010000		JAE 0x4bd12f		
	if p >= 1.0 {
  0x4bcfe8		f20f100d48d80000	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4bcff0		660f2ec1		UCOMISD X1, X0				
  0x4bcff4		0f832c010000		JAE 0x4bd126				
	if n <= 0 || p <= 0.0 {
  0x4bcffa		f20f11442450		MOVSD_XMM X0, 0x50(SP)	
	if float64(n)*p < 5.0 {
  0x4bd000		0f57d2			XORPS X2, X2				
  0x4bd003		f2480f2ad3		CVTSI2SDQ BX, X2			
  0x4bd008		0f10d8			MOVUPS X0, X3				
  0x4bd00b		f20f59c2		MULSD X2, X0				
  0x4bd00f		f20f102591d80000	MOVSD_XMM $f64.4014000000000000(SB), X4	
  0x4bd017		660f2ee0		UCOMISD X0, X4				
  0x4bd01b		760c			JBE 0x4bd029				
	if n <= 0 || p <= 0.0 {
  0x4bd01d		4889442440		MOVQ AX, 0x40(SP)	
  0x4bd022		31c9			XORL CX, CX		
	if float64(n)*p < 5.0 {
  0x4bd024		e937010000		JMP 0x4bd160		
	if n <= 0 || p <= 0.0 {
  0x4bd029		48895c2448		MOVQ BX, 0x48(SP)	
	if float64(n)*p < 5.0 {
  0x4bd02e		f20f11542420		MOVSD_XMM X2, 0x20(SP)	
	count := int(math.Round(mu + sigma*sim.Rng.NormFloat64()))
  0x4bd034		8400			TESTB AL, 0(AX)		
	sigma := math.Sqrt(float64(n) * p * (1.0 - p))
  0x4bd036		f20f5ccb		SUBSD X3, X1		
  0x4bd03a		f20f59c8		MULSD X0, X1		
	count := int(math.Round(mu + sigma*sim.Rng.NormFloat64()))
  0x4bd03e		488b80a820ba07		MOVQ 0x7ba20a8(AX), AX	
	return sqrt(x)
  0x4bd045		f20f51c1		SQRTSD X1, X0		
  0x4bd049		f20f11442408		MOVSD_XMM X0, 0x8(SP)	
	count := int(math.Round(mu + sigma*sim.Rng.NormFloat64()))
  0x4bd04f		e86c86ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd054		f20f104c2408		MOVSD_XMM 0x8(SP), X1			
  0x4bd05a		f20f59c8		MULSD X0, X1				
  0x4bd05e		f20f10442450		MOVSD_XMM 0x50(SP), X0			
  0x4bd064		f20f10542420		MOVSD_XMM 0x20(SP), X2			
  0x4bd06a		c4e2f9b9ca		VFMADD231SD X2, X0, X1			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4bd06f		66480f7ec9		MOVQ X1, CX		
	e := uint(bits>>shift) & mask
  0x4bd074		4889ca			MOVQ CX, DX		
  0x4bd077		48c1e934		SHRQ $0x34, CX		
  0x4bd07b		81e1ff070000		ANDL $0x7ff, CX		
	bits := Float64bits(x)
  0x4bd081		90			NOPL			
	if e < bias {
  0x4bd082		4881f9ff030000		CMPQ CX, $0x3ff		
  0x4bd089		732a			JAE 0x4bd0b5		
		bits &= signMask // +-0
  0x4bd08b		48bb0000000000000080	MOVQ $0x8000000000000000, BX	
  0x4bd095		4821d3			ANDQ DX, BX			
			bits |= uvone // +-1
  0x4bd098		48ba000000000000f03f	MOVQ $0x3ff0000000000000, DX	
  0x4bd0a2		4809da			ORQ BX, DX			
		if e == bias-1 {
  0x4bd0a5		4881f9fe030000		CMPQ CX, $0x3fe		
  0x4bd0ac		480f44da		CMOVE DX, BX		
	count := int(math.Round(mu + sigma*sim.Rng.NormFloat64()))
  0x4bd0b0		4889d9			MOVQ BX, CX		
		if e == bias-1 {
  0x4bd0b3		eb3b			JMP 0x4bd0f0		
	} else if e < bias+shift {
  0x4bd0b5		4881f933040000		CMPQ CX, $0x433		
  0x4bd0bc		732f			JAE 0x4bd0ed		
		e -= bias
  0x4bd0be		488d9901fcffff		LEAQ 0xfffffc01(CX), BX	
		bits += half >> e
  0x4bd0c5		48be0000000000000800	MOVQ $0x8000000000000, SI	
  0x4bd0cf		c4			?				
  0x4bd0d0		e2e3			LOOP 0x4bd0b5			
  0x4bd0d2		f7f6			DIVL SI				
  0x4bd0d4		4801f2			ADDQ SI, DX			
		bits &^= fracMask >> e
  0x4bd0d7		48beffffffffffff0f00	MOVQ $0xfffffffffffff, SI	
  0x4bd0e1		c4			?				
  0x4bd0e2		e2e3			LOOP 0x4bd0c7			
  0x4bd0e4		f7de			NEGL SI				
  0x4bd0e6		c4			?				
  0x4bd0e7		e2e0			LOOP 0x4bd0c9			
  0x4bd0e9		f2caeb03		REPNE; LRET $0x3eb		
  0x4bd0ed		4889d1			MOVQ DX, CX			
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4bd0f0		66480f6ec1		MOVQ CX, X0		
	count := int(math.Round(mu + sigma*sim.Rng.NormFloat64()))
  0x4bd0f5		f2480f2cc0		CVTTSD2SIQ X0, AX	
	return Float64frombits(bits)
  0x4bd0fa		90			NOPL			
  0x4bd0fb		0f1f440000		NOPL 0(AX)(AX*1)	
	if count < 0 {
  0x4bd100		4885c0			TESTQ AX, AX		
  0x4bd103		7c19			JL 0x4bd11e		
	if count > n {
  0x4bd105		488b4c2448		MOVQ 0x48(SP), CX	
  0x4bd10a		4839c1			CMPQ CX, AX		
  0x4bd10d		7d09			JGE 0x4bd118		
		return n
  0x4bd10f		4889c8			MOVQ CX, AX		
  0x4bd112		4883c430		ADDQ $0x30, SP		
  0x4bd116		5d			POPQ BP			
  0x4bd117		c3			RET			
	return count
  0x4bd118		4883c430		ADDQ $0x30, SP		
  0x4bd11c		5d			POPQ BP			
  0x4bd11d		c3			RET			
		return 0
  0x4bd11e		31c0			XORL AX, AX		
  0x4bd120		4883c430		ADDQ $0x30, SP		
  0x4bd124		5d			POPQ BP			
  0x4bd125		c3			RET			
		return n
  0x4bd126		4889d8			MOVQ BX, AX		
  0x4bd129		4883c430		ADDQ $0x30, SP		
  0x4bd12d		5d			POPQ BP			
  0x4bd12e		c3			RET			
		return 0
  0x4bd12f		31c0			XORL AX, AX		
  0x4bd131		4883c430		ADDQ $0x30, SP		
  0x4bd135		5d			POPQ BP			
  0x4bd136		c3			RET			
			if sim.Rng.Float64() < p {
  0x4bd137		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x4bd13d		660f2ed9		UCOMISD X1, X3		
  0x4bd141		0f97c2			SETA DL			
  0x4bd144		0fb6d2			MOVZX DL, DX		
  0x4bd147		488b742418		MOVQ 0x18(SP), SI	
  0x4bd14c		488d0c16		LEAQ 0(SI)(DX*1), CX	
		for i := 0; i < n; i++ {
  0x4bd150		488b5c2410		MOVQ 0x10(SP), BX	
  0x4bd155		48ffcb			DECQ BX			
			if sim.Rng.Float64() < p {
  0x4bd158		488b442440		MOVQ 0x40(SP), AX	
  0x4bd15d		0f1f00			NOPL 0(AX)		
		for i := 0; i < n; i++ {
  0x4bd160		4885db			TESTQ BX, BX		
  0x4bd163		7e52			JLE 0x4bd1b7		
  0x4bd165		48895c2410		MOVQ BX, 0x10(SP)	
  0x4bd16a		48894c2418		MOVQ CX, 0x18(SP)	
			if sim.Rng.Float64() < p {
  0x4bd16f		8400			TESTB AL, 0(AX)		
  0x4bd171		488b90a820ba07		MOVQ 0x7ba20a8(AX), DX	
  0x4bd178		4889542428		MOVQ DX, 0x28(SP)	
again:
  0x4bd17d		eb05			JMP 0x4bd184		
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x4bd17f		488b542428		MOVQ 0x28(SP), DX	
  0x4bd184		488b0a			MOVQ 0(DX), CX		
  0x4bd187		488b4208		MOVQ 0x8(DX), AX	
  0x4bd18b		488b4918		MOVQ 0x18(CX), CX	
  0x4bd18f		ffd1			CALL CX			
	f := float64(r.Int63()) / (1 << 63)
  0x4bd191		0f57c0			XORPS X0, X0				
  0x4bd194		f2480f2ac0		CVTSI2SDQ AX, X0			
  0x4bd199		f20f100d9fd50000	MOVSD_XMM $f64.3c00000000000000(SB), X1	
  0x4bd1a1		f20f59c8		MULSD X0, X1				
	if f == 1 {
  0x4bd1a5		f20f10058bd60000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x4bd1ad		660f2ec8		UCOMISD X0, X1				
  0x4bd1b1		7584			JNE 0x4bd137				
  0x4bd1b3		7bca			JNP 0x4bd17f				
  0x4bd1b5		eb80			JMP 0x4bd137				
		return count
  0x4bd1b7		4889c8			MOVQ CX, AX		
  0x4bd1ba		4883c430		ADDQ $0x30, SP		
  0x4bd1be		5d			POPQ BP			
  0x4bd1bf		90			NOPL			
  0x4bd1c0		c3			RET			
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
  0x4bd1c1		4889442408		MOVQ AX, 0x8(SP)				
  0x4bd1c6		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bd1cb		f20f11442418		MOVSD_XMM X0, 0x18(SP)				
  0x4bd1d1		e8ea28fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bd1d6		488b442408		MOVQ 0x8(SP), AX				
  0x4bd1db		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bd1e0		f20f10442418		MOVSD_XMM 0x18(SP), X0				
  0x4bd1e6		e9d5fdffff		JMP gopic.(*SimulationState).sampleBinomial(SB)	


// --- Symbol: randomSample ---
TEXT gopic.(*SimulationState).randomSample(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation_null.go
func (sim *SimulationState) randomSample(n, count int) []int {
  0x4bcec0		493b6610		CMPQ SP, 0x10(R14)	
  0x4bcec4		0f86c1000000		JBE 0x4bcf8b		
  0x4bceca		55			PUSHQ BP		
  0x4bcecb		4889e5			MOVQ SP, BP		
  0x4bcece		4883ec28		SUBQ $0x28, SP		
	for i := range pool {
  0x4bced2		4889442438		MOVQ AX, 0x38(SP)	
  0x4bced7		48895c2440		MOVQ BX, 0x40(SP)	
  0x4bcedc		48894c2448		MOVQ CX, 0x48(SP)	
	pool := make([]int, n)
  0x4bcee1		488d0590c80e00		LEAQ 0xec890(IP), AX		
  0x4bcee8		4889d9			MOVQ BX, CX			
  0x4bceeb		e8b003fcff		CALL runtime.makeslice(SB)	
	for i := range pool {
  0x4bcef0		31d2			XORL DX, DX		
  0x4bcef2		488b742440		MOVQ 0x40(SP), SI	
  0x4bcef7		eb07			JMP 0x4bcf00		
		pool[i] = i
  0x4bcef9		488914d0		MOVQ DX, 0(AX)(DX*8)	
	for i := range pool {
  0x4bcefd		48ffc2			INCQ DX			
  0x4bcf00		4839d6			CMPQ SI, DX		
  0x4bcf03		7ff4			JG 0x4bcef9		
	pool := make([]int, n)
  0x4bcf05		4889442420		MOVQ AX, 0x20(SP)	
  0x4bcf0a		31c9			XORL CX, CX		
	for i := range pool {
  0x4bcf0c		eb12			JMP 0x4bcf20		
		pool[i], pool[j] = pool[j], pool[i]
  0x4bcf0e		488b3cd0		MOVQ 0(AX)(DX*8), DI	
  0x4bcf12		48893cc8		MOVQ DI, 0(AX)(CX*8)	
  0x4bcf16		488934d0		MOVQ SI, 0(AX)(DX*8)	
	for i := 0; i < count; i++ {
  0x4bcf1a		48ffc1			INCQ CX			
		j := i + sim.Rng.Intn(n-i)
  0x4bcf1d		4889de			MOVQ BX, SI		
	for i := 0; i < count; i++ {
  0x4bcf20		488b5c2448		MOVQ 0x48(SP), BX	
  0x4bcf25		4839cb			CMPQ BX, CX		
  0x4bcf28		7e41			JLE 0x4bcf6b		
  0x4bcf2a		48894c2418		MOVQ CX, 0x18(SP)	
		j := i + sim.Rng.Intn(n-i)
  0x4bcf2f		488b542438		MOVQ 0x38(SP), DX		
  0x4bcf34		8402			TESTB AL, 0(DX)			
  0x4bcf36		488b82a820ba07		MOVQ 0x7ba20a8(DX), AX		
  0x4bcf3d		4889f3			MOVQ SI, BX			
  0x4bcf40		4829cb			SUBQ CX, BX			
  0x4bcf43		e8188cffff		CALL math/rand.(*Rand).Intn(SB)	
  0x4bcf48		488b4c2418		MOVQ 0x18(SP), CX		
  0x4bcf4d		488d1401		LEAQ 0(CX)(AX*1), DX		
		pool[i], pool[j] = pool[j], pool[i]
  0x4bcf51		488b5c2440		MOVQ 0x40(SP), BX	
  0x4bcf56		4839cb			CMPQ BX, CX		
  0x4bcf59		762a			JBE 0x4bcf85		
  0x4bcf5b		488b442420		MOVQ 0x20(SP), AX	
  0x4bcf60		488b34c8		MOVQ 0(AX)(CX*8), SI	
  0x4bcf64		4839d3			CMPQ BX, DX		
  0x4bcf67		77a5			JA 0x4bcf0e		
  0x4bcf69		eb13			JMP 0x4bcf7e		
	return pool[:count]
  0x4bcf6b		4839f3			CMPQ BX, SI			
  0x4bcf6e		7709			JA 0x4bcf79			
  0x4bcf70		4889f1			MOVQ SI, CX			
  0x4bcf73		4883c428		ADDQ $0x28, SP			
  0x4bcf77		5d			POPQ BP				
  0x4bcf78		c3			RET				
  0x4bcf79		e88247fcff		CALL runtime.panicBounds(SB)	
		pool[i], pool[j] = pool[j], pool[i]
  0x4bcf7e		6690			NOPW				
  0x4bcf80		e87b47fcff		CALL runtime.panicBounds(SB)	
  0x4bcf85		e87647fcff		CALL runtime.panicBounds(SB)	
  0x4bcf8a		90			NOPL				
func (sim *SimulationState) randomSample(n, count int) []int {
  0x4bcf8b		4889442408		MOVQ AX, 0x8(SP)				
  0x4bcf90		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bcf95		48894c2418		MOVQ CX, 0x18(SP)				
  0x4bcf9a		e8212bfcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bcf9f		488b442408		MOVQ 0x8(SP), AX				
  0x4bcfa4		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bcfa9		488b4c2418		MOVQ 0x18(SP), CX				
  0x4bcfae		e90dffffff		JMP gopic.(*SimulationState).randomSample(SB)	


