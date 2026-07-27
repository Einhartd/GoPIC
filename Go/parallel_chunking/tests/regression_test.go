package tests

import (
	"bufio"
	"io"
	"math"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"
	"testing"
)

func compareNumericFiles(file1, file2 string, tolerance float64) (bool, string) {
	f1, err := os.Open(file1)
	if err != nil {
		return false, "Nie mozna otworzyc pliku 1: " + err.Error()
	}
	defer f1.Close()

	f2, err := os.Open(file2)
	if err != nil {
		return false, "Nie mozna otworzyc pliku 2: " + err.Error()
	}
	defer f2.Close()

	r1 := bufio.NewReader(f1)
	r2 := bufio.NewReader(f2)

	lineNum := 1
	for {
		l1, err1 := r1.ReadString('\n')
		l2, err2 := r2.ReadString('\n')

		if err1 == io.EOF && err2 == io.EOF {
			break
		}
		if err1 == io.EOF || err2 == io.EOF {
			return false, "Pliki maja rozna liczbe linii."
		}

		parts1 := strings.Fields(l1)
		parts2 := strings.Fields(l2)

		if len(parts1) != len(parts2) {
			return false, "Linia " + strconv.Itoa(lineNum) + " ma rozna liczbe kolumn."
		}

		for col, p1 := range parts1 {
			p2 := parts2[col]
			v1, errV1 := strconv.ParseFloat(p1, 64)
			v2, errV2 := strconv.ParseFloat(p2, 64)

			if errV1 != nil || errV2 != nil {
				if p1 != p2 {
					return false, "Linia " + strconv.Itoa(lineNum) + ", kolumna " + strconv.Itoa(col+1) + " mismatch: " + p1 + " != " + p2
				}
				continue
			}

			diff := math.Abs(v1 - v2)
			if diff > tolerance {
				return false, "Linia " + strconv.Itoa(lineNum) + ", kolumna " + strconv.Itoa(col+1) + " mismatch: " + p1 + " vs " + p2 + " (diff: " + strconv.FormatFloat(diff, 'e', 2, 64) + ")"
			}
		}
		lineNum++
	}
	return true, ""
}

func TestRegressionGoldenRun(t *testing.T) {
	// Przygotowanie sciezek
	cwd, _ := os.Getwd()
	// tests/ lezy w native_version, wiec parentDir to native_version
	parentDir := filepath.Dir(cwd)
	goldDir := filepath.Join(cwd, "regression_gold")
	goldConvPath := filepath.Join(goldDir, "conv.dat")

	// Usuniecie starych plikow
	tempFiles := []string{"picdata.bin", "rng_state.bin", "conv.dat", "density.dat"}
	for _, fname := range tempFiles {
		os.Remove(filepath.Join(parentDir, fname))
	}

	// 1. Zbudowanie regression_runner
	cmdBuild := exec.Command("go", "build", "-o", "regression_runner", "cmd/regression/main.go")
	cmdBuild.Dir = parentDir
	if err := cmdBuild.Run(); err != nil {
		t.Fatalf("Blad budowania regression_runner: %v", err)
	}
	defer os.Remove(filepath.Join(parentDir, "regression_runner"))

	// 2. Inicjalizacja: `./regression_runner 0`
	cmdInit := exec.Command("./regression_runner", "0")
	cmdInit.Dir = parentDir
	if err := cmdInit.Run(); err != nil {
		t.Fatalf("Blad uruchomienia `./regression_runner 0`: %v", err)
	}

	// 3. Kontynuacja: `./regression_runner 5`
	cmdRun := exec.Command("./regression_runner", "5")
	cmdRun.Dir = parentDir
	if err := cmdRun.Run(); err != nil {
		t.Fatalf("Blad uruchomienia `./regression_runner 5`: %v", err)
	}

	generatedConv := filepath.Join(parentDir, "conv.dat")
	if _, err := os.Stat(generatedConv); os.IsNotExist(err) {
		t.Fatalf("Plik conv.dat nie zostal wygenerowany!")
	}

	// Jesli wzorzec nie istnieje, wykonujemy bootstrap
	if _, err := os.Stat(goldConvPath); os.IsNotExist(err) {
		err = os.MkdirAll(goldDir, 0755)
		if err != nil {
			t.Fatalf("Blad tworzenia katalogu gold: %v", err)
		}

		srcFile, err := os.Open(generatedConv)
		if err != nil {
			t.Fatalf("Blad odczytu conv.dat: %v", err)
		}
		defer srcFile.Close()

		destFile, err := os.Create(goldConvPath)
		if err != nil {
			t.Fatalf("Blad zapisu wzorca: %v", err)
		}
		defer destFile.Close()

		_, err = io.Copy(destFile, srcFile)
		if err != nil {
			t.Fatalf("Blad kopiowania wzorca: %v", err)
		}

		t.Skip("Utworzono plik wzorcowy golden run. Pomijanie asercji w tym przebiegu.")
	} else {
		// Porownaj wygenerowany conv.dat ze wzorcowym
		success, msg := compareNumericFiles(generatedConv, goldConvPath, 1e-12)
		if !success {
			t.Errorf("Blad regresji: %s", msg)
		}
	}

	// Posprzatacie po sobie
	for _, fname := range tempFiles {
		os.Remove(filepath.Join(parentDir, fname))
	}
}
