# Moduł 6: Projekt Praktyczny – Równoległa Depozycja Ładunku (Step 1)

Doszedłeś do ostatniego modułu kursu! Połączyłeś już wiedzę o gorutynach, pulach workerów, wskaźnikach `sync.WaitGroup` oraz ochronie przed wyścigami. Teraz przełożymy to na **prawdziwe zadanie fizyczne** z symulacji plasma-in-cell (**GoPIC**).

Napiszemy i zoptymalizujemy zrównolegloną wersję **kroku 1: depozycja ładunku elektronów**.

---

## 1. Zrozumieć fizykę kroku 1 (Depozycja Liniowa)

W symulacjach cząsteczkowych (PIC), elektrony poruszają się w ciągłej przestrzeni o długości od $0$ do $L$. Jednak siatka obliczeniowa (potencjał, pole elektryczne, gęstość) jest dyskretna i składa się z $N_G = 400$ węzłów.

Kiedy elektron znajduje się na pozycji $x$ (gdzieś między węzłem $p$ a $p+1$), musimy przypisać (zdeponować) jego ładunek do tych dwóch sąsiednich węzłów. Robimy to za pomocą **wagowania liniowego**:

```
Węzeł p (x = p*DX)                      Pozycja elektronu (x)                  Węzeł p+1 (x = (p+1)*DX)
   ╠═══════════════════════════════════════════╬═══════════════════════════════════════════╣
   ▲<──────────────── c1 ─────────────────────>▲<───────────────── c2 ────────────────────>▲
```

*   `c0 = x / DX` (pozycja elektronu przeliczona na indeksy siatki).
*   `p = int(c0)` (indeks lewego węzła).
*   `c2 = c0 - p` (odległość od lewego węzła - waga dla prawego węzła).
*   `c1 = p + 1.0 - c0` (odległość od prawego węzła - waga dla lewego węzła).

Lewy węzeł $p$ otrzymuje: `c1 * FACTOR_W` ładunku.
Prawy węzeł $p+1$ otrzymuje: `c2 * FACTOR_W` ładunku.

---

## 2. Architektura Równoległa: Unikanie Cache Thrashing i Blokad

Jeśli 4 wątki (gorutyny) będą próbowały zapisać ładunek swoich cząstek bezpośrednio do globalnej tablicy `e_density` w tym samym czasie, dojdzie do wyścigu o dane. Zabezpieczenie tego mutexami (`sync.Mutex`) lub zapisem atomowym (`atomic.AddUint64`) zniszczyłoby wydajność, ponieważ procesor ciągle blokowałby rdzenie i synchronizował cache (zjawisko *cache thrashing*).

Zamiast tego zastosujemy **lokalną redukcję tablicową (Thread-Local Reduction)**:
1.  **Podział pracy**: Dzielimy tablicę cząstek o rozmiarze $N_e = 100\ 000$ na równe przedziały dla każdego wirtualnego procesora.
2.  **Kopie lokalne**: Każda gorutyna-worker otrzymuje swoją własną, niezależną tablicę `local_density` o rozmiarze $N_G = 400$ wypełnioną zerami.
3.  **Brak blokad**: Gorutyna przetwarza swoje cząstki i deponuje ich ładunek do swojej **lokalnej** tablicy. Ponieważ żadna inna gorutyna nie ma dostępu do tej tablicy, operacje zapisu są w 100% bezpieczne, wolne od wyścigów i niezwykle szybkie.
4.  **Wait**: Główna gorutyna czeka na ukończenie pracy za pomocą `wg.Wait()`.
5.  **Scalenie (Redukcja)**: Po wybudzeniu, wątek główny sekwencyjnie dodaje wartości z lokalnych tablic wszystkich workerów do jednej globalnej tablicy `e_density`.

---

## 3. Zadanie Praktyczne: Kompletny Szablon Kodu

Utwórz katalog `/home/oliwier/Dev/GoPIC/scratch/module6` i stwórz tam plik `main.go`. Wklej i uzupełnij poniższy szablon.

```go
package main

import (
    "fmt"
    "math/rand"
    "runtime"
    "sync"
    "time"
)

const (
    N_G            = 400
    L              = 0.025
    DX             = L / float64(N_G)
    INV_DX         = 1.0 / DX
    WEIGHT         = 70000.0
    ELECTRODE_AREA = 0.01
    FACTOR_W       = WEIGHT / (ELECTRODE_AREA * DX)
)

// Wersja sekwencyjna (Referencyjna)
func Step1ComputeElectronDensitySequential(x_e []float64, e_density []float64) {
    for i := range e_density {
        e_density[i] = 0.0
    }
    for k := 0; k < len(x_e); k++ {
        c0 := x_e[k] * INV_DX
        p := int(c0)
        c1 := float64(p) + 1.0 - c0
        c2 := c0 - float64(p)
        
        e_density[p]   += c1 * FACTOR_W
        e_density[p+1] += c2 * FACTOR_W
    }
    e_density[0] *= 2.0
    e_density[N_G-1] *= 2.0
}

// Kontekst dla jednego robotnika w wersji równoległej
type WorkerContext struct {
    start, end int
    density    []float64 // Prywatna, lokalna tablica gęstości dla tego workera
}

// Funkcja wykonywana przez gorutynę-workera
func worker(ctx *WorkerContext, x_e []float64, wg *sync.WaitGroup) {
    defer wg.Done()
    
    // Uzupełnij kod: wykonaj depozycję dla przedziału cząstek od ctx.start do ctx.end-1.
    // Zapisuj wyniki bezpośrednio do lokalnej tablicy ctx.density!
    
}

// Wersja równoległa
func Step1ComputeElectronDensityParallel(x_e []float64, e_density []float64) {
    for i := range e_density {
        e_density[i] = 0.0
    }
    
    numWorkers := runtime.NumCPU()
    runtime.GOMAXPROCS(numWorkers)
    
    var wg sync.WaitGroup
    chunkSize := len(x_e) / numWorkers
    contexts := make([]WorkerContext, numWorkers)
    
    // 1. Uruchomienie workerów
    for i := 0; i < numWorkers; i++ {
        contexts[i].start = i * chunkSize
        contexts[i].end = contexts[i].start + chunkSize
        if i == numWorkers-1 {
            contexts[i].end = len(x_e)
        }
        contexts[i].density = make([]float64, N_G)
        
        wg.Add(1)
        go worker(&contexts[i], x_e, &wg)
    }
    
    // 2. Czekamy aż wszyscy skończą
    wg.Wait()
    
    // 3. Uzupełnij kod (Redukcja): Dodaj wartości ze wszystkich contexts[i].density
    // do globalnej tablicy e_density.
    
    
    // 4. Uzupełnij kod: na koniec nałóż korekcję brzegową (*2.0) na węzły 0 i N_G-1
    // w globalnej tablicy e_density.
    
}

func main() {
    // Generowanie testowych położeń elektronów
    total_N_e := 100000
    x_e := make([]float64, total_N_e)
    r := rand.New(rand.NewSource(42))
    for i := range x_e {
        x_e[i] = L * (0.1 + 0.8*r.Float64()) // Pozycje wewnątrz gapu
    }
    
    e_density_seq := make([]float64, N_G)
    e_density_par := make([]float64, N_G)
    
    // Pomiar wersji sekwencyjnej
    startSeq := time.Now()
    Step1ComputeElectronDensitySequential(x_e, e_density_seq)
    durationSeq := time.Since(startSeq)
    
    // Pomiar wersji równoległej
    startPar := time.Now()
    Step1ComputeElectronDensityParallel(x_e, e_density_par)
    durationPar := time.Since(startPar)
    
    fmt.Printf("Czas sekwencyjny: %v\n", durationSeq)
    fmt.Printf("Czas równoległy:  %v\n", durationPar)
    fmt.Printf("Przyspieszenie:   %.2fx\n", float64(durationSeq)/float64(durationPar))
    
    // Asercja poprawności (Weryfikacja czy wyniki są identyczne)
    for i := 0; i < N_G; i++ {
        if e_density_seq[i] != e_density_par[i] {
            panic(fmt.Sprintf("BŁĄD: Wyniki różnią się na węźle %d! seq = %v, par = %v", i, e_density_seq[i], e_density_par[i]))
        }
    }
    fmt.Println(">> ASERCJA ZAKOŃCZONA SUKCESEM! Wyniki są w 100% identyczne.")
}
```

---

## 4. Wytyczne do testu

1.  Uzupełnij brakujący kod w miejscach oznaczonych komentarzami `// Uzupełnij kod...`.
2.  Uruchom program: `go run main.go`.
3.  Zwróć uwagę, czy program poprawnie przeszedł asercję i czy przyspieszenie jest satysfakcjonujące. Daj znać o wynikach! Jeśli to zrobisz, cały kurs współbieżności Go będziesz miał pomyślnie ukończony!
