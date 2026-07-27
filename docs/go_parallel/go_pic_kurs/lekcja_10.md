# Lekcja 10: Diagnostyki, dane wyjściowe i jak uruchamiać program

> **Poprzednia lekcja:** [Lekcja 9 — Zderzenia Monte Carlo](lekcja_09.md)
> **To jest ostatnia lekcja kursu.**

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co zawiera każdy plik wyjściowy symulacji i jak go interpretować
- Jakie są warunki stabilności i dlaczego ich pilnujemy
- Jak uruchomić program krok po kroku
- Jak zbudować symulację i co zrobić gdy coś pójdzie nie tak
- Jak bezpiecznie wprowadzać modyfikacje do kodu

---

## 1. Pliki wyjściowe symulacji

| Plik | Kiedy tworzony | Zawartość |
|:-----|:--------------|:---------|
| `picdata.bin` | Po każdym uruchomieniu | Stan cząstek (x, vx, vy, vz dla e⁻ i Ar⁺) |
| `conv.dat` | Po każdym cyklu | Numer cyklu, N_e, N_i |
| `density.dat` | Tryb `m` | Uśrednione profile gęstości n_e(x), n_i(x) |
| `eepf.dat` | Tryb `m` | Rozkład energii elektronów w centrum |
| `ifed.dat` | Tryb `m` | Rozkład energii jonów na elektrodach |
| `info.txt` | Tryb `m` | Raport stabilności i diagnostyki |
| `pot_xt.dat` | Tryb `m` | Rozkład potencjału (przestrzeń × czas) |
| `efield_xt.dat` | Tryb `m` | Rozkład pola E (przestrzeń × czas) |
| `ne_xt.dat` | Tryb `m` | Gęstość elektronów 2D |
| `ni_xt.dat` | Tryb `m` | Gęstość jonów 2D |
| `je_xt.dat` | Tryb `m` | Gęstość prądu elektronów 2D |
| `ji_xt.dat` | Tryb `m` | Gęstość prądu jonów 2D |
| `powere_xt.dat` | Tryb `m` | Gęstość mocy elektronów 2D |
| `poweri_xt.dat` | Tryb `m` | Gęstość mocy jonów 2D |

---

## 2. Krok 9: Zbieranie danych XT

```go
// main.go, linia 850–861

func step9_collect_xt_data(t_index int) {
    if !measurement_mode {
        return   // pomiń jeśli nie ma trybu pomiarowego
    }

    for p := 0; p < N_G; p++ {
        pot_xt[p][t_index]    += pot[p]        // potencjał
        efield_xt[p][t_index] += efield[p]     // pole E
        ne_xt[p][t_index]     += e_density[p]  // gęstość e⁻
        ni_xt[p][t_index]     += i_density[p]  // gęstość Ar⁺
    }
}
```

`t_index = t / N_BIN` — 4000 kroków jest dzielone na 200 przedziałów czasowych
(N_XT=200, N_BIN=20). Wynik to siatka **przestrzeń × czas**: 400 × 200 wartości.

### Co to jest XT?

XT (space-Time) = rozkład 2D. Oś x = pozycja w szczelinie (0..L), oś y = czas w cyklu RF (0..T).

```
T ↑                                      ← jedno RF pętla
  |  [400 punktów przestrzennych] ...
  |  [400 punktów przestrzennych] ...
  |  ...   (200 przedziałów czasowych)
  +——————————————————————————————————→ x: 0 do L
```

---

## 3. Normalizacja i zapis danych XT: `normAllXT()`

```go
// main.go, linia 1036–1074

func normAllXT() {
    f1 = float64(N_XT) / float64(no_of_cycles*N_T)
    f2 = WEIGHT / (ELECTRODE_AREA * DX) / (float64(no_of_cycles) * (PERIOD / float64(N_XT)))

    for i := 0; i < N_G; i++ {
        for j := 0; j < N_XT; j++ {
            pot_xt[i][j]   *= f1   // uśrednij przez cykle i kroki
            efield_xt[i][j] *= f1
            ne_xt[i][j]    *= f1
            ni_xt[i][j]    *= f1

            // Prąd z prędkości i gęstości
            if counter_e_xt[i][j] > 0 {
                ue_xt[i][j]    = ue_xt[i][j] / counter_e_xt[i][j]  // średnia prędkość
                je_xt[i][j]    = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE  // j = -n×e×u
                meanee_xt[i][j] = meanee_xt[i][j] / counter_e_xt[i][j]
            }

            // Moc: P = j × E
            powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j]
            poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j]
        }
    }
}
```

**f1** = czynnik normalizacji: wynik / (liczba_cykli × N_T/N_XT) = uśrednienie w czasie.

**Gęstość prądu**: `j_e = -n_e × e × u_e` (minus bo elektrony mają ładunek ujemny).

**Moc pochłaniana**: `P = j × E` [W/m³] — moc absorbowana przez cząstki od pola.

---

## 4. Raport stabilności: `checkAndSaveInfo()`

To najważniejsza funkcja diagnostyczna. Sprawdza **warunki stabilności** PIC:

```go
// main.go, linia 1094–1207

func checkAndSaveInfo() {
    density  = cumul_e_density[N_G/2] / float64(no_of_cycles) / float64(N_T)
    plas_freq = E_CHARGE × √(density/EPSILON0/E_MASS)   // częstość plazmowa ωₚₑ
    debye_length = √(EPSILON0 × kT / density) / E_CHARGE // długość Debye'a λ_D

    // Warunek 1: Krok czasowy vs częstość plazmowa
    c = plas_freq × DT_E
    // → musi być < 0.20

    // Warunek 2: Rozmiar siatki vs długość Debye'a
    c = DX / debye_length
    // → musi być < 1.00

    // Warunek 3: Kolizje elektronów
    c = maxElectronCollFreq() × DT_E
    // → musi być < 0.05

    // Warunek 4: Kolizje jonów
    c = maxIonCollFreq() × DT_I
    // → musi być < 0.05
}
```

### Warunki stabilności PIC — co i dlaczego

| Warunek | Wyrażenie | Limit | Co się stanie jeśli naruszone |
|:--------|:----------|:------|:------------------------------|
| Krok czasowy | `ωₚₑ × Δt_e` | < 0.20 | Elektrony "omijają" oscylacje plazmowe |
| Rozdzielczość siatki | `Δx / λ_D` | < 1.00 | Nierozwiązane struktury plazmowe |
| Zderzenia e⁻ | `ν_e,max × Δt_e` | < 0.05 | Zbyt wiele zderzeń na krok — p_coll ≠ prawidłowe |
| Zderzenia Ar⁺ | `ν_i,max × Δt_i` | < 0.05 | Jw. dla jonów |

Jeśli jakiś warunek jest naruszony, `info.txt` zawiera ostrzeżenie:
```
** STABILITY AND ACCURACY CONDITION(S) VIOLATED **
```

---

## 5. Pliki danych — format i interpretacja

### `density.dat`

```
# x[m]    n_e[1/m³]    n_i[1/m³]
0.00000   1.23e+14     1.24e+14
0.00006   4.56e+14     4.57e+14
...
0.02500   1.23e+14     1.24e+14
```

400 wierszy (jeden na węzeł siatki). Uśrednione gęstości przez wszystkie cykle i kroki.

### `eepf.dat`

```
# energia[eV]   f(ε) [eV^{-3/2}]
0.025           1.23e-2
0.075           2.34e-2
...
```

EEPF znormalizowana: `eepf[i] / (h × √(energy))`, gdzie `h = Σ eepf[i] × DE_EEPF`.
Wykres log(EEPF) vs ε powinien być linią prostą dla rozkładu Maxwella.

### `ifed.dat`

```
# energia[eV]   f_pow   f_gnd
0.5             0.0023  0.0035
1.5             0.0156  0.0212
...
```

Dwie kolumny: IFED dla lewej i prawej elektrody, znormalizowane do 1.

### Pliki `*_xt.dat`

Format: macierz 400 × 200, wartości rozdzielone spacją, jeden wiersz = jedna pozycja siatki.
Wizualizacja: heatmapa (np. matplotlib `imshow`).

---

## 6. Jak uruchomić symulację — krok po kroku

### Kompilacja

```bash
cd /home/oliwier/Dev/GoPIC/Go/naive_version
go build -o GoPIC main.go
```

### Typowy workflow

```bash
# Krok 1: Inicjalizacja (tylko raz!)
./GoPIC 0
# → tworzy picdata.bin (1000 losowych cząstek, 1 cykl)
# → tworzy/dopenduje conv.dat

# Krok 2: Rozgrzewka (daj plazmie czas na stabilizację)
./GoPIC 200
# → 200 cykli RF ≈ 200 × 73.7 ns ≈ 14.7 μs symulowanego czasu

# Krok 3: Pomiar (tryb m)
./GoPIC 500 m
# → 500 cykli z diagnostykami
# → generuje wszystkie pliki .dat i info.txt

# Sprawdź stabilność:
cat info.txt

# Wizualizacja (przykład w Pythonie):
python3 -c "
import numpy as np; import matplotlib.pyplot as plt
d = np.loadtxt('density.dat')
plt.plot(d[:,0]*1000, d[:,1], label='e-')
plt.plot(d[:,0]*1000, d[:,2], label='Ar+')
plt.xlabel('x [mm]'); plt.ylabel('gęstość [1/m³]')
plt.legend(); plt.show()
"
```

### Czyszczenie i restart

```bash
rm picdata.bin conv.dat *.dat info.txt
./GoPIC 0   # nowa inicjalizacja
```

---

## 7. Jak bezpiecznie modyfikować kod

### Strategia: małe zmiany, częste testy

1. **Zrób kopię zapasową** oryginalnego `main.go` przed zmianami:
   ```bash
   cp main.go main.go.backup
   ```

2. **Wprowadź jedną zmianę** i sprawdź czy kompiluje:
   ```bash
   go build -o GoPIC main.go && echo "OK"
   ```

3. **Uruchom inicjalizację i kilka cykli** — sprawdź czy N_e i N_i rosną sensownie:
   ```bash
   rm picdata.bin conv.dat
   ./GoPIC 0
   ./GoPIC 10
   cat conv.dat
   ```

4. **Sprawdź stabilność** po kilkuset cyklach:
   ```bash
   ./GoPIC 200 m
   cat info.txt
   ```

### Typowe miejsca modyfikacji

| Co chcesz zmienić | Gdzie w kodzie | Co sprawdzić |
|:------------------|:--------------|:-------------|
| Napięcie RF | `VOLTAGE` (linia ~39) | Czy stabilność OK? |
| Ciśnienie | `PRESSURE` (linia ~41) | Czy N_e stabilne? |
| Rozmiar siatki | `N_G`, `N_T` | Warunki stabilności! |
| Inny gaz | `setElectronCrossSectionsAr()` + `AR_MASS` + progi EXC/ION | N_e musi być niezerowe |
| Emisja wtórna | `step5_check_boundaries_electrons()` | N_e nie może eksplodować |
| Dodatkowa diagnostyka | Nowa tablica + zbieranie w step9 | Nie zapomnij zainicjalizować |

### Częste błędy i jak je diagnozować

| Objaw | Możliwa przyczyna | Jak sprawdzić |
|:------|:------------------|:-------------|
| `panic: index out of range` | Cząstka poza siatką (x<0 lub x>L) | Dodaj print przed depozycją |
| N_e rośnie bez ograniczeń | Jonizacja >> absorpcja | Sprawdź ciśnienie i napięcie |
| N_e = 0 po kilku cyklach | Brak jonizacji lub zbyt silna absorpcja | Sprawdź progi E_ION_TH |
| Warunek stabilności naruszony | Zbyt mało punktów siatki lub zbyt duży DT | Zwiększ N_G lub N_T |
| `info.txt` nietworzony | Brak flagi `m` | Dodaj `m` jako 2. argument |

---

## 8. Podsumowanie całego kursu

Przeszedłeś przez **cały algorytm PIC/MCC**:

```
1. INIT:    Losowe cząstki w [0, L], zerowe prędkości
2. CYKL RF: 4000 kroków × 9 funkcji
   1a. step1a: e_density ← interpolacja liniowa cząstek na siatkę (ZAWSZE)
   1b. step1b: i_density ← to samo dla jonów (co N_SUB=20 kroków)
    2. step2:  rho = e(n_i-n_e) → solvePoisson → E-field
    3. step3:  Interpoluj E na e⁻ → vx_e -= E×FACTOR_E → x_e += vx_e×DT_E
    4. step4:  To samo dla Ar⁺ (co N_SUB) → vx_i += E×FACTOR_I → x_i += vx_i×DT_I
    5. step5:  x<0 lub x>L → usuń e⁻ (swap z ostatnim)
    6. step6:  To samo dla Ar⁺ (co N_SUB) + zbierz IFED
    7. step7:  p_coll → zderzenie e⁻/Ar (elastyczne/wzbudzenie/jonizacja)
    8. step8:  To samo dla Ar⁺ (co N_SUB)
    9. step9:  Zbieraj diagnostyki XT (w trybie m)
3. ZAPIS: picdata.bin + pliki .dat (w trybie m)
```

### Klucze do zapamiętania

1. **Boundary correction ×2** w depozycji gęstości — nigdy nie pomijaj
2. **Minus dla e⁻, plus dla Ar⁺** w aktualizacji prędkości — od znaku ładunku
3. **Subcycling**: kroki 1b, 4, 6, 8 → tylko gdy `t % N_SUB == 0`
4. **Swap z ostatnim** przy usuwaniu cząstek — O(1) bez przesuwania
5. **Warunki stabilności** w `info.txt` — zawsze sprawdź przed interpretacją wyników
6. **cumul_i_density akumuluje co krok** — nawet gdy i_density nie jest przeliczone

---

## Dalsze kroki

Po opanowaniu tego kodu, naturalnymi rozszerzeniami są:

1. **Wektoryzacja**: Przepisanie pętli na operacje SIMD lub goroutines
2. **Równoległość**: Podział cząstek między wątki Go (goroutines + mutex/channels)
3. **2D/3D**: Rozszerzenie siatki na dwa lub trzy wymiary (wymaga 2D/3D solvera Poissona)
4. **Inne gazy**: Zmiana wzorów przekrojów czynnych (np. N₂, He, Ne)
5. **Nowe procesy**: Emisja wtórna elektronów, reakcje chemiczne

---

**Koniec kursu.** Wróć do [spisu lekcji](README.md) jeśli potrzebujesz.

Kod źródłowy: [`Go/naive_version/main.go`](../../Go/naive_version/main.go)
