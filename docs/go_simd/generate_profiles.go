package main

import (
	"math/rand"
	"os"
	"runtime/pprof"
	"simd"
)

const (
	N_G      = 400
	INV_DX   = 10000.0
	FACTOR_E = 1.758820024e11 * 1.0e-12
	DT_E     = 1.0e-12
)

//go:noinline
func simdLeapFrog(x, vx []float64, efield []float64, n int) {
	vNegFactor := simd.BroadcastFloat64s(-FACTOR_E)
	vDt := simd.BroadcastFloat64s(DT_E)
	var exArr [4]float64

	k := 0
	for ; k <= n-4; k += 4 {
		c0_0 := x[k] * INV_DX
		p0 := min(max(int(c0_0), 0), N_G-2)
		c1_0 := float64(p0) + 1.0 - c0_0
		c2_0 := c0_0 - float64(p0)
		exArr[0] = c1_0*efield[p0] + c2_0*efield[p0+1]

		c0_1 := x[k+1] * INV_DX
		p1 := min(max(int(c0_1), 0), N_G-2)
		c1_1 := float64(p1) + 1.0 - c0_1
		c2_1 := c0_1 - float64(p1)
		exArr[1] = c1_1*efield[p1] + c2_1*efield[p1+1]

		c0_2 := x[k+2] * INV_DX
		p2 := min(max(int(c0_2), 0), N_G-2)
		c1_2 := float64(p2) + 1.0 - c0_2
		c2_2 := c0_2 - float64(p2)
		exArr[2] = c1_2*efield[p2] + c2_2*efield[p2+1]

		c0_3 := x[k+3] * INV_DX
		p3 := min(max(int(c0_3), 0), N_G-2)
		c1_3 := float64(p3) + 1.0 - c0_3
		c2_3 := c0_3 - float64(p3)
		exArr[3] = c1_3*efield[p3] + c2_3*efield[p3+1]

		vEx := simd.LoadFloat64s(exArr[:4])
		vVx := simd.LoadFloat64s(vx[k : k+4])
		vX := simd.LoadFloat64s(x[k : k+4])

		vVxNew := vEx.MulAdd(vNegFactor, vVx)
		vXNew := vVxNew.MulAdd(vDt, vX)

		vVxNew.Store(vx[k : k+4])
		vXNew.Store(x[k : k+4])
	}
}

//go:noinline
func scalarLeapFrog(x, vx []float64, efield []float64, n int) {
	k := 0
	for ; k <= n-4; k += 4 {
		c0_0 := x[k] * INV_DX
		p0 := min(max(int(c0_0), 0), N_G-2)
		d0 := c0_0 - float64(p0)
		ex0 := efield[p0] + d0*(efield[p0+1]-efield[p0])

		c0_1 := x[k+1] * INV_DX
		p1 := min(max(int(c0_1), 0), N_G-2)
		d1 := c0_1 - float64(p1)
		ex1 := efield[p1] + d1*(efield[p1+1]-efield[p1])

		c0_2 := x[k+2] * INV_DX
		p2 := min(max(int(c0_2), 0), N_G-2)
		d2 := c0_2 - float64(p2)
		ex2 := efield[p2] + d2*(efield[p2+1]-efield[p2])

		c0_3 := x[k+3] * INV_DX
		p3 := min(max(int(c0_3), 0), N_G-2)
		d3 := c0_3 - float64(p3)
		ex3 := efield[p3] + d3*(efield[p3+1]-efield[p3])

		vx0 := vx[k] - ex0*FACTOR_E
		vx1 := vx[k+1] - ex1*FACTOR_E
		vx2 := vx[k+2] - ex2*FACTOR_E
		vx3 := vx[k+3] - ex3*FACTOR_E

		vx[k] = vx0
		vx[k+1] = vx1
		vx[k+2] = vx2
		vx[k+3] = vx3

		x[k] += vx0 * DT_E
		x[k+1] += vx1 * DT_E
		x[k+2] += vx2 * DT_E
		x[k+3] += vx3 * DT_E
	}
}

func main() {
	n := 100000
	x := make([]float64, n)
	vx := make([]float64, n)
	efield := make([]float64, N_G)

	r := rand.New(rand.NewSource(42))
	for i := range x {
		x[i] = r.Float64() * 0.04
		vx[i] = (r.Float64() - 0.5) * 1e6
	}
	for i := range efield {
		efield[i] = (r.Float64() - 0.5) * 1e4
	}

	// 1. Profil SIMD
	fSimd, err := os.Create("docs/go_simd/simd_profile.pprof")
	if err != nil {
		panic(err)
	}
	defer fSimd.Close()

	pprof.StartCPUProfile(fSimd)
	for iter := 0; iter < 3000; iter++ {
		simdLeapFrog(x, vx, efield, n)
	}
	pprof.StopCPUProfile()

	// 2. Profil Skalarny
	fScalar, err := os.Create("docs/go_simd/scalar_profile.pprof")
	if err != nil {
		panic(err)
	}
	defer fScalar.Close()

	pprof.StartCPUProfile(fScalar)
	for iter := 0; iter < 10000; iter++ {
		scalarLeapFrog(x, vx, efield, n)
	}
	pprof.StopCPUProfile()
}
