# Rozdział 7: Narzędzia w Praktyce (Przegląd Ekosystemu)

Różne języki programowania oferują odmienne modele abstrakcji i narzędzia do zrównoleglania kodu. W tym rozdziale przyjrzymy się trzem środowiskom, które bezpośrednio wykorzystujemy w naszym projekcie GoPIC: C/C++, Go oraz Python.

---

## 1. Język C/C++: Blisko Sprzętu

Język C i C++ dają bezpośredni, niskopoziomowy dostęp do zasobów sprzętowych. Programowanie równoległe opiera się tu na dwóch podejściach: niskopoziomowym bibliotecznym oraz wysokopoziomowym dyrektyw kompilatora.

### A. Natywne wątki (`std::thread`, `std::jthread` od C++20)
Wprowadzone w standardzie C++11. Klasa `std::thread` to bezpośrednie opakowanie (wrapper) na wątki systemowe (np. POSIX Threads w Linuxie).
*   Zarządzanie pamięcią i synchronizacja leżą w 100% po stronie programisty przy użyciu takich obiektów jak: `std::mutex`, `std::unique_lock`, `std::lock_guard` oraz mechanizmów synchronizacji zdarzeń (`std::condition_variable`).
*   C++20 wprowadza `std::jthread` (joining thread), który automatycznie wywołuje `.join()` (czekanie na zakończenie wątku) w swoim destruktorze, co zapobiega crashom aplikacji przy wyjściu z zakresu funkcji.

### B. OpenMP (Open Multi-Processing)
Standard oparty na dyrektywach kompilatora (`#pragma`). Pozwala na pisanie kodu równoległego bez ręcznej manipulacji wątkami.
*   **Zrównoleglanie pętli**: Wystarczy dopisać przed pętlą `#pragma omp parallel for`, a kompilator automatycznie podzieli iteracje pętli pomiędzy dostępny zestaw rdzeni (Fork-Join).
*   **Zarządzanie zakresem danych**:
    *   `shared(zmienna)` – zmienna jest współdzielona (wszystkie wątki widzą tę samą pamięć - ryzyko wyścigu).
    *   `private(zmienna)` – każdy wątek dostaje własną, niezależną kopię zmiennej na swoim stosie.
    *   `reduction(operator:zmienna)` – bezpieczna akumulacja (np. liczenie sumy). Każdy wątek liczy sumę częściową dla swoich iteracji, a na koniec kompilator bezpiecznie (atomowo) łączy je w jedną zmienną.

### C. Inne biblioteki
*   **Pthreads (POSIX Threads)**: Klasyczna biblioteka języka C dla systemów Unix/Linux. Bardzo niskopoziomowa.
*   **Intel TBB (Threading Building Blocks)**: Zaawansowana biblioteka C++ wykorzystująca szablony, oferująca gotowe algorytmy równoległe (np. `parallel_for`, `parallel_sort`) oraz bezpieczne wątkowo struktury danych.

---

## 2. Język Go: Projektowany dla Wielordzeniowości

Język Go nie korzysta bezpośrednio z wątków systemowych w kodzie użytkownika. Opiera się na modelu **CSP (Communicating Sequential Processes)**.

### A. Goroutines (Gorutyny)
Niezwykle lekkie „wątki użytkownika” (Green Threads) zarządzane przez runtime Go.
*   Uruchomienie gorutyny (`go func()`) kosztuje zaledwie kilka kilobajtów pamięci na stosie (w porównaniu do 1-8 MB dla wątku systemowego).
*   Możesz uruchomić setki tysięcy gorutyn bez przeciążenia pamięci RAM.

### B. Go Scheduler (M:N Multiplexing)
Harmonogram wbudowany w runtime Go mapuje $M$ gorutyn na $N$ wątków systemowych przy użyciu techniki **Work Stealing** (kradzież zadań z mniej obciążonych rdzeni CPU). Jeśli gorutyna zostanie zablokowana (np. czeka na I/O), scheduler automatycznie odpina ją od wątku OS i przypina inną gorutynę, aby rdzeń nie stał bezczynnie.

### C. Kanały (Channels)
Przekazywanie wiadomości zamiast blokowania pamięci. Bezpieczna, wbudowana kolejka FIFO łącząca gorutyny. Go promuje zasadę: *„Nie komunikuj się poprzez współdzielenie pamięci; zamiast tego współdziel pamięć poprzez komunikację”*.

### D. Narzędzia
Wbudowany detektor wyścigów (`go test -race` / `go build -race`) automatycznie analizuje dostęp do pamięci i zgłasza wyścigi o dane w czasie wykonywania testów.

---

## 3. Język Python: Specyfika i omijanie GIL

Standardowy interpreter Pythona (CPython) posiada globalną blokadę interpretera – **GIL (Global Interpreter Lock)**.

### A. Zrozumienie GIL
GIL pozwala **tylko jednemu wątkowi systemowemu na wykonywanie kodu Pythona w danej chwili**, nawet jeśli Twój komputer ma wiele rdzeni. Wprowadzono go w celu ułatwienia zarządzania pamięcią (Reference Counting).

### B. Wątki (`threading`) vs Procesy (`multiprocessing`)
*   `threading` nadaje się wyłącznie do zadań wejścia/wyjścia (I/O-bound, np. pobieranie plików). Przy obliczeniach CPU-bound (np. fizyka PIC) wątki rywalizują o GIL, co spowalnia program.
*   `multiprocessing` omija GIL, uruchamiając całkowicie oddzielne procesy systemu operacyjnego (każdy ma swój interpreter i pamięć RAM). Wadą jest duży narzut pamięciowy i powolna komunikacja (IPC).
*   `asyncio` realizuje współbieżność jednowątkową opartą na pętli zdarzeń (Event Loop) dla zadań I/O.

### C. Omijanie GIL w obliczeniach naukowych
*   **NumPy / SciPy**: Wewnętrzne algorytmy NumPy są napisane w C/C++ i **zwalniają blokadę GIL** na czas obliczeń numerycznych. Dzięki temu wektorowe operacje w NumPy potrafią działać równolegle.
*   **Numba JIT (`numba.njit(parallel=True)`)**: Kompiluje kod Pythona do kodu maszynowego, zwalnia GIL i automatycznie zrównolegla pętle `numba.prange` za pomocą wbudowanej biblioteki wątków (np. OpenMP lub TBB).

---

## Polecana literatura i źródła zewnętrzne:
*   **Książka C++**: Anthony Williams – *„C++ Concurrency in Action”*.
*   **Książka Go**: Katherine Cox-Buday – *„Concurrency in Go: Tools and Techniques for Developers”*.
*   **Książka Python**: Luciano Ramalho – *„Zaawansowany Python” (Fluent Python)* – Sekcja V.
