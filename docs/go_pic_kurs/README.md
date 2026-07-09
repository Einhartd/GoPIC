# Kurs: Symulacja PIC w języku Go

> **Cel kursu:** Zrozumieć kod symulacji plazmowej PIC/MCC w Go na tyle dobrze,
> by móc samodzielnie wprowadzać w nim zmiany.
>
> **Dla kogo:** Student informatyki bez doświadczenia z fizyką plazmy ani Go.

---

## Spis lekcji

| Nr | Temat | Plik |
|:---|:------|:-----|
| 1 | Mapa kodu — co jest gdzie i po co | [lekcja_01.md](lekcja_01.md) |
| 2 | Stałe i zmienne globalne — każda liczba ma sens | [lekcja_02.md](lekcja_02.md) |
| 3 | Generator liczb losowych i przekroje czynne | [lekcja_03.md](lekcja_03.md) |
| 4 | Inicjalizacja — jak zaczynamy symulację | [lekcja_04.md](lekcja_04.md) |
| 5 | Krok 1 — Depozycja gęstości (interpolacja liniowa) | [lekcja_05.md](lekcja_05.md) |
| 6 | Krok 2 — Solver Poissona (algorytm Thomasa) | [lekcja_06.md](lekcja_06.md) |
| 7 | Krok 3 & 4 — Ruch cząstek (schemat Leapfrog) | [lekcja_07.md](lekcja_07.md) |
| 8 | Krok 5 & 6 — Warunki brzegowe (absorpcja na elektrodach) | [lekcja_08.md](lekcja_08.md) |
| 9 | Krok 7 & 8 — Zderzenia Monte Carlo (MCC) | [lekcja_09.md](lekcja_09.md) |
| 10 | Diagnostyki, zapis danych i jak uruchamiać program | [lekcja_10.md](lekcja_10.md) |

---

## Jak czytać ten kurs?

- Czytaj lekcje **po kolei** — każda buduje na poprzedniej.
- Przy każdej lekcji miej otwarty plik [`main.go`](../../Go/naive_version/main.go) i śledź fragmenty kodu na bieżąco.
- Lekcje 5–9 to **serce algorytmu** — poświęć im najwięcej czasu.
- Lekcja 10 jest kluczowa, jeśli chcesz **uruchomić i zmodyfikować** symulację.

## Kod źródłowy

Cały kod kursu: [`Go/naive_version/main.go`](../../Go/naive_version/main.go)

Oryginalny kod C++ (wzorzec): [`eduPIC/C/eduPIC.cc`](../../eduPIC/C/eduPIC.cc)
