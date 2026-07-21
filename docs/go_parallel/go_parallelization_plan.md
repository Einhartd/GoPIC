# Plan i Architektura Zrównoleglenia w Języku Go (GoPIC)

Język Go posiada całkowicie odmienną filozofię współbieżności niż C/C++ z OpenMP. Zamiast dyrektyw kompilatora i polegania na wątkach systemowych, Go oferuje wbudowane w język lekkie **gorutyny**, **kanały** oraz pakiet synchronizacyjny `sync`.

---

## 1. Jak Działają Gorutyny: Model M:N pod Lupą

Aby zrozumieć gorutyny z poziomu wątków i rdzeni, musimy przyjrzeć się architekturze **Go Runtime Scheduler** (harmonogramu czasu uruchomieniowego Go). Model ten opisuje się za pomocą trzech głównych bytów: **G**, **M** oraz **P**.

```
  [ G1 ] [ G2 ] [ G3 ] (Kolejka Gorutyn)
           |
           v
    [ P ] (Wirtualny Procesor / GOMAXPROCS)
           |
           v
    [ M ] (Wątek Systemowy OS)
           |
           v
    [ Fizyczny Rdzeń CPU ]
```

### A. Anatomia modelu G-M-P:
1.  **G (Goroutine)**:
    *   Reprezentuje gorutynę – czyli lekką strukturę danych zawierającą stan wykonania kodu (licznik instrukcji, rejestry oraz stos).
    *   Stos gorutyny rozpoczyna się od zaledwie **2 KB** i rośnie dynamicznie w miarę potrzeb.
2.  **M (Machine / OS Thread)**:
    *   To rzeczywisty wątek systemu operacyjnego (np. POSIX thread), zarządzany i harmonogramowany przez jądro systemu (kernel).
    *   Domyślnie posiada duży stos o rozmiarze **1–8 MB**, którego alokacja i przełączanie są kosztowne.
3.  **P (Processor)**:
    *   Reprezentuje zasób logiczny potrzebny do wykonywania kodu Go. Liczba $P$ jest równa wartości `GOMAXPROCS` (domyślnie równa liczbie rdzeni fizycznych CPU).
    *   Każdy $P$ posiada swoją **lokalną kolejkę uruchomieniową** gorutyn ($G$).

### B. Mapowanie M:N i Work Stealing:
Go mapuje $M$ gorutyn użytkownika na $N$ wątków systemowych ($M \gg N$).
*   Gdy uruchamiasz gorutynę (`go func()`), trafia ona do lokalnej kolejki procesora $P$.
*   Wątek systemowy $M$ pobiera z $P$ gorutynę $G$ i wykonuje ją na fizycznym rdzeniu CPU.
*   **Work Stealing (Kradzież Pracy)**: Jeśli kolejka danego $P$ opustoszeje, wątek $M$ obsługujący ten $P$ automatycznie „kradnie” połowę gorutyn z kolejki innego wirtualnego procesora $P$, zapobiegając bezczynności rdzenia.
*   **Wątki blokowane (Syscalls)**: Jeśli gorutyna $G$ wykonuje blokujące wywołanie systemowe (np. odczyt z dysku), runtime Go odłącza wątek $M$ od wirtualnego procesora $P$ i przypisuje do $P$ nowy wątek systemowy, aby inne gorutyny mogły kontynuować pracę na tym rdzeniu.

---

## 2. Porównanie: Go (Gorutyny) vs C (Wątki / Pthreads)

| Cecha | Gorutyna w Go | Wątek w C/C++ (`std::thread`, Pthreads) |
| :--- | :--- | :--- |
| **Rozmiar stosu (początkowy)** | **~2 KB** (rośnie dynamicznie) | **1–8 MB** (stały rozmiar) |
| **Zarządzanie** | Go Runtime Scheduler (przestrzeń użytkownika) | Jądro Systemu Operacyjnego (przestrzeń jądra) |
| **Przełączanie kontekstu** | Tanie (kilkanaście ns - bez wywołania systemowego) | Kosztowne (mikrosekundy - wywołanie jądra, zmiana rejestrów CPU) |
| **Granica liczby wątków** | Miliony gorutyn jednocześnie | Tysiące wątków (brak pamięci RAM / przeciążenie kernela) |
| **Komunikacja** | Kanały (komunikaty), `sync.WaitGroup` | Współdzielona pamięć, Mutexy, zmienne warunkowe |

---

## 3. Lekcja z Analizy Daniela Lemire: Wydajność a Narzut Obliczeń

Równoległość nie zawsze oznacza przyspieszenie. Daniel Lemire w swoim artykule *„An overview of parallel programming (Go edition)”* wskazuje na bardzo ważne reguły:

1.  **Zadania za małe (De-optymalizacja)**:
    *   Jeśli zadanie jest zbyt proste (np. sumowanie tablicy 100k liczb), zrównoleglenie go za pomocą 128 gorutyn jest **5-krotnie wolniejsze** i **640-krotnie mniej efektywne** energetycznie niż wykonanie jednowątkowe!
    *   *Wniosek*: Narzut na utworzenie gorutyny, podział tablicy i komunikację kanałami przewyższa zysk z podziału pracy.
2.  **Ograniczenie pamięci (Memory Bound)**:
    *   Zadania, które polegają na czytaniu z RAM (np. proste dodawanie wektorów), są ograniczone przez przepustowość magistrali pamięci (Memory Bandwidth). Zwiększanie liczby rdzeni z 16 do 128 nie przyniesie dalszych zysków.
3.  **Optymalny zysk (CPU Bound)**:
    *   Wydajność rośnie subliniowo do pewnego limitu (np. liczby fizycznych rdzeni). Największy zysk uzyskujemy dla zadań czysto obliczeniowych (np. funkcje trygonometryczne, fizyka cząstek).

---

## 4. Minipodręcznik Współbieżności w Go (Tutorial)

### A. Uruchomienie Gorutyny
Aby uruchomić funkcję asynchronicznie, wystarczy poprzedzić jej wywołanie słowem kluczowym `go`:

```go
package main

import (
    "fmt"
    "time"
)

func sayHello() {
    fmt.Println("Hello z gorutyny!")
}

func main() {
    go sayHello() // Uruchomienie gorutyny
    
    // TRAP: Jeśli program się zakończy w tym miejscu, sayHello() może się nie wykonać!
    // Główna gorutyna (funkcja main) nie czeka na inne gorutyny.
    time.Sleep(100 * time.Millisecond) 
}
```

### B. Synchronizacja za pomocą `sync.WaitGroup`
Najlepszy sposób na koordynację wielu robotników wykonujących zadanie równoległe:

```go
package main

import (
    "fmt"
    "sync"
)

func worker(id int, wg *sync.WaitGroup) {
    defer wg.Done() // Zmniejsz licznik WaitGroup przy wyjściu z funkcji (odpowiednik ++/-- w C)
    fmt.Printf("Pracownik %d zakończył pracę\n", id)
}

func main() {
    var wg sync.WaitGroup
    
    for i := 1; i <= 5; i++ {
        wg.Add(1) // Zwiększ licznik o 1 przed uruchomieniem gorutyny
        go worker(i, &wg)
    }
    
    wg.Wait() // Zablokuj wykonanie main(), dopóki licznik nie spadnie do 0
    fmt.Println("Wszyscy pracownicy skończyli!")
}
```

### C. Komunikacja za pomocą Kanałów (`channels`)
Kanały służą do bezpiecznego przesyłania danych między gorutynami:

```go
package main

import "fmt"

func calculateSquare(val int, ch chan int) {
    ch <- val * val // Wyślij wartość do kanału (operacja blokująca)
}

func main() {
    // Stworzenie kanału przesyłającego typ int
    ch := make(chan int)
    
    go calculateSquare(10, ch)
    
    // Odbierz wartość z kanału (operacja blokująca, czeka na nadawcę)
    result := <-ch 
    fmt.Println("Wynik:", result)
}
```

### D. Zabezpieczenie przed Wyścigami (Data Races)
Jeśli wątki modyfikują wspólne dane, musimy użyć mutexu z pakietu `sync` lub operacji atomowych z pakietu `sync/atomic`:

```go
package main

import (
    "sync"
    "sync/atomic"
)

type SafeCounter struct {
    mu      sync.Mutex
    value1  int64
    value2  int32
}

func (c *SafeCounter) IncrementWithLock() {
    c.mu.Lock()
    c.value1++ // Bezpieczny zapis chroniony mutexem
    c.mu.Unlock()
}

func (c *SafeCounter) IncrementAtomic() {
    // Szybka, sprzętowa operacja atomowa (bez mutexu)
    atomic.AddInt32(&c.value2, 1) 
}
```

---

## 5. Równoległa Architektura w GoPIC (Worker Pool & Chunking)

W symulacjach cząsteczkowych ze względu na wydajność **nie używamy kanałów do przesyłania pojedynczych cząstek**. Zamiast tego dzielimy dane wejściowe na równe części i przekazujemy je do puli gorutyn-pracowników.

### Schemat podziału w GoPIC:

```go
type WorkerContext struct {
    Start, End int
    Density    []float64  // Lokalna siatka (zapobiega wyścigom bez locków)
    RNG        *rand.Rand // Własny generator liczb losowych
}

func parallelCalculation(particles []Particle) {
    numWorkers := runtime.GOMAXPROCS(0) // Np. 128 dla Twojego węzła
    var wg sync.WaitGroup
    
    chunkSize := len(particles) / numWorkers
    contexts := make([]WorkerContext, numWorkers)
    
    for i := 0; i < numWorkers; i++ {
        contexts[i].Start = i * chunkSize
        if i == numWorkers-1 {
            contexts[i].End = len(particles)
        } else {
            contexts[i].End = (i + 1) * chunkSize
        }
        contexts[i].Density = make([]float64, N_G)
        // Każdy worker dostaje swój niezależny, bezpieczny generator z unikalnym seedem
        contexts[i].RNG = rand.New(rand.NewSource(baseSeed + int64(i)))
        
        wg.Add(1)
        go func(ctx *WorkerContext) {
            defer wg.Done()
            // Obliczenia na przedziale cząstek [ctx.Start, ctx.End)
            // Wyniki depozycji zapisywane są do lokalnej tablicy ctx.Density
        }(&contexts[i])
    }
    
    wg.Wait() // Czekamy na koniec wszystkich obliczeń
    
    // Redukcja: Scalenie lokalnych tablic gęstości w jedną globalną
    for p := 0; p < N_G; p++ {
        globalDensity[p] = 0
        for i := 0; i < numWorkers; i++ {
            globalDensity[p] += contexts[i].Density[p]
        }
    }
}
```
*Opis paradygmatów potokowych oraz dekompozycji przestrzennej znajdziesz w pliku [go_concurrency_paradigms.md](file:///home/oliwier/Dev/GoPIC/docs/parallel/go_concurrency_paradigms.md).*
