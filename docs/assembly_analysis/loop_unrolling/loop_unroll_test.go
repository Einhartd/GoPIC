package main

import "testing"

func BenchmarkStandard(b *testing.B) {
	const N = 80000
	x := make([]float64, N)
	v := make([]float64, N)
	for i := range x {
		x[i] = float64(i)
		v[i] = 1.5
	}
	dt := 1e-11
	b.ResetTimer()
	for k := 0; k < b.N; k++ {
		MoveStandard(x, v, dt)
	}
}

func BenchmarkUnrolled4(b *testing.B) {
	const N = 80000
	x := make([]float64, N)
	v := make([]float64, N)
	for i := range x {
		x[i] = float64(i)
		v[i] = 1.5
	}
	dt := 1e-11
	b.ResetTimer()
	for k := 0; k < b.N; k++ {
		MoveUnrolled4(x, v, dt)
	}
}
