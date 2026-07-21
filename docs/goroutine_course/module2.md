# Moduł 2: Koordynacja Gorutyn za pomocą sync.WaitGroup

W poprzednim module używaliśmy funkcji `time.Sleep()`, aby zatrzymać główną funkcję `main()` i dać czas gorutynom w tle na zakończenie pracy. W rzeczywistych programach **używanie `time.Sleep()` do synchronizacji jest niedopuszczalne**. Nigdy nie wiemy z góry, ile dokładnie czasu zajmą obliczenia, a program albo zakończy się za wcześnie (gubiąc dane), albo będzie czekał niepotrzebnie za długo (marnując wydajność).

W tym module nauczysz się profesjonalnej metody koordynacji gorutyn przy użyciu mechanizmu **`sync.WaitGroup`** oraz wdrożysz klasyczny wzorzec dzielenia zadań obliczeniowych – **Pule Pracowników (Worker Pools)**.

---

## 1. Teoria: Jak działa sync.WaitGroup?

Wyobraź sobie kierownika budowy (funkcja `main`), który ma do wykonania 5 zadań. Wynajmuje 5 robotników (gorutyny). Zanim przejdzie do odbioru technicznego budynku (dalsza część programu), musi mieć pewność, że **wszyscy** robotnicy skończyli swoją pracę.

Kierownik stawia na stole tablicę kredową z licznikiem (to jest nasza **`WaitGroup`**):
1.  Przed wysłaniem robotników do pracy, kierownik zapisuje na tablicy liczbę **`5`** (metoda **`Add(5)`**).
2.  Każdy robotnik, kiedy skończy swoje zadanie, podchodzi do tablicy i zmniejsza liczbę o **`1`** (metoda **`Done()`**).
3.  Kierownik siada na krześle i patrzy na tablicę. Jeśli liczba jest większa niż 0, kierownik czeka cierpliwie (metoda **`Wait()`**).
4.  Gdy ostatni robotnik zmaże ostatnią kreskę i na tablicy pojawi się **`0`**, kierownik zostaje natychmiast "wybudzony" i przechodzi do kolejnego etapu.

### Reprezentacja graficzna przepływu czasu:
```
main: ---- Add(3) ---- Wait() ══════════════════════ (Blokada - oczekiwanie) ════════════ wybudzenie --->
                        │
goroutine 1:            └---> [Obliczenia...] ---> Done() (licznik = 2)
goroutine 2:            └---> [Obliczenia...] -------------> Done() (licznik = 1)
goroutine 3:            └---> [Obliczenia...] ---------------------> Done() (licznik = 0)
```

---

## 2. Słownik API: `sync.WaitGroup`

Wszystkie operacje wykonujemy na typie `sync.WaitGroup` z pakietu standardowego `"sync"`.

| Sygnatura Metody | Opis Działania | Szczegóły |
| :--- | :--- | :--- |
| `(wg *WaitGroup) Add(delta int)` | Zmienia wewnętrzny licznik o wartość `delta`. | Zazwyczaj wywołujemy to w wątku głównym przed uruchomieniem gorutyny z parametrem `1`. Jeśli przekażesz wartość ujemną, zmniejszysz licznik. Jeśli licznik spadnie poniżej zera, program zgłosi błąd (*panic*). |
| `(wg *WaitGroup) Done()` | Zmniejsza wewnętrzny licznik o `1`. | Odpowiednik wywołania `Add(-1)`. Zazwyczaj umieszczana na samym początku funkcji gorutyny z użyciem słowa kluczowego `defer`, aby upewnić się, że zostanie wywołana nawet w przypadku błędu. |
| `(wg *WaitGroup) Wait()` | Blokuje gorutynę, dopóki licznik nie spadnie do `0`. | Wywoływana najczęściej w głównej gorutynie (`main`), gdy chcemy zatrzymać program i poczekać na zakończenie wszystkich asynchronicznych obliczeń. |

---

## 3. Bardzo Ważna Reguła: Przekazywanie przez Wskaźnik (`*`)

W języku Go struktury przekazywane do funkcji są domyślnie **kopiowane** (przekazywane przez wartość). Jeśli przekażesz `sync.WaitGroup` do funkcji bez użycia znaku `&` (wskaźnika), Go stworzy zupełnie nowy licznik w pamięci dla tej funkcji:

*   Gorutyna zmniejszy o jeden swoją lokalną kopię licznika.
*   Licznik w funkcji `main` nigdy nie spadnie do zera!
*   Program zawiesi się na zawsze, a runtime zgłosi błąd typu **`deadlock`** (wszystkie gorutyny śpią, brak postępu).

### 🚫 ŹLE (Przekazywanie przez kopię):
```go
func worker(id int, wg sync.WaitGroup) { // Kopia! Błąd!
    defer wg.Done()
}
```

###  DOBRZE (Przekazywanie przez wskaźnik):
```go
func worker(id int, wg *sync.WaitGroup) { // Wskaźnik (*) do oryginalnego obiektu w pamięci
    defer wg.Done()
}
```

---

## 4. Analiza Kodu Krok po Kroku: Wzorzec Puli Pracowników (Worker Pool)

Przeanalizujmy, jak równomiernie podzielić duże zadanie obliczeniowe (np. sumowanie tablicy danych) pomiędzy gorutyny odpowiadające liczbie rdzeni CPU:

```go
package main

import (
    "fmt"
    "runtime"
    "sync"
)

// Definicja robotnika
// Przyjmuje: ID robotnika, przedział indeksów [start, end) do obliczenia, oraz wskaźnik do WaitGroup
func worker(id int, start, end int, wg *sync.WaitGroup) {
    // Słowo kluczowe "defer" gwarantuje, że wg.Done() wykona się DOKŁADNIE w momencie
    // wyjścia z funkcji worker, niezależnie od tego, jak funkcja się zakończy.
    defer wg.Done() 
    
    fmt.Printf("[Pracownik %d] Rozpoczynam obliczenia od indeksu %d do %d\n", id, start, end)
    
    suma := 0
    for i := start; i < end; i++ {
        suma += i
    }
    
    fmt.Printf("[Pracownik %d] Zakończyłem! Suma mojego przedziału = %d\n", id, suma)
}

func main() {
    // 1. Pobieramy liczbę fizycznych rdzeni komputera i ustawiamy scheduler
    numCPU := runtime.NumCPU()
    runtime.GOMAXPROCS(numCPU)
    fmt.Printf("Konfiguracja: uruchamiam pulę dla %d rdzeni CPU\n", numCPU)
    
    // 2. Deklarujemy obiekt WaitGroup
    var wg sync.WaitGroup
    
    // 3. Definiujemy rozmiar problemu (np. tablica o wielkości 1000)
    dataSize := 1000
    chunkSize := dataSize / numCPU // Wielkość paczki danych dla jednego rdzenia
    
    // 4. Uruchamiamy tylu robotników, ile mamy rdzeni CPU
    for i := 0; i < numCPU; i++ {
        start := i * chunkSize
        end := start + chunkSize
        
        // Zabezpieczenie na wypadek, gdyby rozmiar danych nie był idealnie podzielny przez numCPU
        if i == numCPU-1 {
            end = dataSize 
        }
        
        // Zwiększamy licznik o 1 PRZED uruchomieniem gorutyny
        wg.Add(1) 
        
        // Uruchamiamy gorutynę przekazując adres (&wg) do oryginalnego licznika
        go worker(i, start, end, &wg)
    }
    
    // 5. Zatrzymujemy funkcję main i czekamy, aż licznik spadnie do 0
    wg.Wait() 
    
    fmt.Println(">> Wszystkie gorutyny zakończyły pracę. Główny program może iść dalej!")
}
```

---

## 5. Zadanie Praktyczne do Wykonania

Napisz program w pliku `scratch/module2/main.go`, który wykonuje zrównoleglone sumowanie tablicy:

1.  W funkcji `main` zadeklaruj slice (tablicę dynamiczną) o rozmiarze 2000 elementów typu `float64`. Wypełnij ją liczbami od `1.0` do `2000.0` (użyj pętli `for`).
2.  Zidentyfikuj liczbę logicznych rdzeni CPU za pomocą `runtime.NumCPU()`.
3.  Zaprojektuj podział tej tablicy na równe fragmenty. Jeśli komputer ma np. 4 rdzenie, każdy worker powinien dostać przedział o długości 500 elementów.
4.  Stwórz funkcję `worker(id int, data []float64, wg *sync.WaitGroup)`:
    *   Funkcja powinna przyjmować **wycinek oryginalnej tablicy** (w języku Go wycinek przekazujemy jako `data[start:end]`).
    *   Worker sumuje wszystkie elementy przekazanego mu wycinka.
    *   Na koniec wypisuje w konsoli: `[Worker Y] Suma mojego wycinka = Z` (gdzie Y to ID workera, a Z to jego lokalna suma).
    *   Pamiętaj o `defer wg.Done()`.
5.  W funkcji `main()` uruchom workerów w tle za pomocą `go worker(...)`.
6.  Użyj `wg.Wait()`, aby zatrzymać główny program do momentu, gdy wszyscy skończą.
7.  Na samym końcu funkcji `main` wypisz: `>> Obliczenia zakończone sukcesem!`.

Napisz ten kod, przetestuj w konsoli za pomocą `go run main.go` i opisz swoje spostrzeżenia. Czy program za każdym razem kończy się poprawnie bez użycia `time.Sleep()`?
