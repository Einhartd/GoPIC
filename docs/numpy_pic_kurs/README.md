# Kurs: Implementacja PIC w NumPy — od pętli do macierzy

> **Cel kursu:** Zrozumieć jak kod symulacji PIC w czystym Pythonie zostaje
> przepisany na operacje wektorowe NumPy — i dlaczego to ma sens.
>
> **Dla kogo:** Student Pythona, który zna pętle i listy, ale nie zna NumPy.
>
> **Założenie:** Nie musisz znać fizyki plazmy — skupiamy się na transformacji kodu.

---

## Spis lekcji

| Nr | Temat | Plik |
|:---|:------|:-----|
| 1 | NumPy od zera — tablice, typy, operacje wektorowe | [lekcja_01.md](lekcja_01.md) |
| 2 | Struktura projektu i klasa SimulationState | [lekcja_02.md](lekcja_02.md) |
| 3 | Krok 1 — Depozycja gęstości: `np.add.at` vs pętla | [lekcja_03.md](lekcja_03.md) |
| 4 | Krok 2 — Solver Poissona: `scipy.linalg.solve_banded` | [lekcja_04.md](lekcja_04.md) |
| 5 | Krok 3 & 4 — Ruch cząstek: wektoryzacja Leapfroga | [lekcja_05.md](lekcja_05.md) |
| 6 | Krok 5 & 6 — Granice: boolean masking zamiast swap | [lekcja_06.md](lekcja_06.md) |
| 7 | Krok 7 & 8 — Zderzenia: `np.where` + pętla po ~5% | [lekcja_07.md](lekcja_07.md) |
| 8 | Krok 9 — Diagnostyki XT: slicowanie 2D macierzy | [lekcja_08.md](lekcja_08.md) |

---

## Jak czytać ten kurs?

- Zaczniemy od **Lekcji 1** — absolutne podstawy NumPy potrzebne w tym projekcie.
- Od **Lekcji 3** każda lekcja pokazuje jeden krok algorytmu w trzech wersjach:
  - Kod **natywny Python** (wersja referencyjna)
  - Kod **NumPy** (wersja zoptymalizowana)
  - Wyjaśnienie **co dokładnie robi każda operacja NumPy**
- Miej otwarte pliki obok siebie podczas czytania.

## Pliki projektu

| Plik | Rola |
|:-----|:-----|
| [`python/numpy_version/state.py`](../../python/numpy_version/state.py) | Klasa stanu symulacji (tablice NumPy) |
| [`python/numpy_version/simulation.py`](../../python/numpy_version/simulation.py) | Główna pętla + kroki 1–9 |
| [`python/numpy_version/poisson.py`](../../python/numpy_version/poisson.py) | Solver równania Poissona |
| [`python/numpy_version/collisions.py`](../../python/numpy_version/collisions.py) | Zderzenia cząstek (MCC) |
| [`python/numpy_version/constants.py`](../../python/numpy_version/constants.py) | Stałe fizyczne i parametry |
| [`python/native_version/simulation.py`](../../python/native_version/simulation.py) | Wersja referencyjna (czyste pętle) |
