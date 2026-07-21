# Moduł 5: Zaawansowane Wzorce Kanałowe & Context

W poprzednim module poznałeś proste rury łączące dwie gorutyny. W rzeczywistych systemach i symulacjach często jednak musimy:
1.  Nasłuchiwać na wielu kanałach jednocześnie i reagować na ten, który pierwszy dostarczy dane (multiplexing).
2.  Zabezpieczać się przed zawieszeniem programu (Timeouts).
3.  Przerywać pracę wielu wątków jednocześnie (anulowanie zadań).

W tym module poznasz instrukcję **`select`**, mechanizmy kontroli czasu oraz pakiet **`context`**, który służy do zarządzania cyklem życia gorutyn.

---

## 1. Instrukcja `select` – Kontroler Lotów

Instrukcja `select` wygląda podobnie do zwykłej instrukcji warunkowej `switch`, ale służy wyłącznie do operacji na kanałach. 

### Analogia z kontrolerem lotów ✈️
Wyobraź sobie kontrolera lotów, który nasłuchuje na trzech różnych pasmach radiowych (kanałach) od pilotów samolotów. Kontroler nie może słuchać tylko jednego pasma, bo przegapiłby wezwanie na pozostałych. Siedzi i czeka, aż na **którymkolwiek** pasmie pojawi się komunikat. Gdy pilot z pasma A zaczyna mówić – kontroler go obsługuje. Gdy skończy, wraca do nasłuchiwania na wszystkich pasmach.

```go
select {
case msg1 := <-kanalA:
    fmt.Println("Obsługuję sygnał z kanału A:", msg1)
case msg2 := <-kanalB:
    fmt.Println("Obsługuję sygnał z kanału B:", msg2)
case kanalC <- 42:
    fmt.Println("Wysłałem dane do kanału C")
}
```

### Ważne cechy `select`:
*   **Blokowanie**: Jeśli żaden kanał nie jest gotowy, `select` blokuje gorutynę i czeka.
*   **Losowość**: Jeśli gotowych jest kilka kanałów w tym samym czasie, Go wybiera jeden z nich **losowo**, co zapobiega zagłodzeniu innych wątków.
*   **Przypadek `default`**: Jeśli dodasz blok `default`, `select` staje się **nieblokujący**. Jeśli żaden kanał nie ma danych, natychmiast wykona się kod z sekcji `default`.

---

## 2. Obsługa Limitów Czasowych (Timeouts)

Często w symulacjach chcemy przerwać operację, jeśli trwa ona zbyt długo. Wykorzystujemy do tego połączenie `select` oraz funkcję **`time.After(czas)`**, która zwraca kanał. Go runtime przesyła do tego kanału wartość dokładnie po upływie zadanego czasu:

```go
select {
case wynik := <-kanalObliczen:
    fmt.Println("Otrzymano wynik symulacji:", wynik)
case <-time.After(1 * time.Second):
    // Ten przypadek wykona się po 1 sekundzie, jeśli kanalObliczen do tej pory nie przysłał danych
    fmt.Println("BŁĄD: Obliczenia trwały zbyt długo. Przerywam zadanie!")
}
```

---

## 3. Pakiet `context` – Zdalny Wyłącznik Bezpieczeństwa

Wyobraź sobie, że uruchomiłeś 100 gorutyn do przeszukiwania bazy danych. Jedna z nich znalazła szukany rekord po 1 milisekundzie. Pozostałe 99 gorutyn wciąż intensywnie pracuje i marnuje prąd. Chcemy wysłać do nich sygnał: *"Koniec pracy, rekord znaleziony, wyłączcie się!"*.

Do tego służy **`context.Context`**. Przekazujemy obiekt kontekstu jako pierwszy argument do wszystkich gorutyn.

| Funkcja API pakietu `context` | Opis |
| :--- | :--- |
| `context.Background() Context` | Tworzy pusty kontekst bazowy (zazwyczaj na samym początku funkcji `main`). |
| `context.WithCancel(parent Context) (Context, CancelFunc)` | Tworzy nowy kontekst potomny oraz zwraca funkcję `cancel()`. Wywołanie `cancel()` wysyła sygnał przerwania do wszystkich gorutyn używających tego kontekstu. |
| `context.WithTimeout(parent, duration) (Context, CancelFunc)` | Tworzy kontekst, który automatycznie wyśle sygnał przerwania po upływie czasu `duration`. |
| `(ctx Context) Done() <-chan struct{}` | Zwraca kanał. Gorutyny powinny go nasłuchiwać. Kanał ten zostaje **zamknięty** w momencie wywołania `cancel()`, co wybudza nasłuchujące gorutyny. |

### Przykład obsługi Contextu w gorutynie:
```go
func worker(ctx context.Context, id int) {
    for {
        select {
        case <-ctx.Done(): // Sprawdzamy, czy przyszedł sygnał "wyłącznik"
            fmt.Printf("[Worker %d] Otrzymałem sygnał STOP. Sprzątam i kończę.\n", id)
            return // Wyjście z funkcji kończy gorutynę
        default:
            // Wykonujemy małą porcję pracy...
            time.Sleep(5 * time.Millisecond)
        }
    }
}
```

---

## 4. Zadanie Praktyczne do Wykonania

Napisz program w pliku `scratch/module5/main.go`, który zasymuluje automatyczne przerywanie pracy z powodu przekroczenia czasu:

1.  W funkcji `main` stwórz kontekst, który automatycznie anuluje się po 50 milisekundach:
    `ctx, cancel := context.WithTimeout(context.Background(), 50 * time.Millisecond)`
    *Pamiętaj o dopisaniu `defer cancel()`, aby zwolnić zasoby kontekstu przy wyjściu z main!*
2.  Uruchom w tle gorutynę workera, przekazując do niej ten kontekst: `go obliczenia(ctx)`.
3.  Zaimplementuj funkcję `obliczenia(ctx context.Context)`:
    *   Funkcja powinna działać w nieskończonej pętli.
    *   W pętli, co 10 milisekund (`time.Sleep(10 * time.Millisecond)`), wypisuje komunikat: `[Obliczenia] Pracuję...`.
    *   Użyj instrukcji `select`, aby w każdej iteracji sprawdzać, czy kanał `ctx.Done()` został zamknięty.
    *   Jeśli kanał zostanie zamknięty, funkcja powinna wypisać: `[Obliczenia] Praca przerwana przez limit czasu!` i natychmiast zakończyć działanie (`return`).
4.  Na końcu funkcji `main()` wstaw `time.Sleep(120 * time.Millisecond)`.
5.  Uruchom program. Upewnij się, że worker wypisze komunikat `Pracuję...` maksymalnie 4-5 razy, po czym zakończy pracę z powodu timeoutu, a w drugiej połowie czasu trwania programu w konsoli panuje cisza.
