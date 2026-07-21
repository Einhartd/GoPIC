# Paradygmaty Współbieżności w Go a Nowe Myślenie o Symulacjach PIC

Tradycyjne programowanie równoległe (np. OpenMP w C++) zmusza nas do myślenia w kategoriach **podziału danych (Data Partitioning)** i **barier synchronizacyjnych**. Nasz kod jest liniową sekwencją kroków: wykonujemy krok A, czekamy na barierze aż wszystkie wątki skończą, wykonujemy krok B, znów czekamy. 

Język Go i jego model współbieżności oparty na **CSP (Communicating Sequential Processes)** pozwalają całkowicie zmienić ten paradygmat. Zamiast dzielić pętle, możemy myśleć o symulacji jako o **sieci autonomicznych, komunikujących się ze sobą podmiotów**.

Poniżej przedstawiam analizę, jak gorutyny zmieniają myślenie o zrównoleglaniu i jakie nowe, potencjalnie lepsze paradygmaty obliczeniowe otwierają przed symulacjami Particle-in-Cell (PIC).

---

## 1. Zmiana Paradygmatu: Od "Blokowania Pamięci" do "Przepływu Komunikatów"

W C++ myślimy: *„Jak zrównoleglić pętlę cząstek, żeby wątki nie nadpisały tej samej komórki pamięci gęstości?”* (rozwiązanie: mutexy, atomics lub skomplikowane redukcje).

W Go możemy pomyśleć inaczej: *„Niech gęstość siatki będzie zarządzana przez jednego właściciela (gorutynę siatki). Inne gorutyny (cząstki) będą po prostu wysyłać do niego informacje o swojej pozycji przez kanał”*.

To eliminuje potrzebę stosowania jakichkolwiek blokad (`locks`). Stan jest bezpieczny, ponieważ każda zmienna ma tylko jednego właściciela (jedną gorutynę, która ma do niej prawo zapisu). Pozostałe komponenty komunikują się z nią za pomocą przesyłania kopii danych (komunikatów).

---

## 2. Paradygmat I: Dekompozycja Przestrzenna jako Sieć Gorutyn (Spatial Domain Decomposition)

W tradycyjnym podejściu dzielimy tablicę cząstek (dekompozycja cząstek). Jednak w rzeczywistym świecie fizycznym cząstki oddziałują ze sobą tylko lokalnie (w sąsiednich komórkach siatki).

Wykorzystując fakt, że gorutyny są niezwykle tanie (możemy ich stworzyć dziesiątki tysięcy), możemy zaprojektować symulację opartą na **dekompozycji przestrzennej**:

```
Siatka podzielona na regiony (subdomeny):
[ Region 0 ] <--- Kanał ---> [ Region 1 ] <--- Kanał ---> [ Region 2 ]
 (Gorutyna 0)                 (Gorutyna 1)                 (Gorutyna 2)
  Cząstki 0                    Cząstki 1                    Cząstki 2
```

### Jak to działa?
1.  Dzielimy obszar symulacji $0$ do $L$ na $K$ regionów.
2.  Tworzymy **jedną gorutynę na każdy region**. Każda gorutyna przechowuje w swojej lokalnej pamięci (slice) wyłącznie cząstki, które aktualnie znajdują się w jej obszarze fizycznym. **Nie ma globalnej tablicy cząstek!**
3.  Każda gorutyna liczy ruch i kolizje tylko dla swoich cząstek.
4.  **Komunikacja przez kanały**: Kiedy podczas kroku `Move` cząstka przekracza granicę fizyczną i wchodzi do sąsiedniego regionu, gorutyna regionu $i$ po prostu wysyła strukturę cząstki przez kanał do gorutyny regionu $i+1$.
5.  *Zaleta*: Całkowity brak globalnych barier. Gorutyny regionów pracują asynchronicznie. Informacje o polu elektrycznym są przekazywane lokalnie. Doskonała lokalność cache (wątki procesora obsługujące dany region mają w cache L1/L2 tylko lokalne cząstki i lokalny fragment siatki).

---

## 3. Paradygmat II: Potokowość Asynchroniczna (Pipeline Parallelism & Out-of-Order PIC)

Klasyczny cykl PIC/MCC jest ściśle synchroniczny:
$$\text{Depozycja} \rightarrow \text{Poisson} \rightarrow \text{Move} \rightarrow \text{Granice} \rightarrow \text{Zderzenia}$$
Jeśli krok `Move` na 128 rdzeniach trafi na opóźnienie pamięci (np. chybienie cache na jednym z rdzeni), wszystkie pozostałe 127 rdzeni stoi bezczynnie na barierze synchronizacyjnej, czekając na przejście do kroku `Poisson`.

Gorutyny pozwalają na wdrożenie **potokowości asynchronicznej (Asynchronous PIC)**:

```
[ Potok Obliczeniowy ]
Stage 1: Generator/Mover  --> [ Kanał cząstek ] --> Stage 2: Depozytor ładunku
                                                                  |
                                                                  v
Stage 4: Obsługa zderzeń  <-- [ Kanał pól E ]   <-- Stage 3: Solver Poissona
```

### Jak to działa?
1.  Każdy krok symulacji (Move, Depozycja, Poisson, Zderzenia) jest autonomicznym etapem potoku (osobną grupą gorutyn).
2.  Dane płyną między etapami strumieniowo za pomocą buforowanych kanałów.
3.  **Brak globalnego czasu kroku**: Możemy rozluźnić warunek czasowy. Podczas gdy etap zderzeń przetwarza cząstki dla kroku czasowego $t$, etap `Move` może już przetwarzać cząstki dla kroku $t+1$ przy użyciu lekko opóźnionego pola elektrycznego z kroku $t-1$.
4.  *Zaleta*: W klastrach HPC eliminuje to tzw. *jitter* (losowe mikrosekundowe opóźnienia systemu operacyjnego), które w klasycznym Fork-Join sumują się i drastycznie spowalniają obliczenia. Potok jest cały czas pełny, a rdzenie CPU pracują na 100% bez barier.

---

## 4. Paradygmat III: Cząstki jako Autonomiczni Aktorzy (Actor Model)

Skoro gorutyna kosztuje tylko 2-4 KB pamięci, na serwerze z 256 GB RAM możemy teoretycznie uruchomić **miliony gorutyn jednocześnie**.

Możemy pójść w stronę skrajną (koncepcyjną): **jedna gorutyna na każdą supercząstkę**.
*   Każda cząstka jest autonomicznym mikrorobotem (aktorem) posiadającym swoje współrzędne i prędkość.
*   Cząstka samodzielnie decyduje o swoim ruchu, a informacje o sile pobiera, wysyłając zapytanie do gorutyny siatki.
*   *Czy to jest wydajne?* W czystych obliczeniach numerycznych CPU-bound narzut na scheduler Go przy milionie gorutyn zredukowałby wydajność. Jest to jednak niesamowicie ciekawy paradygmat do symulacji systemów o bardzo skomplikowanych regułach indywidualnych cząstek (np. cząstki o zmiennej masie, z własną wewnętrzną chemią/stanami wzbudzenia), gdzie koszt podejmowania decyzji przez cząstkę jest wyższy niż koszt schedulera.

---

## 5. Podsumowanie: Jak gorutyny zmieniają myślenie?

| Cecha | Podejście tradycyjne (C++/OpenMP) | Podejście Go (CSP/Gorutyny) |
| :--- | :--- | :--- |
| **Model myślenia** | „Jak podzielić pętlę i zablokować pamięć” | „Jak podzielić zadanie na niezależne procesy komunikujące się kanałami” |
| **Synchronizacja** | Jawne bariery (Barrier) po każdym kroku | Asynchroniczny przepływ danych przez bufory kanałów |
| **Lokalność danych** | Globalne tablice, ryzyko fałszywego współdzielenia | Ścisła izolacja pamięci (własność gorutyny) |
| **Skalowalność** | Ograniczona Prawem Amdahla (koszt barier) | Wysoka dzięki eliminacji barier na rzecz potoków |
