# Podsumowanie Postępów Prac - 24 Lipca 2026

## 🎯 1. Cel Prac
Stworzenie w pełni zoptymalizowanej, wielowątkowej reimplementacji C++ z wykorzystaniem OpenMP w katalogu [C/parallel-only-omp/](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/). 
Implementacja ta stanowi **referencyjny punkt odniesienia (baseline)** dla dalszych prac w języku Go/Python oraz analiz skalowalności na klastrze HPC (dla obliczeń na 1 do 128 rdzeniach).

---

## ⏳ 2. Timeline Zmian w Kodzie (`C/parallel-only-omp/`)

```
  [Krok 1: Refaktoryzacja]
     └─ Rozbicie monolitu eduPIC.cc na funkcje step1-step9
  
  [Krok 2: Wstępny OpenMP]
     └─ Dodanie #pragma omp parallel for + #pragma omp atomic
     └─ Problem: Spowolnienie (8.63s vs 5.71s sekwencyjne) z powodu false sharing i atomików
  
  [Krok 3: Optymalizacja Pamięciowa - WorkerBuffers]
     └─ Usunięcie atomików, dodanie buforów per-wątek w state.h
     └─ Eliminacja alokacji na stercie w null_collision.h
     └─ Wynik: Czas spada do 4.14s (2.08x szybciej od starego OMP, 1.38x szybciej od sekwencyjnego)
  
  [Krok 4: Nieudana Próba Scalenia w do_one_cycle()]
     └─ Otwarcie trwałego #pragma omp parallel wokół pętli 4000 kroków czasowych
     └─ Błędy: Wyścig na stosie (total_survived -> #e=0, #i=0), uszkodzenie tablicy vx_e w step6, deadlock barier (>3.5h)
  
  [Krok 5: Wyczyszczenie i Stabilizacja (Stan Obecny)]
     └─ Wycofanie barier lambd z do_one_cycle(), przywrócenie czystych bloki OMP w step1-step8
     └─ Naprawa wskaźników jonów i wyczyszczenie komentarzy
     └─ Przejście 100% testów gtest i stabilne wyliczanie cząstek
```

---

## 🏗️ 3. Opis Szczegółowy Rozwoju i Napotkanych Problemów

### Krok 1: Wstępna refaktoryzacja i podział kodu
* Rozbicie monolitycznej pętli `eduPIC.cc` na 10 czytelnych kroków fizycznych (`step1` do `step9`) w [simulation.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/simulation.h).
* Wydzielenie osobnych funkcji obliczania gęstości elektronów (`step1a`) i jonów (`step1b`) z poprawnym warunkiem subcyclingu `if ((t % N_SUB) != 0) return;`.

### Krok 2: Pierwsza wersja OpenMP i identyfikacja wąskich gardeł
* Dodanie `#pragma omp parallel for` do pętli cząsteczkowych oraz `#pragma omp atomic` do zbierania diagnostyki XT/EEPF/IFED.
* **Wąskie gardło**: Wywołanie 14 atomików na cząstkę przy 4000 krokach wygenerowało potężny narzut synchronizacyjny, wysoki wskaźnik pudłowań cache L1 (**18.10%**) oraz spowolnienie czasu wykonania do **8.637 s** (gorzej niż 5.713 s w wersji sekwencyjnej).

### Krok 3: Optymalizacja pamięciowa – wprowadzenie `WorkerBuffers`
* **Usunięcie atomików**: Wprowadzono pre-alokowaną strukturę `WorkerBuffers` w [state.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/state.h). Każdy wątek zapisuje wyniki cząstkowe do prywatnych tablic (`e_density`, `i_density`, `ue`, `ui`, `meanee`, `meanei`, `ioniz`, `eepf`, `ifed`), a redukcja do macierzy globalnych odbywa się sekwencyjnie.
* **Eliminacja alokacji na stercie**: Zoptymalizowano `random_sample` w [null_collision.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/null_collision.h) za pomocą pre-alokowanych buforów `candidates_e`/`candidates_i` i `std::copy`.
* **Wynik**: Czas wykonania dla 2 wątków spadł z 8.637 s do **4.140 s** (przyspieszenie **2.08x** względem pierwszej wersji OMP i **1.38x** względem wersji sekwencyjnej), L1 cache miss rate spadł do **8.04%**, a IPC wzrósł do **1.23**.

### Krok 4: Nieudana próba scalenia w "Trwały Region Równoległy"
* **Koncepcja**: Próba wyeliminowania narzutu tworzenia zespołu wątków poprzez otwarcie pojedynczego `#pragma omp parallel` w `do_one_cycle()` wokół pętli pętli czasowej (4000 kroków), przekazując operacje w lambdach z dyrektywami `#pragma omp single` i `#pragma omp barrier`.
* **Napotkane błędy i przyczyny**:
  1. **Wyścig na stosie (`Stack Capture Race`) & Wyzerowanie cząstek (`#e = 0, #i = 0`)**: Zmienna `total_survived` zdeklarowana na stosie była modyfikowana przez Wątek 0 w `#pragma omp single`, a kolejny blok `#pragma omp single` wykonywał się na innym wątku z `total_survived == 0`. Powodowało to natychmiastowe usunięcie wszystkich cząsteczek z symulacji.
  2. **Uszkodzenie pamięci cząstek**: W `step6_check_boundaries_ions` prędkości jonów niefortunnie nadpisywały tablice prędkości elektronów `vx_e` zamiast `vx_i`.
  3. **Zakleszczenia barier (`Barrier Deadlock & Spin-Wait`)**: Zagnieżdżenie barier wewnątrz lambd doprowadziło do bezczynnego wirowania rdzeni CPU i zawieszenia symulacji (> 3.5 h bez zakończenia).

### Krok 5: Stabilizacja i uporządkowanie kodu (Stan Obecny)
* Wycofano zagnieżdżone bariery w lambdach z `do_one_cycle()` i przywrócono czystą, stabilną strukturę OpenMP wywoływaną wewnątrz poszczególnych kroków `step1`–`step8`.
* Usunięto błędy wskaźników w `step6` oraz niebezpieczne przechwytywanie zmiennych lokalnych na stosie.
* Wyczyszczono kod, dodano przejrzyste sekcje komentarzy i zweryfikowano poprawność pakietem 13 testów Google Test (`PASSED`) oraz biegiem 5 cykli (gdzie liczba cząstek fizycznie rozwija się prawidłowo od 545 do 2799).

---

## 📊 4. Wyniki Weryfikacyjne (Stan Obecny)

* **Testy Jednostkowe**: 100% testów w pakiecie Google Test (`C/parallel-only-omp/tests/`) przechodzi pomyślnie (`PASSED`).
* **Zysk Wydajności Pomiary (2 wątki)**:
  - Czas wykonania: **4.140 s** (2.08x szybciej od wstępnej wersji OMP, 1.38x szybciej od sekwencyjnego).
  - L1 dcache miss rate: **8.04%** (spadek z 18.10%).
  - Instrukcje na cykl (IPC): **1.23** (wzrost z 0.93).
