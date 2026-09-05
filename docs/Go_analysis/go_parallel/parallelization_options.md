# Analiza i Wybór Implementacji Równoległych w języku Go (GoPIC)

Aby zbadać zachowanie języka Go w symulacjach Particle-in-Cell (PIC) i porównać je z wydajnością C++ (OpenMP, MPI) oraz Pythona (NumPy, Numba), zaimplementujemy **trzy odmienne podejścia**. Wszystkie zachowują identyczny algorytm fizyczny (**dekompozycja cząstek ze współdzieloną siatką**), co zapewnia rzetelność porównawczą.

---

## Trzy Zrównoważone Implementacje w Go

```
                               ┌─────────────────────────────┐
                               │   GoPIC: Trzy Podejścia     │
                               └──────────────┬──────────────┘
                                              │
              ┌───────────────────────────────┼───────────────────────────────┐
              ▼                               ▼                               ▼
   [ Opcja 1: Chunking & Pool ]    [ Opcja 2: Coordinator-Channel ] [ Opcja 3: Potokowość ]
   - Odpowiednik OpenMP C++        - Odpowiednik MPI C++           - Out-of-order PIC
   - Pamięć współdzielona          - Przesyłanie komunikatów       - Brak barier czasowych
```

### Opcja 1: Klasyczny Podział Cząstek (Data Chunking / Worker Pool)
*   **Opis**: Podział globalnych tablic cząstek na równe fragmenty (*chunks*) przypisane do puli gorutyn-pracowników. Synchronizacja odbywa się za pomocą `sync.WaitGroup`. Każdy robotnik zapisuje gęstość lokalnie, a po skończeniu pętli wątek główny sekwencyjnie scala lokalne tablice gęstości w pamięci współdzielonej.
*   **Odpowiednik w C++**: **C++ OpenMP-only** (wersja bez MPI).
*   **Co badamy**: Czysty narzut schedulera Go (modelu G-M-P) na tworzenie i synchronizację gorutyn w porównaniu do dyrektyw OpenMP na poziomie kompilatora.

### Opcja 2: Model Koordynator-Pracownik z komunikacją kanałowej (Coordinator-Worker via Channels)
*   **Opis**: Wdrażamy model przesyłania komunikatów (Message Passing) w obrębie jednego procesu. Tworzymy jedną gorutynę **Koordynatora** (odpowiednik Mastera w MPI) oraz pulę gorutyn **Pracowników** (odpowiedniki procesów Worker w MPI). 
    *   Pracownicy nie mają dostępu do wspólnej pamięci siatki.
    *   Po wykonaniu kroku Move, każdy Pracownik **wysyła swoją lokalną siatkę gęstości przez kanał** (`chan []float64`) do Koordynatora.
    *   Koordynator sumuje gęstości, rozwiązuje Poissona i **rozsyła nowe pole elektryczne z powrotem do Pracowników przez kanały**.
*   **Odpowiednik w C++**: **C++ MPI** (w skali jednego węzła klastra).
*   **Co badamy**: Zmierzymy narzut komunikacji opartej na kanałach Go w porównaniu z biblioteką MPI w C++. Pokaże to, jak wydajny jest model CSP w zadaniach intensywnej synchronizacji danych numerycznych.

### Opcja 3: Potokowość Asynchroniczna (Pipeline Parallelism)
*   **Opis**: Każdy etap cyklu PIC (Move, Depozycja, Poisson, Zderzenia) jest autonomicznym procesem (gorutyną) połączonym buforowanym kanałem. Dane płyną strumieniowo. Dopuszczamy asynchroniczne, lekko opóźnione pole elektryczne (*out-of-order PIC*), eliminując sztywne bariery czasowe.
*   **Odpowiednik w C++**: **Brak odpowiednika** (C++ jest w 100% synchroniczny).
*   **Co badamy**: Jak asynchroniczny przepływ potoku w Go potrafi wyeliminować bezczynność rdzeni (idle time) na barierach w porównaniu z synchronicznym C++/Pythonem, oraz jak Garbage Collector radzi sobie przy ciągłej alokacji komunikatów na kanałach.
