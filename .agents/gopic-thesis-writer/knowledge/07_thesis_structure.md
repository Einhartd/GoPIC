# Struktura i Przewodnik po Rozdziałach Pracy Magisterskiej

Niniejszy dokument przedstawia szczegółowy plan redakcyjny pracy magisterskiej, oparty na [`experiments/rozpiska_rozdzialow.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/rozpiska_rozdzialow.md), wraz z wytycznymi merytorycznymi dla każdego podrozdziału.

---

## Rozdział 1. Wstęp i Cel Pracy

### 1.1. Motywacja Badawcza
- Zapotrzebowanie na wydajne narzędzia symulacyjne w fizyce plazmy niskotemperaturowej (mikroelektronika, fuzja jądrowa, trawienie plazmowe, nanotechnologia).
- Dominacja języków tradycyjnych (C, C++, Fortran) w HPC i bariera trudności ich utrzymania oraz podatność na błędy pamięciowe.
- Dynamiczny rozwój języka Go (prostota współbieżności, bezpieczeństwo pamięci, szybkość kompilacji) i pytanie o jego dojrzałość w domenie obliczeń naukowych wysokiej wydajności (High-Performance Computing).

### 1.2. Problem Badawczy i Hipotezy
- **Pytanie badawcze:** *Czy kompilowany język z automatycznym odśmiecaniem pamięci (Garbage Collector) oraz zorientowanym na komunikację modelem wielowątkowości (gorutyny, kanały CSP) może stanowić realną i wydajną alternatywę dla C++ i OpenMP w obliczeniach kinetycznych plazmy metodą Particle-In-Cell?*
- **Hipoteza 1 (Alokacyjna):** Wyciszenie lub całkowite wyeliminowanie dynamicznej alokacji pamięci na stercie w pętli symulacyjnej pozwala zniwelować narzut odśmiecacza pamięci w Go niemal do zera.
- **Hipoteza 2 (Barierowa):** Standardowy model komunikacyjny CSP oparty na kanałach oraz semafory `sync.WaitGroup` zawodzą przy wysokich częstotliwościach synchronizacji ($>20\,000$ barier/s); dedykowana bezblokadowa bariera `StarBarrier` na atomikach przywraca skalowalność wielordzeniową.
- **Hipoteza 3 (Luki SIMD):** Głównym czynnikiem różnicującym wydajność Go względem C++ w metodzie PIC nie jest odśmiecacz pamięci, lecz brak autowektoryzacji SIMD w kompilatorze Go `gc` oraz koszt operacji Gather.

### 1.3. Zakres Pracy
- Wdrożenie pełnego, ekwiwalentnego silnika 1D-3V PIC/MCC w C++ i Go na bazie kodu referencyjnego eduPIC.
- Opracowanie ścieżki ewolucyjnej optymalizacji sekwencyjnej (Kroki 1–4) i równoległej (Kroki 1–5).
- Kompleksowe pomiary liczników sprzętowych (`perf stat`), profilowanie drzew wywołań (`perf record` / Flame Graphs) oraz analiza skalowalności na klastrze HPC.

---

## Rozdział 2. Modelowanie Kinetyczne Wyładowań Plazmowych Metodą PIC/MCC

### 2.1. Fizyka Wyładowań Pojemnościowych RF (CCRF)
- Dynamika warstw przyelektrodowych (sheath dynamics), zjawisko grzania stochastycznego i omowego.
- Równania ruchu w polu samospójnym (układ Vlasova-Poissona-Boltzmanna).

### 2.2. Cykl Obliczeniowy 1D-3V PIC/MCC
- Schemat blokowy cyklu (depozycja CIC, solver Poissona, Leap-Frog, granice, MCC).
- Matematyczne sformułowanie wag liniowych, warunków brzegowych Dirichleta, algorytmu Thomasa.
- Technika podkroków czasowych (subcycling jonów).

### 2.3. Architektura Oryginalnego Kodu Referencyjnego eduPIC
- Analiza struktury `eduPIC.cc` (Donkó et al.).
- Algorytm bezpośredniego sprawdzania zderzeń (Direct MCC) i jego złożoność $O(N \cdot N_{\text{substeps}})$.
- Krytyka stanu wyjściowego pod kątem architektury sprzętowej (brak SoA, powtórne odczyty z pamięci).

---

## Rozdział 3. Przegląd Literatury i Stan Badań nad Optymalizacją Symulacji Cząstkowych

### 3.1. Algorytmiczne Metody Redukcji Złożoności Zderzeń Kinetycznych
- Teoria Metody Zderzeń Zerowych (Null-Collision) Skulleruda oraz Vahediego i Surendry.
- Analityczna kinetyka wymiany ładunku (Charge Exchange — CX) i zderzeń sprężystych jon-neutral.
- Przekroje czynne Phelpsa dla argonu.

### 3.2. Architektura Struktur Danych i Zarządzanie Pamięcią Podręczną
- Array of Structures (AoS) vs Structure of Arrays (SoA).
- Bezkolizyjne techniki depozycji ładunku: atomiki vs prywatne bufory w pamięci podręcznej L1d.
- Zjawisko fałszywego współdzielenia linii pamięci podręcznej (False Sharing) i protokoły spójności MESI/MOESI.

### 3.3. Wyzwania Wektoryzacji SIMD i Nielokalnego Dostępu do Pamięci
- Integrator Leap-Frog w rejestrach wektorowych (AVX2, AVX-512).
- Problem nielokalnego odczytu siatki (Gather Problem) i sprzętowa instrukcja `VGATHERDPD`.

### 3.4. Modele Programowania Współbieżnego w HPC
- Współdzielenie pamięci i model fork-join (OpenMP).
- Model CSP (Communicating Sequential Processes) i scheduler M:N w Go.
- Problem opóźnień wywołań systemowych `SYS_futex` w barierach wysokiej częstotliwości.

---

## Rozdział 4. Eksperymenty Optymalizacyjne i Analiza Wydajności w C++ oraz Go

### 4.1. Metodyka Pomiarowa i Środowisko Badawcze
- Specyfikacja klastra HPC WCSS (węzły AMD EPYC Zen 4, moduły CCX, pamięć L3).
- Narzędzia pomiarowe: `perf stat` (metryki: IPC, chybienia L1d/L3, migracje, przełączenia kontekstu) oraz `perf record` z wykresami płomieniowymi.
- Metodologia Golden Record ([`golden_record/picdata.bin`](file:///C:/Users/E14/Documents/GitHub/GoPIC/golden_record/picdata.bin)) i testy regresyjne.

### 4.2. Analiza Stanu Wyjściowego i Diagnoza Kodu Bazowego (Baseline)
- Identyfikacja wąskich gardeł w profilu wykonania (`perf record`).
- Koszt wielokrotnego losowania zderzeń Direct MCC.

### 4.3. Porównawcza Analiza Assemblerowa Kompilatorów GCC i Go `gc`
- Zestawienie kodu maszynowego Leap-Frog: instrukcje skalarne SSE (`MOVSD`) w Go vs wektory YMM/ZMM w C++.
- Problem sprawdzania granic tablic: instrukcje `CMPQ/JAE runtime.panicIndex` i ich usunięcie przez BCE.

### 4.4. Ścieżka Optymalizacji Symulacji w C++ (OpenMP)
- Wdrożenie Null-Collision i wektoryzacji.
- Zrównoleglenie OpenMP, optymalizacja powiązania wątków do modułu CCX (`OMP_PROC_BIND=close`).

### 4.5. Ścieżka Optymalizacji Sekwencyjnej w Go (Kroki 1–4)
- Krok 1 (Baseline) $\to$ Krok 2 (Port algorytmiczny).
- Krok 3 (Zero-Allocation): eliminacja 4.8 GB/cykl sterty, 1317 cykli GC, przyspieszenie 4.66x.
- Krok 4 (BCE & Loop Unrolling): usunięcie narzutu granic tablic, rozwinięcie x4, `GOAMD64=v4`.

### 4.6. Ścieżka Optymalizacji Wielowątkowej w Go (Kroki 1–5)
- Krok 1: Analiza narzutu kanałów Go (CSP) i blokad `hchan.lock`.
- Krok 2: Dekompozycja domenowa, prywatne bufory L1d, eliminacja False Sharing (przyspieszenie 38x–105x).
- Krok 3: Architektura `StarBarrier`, eliminacja `SYS_futex`, aktywne wirowanie `PAUSE` (przyspieszenie bariery 7.59x).
- Krok 4: Fuzja Leap-Frog z granicami (Fused Move & Detect), redukcja 8000 barier na cykl, kompaktacja $O(\text{dead})$.
- Krok 5: Strojenie mikroarchitektoniczne, ostateczna skalowalność.

### 4.7. Bezpośrednie Porównanie Międzyjęzykowe i Dyskusja Wyników
- Zestawienie skalowalności C++ OpenMP vs Go StarBarrier (wykresy speedup, efektywność równoległa).
- Bilans zysków i strat: prostota języka i bezpieczeństwo pamięci vs brak autowektoryzacji.

---

## Rozdział 5. Podsumowanie i Wnioski Końcowe

### 5.1. Podsumowanie Osiągniętych Rezultatów
- Zestawienie sumarycznych czasów i zysków wydajnościowych na każdym etapie.
### 5.2. Weryfikacja Hipotez Badawczych
- Odpowiedź na pytanie główne: Go z zerową alokacją i dedykowaną barierą `StarBarrier` osiąga wydajność na poziomie $\approx 70-85\%$ zoptymalizowanego C++ OpenMP.
### 5.3. Kierunki Dalszych Badań
- Wykorzystanie intrinsics SIMD w Go (poprzez generator kodu lub zewnętrzne biblioteki), heterogeniczne obliczenia GPU (CUDA/OpenCL/Vulkan).
