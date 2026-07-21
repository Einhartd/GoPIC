# Moduł 4: Kanały (Channels) – Podstawy Modelu CSP

Do tej pory synchronizowaliśmy wątki za pomocą blokowania pamięci (Mutexy, WaitGroup). To tradycyjne podejście, które ma wadę: łatwo o pomyłkę, zapomnienie blokady lub deadlock.

Filozofia języka Go opiera się na innym modelu – **CSP (Communicating Sequential Processes)**. Zamiast dzielić pamięć i zakładać na nią kłódki (mutexy), gorutyny powinny przekazywać sobie dane bezpośrednio, przesyłając wiadomości. Służą do tego **kanały (`channels`)**.

---

## 1. Teoria: Czym jest kanał? (Analogia Rury)

Wyobraź sobie kanał jako fizyczną **rurę**, która łączy dwie niezależne gorutyny:
*   Jedna gorutyna wrzuca paczkę (zmienną) do rury z jednego końca.
*   Druga gorutyna odbiera tę paczkę z drugiego końca.

```
 [ Gorutyna Nadawcy ]  ─── wysyła (ch <- dane) ───>  [ KANAŁ (RURA) ]  ─── odbiera (<- ch) ───>  [ Gorutyna Odbiorcy ]
```

### Kluczowa cecha: Synchronizacja (Rendezvous)
Kanały niebuforowane (o których powiemy za chwilę) nie mają żadnego wewnętrznego magazynu. Oznacza to, że wysłanie i odebranie danych musi nastąpić dokładnie w tym samym czasie (spotkanie / rendezvous):
*   Jeśli nadawca chce wysłać dane, a odbiorca jeszcze nie czeka przy rurze – **nadawca zostaje zablokowany** i "zamrożony" na linii wysyłania.
*   Jeśli odbiorca podchodzi do rury, a nadawca jeszcze nic nie wysłał – **odbiorca zostaje zablokowany** i czeka na dane.
*   Dopiero gdy obaj są gotowi, dane przepływają, a obie gorutyny zostają wybudzone i ruszają dalej.

---

## 2. Słownik API i Składnia Kanałów

Kanały są typowane – to znaczy, że kanał stworzony dla liczb `int` nie może przesyłać tekstów `string`. Kanał tworzymy przy użyciu wbudowanej funkcji `make`:

```go
ch := make(chan int) // Utworzenie kanału niebuforowanego dla liczb typu int
```

### Strzałka `<-` określa kierunek przepływu danych:

1.  **Wysyłanie do kanału (`ch <- dane`)**
    *   *Składnia*: Nazwa kanału po lewej stronie strzałki, dane po prawej.
    *   *Przykład*: `ch <- 42` (wyślij liczbę 42 do kanału `ch`).
2.  **Odbieranie z kanału (`zmienna := <-ch` lub po prostu `<-ch`)**
    *   *Składnia*: Strzałka po lewej stronie kanału.
    *   *Przykład*: `wynik := <-ch` (odbierz dane z kanału `ch` i zapisz do zmiennej `wynik`).
3.  **Zamykanie kanału (`close(ch)`)**
    *   *Opis*: Informuje odbiorców, że nadawca nie wyśle już żadnych nowych danych.
    *   *Ważne*: Tylko nadawca powinien zamykać kanał! Próba wysłania danych do zamkniętego kanału spowoduje błąd krytyczny (*panic*).
4.  **Bezpieczny odczyt (`value, ok := <-ch`)**
    *   *Opis*: Dwuwartościowy odczyt. Zmienna `ok` przyjmuje wartość `true`, jeśli odczytano poprawną wartość. Jeśli kanał został zamknięty i nie ma w nim więcej danych, `ok` wynosi `false`, a `value` to tzw. wartość zerowa (np. `0` dla `int`, `""` dla `string`).

---

## 3. Kanały Niebuforowane vs Buforowane

W Go możemy zdefiniować pojemność kanału (bufor) podczas jego tworzenia:

```go
ch_niebuforowany := make(chan int)    // Pojemność = 0 (Rendezvous)
ch_buforowany    := make(chan int, 3) // Pojemność = 3
```

### Jak działa bufor?
Kanał buforowany działa jak **magazyn z półkami** (skrzynka pocztowa):
*   Nadawca może wrzucić do kanału 3 wartości pod rząd i **nie zostanie zablokowany**, nawet jeśli nikt ich jeszcze nie odbiera. Dane czekają na półkach w buforze.
*   Jeśli nadawca spróbuje wrzucić 4. wartość, a bufor jest pełny – wtedy nadawca zostanie zablokowany i będzie czekał, aż odbiorca pobierze chociaż jedną wartość z bufora.
*   Odbiorca blokuje się tylko wtedy, gdy bufor jest pusty.

---

## 4. Automatyzacja Odczytu: Pętla `for range` po kanale

Często chcemy czytać z kanału strumieniowo (jak w pętli). Zamiast pisać skomplikowane warunki `if ok == false`, Go udostępnia pętlę **`for range`**, która automatycznie pobiera wartości z kanału i kończy swoje działanie dokładnie w momencie, gdy nadawca zamknie kanał za pomocą `close()`:

```go
package main

import (
    "fmt"
    "time"
)

func generator(ch chan string) {
    ch <- "Pierwsza wiadomość"
    time.Sleep(10 * time.Millisecond)
    ch <- "Druga wiadomość"
    time.Sleep(10 * time.Millisecond)
    
    close(ch) // Zamykamy kanał – to wybudzi i zakończy pętlę range w main!
}

func main() {
    ch := make(chan string)
    go generator(ch)
    
    // Pętla range pobiera dane z kanału. Czeka na nadawcę (blokuje się),
    // a gdy kanał zostanie zamknięty, pętla sama się przerywa.
    for msg := range ch {
        fmt.Println("Konsument odebrał:", msg)
    }
    fmt.Println("Koniec odbierania, kanał zamknięty.")
}
```

---

## 5. Zadanie Praktyczne do Wykonania

Napisz program w pliku `scratch/module4/main.go` realizujący model **Producent-Konsument**:

1.  W funkcji `main` utwórz kanał **buforowany** o nazwie `kanalZadan` typu `int` o pojemności 3.
2.  Uruchom w tle gorutynę producenta: `go producent(kanalZadan)`.
3.  Zaimplementuj funkcję `producent(ch chan int)`:
    *   Funkcja w pętli `for` generuje liczby: `10, 20, 30, 40, 50`.
    *   Po wysłaniu każdej liczby wypisuje w konsoli: `[Producent] Wysłałem: X`.
    *   Na koniec (po wysłaniu liczby 50) producent **musi** zamknąć kanał za pomocą `close(ch)`.
4.  W funkcji `main` (która reprezentuje konsumenta) napisz pętlę `for range` odczytującą dane z `kanalZadan`.
5.  Dla każdej odebranej liczby konsument powinien wypisać: `[Konsument] Odebrałem: X, pierwiastek = Y` (do obliczenia pierwiastka użyj funkcji `math.Sqrt(float64(val))`).
6.  Uruchom program. Zaobserwuj, czy producent wysyła wartości partiami (dzięki buforowi), a konsument je odbiera, oraz czy program kończy się czysto bez zakleszczenia (*deadlock*).
