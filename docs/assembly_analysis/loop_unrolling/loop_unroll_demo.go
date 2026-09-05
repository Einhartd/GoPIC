package main

// MoveStandard: zwykła pętla po 1 elemencie
func MoveStandard(x, v []float64, dt float64) {
	for i := 0; i < len(x); i++ {
		x[i] += v[i] * dt
	}
}

// MoveUnrolled4: pętla rozwinięta ręcznie na 4 elementy
func MoveUnrolled4(x, v []float64, dt float64) {
	n := len(x)
	i := 0
	for ; i+3 < n; i += 4 {
		x[i] += v[i] * dt
		x[i+1] += v[i+1] * dt
		x[i+2] += v[i+2] * dt
		x[i+3] += v[i+3] * dt
	}
	for ; i < n; i++ {
		x[i] += v[i] * dt
	}
}
