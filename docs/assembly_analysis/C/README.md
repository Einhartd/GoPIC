# Analiza Asemblera i Wektoryzacji AMD EPYC Zen 4 (AVX-512) dla Kodu GoPIC

Katalog zawiera wygenerowany i wyizolowany kod asemblera dla każdej pojedynczej funkcji zoptymalizowany dla architektury **AMD Zen 4 (EPYC 9554 / `znver4`)** z pełnym zestawem instrukcji **AVX-512** oraz flagami kompilacji HPC:
`-O3 -march=znver4 -fopenmp -std=c++17 -ffunction-sections -fverbose-asm`

---

## 📁 Wyizolowane Pliki Asemblera Poszczególnych Funkcji ([`functions/`](./functions/))

| Krok / Moduł | Wygenerowany Plik Asemblera | Liczba Linii | Kluczowe Instrukcje / Opis |
|---|---|:---:|---|
| **Krok 3: Popychanie Elektronów** | [`step3_move_electrons_body.s`](./functions/step3_move_electrons_body.s) | 618 | 3x instrukcje FMA (`vfmadd132sd`, `vfnmadd213sd`), brak prefetch, rejestry `%xmm` |
| **Krok 4: Popychanie Jonów** | [`step4_move_ions_body.s`](./functions/step4_move_ions_body.s) | 427 | Subcycling, sprzętowe FMA (`vfmadd`), rejestry `%xmm` |
| **Krok 6: Granice Jonów & IFED** | [`step6_check_boundaries_ions_body.s`](./functions/step6_check_boundaries_ions_body.s) | 664 | Manualny chunking, branchless predykcja `__builtin_expect`, redukcja IFED |
| **Krok 7: Kolizje Elektronów** | [`step7_collisions_electrons_body.s`](./functions/step7_null_collision_zen4.s) | 770 | Niezależne losowanie dwumianowe, prywatny `thread_local MTgen` |
| **Krok 8: Kolizje Jonów** | [`step8_collision_ions_body.s`](./functions/step8_collision_ions_body.s) | 1202 | Równoległe losowanie MCC dla jonów Ar+ |
| **Zderzenia Elektronów (MCC)** | [`collision_electron.s`](./functions/collision_electron.s) | 1473 | Czysta algebra wektorowa bez `atan2/sin/cos/acos` (`sqrtsd`, `divsd`) |
| **Przekroje Czynne (Elektrony)** | [`set_electron_cross_sections_ar.s`](./functions/set_electron_cross_sections_ar.s) | 336 | Tablice przekrojów zderzeń z argonem |
| **Przekroje Czynne (Jony)** | [`set_ion_cross_sections_ar.s`](./functions/set_ion_cross_sections_ar.s) | 123 | Tablice przekrojów izotropowych i wymiany ładunku |
| **Parametry Null-Collision** | [`compute_null_collision_params.s`](./functions/compute_null_collision_params.s) | 174 | Prekalkulacja maksymalnych prawdopodobieństw $P^*$ |
| **Pętla Główna Cyklu RF** | [`do_one_cycle__clone___omp_fn_0.s`](./functions/do_one_cycle__clone___omp_fn_0.s) | 1339 | Główna trwała sekcja równoległa OpenMP (Kroki 1–9) |
| **Inicjalizacja Cząstek** | [`init.s`](./functions/init.s) | 435 | Losowanie jednorodne $1D3V$ |
| **Zapis Danych (Diagnostyka)** | [`save_particle_data.s`](./functions/save_particle_data.s) | 168 | Binarny zrzut stanu cząstek |
| **Odczyt Danych** | [`load_particle_data.s`](./functions/load_particle_data.s) | 329 | Wczytanie stanu cząstek do pamięci |
| **Diagnostyka Czasoprzestrzenna** | [`check_and_save_info.s`](./functions/check_and_save_info.s) | 1804 | Zapis macierzy XT oraz profili EEPF/IFED |

---

## 🔬 Główne Wnioski z Analizy Asemblera

### 1. Czysty, 18-instrukcyjny Potok w Kroku 3 (Popychanie)
Pętla Leap-Frog w [`step3_move_electrons_body.s`](./functions/step3_move_electrons_body.s) nie wykonuje żadnych zbędnych instrukcji prefetch ani skoków warunkowych. Wszystkie operacje są spięte w 3 sprzętowe instrukcje FMA:
```assembly
vfmadd132sd  %xmm1, %xmm3, %xmm0    # FMA: E_x = efield[p] + c2 * (efield[p+1] - efield[p])
vfnmadd213sd -8(%rcx), %xmm6, %xmm0  # FMA: v = vx_e - E_x * FACTOR_E
vfmadd132sd  %xmm5, %xmm2, %xmm0    # FMA: x_e = x_e + v * DT_E
```

### 2. Eliminacja Biblioteki Matematycznej `libm` w Kolizjach
W pliku [`collision_electron.s`](./functions/collision_electron.s) wyeliminowano wszystkie kosztowne wywołania `call atan2`, `call sin`, `call cos`, `call acos` na rzecz lokalnych instrukcji procesora `sqrtsd` i `divsd`.
