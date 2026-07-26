# Lekcja 4: Inicjalizacja — jak zaczynamy symulację

> **Poprzednia lekcja:** [Lekcja 3 — Generator liczb losowych](lekcja_03.md)
> **Następna lekcja:** [Lekcja 5 — Depozycja gęstości](lekcja_05.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jak program przyjmuje argumenty z linii komend
- Co robi `initParticles()` i dlaczego zaczynamy od 1000 cząstek
- Jak działa zapis i odczyt stanu symulacji (`picdata.bin`)
- Jaka jest różnica między uruchomieniem `./GoPIC 0` a `./GoPIC 100`

---

## 1. Punkt wejścia — funkcja `main()`

```go
// main.go, linia 1216

func main() {
    fmt.Println(">> GoPIC: starting...")

    // Sprawdź argumenty linii komend
    if len(os.Args) == 1 {
        fmt.Println(">> GoPIC: error = need starting_cycle argument")
        os.Exit(1)
    }

    arg1 = atoi(os.Args[1])   // pierwszy argument: liczba cykli (lub 0 dla init)

    if len(os.Args) > 2 && strings.TrimSpace(os.Args[2]) == "m" {
        measurement_mode = true   // tryb pomiarowy włączony
    }

    // Przygotowanie przekrojów czynnych
    setElectronCrossSectionsAr()
    setIonCrossSectionsAr()
    calcTotalCrossSections()

    datafile = openAppend("conv.dat")   // plik zbieżności
    defer datafile.Close()

    if arg1 == 0 {
        // ← INICJALIZACJA (cykl zerowy)
        initParticles(N_INIT)
        doOneCycle()
        cycles_done = 1
    } else {
        // ← KONTYNUACJA z pliku
        no_of_cycles = arg1
        loadParticleData()
        for cycle = cycles_done + 1; cycle <= cycles_done+no_of_cycles; cycle++ {
            doOneCycle()
        }
        cycles_done += no_of_cycles
    }

    saveParticleData()
    if measurement_mode {
        checkAndSaveInfo()
    }
}
```

### Jak uruchamiać program?

```bash
# Krok 1: inicjalizacja (pierwsze uruchomienie)
./GoPIC 0

# Krok 2: uruchom 100 cykli (kontynuacja)
./GoPIC 100

# Krok 3: uruchom 500 cykli z włączonymi pomiarami
./GoPIC 500 m
```

Symulacja jest **dwufazowa**:
1. **Inicjalizacja (`arg1 == 0`)**: Umieszczamy losowe cząstki, robimy 1 cykl.
   Zapisujemy stan do `picdata.bin`.
2. **Produkcja (`arg1 > 0`)**: Wczytujemy stan z `picdata.bin`, uruchamiamy N cykli.

Dlaczego taka architektura? Plazma potrzebuje wielu cykli RF żeby się "ustabilizować"
(osiągnąć stan stacjonarny). Możemy przerywać i kontynuować.

---

## 2. Inicjalizacja cząstek — `initParticles()`

```go
// main.go, linia 364–377

func initParticles(nseed int) {
    for i := 0; i < nseed; i++ {
        x_e[i] = L * R01()   // losowa pozycja elektronu w [0, L]
        vx_e[i] = 0          // zerowe prędkości startowe
        vy_e[i] = 0
        vz_e[i] = 0

        x_i[i] = L * R01()   // losowa pozycja jonu w [0, L]
        vx_i[i] = 0
        vy_i[i] = 0
        vz_i[i] = 0
    }
    N_e = nseed   // N_INIT = 1000 elektronów aktywnych
    N_i = nseed   // N_INIT = 1000 jonów aktywnych
}
```

### Dlaczego zerowe prędkości?

Na początku symulacji nie wiemy jak cząstki będą się poruszać — plazma jeszcze nie
istnieje. Zaczynamy od najprostszego założenia: wszystkie cząstki stoją w miejscu.
Po kilku cyklach RF pole elektryczne i zderzenia nadadzą im odpowiednie prędkości.

### Dlaczego tylko 1000 cząstek?

`N_INIT = 1000` to tylko ziarno. Po kilku cyklach jonizacja tworzy nowe pary e⁻/Ar⁺,
a absorpcja na ścianach usuwa inne. Symulacja sama dochodzi do naturalnej liczby
cząstek. Zbyt mało ziarn → wolna inicjalizacja; zbyt dużo → zbędny koszt.

---

## 3. Zapis i odczyt stanu — format binarny

### Zapis: `saveParticleData()`

```go
// main.go, linia 897–921

func saveParticleData() {
    f, _ := os.Create("picdata.bin")   // nadpisuje plik!
    buf := bufio.NewWriter(f)

    writeFloat64(buf, Time)                // czas globalny
    writeFloat64(buf, float64(cycles_done)) // liczba ukończonych cykli
    writeFloat64(buf, float64(N_e))         // liczba elektronów
    writeFloat64Slice(buf, x_e[:N_e])       // pozycje elektronów
    writeFloat64Slice(buf, vx_e[:N_e])      // prędkości vx
    writeFloat64Slice(buf, vy_e[:N_e])      // prędkości vy
    writeFloat64Slice(buf, vz_e[:N_e])      // prędkości vz
    writeFloat64(buf, float64(N_i))         // liczba jonów
    writeFloat64Slice(buf, x_i[:N_i])       // ... i to samo dla jonów
    writeFloat64Slice(buf, vx_i[:N_i])
    writeFloat64Slice(buf, vy_i[:N_i])
    writeFloat64Slice(buf, vz_i[:N_i])
}
```

### Format pliku `picdata.bin`

```
[Time: 8 bajtów float64]
[cycles_done: 8 bajtów float64]
[N_e: 8 bajtów float64]
[x_e[0]: 8 bajtów] [x_e[1]: 8 bajtów] ... [x_e[N_e-1]: 8 bajtów]
[vx_e[0]] ... [vx_e[N_e-1]]
[vy_e[0]] ... [vy_e[N_e-1]]
[vz_e[0]] ... [vz_e[N_e-1]]
[N_i: 8 bajtów float64]
[x_i[0]] ... [x_i[N_i-1]]
[vx_i[0]] ... [vx_i[N_i-1]]
[vy_i[0]] ... [vy_i[N_i-1]]
[vz_i[0]] ... [vz_i[N_i-1]]
```

Dane są w formacie **little-endian binary** — to ten sam format co C++ na x86/x64.
Dzięki temu pliki `picdata.bin` są **kompatybilne między implementacjami** (C++, Python, Go).

### Dlaczego binary, a nie tekst?

- Plik z 50 000 cząstkami w formacie binarnym: ~3 MB
- Plik z 50 000 cząstkami w formacie tekstowym: ~15 MB
- Zapis binarny jest ~10× szybszy

### Odczyt: `loadParticleData()`

```go
func loadParticleData() {
    f, err := os.Open("picdata.bin")
    if err != nil {
        fmt.Println(">> eduPIC: ERROR: No particle data file found")
        os.Exit(0)
    }
    buf := bufio.NewReader(f)

    Time = readFloat64(buf)
    cycles_done = int(readFloat64(buf))
    N_e = int(readFloat64(buf))
    readFloat64Slice(buf, x_e[:N_e])   // odczytaj dokładnie N_e wartości
    // ... itd.
}
```

Odczyt jest lustrzanym odbiciem zapisu — dane są czytane w tej samej kolejności.

---

## 4. Tryb pomiarowy (`measurement_mode`)

```go
measurement_mode = false  // domyślnie: brak pomiarów
```

Gdy uruchomisz z argumentem `m`:
```bash
./GoPIC 500 m
```

Flaga `measurement_mode = true` aktywuje dodatkowe obliczenia w krokach 3, 4, 9:
- Zbieranie EEPF (rozkład energii elektronów)
- Zbieranie rozkładów XT (przestrzenno-czasowych)
- Generowanie raportu `info.txt`

Bez tego trybu symulacja jest **szybsza** — nie liczy diagnostyk. Typowy workflow:

```bash
./GoPIC 0           # inicjalizacja
./GoPIC 200         # 200 cykli "rozgrzewkowych" (bez pomiarów)
./GoPIC 500 m       # 500 cykli z pomiarem (stan stacjonarny)
```

---

## 5. Plik zbieżności `conv.dat`

```go
datafile = openAppend("conv.dat")   // otwórz do dopisywania
```

Co krok `doOneCycle()`, na końcu jest:
```go
fmt.Fprintf(datafile, "%8d  %8d  %8d\n", cycle, N_e, N_i)
```

Przykładowa zawartość `conv.dat`:
```
       1      1043      1038
       2      1089      1085
       3      1152      1148
     ...
     200      8734      8731
```

Kolumny: numer cyklu, liczba elektronów, liczba jonów. Możemy obserwować jak plazma
"rośnie" z 1000 do stabilnej wartości (~10 000).

---

## 6. Ochrona przed nadpisaniem

```go
if arg1 == 0 {
    if fileExists("picdata.bin") {
        fmt.Println(">> GoPIC: Warning: Data from previous calculation are detected.")
        os.Exit(0)   // zatrzymaj program!
    }
    // ...
}
```

Program **odmawia inicjalizacji**, jeśli `picdata.bin` już istnieje. To ochrona przed
przypadkowym zniszczeniem długiej symulacji. Żeby zacząć od nowa, musisz ręcznie
usunąć stare pliki:

```bash
rm picdata.bin conv.dat
./GoPIC 0
```

---

## Podsumowanie

| Krok | Polecenie | Co się dzieje |
|:-----|:----------|:-------------|
| Init | `./GoPIC 0` | Losowe cząstki → 1 cykl → zapis do `picdata.bin` |
| Produkcja | `./GoPIC N` | Wczytaj → N cykli → zapis do `picdata.bin` |
| Pomiary | `./GoPIC N m` | Jak wyżej + diagnostyki → `info.txt`, `*.dat` |

### Co możesz zmienić?

| Zmiana | Gdzie |
|:-------|:------|
| Liczba cząstek startowych | `N_INIT` (stała, linia ~45) |
| Niestandardowy format zapisu | `saveParticleData()` / `loadParticleData()` |
| Wydruk co ile kroków | `if (t % 1000) == 0` w `doOneCycle()` |

---

**Następna lekcja:** [Lekcja 5 — Depozycja gęstości (interpolacja liniowa)](lekcja_05.md)
