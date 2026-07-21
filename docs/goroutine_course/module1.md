# Moduł 1: Wstęp do Współbieżności w Go & Architektura GMP

Witaj w pierwszym module! Ponieważ jest to Twój pierwszy kontakt ze zrównoleglaniem w Go, przeanalizujemy ten temat od samych podstaw. Zaczniemy od intuicyjnych analogii z życia codziennego, przejdziemy przez to, jak procesor i system operacyjny współpracują z Go, a na koniec napiszemy i szczegółowo przeanalizujemy Twój pierwszy współbieżny program.

---

## 1. Intuicyjne Wprowadzenie: Współbieżność vs Równoległość

Zanim przejdziemy do kodu, musimy bardzo precyzyjnie rozróżnić dwa pojęcia, które w potocznej mowie często oznaczają to samo, ale w informatyce mają zupełnie inne znaczenie: **współbieżność (concurrency)** oraz **równoległość (parallelism)**.

### 🍳 Analogia Kuchenna (Wyobraź sobie kucharza)

Wyobraź sobie, że przygotowujesz obiad składający się z pieczonego kurczaka i sałatki.

*   **Współbieżność (Organizowanie zadań)**: 
    Jesteś **jednym kucharzem** w kuchni. Wstawiasz kurczaka do piekarnika (zadanie A). Podczas gdy kurczak się piecze, nie stoisz bezczynnie, tylko zaczynasz kroić warzywa na sałatkę (zadanie B). Zanim skończysz sałatkę, dzwoni minutnik piekarnika – przerywasz krojenie, wyjmujesz kurczaka, a potem wracasz do sałatki. 
    *   *Wnioski*: Robisz postępy w wielu zadaniach w tym samym okresie czasu. Robisz to jednak **sam**, przełączając się między zadaniami. To jest właśnie **współbieżność** – strukturyzacja pracy tak, by zadania mogły na siebie nachodzić.
*   **Równoległość (Jednoczesne wykonanie)**:
    Do kuchni zapraszasz **drugiego kucharza**. Ty kroisz warzywa na sałatkę (zadanie A), a w tym samym fizycznym ułamku sekundy Twój pomocnik przyprawia kurczaka i wsadza go do pieca (zadanie B).
    *   *Wnioski*: Dwa zadania wykonują się **jednocześnie**, fizycznie w tej samej milisekundzie. Do tego potrzebujesz więcej niż jednego wykonawcy (w komputerze: więcej niż jednego fizycznego rdzenia procesora). To jest **równoległość**.

### 💻 Przekładając to na komputer:
*   **Współbieżność** to cecha struktury kodu – piszesz program tak, by składał się z małych, niezależnych procesów (gorutyn), które mogą być wykonywane w dowolnej kolejności.
*   **Równoległość** to cecha sprzętu – jeśli Twój komputer ma np. 8 rdzeni, to scheduler systemu operacyjnego uruchomi Twoje gorutyny na różnych rdzeniach fizycznie w tym samym czasie.

---

## 2. Pod Maską: Jak systemy operacyjne obsługują wątki, a jak robi to Go?

Aby w pełni docenić to, jak genialne są gorutyny w Go, musimy zrozumieć tradycyjny model programowania równoległego (znany z C++ czy Javy) i jego ograniczenia.

### Tradycyjne Wątki Systemowe (OS Threads)
W tradycyjnych językach, kiedy tworzysz wątek (np. `std::thread` w C++), program prosi system operacyjny (kernel) o utworzenie nowego wątku. 
*   **Wielkość**: Każdy taki wątek dostaje z góry przydzielony duży obszar pamięci na swój stos (zazwyczaj **1 do 8 megabajtów**). Jeśli chciałbyś stworzyć 10 000 takich wątków, sam ich stos zająłby 10-80 GB pamięci RAM! Twój komputer szybko uległby awarii z braku pamięci.
*   **Przełączanie kontekstu (Context Switching)**: Kiedy procesor przełącza się z jednego wątku systemowego na inny, musi wejść w tryb administratora jądra systemu (kernel mode), zapisać stan rejestrów procesora do pamięci, załadować rejestry nowego wątku i wrócić do programu. To bardzo droga operacja (trwa mikrosekundy), która spowalnia obliczenia.

### Gorutyny w Go (Lekkie Wątki)
Twórcy języka Go postanowili obejść te ograniczenia i stworzyli własnego zarządcę wątków wbudowanego bezpośrednio w Twój program (tzw. **Go Runtime Scheduler**). Działa on w przestrzeni użytkownika, bez ciągłego pytania systemu operacyjnego o zgodę.

*   **Początkowy stos to tylko ~2 KB**: Gorutyny zaczynają z minimalną ilością pamięci. Jeśli gorutyna potrzebuje więcej miejsca (np. wywołuje głębokie funkcje), Go dynamicznie powiększa jej stos w locie, a potem go zmniejsza. Możesz bez problemu uruchomić **milion gorutyn** na zwykłym laptopie!
*   **Niski koszt przełączania**: Przełączenie wykonania z jednej gorutyny na drugą odbywa się wewnątrz Twojego programu (bez przechodzenia do jądra systemu operacyjnego). Trwa to zaledwie kilkanaście nanosekund.

### Model G-M-P – Architektura Schedulera Go
Scheduler Go zarządza trzema typami bytów (skrót **GMP**):

```
       [ G1 ] [ G2 ] [ G3 ] ...  (Kolejka Gorutyn)
                 │
                 ▼
          ┌─────────────┐
          │    [ P ]    │  (Wirtualny Procesor / GOMAXPROCS)
          └──────┬──────┘
                 │
                 ▼
          ┌─────────────┐
          │    [ M ]    │  (Wątek Systemowy OS)
          └──────┬──────┘
                 │
                 ▼
    [ Fizyczny Rdzeń Procesora ]
```

*   **G (Goroutine)**: Reprezentuje gorutynę – czyli Twój kod, który ma zostać wykonany.
*   **M (Machine)**: Reprezentuje rzeczywisty wątek systemu operacyjnego (OS Thread) stworzony przez jądro systemu.
*   **P (Processor)**: Reprezentuje zasób obliczeniowy (wirtualny procesor). Liczba $P$ jest domyślnie równa liczbie logicznych rdzeni procesora (zmienna `GOMAXPROCS`).

### Jak to działa w praktyce?
Każdy wirtualny procesor $P$ posiada swoją lokalną kolejkę gorutyn ($G$) oczekujących na uruchomienie. Wątek systemowy $M$ podpina się pod procesor $P$, pobiera z jego kolejki gorutynę $G$ i wykonuje ją na fizycznym rdzeniu procesora.

**Kradzież Pracy (Work Stealing)**:
Co się stanie, jeśli wątek $M$ skończy wykonywać wszystkie gorutyny z kolejki swojego procesora $P$? Zamiast zasypiać i marnować czas procesora, ten wątek przechodzi w tryb "złodzieja" – patrzy na kolejki innych procesorów $P$ i **kradnie** z nich połowę oczekujących gorutyn, aby wykonać je u siebie. Dzięki temu praca na wszystkich rdzeniach komputera jest zawsze idealnie zbalansowana!

---

## 3. Słownik API i Składnia: Wchodzimy w Kod

Teraz nauczymy się uruchamiać gorutyny i kontrolować ich działanie za pomocą pakietu `runtime`.

### Jak uruchomić gorutynę?
Wystarczy dopisać słowo kluczowe `go` przed wywołaniem dowolnej funkcji.

#### Metoda 1: Wywołanie funkcji zdefiniowanej w kodzie
```go
package main

import (
    "fmt"
    "time"
)

// Funkcja, którą chcemy uruchomić współbieżnie
func wypiszWiadomosc(tekst string) {
    fmt.Println(tekst)
}

func main() {
    // Słowo kluczowe "go" uruchamia funkcję w tle
    go wypiszWiadomosc("Cześć z gorutyny!")
    
    // Blokujemy na chwilę główny program, by gorutyna zdążyła wypisać tekst
    time.Sleep(10 * time.Millisecond)
}
```

#### Metoda 2: Wywołanie funkcji anonimowej (bardzo popularne)
Czasami nie chcemy tworzyć nowej funkcji z nazwą. Możemy napisać funkcję bez nazwy i od razu ją uruchomić:
```go
func main() {
    go func() {
        fmt.Println("To jest funkcja anonimowa!")
    }() // Te nawiasy na końcu oznaczają: "wywołaj tę funkcję teraz!"
    
    time.Sleep(10 * time.Millisecond)
}
```

---

### Słownik funkcji pakietu `runtime`

Pakiet `runtime` udostępnia nam funkcje pozwalające rozmawiać bezpośrednio z Go Runtime Schedulerem:

```go
import "runtime"
```

1.  **`runtime.NumCPU() int`**
    *   *Opis*: Zwraca liczbę logicznych rdzeni procesora, które Twój system udostępnia programowi.
    *   *Zastosowanie*: Pozwala dowiedzieć się, na ile części najlepiej podzielić pętle obliczeniowe.
    *   *Przykład*: `rdzenie := runtime.NumCPU()` (zwróci np. `8` lub `16`).

2.  **`runtime.GOMAXPROCS(n int) int`**
    *   *Opis*: Ustala, ile wirtualnych procesorów ($P$) ma jednocześnie wykonywać kod Go. Zwraca poprzednio ustawioną wartość.
    *   *Wskazówka*: Jeśli przekażesz wartość mniejszą niż 1 (np. `0`), funkcja nie dokona żadnej zmiany, a jedynie zwróci aktualnie ustawioną wartość.
    *   *Przykład*: `runtime.GOMAXPROCS(4)` (ograniczy działanie programu do maksymalnie 4 procesorów logicznych, nawet jeśli komputer ma ich 32).

3.  **`runtime.Gosched()`**
    *   *Opis*: To prośba gorutyny: *"Wiem, że mam jeszcze pracę do wykonania, ale oddaję na moment mój czas procesora innym gorutynom. Wróć do mnie później"*. Gorutyna trafia na koniec kolejki oczekujących.
    *   *Zastosowanie*: Przydatne przy długich pętlach obliczeniowych bez operacji wejścia/wyjścia (I/O), aby jedna gorutyna nie zmonopolizowała całego rdzenia.

---

## 4. Pułapka Domknięć (Closure Trap): Najczęstszy Błąd Początkujących

To jest niezwykle ważna sekcja. Błąd, który tu omówimy, popełnia prawie każdy na początku pracy z Go. Wynika on ze specyfiki asynchroniczności.

Wyobraź sobie, że chcesz wypisać liczby od 1 do 5 przy użyciu 5 gorutyn.

### 🚫 Wersja z błędem (wyścig o zmienną):
```go
package main

import (
    "fmt"
    "time"
)

func main() {
    for i := 1; i <= 5; i++ {
        go func() {
            // Gorutyna czyta zmienną "i" bezpośrednio z pętli!
            fmt.Println(i) 
        }()
    }
    time.Sleep(100 * time.Millisecond)
}
```

#### Co wypisze ten program?
Zamiast liczb `1, 2, 3, 4, 5` (w losowej kolejności), zobaczysz najprawdopodobniej same szóstki: `6, 6, 6, 6, 6`!

#### Dlaczego tak się dzieje? (Wyjaśnienie krok po kroku)
1.  Pętla `for` wykonuje się **błyskawicznie**. Uruchomienie gorutyny w tle zajmuje ułamek sekundy, ale pętla w tym czasie zdąży już przeiterować do samego końca, czyli do momentu gdy warunek `i <= 5` przestanie być spełniony. Wtedy zmienna `i` w pamięci ma wartość `6`.
2.  Gorutyny, które zostały uruchomione w tle, zaczynają się wykonywać dopiero po chwili.
3.  Kiedy gorutyna wykonuje instrukcję `fmt.Println(i)`, patrzy do pamięci na zmienną `i`. Ponieważ wszystkie gorutyny współdzielą **tę samą zmienną** `i`, każda z nich odczytuje jej aktualną wartość, czyli `6`.

---

###  Wersja poprawna (przekazywanie przez kopię wartości):
Aby to naprawić, musimy sprawić, by każda gorutyna otrzymała swoją **własną, prywatną kopię** wartości zmiennej `i` w momencie tworzenia pętli. Przekazujemy wartość jako parametr (argument) do funkcji:

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    for i := 1; i <= 5; i++ {
        // Definiujemy, że nasza funkcja anonimowa przyjmuje jeden argument "val" typu int
        go func(val int) {
            fmt.Println(val) // Każda gorutyna czyta swoją lokalną, bezpieczną zmienną "val"
        }(i) // Tutaj w nawiasie PRZEKAZUJEMY aktualną wartość "i" (kopia wartości trafia do gorutyny)
    }
    time.Sleep(100 * time.Millisecond)
}
```
*Efekt*: Teraz program wypisze liczby od 1 do 5 (najprawdopodobniej w losowej kolejności, np. `3, 1, 5, 2, 4`), ponieważ gorutyny wykonują się asynchronicznie, ale każda dysponuje poprawną, zapamiętaną wartością.

---

## 5. Zadanie Praktyczne do Wykonania

Czas na Twoje pierwsze samodzielne ćwiczenie. Stworzymy mały program współbieżny i przeanalizujemy jego działanie.

### Instrukcja krok po kroku:
1.  Przejdź do katalogu `/home/oliwier/Dev/GoPIC/scratch/` i utwórz folder `module1`:
    `mkdir -p /home/oliwier/Dev/GoPIC/scratch/module1`
2.  W tym katalogu utwórz plik `main.go`.
3.  Zaimplementuj program, który:
    *   Importuje pakiety `"fmt"`, `"runtime"` oraz `"time"`.
    *   Wewnątrz funkcji `main` ustawia maksymalną liczbę procesorów na 2: `runtime.GOMAXPROCS(2)`.
    *   Wypisuje na ekranie informację o liczbie fizycznych rdzeni komputera przy użyciu `runtime.NumCPU()`.
    *   Uruchamia w pętli `for` **5 gorutyn** (identyfikatory od 1 do 5).
    *   Każda gorutyna na swoim początku powinna wypisać: `[Gorutyna X] Start`, następnie odczekać 10 milisekund (`time.Sleep(10 * time.Millisecond)`), a na końcu wypisać: `[Gorutyna X] Stop`. (Upewnij się, że poprawnie przekazałeś identyfikator jako parametr funkcji anonimowej!).
    *   Na końcu funkcji `main()` wstaw `time.Sleep(150 * time.Millisecond)`, aby dać gorutynom czas na zakończenie pracy.
4.  Uruchom program w terminalu:
    `go run main.go`
5.  **Pytanie do przemyślenia**: Zaobserwuj kolejność komunikatów Start/Stop. Czy są one uporządkowane liniowo, czy przeplatają się asynchronicznie?

Napisz kod, uruchom go i daj znać o wynikach! Jeśli napotkasz trudności, nie wahaj się wkleić kodu – chętnie pomogę go przeanalizować.
