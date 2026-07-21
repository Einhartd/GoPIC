# Moduł 3: Bezpieczeństwo Pamięci Współdzielonej & Mutexy

W tym module poruszymy jeden z najważniejszych i najtrudniejszych tematów w programowaniu równoległym: **bezpieczeństwo pamięci współdzielonej (thread safety)**. Dowiesz się, dlaczego współbieżny zapis do tej samej zmiennej niszczy dane na poziomie sprzętowym, jak automatycznie wykrywać te błędy za pomocą kompilatora Go oraz jak zabezpieczać sekcje krytyczne przy użyciu blokad (`Mutex`) i operacji atomowych (`atomic`).

---

## 1. Teoria: Dlaczego zapis współbieżny niszczy dane? (Poziom Sprzętowy)

Wyobraź sobie, że dwie gorutyny (wykonujące się na dwóch różnych rdzeniach CPU) chcą zwiększyć o jeden tę samą zmienną globalną `counter`, która aktualnie ma wartość `100`.

Operacja `counter++` wydaje się być jedną prostą czynnością, ale na poziomie procesora składa się z **trzech kroków (Read-Modify-Write)**:
1.  **Read (Odczyt)**: Rdzeń CPU kopiuje wartość `counter` z pamięci RAM/cache do swojego rejestru (lokalnej pamięci procesora).
2.  **Modify (Modyfikacja)**: Rejestr zwiększa wartość o 1 (z 100 na 101).
3.  **Write (Zapis)**: Rdzeń zapisuje nową wartość 101 z rejestru z powrotem do RAM.

### Scenariusz konfliktu (Wyścig o dane / Data Race):
Jeśli gorutyna A i gorutyna B wykonają te kroki jednocześnie bez synchronizacji, dojdzie do następującej sytuacji:

```
Czas  │ Gorutyna A (na Rdzeniu 1)       │ Gorutyna B (na Rdzeniu 2)       │ Stan counter w RAM
──────┼─────────────────────────────────┼─────────────────────────────────┼───────────────────
t1    │ Odczytuje counter (widzi 100)   │ Odczytuje counter (widzi 100)   │ 100
t2    │ Modyfikuje rejestr na 101       │ Modyfikuje rejestr na 101       │ 100
t3    │ Zapisuje 101 do pamięci         │ Zapisuje 101 do pamięci         │ 101 (Nadpisanie!)
```

*Wynik*: Zrobiliśmy dwa dodawania (`counter++`), ale wartość wzrosła tylko o **1** (wynosi 101 zamiast 102). Jedno dodawanie zostało bezpowrotnie zagubione! To zjawisko nazywamy **wyścigiem o dane (Data Race)**.

Wyścigi są niezwykle niebezpieczne, ponieważ program nie zgłasza żadnego błędu, a jedynie zwraca losowo błędne wyniki (błędy pojawiają się tylko czasami, np. przy dużym obciążeniu procesora, co utrudnia ich debugowanie).

---

## 2. Detektor Wyścigów w Go (`-race`)

Twórcy Go wbudowali w kompilator genialne narzędzie do wykrywania takich sytuacji. Dodając flagę `-race` podczas uruchamiania lub testowania, kompilator dodaje do kodu instrukcje śledzące dostęp do pamięci.

```bash
go run -race main.go
go test -race ./...
```
Jeśli program wykryje wyścig, natychmiast wypisze w konsoli szczegółowy raport pokazujący, która gorutyna pisała do pamięci, a która czytała w tym samym ułamku sekundy, wraz z dokładnymi numerami linii w kodzie!

---

## 3. Rozwiązanie I: Blokada Mutex (`sync.Mutex`)

Najprostszym sposobem na rozwiązanie tego problemu jest ochrona **sekcji krytycznej** (fragmentu kodu modyfikującego współdzieloną zmienną). Używamy do tego struktury **`sync.Mutex`** (skrót od *Mutual Exclusion* - wzajemne wykluczanie).

### Analogia z kluczem do toalety 🔑
Wyobraź sobie Mutex jako fizyczny klucz do jedynej toalety w biurze. 
*   Pracownik (gorutyna), który chce skorzystać z toalety, bierze klucz i zamyka drzwi od środka (metoda **`Lock()`**).
*   Inni pracownicy, którzy też chcą wejść, muszą stać w kolejce przed drzwiami. Blokują się i czekają.
*   Gdy pracownik wychodzi, oddaje klucz na wieszak (metoda **`Unlock()`**).
*   Kolejna osoba z kolejki bierze klucz i wchodzi.

### Przykład implementacji:
```go
package main

import (
    "sync"
)

type SafeCounter struct {
    mu    sync.Mutex // Mutex chroniący zmienną pod spodem
    value int
}

func (c *SafeCounter) Increment() {
    c.mu.Lock()         // Blokujemy dostęp dla innych gorutyn
    c.value++           // Sekcja krytyczna (bezpieczna!)
    c.mu.Unlock()       // Zwalniamy blokadę
}
```

---

## 4. Optymalizacja dla odczytów: `sync.RWMutex`

Jeśli nasz program bardzo często czyta zmienną (np. 1000 razy na sekundę), a modyfikuje ją rzadko (np. raz na sekundę), zwykły `Mutex` drastycznie spowolni działanie, bo czytelnicy będą blokować się nawzajem.

Wtedy stosujemy blokadę **odczytu/zapisu** (`sync.RWMutex`):
*   **Wielu czytelników jednocześnie**: Wiele gorutyn może jednocześnie założyć blokadę odczytu (**`RLock()`** i **`RUnlock()`**). Nie blokują się one nawzajem!
*   **Wyłączność dla pisarza**: Tylko jedna gorutyna może założyć blokadę zapisu (**`Lock()`** i **`Unlock()`**). Blokuje ona wtedy zarówno innych pisarzy, jak i wszystkich czytelników.

---

## 5. Rozwiązanie II: Operacje Atomowe (`sync/atomic`)

Blokowanie i odblokowywanie Mutexu to operacja programowa (zarządzana przez Go runtime). Dla prostych operacji matematycznych (jak zwykła inkrementacja) jest to zbyt powolne.

Procesory posiadają specjalne instrukcje sprzętowe (np. `LOCK XADD` na architekturze x86), które potrafią zablokować szynę pamięci na czas jednej instrukcji procesora. Język Go udostępnia je w pakiecie **`sync/atomic`**. Działają one bez mutexów (lock-free) i są wielokrotnie szybsze.

| Funkcja API | Opis | Przykład |
| :--- | :--- | :--- |
| `atomic.AddInt64(addr *int64, delta int64)` | Zwiększa bezpiecznie zmienną pod adresem `addr` o wartość `delta`. | `atomic.AddInt64(&counter, 1)` |
| `atomic.LoadInt64(addr *int64) int64` | Bezpiecznie (atomowo) odczytuje wartość zmiennej. | `val := atomic.LoadInt64(&counter)` |
| `atomic.StoreInt64(addr *int64, val int64)` | Bezpiecznie (atomowo) zapisuje wartość do zmiennej. | `atomic.StoreInt64(&counter, 0)` |

---

## 6. Zadanie Praktyczne do Wykonania

Napisz program w pliku `scratch/module3/main.go`, który zasymuluje wyścig i go naprawi:

1.  Zadeklaruj globalną zmienną `counter` typu `int64`.
2.  Stwórz funkcję `incrementator(wg *sync.WaitGroup)`, która w pętli `for` wykonuje `counter++` dokładnie **1000 razy**.
3.  W funkcji `main()` uruchom **10 gorutyn** w tle wywołujących `go incrementator(&wg)`.
4.  Użyj `sync.WaitGroup` do poczekania, aż wszystkie gorutyny skończą pracę.
5.  Na końcu wypisz w konsoli końcową wartość `counter` (powinna wynosić dokładnie 10 000).
6.  **Krok 1 (Wyścig)**: Uruchom program bez żadnej synchronizacji (czyli po prostu `counter++`) za pomocą komendy `go run -race main.go`. Przeanalizuj wygenerowany raport o błędzie wyścigu (*Data Race detected*). Zwróć uwagę, że wynik końcowy jest mniejszy niż 10 000.
7.  **Krok 2 (Naprawa Mutexem)**: Dodaj zmienną typu `sync.Mutex` i zabezpiecz nią operację inkrementacji (`mu.Lock()` i `mu.Unlock()`). Uruchom ponownie z flagą `-race`. Upewnij się, że raport o wyścigu zniknął, a wynik to zawsze dokładnie 10 000.
8.  **Krok 3 (Naprawa Atomowa)**: Zastąp Mutex funkcją `atomic.AddInt64(&counter, 1)` z pakietu `sync/atomic`. Sprawdź, czy program wciąż działa bezbłędnie i poprawnie.
