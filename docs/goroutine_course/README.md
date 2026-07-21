# Kurs Współbieżności i Równoległości w Go (Go Concurrency Course)

Witaj w kursie współbieżności języka Go. Ten folder zawiera zestaw modułów szkoleniowych, które przeprowadzą Cię od podstaw gorutyn do zaawansowanych algorytmów synchronizacji. Zdobytą wiedzę wykorzystamy bezpośrednio do zrównoleglenia projektu **GoPIC**.

---

## 🗺️ Plan Kursu

1.  **[Moduł 1: Podstawy Gorutyn i Model GMP](module1.md)**
    *   Współbieżność vs Równoległość.
    *   Uruchamianie gorutyn za pomocą `go`.
    *   API pakietu `runtime` (`NumCPU`, `GOMAXPROCS`, `Gosched`).
    *   Pułapka domknięć (Closure Trap).
2.  **[Moduł 2: Koordynacja i sync.WaitGroup](module2.md)**
    *   Zasada działania liczników.
    *   Wzorzec Worker Pool.
    *   Synchronizacja wielu gorutyn logicznych.
3.  **[Moduł 3: Wyścigi o dane i Mutexy](module3.md)**
    *   Wykrywanie wyścigów (`go run -race`).
    *   Blokady `sync.Mutex` i `sync.RWMutex`.
    *   Szybkie operacje atomowe z `sync/atomic`.
4.  **[Moduł 4: Kanały (channels)](module4.md)**
    *   Kanały buforowane i niebuforowane.
    *   Składnia wysyłania/odbierania.
    *   Zamykanie kanałów (`close`) i pętla `for range`.
5.  **[Moduł 5: Zaawansowane wzorce kanałowe](module5.md)**
    *   Multiplexing z `select`.
    *   Wzorzec Fan-In / Fan-Out.
    *   Kontrola czasu z `time.After` i anulowanie zadań za pomocą `context.Context`.
6.  **[Moduł 6: Projekt Praktyczny: Równoległa Depozycja Ładunku](module6.md)**
    *   Implementacja zrównoleglonego kroku 1 z eduPIC.
    *   Badanie wydajności i Garbage Collectora.
