# Poradnik Deweloperski: Kompilacja, Uruchamianie i Weryfikacja z Golden Record (WSL & Arch Linux)

Dokument stanowi kompletny przewodnik lokalnego uruchamiania i testowania symulacji Particle-in-Cell (C++) z podpiętym stanem wzorcowym (**Golden Record**). Przygotowany dla środowisk:
1. **Windows z WSL 2 (Ubuntu 22.04 / 24.04)**
2. **Natywny Arch Linux**

---

## 1. Dlaczego testujemy z Golden Recordem?

Domyślne uruchomienie symulacji od zera (`./eduPIC 0`) startuje z zaledwie **1000 cząstek** (początkowy seed) i wymaga setek cykli, aby osiągnąć stan ustalony wyładowania. Taki przebieg nie nadaje się do miarodajnych testów wydajnościowych.

W katalogu `golden_record/` znajduje się plik:
* **`golden_record/picdata.bin`** — binarny zrzut stanu plazmy po ustaleniu wyładowania (stan po ~2000 cykli, zawierający ponad **108 000 elektronów** i **113 000 jonów**).

Podpięcie tego pliku do katalogu roboczego sprawia, że symulacja od razu startuje w **realistycznym, produkcyjnym obciążeniu obliczeniowym** — dokładnie takim samym, jakie jest benchmarkowane na klastrze HPC Lem.

---

## 2. Wersja I: Windows z WSL 2 (Ubuntu)

### 2.1 Wymagania wstępne i instalacja pakietów
W terminalu WSL (Ubuntu) zainstaluj kompilator C++, narzędzia budowania oraz Pythona do weryfikacji:

```bash
sudo apt update
sudo apt install -y build-essential g++ make python3 python3-pip linux-tools-generic
```

### 2.2 Ścieżki w WSL
Twoje repozytorium Windows jest zamontowane w WSL pod ścieżką:
```bash
cd /mnt/c/Users/E14/Documents/GitHub/GoPIC
```

> [!TIP]
> **Wskazówka wydajnościowa WSL:** Dostęp do plików na `/mnt/c/` przechodzi przez mostek 9P systemu Windows, co wprowadza drobny narzut na operacje wejścia/wyjścia (I/O). Obliczenia numeryczne w pamięci RAM wykonują się z natywną prędkością procesora, ale jeśli zależy Ci na maksymalnej szybkości zapisu plików `.dat`, możesz sklonować repozytorium bezpośrednio do linuksowego systemu plików WSL (np. `~/GoPIC`).

---

### 2.3 Krok po kroku: Kompilacja i uruchomienie

#### Krok 1: Przejście do katalogu z kodem
```bash
cd /mnt/c/Users/E14/Documents/GitHub/GoPIC/C/experimental
```

#### Krok 2: Kompilacja
Plik `Makefile` kompiluje kod z flagami optymalizacji `-std=c++17 -O3 -Wall -fno-math-errno -lm`:
```bash
make clean && make
```
Powstanie plik wykonywalny `eduPIC`.

#### Krok 3: Podpięcie stanu Golden Record
Skopiuj referencyjny plik `picdata.bin` bezpośrednio do katalogu roboczego:
```bash
cp ../../golden_record/picdata.bin ./picdata.bin
```

#### Krok 4: Uruchomienie symulacji
Program przyjmuje dwa argumenty:
`./eduPIC <liczba_cykli> [m]`
* `<liczba_cykli>`: liczba okresów RF do przeliczenia (np. 1, 5, 20).
* `m` (opcjonalnie): tryb diagnostyczny — generuje pełne pliki diagnostyczne (`density.dat`, `eepf.dat`, `ifed.dat`, `info.txt`, rozkłady `*_xt.dat`).

**Szybki test (1 cykl):**
```bash
./eduPIC 1
```
*Wynik w konsoli:*
```text
>> eduPIC: data loaded : 108199 electrons 113624 ions, 2001 cycles completed before
>> eduPIC: running 1 cycle(s)
 c =     2002  t =        0  #e =   108198  #i =   113618
 c =     2002  t =     1000  #e =   108156  #i =   113563
 c =     2002  t =     2000  #e =   108196  #i =   113598
 c =     2002  t =     3000  #e =   108169  #i =   113546
>> eduPIC: data saved : 108189 electrons 113584 ions, 2002 cycles completed
```

**Benchmark wydajnościowy (np. 10 cykli z pomiarem czasu):**
```bash
time ./eduPIC 10
```

**Pomiar diagnostyczny z generowaniem plików fizycznych:**
```bash
./eduPIC 5 m
```

---

## 3. Wersja II: Natywny Arch Linux

Na Arch Linuxie pracujesz bezpośrednio na natywnym kernelu Linuksa z najświeższym zestawem narzędzi GNU (GCC 14 / 15), co zapewnia bezkonkurencyjną wydajność i bezpośredni dostęp do sprzętowych liczników wydajności procesora.

### 3.1 Wymagania wstępne i instalacja pakietów
W terminalu Archa wykonaj:

```bash
sudo pacman -Syu --needed base-devel gcc make python perf linux-tools
```

### 3.2 Odblokowanie liczników sprzętowych `perf` (Opcjonalne, zalecane)
Domyślnie Linux ogranicza dostęp zwykłym użytkownikom do zaawansowanych liczników CPU:
```bash
sudo sysctl kernel.perf_event_paranoid=-1
```
*(Aby zmiana była trwała, dodaj wpis `kernel.perf_event_paranoid = -1` do pliku `/etc/sysctl.d/perf.conf`).*

---

### 3.3 Krok po kroku: Kompilacja i uruchomienie na Archu

#### Krok 1: Przejście do repozytorium
```bash
cd ~/GoPIC/C/experimental
```

#### Krok 2: Kompilacja z natywną mikroarchitekturą
Możesz skompilować standardowym `make`:
```bash
make clean && make
```
Lub wymusić flagę `-march=native`, która automatycznie włącza wszystkie wektory obsługiwane przez Twój procesor (AVX2, FMA, a na procesorach Zen4 / nowszych Intelach także AVX-512):
```bash
g++ -std=c++17 -O3 -march=native -fno-math-errno eduPIC.cc -o eduPIC -lm
```

#### Krok 3: Podpięcie Golden Recordu
```bash
cp ../../golden_record/picdata.bin ./picdata.bin
```

#### Krok 4: Uruchomienie z zaawansowaną telemetrią `perf`
Na Archu możesz zmierzyć dokładny koszt instrukcji i cykli procesora:
```bash
perf stat -d ./eduPIC 5
```
*Przykładowe metryki wyjściowe:*
* **`instructions`** oraz **`cycles`** — wyznaczają wskaźnik **IPC** (*Instructions Per Cycle*).
* **`branches`** i **`branch-misses`** — pokazują procent nietrafionych skoków w pętli cząstek.
* **`L1-dcache-load-misses`** — weryfikują efektywność pamięci podręcznej L1.

---

## 4. Lokalne Profilowanie i Zbieranie Logów `perf` (`run_local_perf.sh`)

Aby natychmiast sprawdzić, jak wprowadzona optymalizacja wpłynęła na sprzętową charakterystykę programu (spadek cykli zegara, wzrost IPC, usunięcie wąskich gardeł w funkcjach matematycznych), przygotowano zautomatyzowany skrypt:
`C/experimental/run_local_perf.sh`.

### 4.1 Co wykonuje skrypt?
1. **Kompilacja z symbolami debugowania:** Buduje `eduPIC` z flagami `-fno-omit-frame-pointer -g`, co umożliwia narzędziu `perf` wierne odtworzenie całego drzewa wywołań funkcji (call-graph) bez spowalniania optymalizacji `-O3`.
2. **Podpięcie Golden Record:** Zapewnia realistyczny stan początkowy (~108 tys. cząstek).
3. **Telemetria liczników sprzętowych (`perf stat`):** Mierzy:
   * `cycles` i `instructions` (wylicza **IPC — Instructions Per Cycle**),
   * `branches` i `branch-misses` (odsetek błędnie przewidzianych skoków warunkowych),
   * `task-clock` (dokładny czas CPU).
4. **Profilowanie próbkowane stosu (`perf record -F 99 -g`):** Zlicza próbki na poziomie instrukcji asemblera i funkcji.
5. **Generowanie raportu tekstowego (`perf report --stdio`):** Listuje funkcje o najwyższym udziale w czasie wykonania (Top Hotspots).
6. **Archiwizacja wyników:** Każdy przebieg zapisywany jest w osobnym katalogu ze stemplem czasowym (np. `perf_results_20260909_180944/`), co pozwala łatwo porównywać logi (`diff`) między kolejnymi krokami optymalizacji.

### 4.2 Uruchomienie skryptu

```bash
cd /mnt/c/Users/E14/Documents/GitHub/GoPIC/C/experimental
chmod +x run_local_perf.sh

# Profilowanie 1 cyklu (szybka iteracja deweloperska ~10-12s):
./run_local_perf.sh 1

# Profilowanie 5 cykli w trybie pomiarowym (z diagnostyką fizyczną):
./run_local_perf.sh 5 m
```

### 4.3 Przykładowy wynik (Kod Bazowy Step 0)
```text
=== 3. Profilowanie sprzetowe (perf stat) na 1 cyklach ===
         40,942,652,367      cycles
        102,801,659,428      instructions              #    2.51  insn per cycle
            730,950,563      branches
              1,215,907      branch-misses             #    0.17% of all branches

-----------------------------------------------------------------
>> Top 15 najbardziej obciazajacych funkcji (Hotspots):
# Overhead  Command  Shared Object      Symbol
# ........  .......  .................  .......................................
     7.44%  eduPIC   libm.so.6          [.] __exp_finite
     6.89%  eduPIC   libm.so.6          [.] __atan2_finite
     5.07%  eduPIC   libm.so.6          [.] __pow_finite
     3.79%  eduPIC   eduPIC             [.] do_one_cycle
     2.85%  eduPIC   libm.so.6          [.] __cos_finite
     2.77%  eduPIC   libm.so.6          [.] __sin_finite
```
> [!TIP]
> **Dlaczego to jest kluczowe?** Powyższy log z kodu bazowego natychmiast dowodzi słuszności pierwszych zaplanowanych optymalizacji:
> * Ponad **22% całkowitego czasu procesora** marnowane jest w funkcjach matematycznych biblioteki `libm` (`exp`, `atan2`, `pow`, `cos`, `sin`).
> * Po wdrożeniu metody **Null-Collision** udział funkcji `__exp_finite` powinien spaść z **7.44% do 0.00%**, co natychmiast potwierdzi kolejny log z `perf`!

---

## 5. Weryfikacja Poprawności Numerycznej (Automatyczny Skrypt)

W katalogu `C/sequential/tests/` znajduje się narzędzie `compare_numeric.py`, które pozwala sprawdzić, czy zmodyfikowany kod nie spowodował dryfu fizycznego względem danych referencyjnych.

### Skrypt automatycznego testu weryfikacyjnego (`run_verify.sh`)
Skrypt znajduje się w katalogu `C/experimental/run_verify.sh`:

```bash
chmod +x run_verify.sh
./run_verify.sh
```

---

## 6. Ściągawka Poleceń (Cheat Sheet)

| Zadanie | Polecenie WSL (Ubuntu) / Arch Linux |
|:---|:---|
| **Kompilacja na czysto** | `make clean && make` |
| **Reset do stanu Golden Record** | `cp ../../golden_record/picdata.bin ./picdata.bin` |
| **Szybki przebieg testowy (1 cykl)** | `./eduPIC 1` |
| **Benchmark (10 cykli z pomiarem czasu)** | `time ./eduPIC 10` |
| **Pełna diagnostyka (5 cykli + wykresy)** | `./eduPIC 5 m` |
| **Profilowanie lokalne perf stat & report** | `./run_local_perf.sh 1` |
| **Weryfikacja wygenerowanych danych** | `./run_verify.sh` |
| **Wyczyszczenie plików wyjściowych** | `rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *.xt` |
