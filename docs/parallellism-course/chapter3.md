# Rozdział 3: Klasyfikacja i Typy Równoległości

Projektowanie programu równoległego polega na dekompozycji (podziale) problemu. Aby zrobić to poprawnie, musisz wiedzieć, jakie typy równoległości oferuje współczesny sprzęt oraz jakie wzorce algorytmiczne możesz zastosować.

---

## 1. Taksonomia Flynna (Flynn's Taxonomy)

W 1966 roku Michael Flynn zaproponował klasyfikację architektur komputerowych na podstawie strumieni instrukcji oraz strumieni danych. Do dzisiaj jest to podstawowy model podziału:

```
                  STRUMIEŃ DANYCH
               Jednokrotny   Wielokrotny
STRUMIEŃ      +-------------+-------------+
INSTRUKCJI    |             |             |
  Jednokrotny |    SISD     |    SIMD     |
              |             |             |
              +-------------+-------------+
  Wielokrotny |    MISD     |    MIMD     |
              |             |             |
              +-------------+-------------+
```

1.  **SISD (Single Instruction, Single Data)**: Klasyczny model jednoprocesorowy. Jedna instrukcja przetwarza jedną daną w danym czasie.
2.  **SIMD (Single Instruction, Multiple Data)**: Jedna instrukcja wykonuje tę samą operację na wielu danych jednocześnie.
    *   *Przykład*: Wektoryzacja procesora (instrukcje AVX/SSE) lub architektury GPU. Procesor może w jednym cyklu dodać do siebie 8 par liczb zmiennoprzecinkowych.
3.  **MISD (Multiple Instruction, Single Data)**: Wiele instrukcji przetwarza tę samą daną. Architektura rzadka, używana głównie w systemach o wysokiej niezawodności (np. komputery pokładowe w lotnictwie).
4.  **MIMD (Multiple Instruction, Multiple Data)**: Wiele rdzeni wykonuje różne instrukcje na różnych danych. To domyślny tryb działania współczesnych procesorów wielordzeniowych i klastrów komputerowych.

---

## 2. Równoległość Danych (Data Parallelism)

> [!TIP]
> **Równoległość danych** polega na podziale struktury danych (np. tablicy, siatki przestrzennej) na części i przypisaniu każdej części do innego wątku, który wykonuje na niej tę samą operację.

Jest to najczęstszy sposób zrównoleglania w obliczeniach naukowych. W naszej symulacji Particle-in-Cell (eduPIC):
*   Mamy tablicę cząstek.
*   Dzielimy tę tablicę na sekcje (np. wątek 1 liczy cząstki od 0 do 999, wątek 2 od 1000 do 1999).
*   Każdy wątek wykonuje dokładnie ten sam kod fizyczny (np. push cząstek).

---

## 3. Równoległość Zadań (Task Parallelism)

> [!NOTE]
> **Równoległość zadań** polega na podziale aplikacji na różne funkcje (zadania), które wykonują się równolegle na tej samej lub innej strukturze danych.

*   *Przykład*: Gra komputerowa.
    *   Wątek 1: Liczy fizykę świata.
    *   Wątek 2: Obsługuje dźwięk.
    *   Wątek 3: Generuje grafikę i przesyła ją do GPU.
    *   Wątek 4: Obsługuje połączenie sieciowe z serwerem.
Zadania te są zupełnie inne, mają różny kod i koordynują swoją pracę za pomocą komunikatów lub synchronizacji pamięci.

---

## 4. Wzorzec Fork-Join

Jest to podstawowy model sterowania przepływem w algorytmach równoległych:

```
            [ Zadanie Główne ]
                    |
                 ( FORK ) - Podział zadania
              /     |      \
    [Wątek 1]   [Wątek 2]   [Wątek 3]  - Przetwarzanie równoległe
              \     |      /
                 ( JOIN ) - Oczekiwanie na zakończenie wszystkich
                    |
         [ Dalszy Ciąg Programu ]
```

1.  **Fork (Rozwidlenie)**: Główny wątek programu dzieli pracę na podzadania i uruchamia wątki robotników (workers).
2.  **Join (Połączenie)**: Główny wątek zatrzymuje się i czeka (bariera synchronizacyjna), aż wszyscy robotnicy zakończą swoje obliczenia, aby scalić wyniki i przejść do kolejnego etapu.

---

## 5. Potokowość (Pipelining)

Model potokowy dzieli proces przetwarzania danych na sekwencyjne etapy, podobnie jak linia produkcyjna w fabryce samochodów.

```
Dane Wejściowe --> [ Etap 1: Odczyt ] --> [ Etap 2: Filtrowanie ] --> [ Etap 3: Zapis ]
```

*   Podczas gdy Etap 2 przetwarza paczkę danych numer $N$, Etap 1 może już odczytywać paczkę numer $N+1$.
*   Maksymalne przyspieszenie potoku jest ograniczone przez najwolniejszy etap potoku (tzw. wąskie gardło potoku).

---

## Polecana literatura i źródła zewnętrzne:
*   **Książka**: *„Structured Parallel Programming: Patterns for Efficient Computation”* Michael McCool, Arch D. Robison, James Reinders.
*   **Kurs wideo**: Coursera – *„Parallel programming in Java”* (Rice University).
