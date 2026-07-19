# Rozdział 2: Jak Działa Komputer „Od Kuchni” (Podstawy Sprzętowe)

Jako programiści często myślimy o pamięci RAM jako o wielkiej, jednolitej tablicy bajtów, do której dostęp zajmuje zawsze tyle samo czasu. W świecie programowania równoległego to uproszczenie jest niebezpieczne. Architektura sprzętowa procesora wielordzeniowego bezpośrednio decyduje o tym, jak szybko Twój kod będzie działał.

---

## 1. Rdzeń Fizyczny vs Rdzeń Logiczny (Hyper-Threading)

Kiedy kupujesz procesor posiadający np. 8 rdzeni i 16 wątków, system operacyjny widzi 16 procesorów logicznych.
*   **Rdzeń fizyczny (Physical Core)**: Samodzielna jednostka wykonawcza na krzemie, zawierająca własne jednostki ALU (Arytmetyczno-Logiczne), FPU (Zmiennoprzecinkowe) oraz rejestry.
*   **Rdzeń logiczny / Hyper-Threading (HT)**: Technologia pozwalająca jednemu rdzeniowi fizycznemu na naprzemienne wykonywanie instrukcji z dwóch różnych wątków. Rdzeń logiczny współdzieli większość fizycznych zasobów rdzenia głównego.
    > [!IMPORTANT]
    > Aktywowanie Hyper-Threadingu rzadko podwaja wydajność obliczeniową. W zadaniach mocno obciążających ALU/FPU (np. symulacje fizyczne) zysk z HT wynosi zazwyczaj jedynie 10-30%, ponieważ wątki logiczne czekają w kolejce na te same fizyczne zasoby wykonawcze.

---

## 2. Ściana Pamięci i Hierarchia Cache

Prędkość procesorów rosła znacznie szybciej niż prędkość pamięci RAM. Zjawisko to nazywamy **ścianą pamięci (Memory Wall)**. 
Odczyt danych z pamięci RAM trwa wieczność z perspektywy procesora – około **100-200 cykli zegara CPU**. Aby procesor nie stał bezczynnie, wprowadzono bardzo szybką, podręczną pamięć statyczną SRAM – **Cache**.

```
[  Rdzeń CPU  ] <--> L1 Cache (~4 cykle)
      |
[  Rdzeń CPU  ] <--> L2 Cache (~12 cykli)
      |
[ Wspólny L3 Cache ] (~40 cykli)
      |
[  Szyna Pamięci  ]
      |
[  Pamięć RAM  ] (~200 cykli)
```

### Linie Cache (Cache Lines)
Procesor nigdy nie pobiera z pamięci pojedynczego bajtu. Zawsze pobiera dane w paczkach o stałym rozmiarze, najczęściej **64 bajtów**, nazywanych **liniami cache (Cache Lines)**.
*   Jeśli odczytujesz `tablica[0]`, procesor automatycznie pobierze do pamięci cache całą linię zawierającą również `tablica[1]`, `tablica[2]` itd.
*   Zjawisko to nazywa się **lokalnością przestrzenną (Spatial Locality)**. Projektując algorytmy, powinieneś odczytywać dane sekwencyjnie (np. wiersz po wierszu macierzy, a nie kolumna po kolumnie), aby maksymalnie wykorzystać linie cache.

---

## 3. Koherencja Pamięci Cache (Cache Coherence)

Ponieważ każdy rdzeń CPU posiada własną, lokalną pamięć cache L1/L2, pojawia się problem: **co jeśli dwa rdzenie mają w swoim cache kopię tej samej zmiennej z pamięci RAM, a jeden z nich ją zmodyfikuje?**

```
Rdzeń 1 (Zmienia X = 5 na X = 10) ---> Lokalny Cache L1 (X = 10)
                                            | (Niezgodność!)
Rdzeń 2 (Chce odczytać X)      <--- Lokalny Cache L1 (X = 5)
```

Aby zapobiec chaosowi, procesory sprzętowo realizują protokoły koherencji cache. Najpopularniejszym z nich jest protokół **MESI**, w którym każda linia cache może znajdować się w jednym z 4 stanów:
1.  **M (Modified)**: Linia została zmodyfikowana lokalnie i różni się od zawartości RAM. Tylko ten cache ma aktualną wersję.
2.  **E (Exclusive)**: Linia jest identyczna z RAM i znajduje się *wyłącznie* w tym cache.
3.  **S (Shared)**: Linia jest identyczna z RAM i może znajdować się również w cache innych rdzeni.
4.  **I (Invalid)**: Linia jest nieaktualna (została zmodyfikowana przez inny rdzeń) i nie wolno z niej czytać.

### Koszt MESI
Kiedy Rdzeń 1 modyfikuje zmienną w stanie **Shared (S)**, procesor musi wysłać sygnał unieważnienia (Invalidation) przez szynę systemową do wszystkich pozostałych rdzeni. Rdzeń 2, próbując odczytać tę zmienną, napotka chybienie cache (Cache Miss) i musi pobrać zaktualizowaną linię.
> [!CAUTION]
> Częsta modyfikacja współdzielonych danych przez różne rdzenie powoduje ciągłe przesyłanie sygnałów unieważnienia i chybienia cache, co drastycznie spowalnia aplikację (szyna systemowa zostaje nasycona).

---

## 4. Architektura UMA vs NUMA

W nowoczesnych komputerach wieloprocesorowych (szczególnie na serwerach HPC) kontrolery pamięci są zintegrowane bezpośrednio w procesorach.

```
[  CPU 1  ] <---> Szybka lokalna szyna <---> [ Pamięć RAM (Lokalna) ]
    ^
    | Wolniejsza szyna (QPI / UPI / Infinity Fabric)
    v
[  CPU 2  ] <---> Szybka lokalna szyna <---> [ Pamięć RAM (Zdalna dla CPU 1) ]
```

*   **UMA (Uniform Memory Access)**: Czas dostępu do dowolnego adresu w pamięci RAM jest taki sam dla każdego procesora. Typowa dla komputerów PC.
*   **NUMA (Non-Uniform Memory Access)**: Pamięć RAM jest fizycznie podzielona na banki przypisane do konkretnych gniazd procesorów (NUMA Nodes).
    *   Dostęp do pamięci **lokalnej** (podłączonej bezpośrednio do gniazda procesora) jest bardzo szybki.
    *   Dostęp do pamięci **zdalnej** (obsługiwanej przez drugi procesor) wymaga przesłania danych przez szynę łączącą procesory, co trwa znacznie dłużej.

---

## 5. Podsumowanie dla Programisty
1.  **Struktury danych dopasowane do linii cache**: Zawsze staraj się organizować dane tak, aby były przetwarzane liniowo.
2.  **Świadomość NUMA**: Na serwerach obliczeniowych (HPC) system operacyjny powinien uruchamiać procesy i alokować ich pamięć w obrębie tego samego węzła NUMA. Zjawisko migracji wątków między procesorami niszczy wydajność.

---

## Polecana literatura i źródła zewnętrzne:
*   **Artykuł naukowy**: Ulrich Drepper – *„What Every Programmer Should Know About Memory”*.
*   **Książka**: *„Computer Architecture: A Quantitative Approach”* John L. Hennessy, David A. Patterson – Rozdział 5: *Thread-Level Parallelism*.
