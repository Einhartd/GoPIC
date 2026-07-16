# Rozdział 5: Prawa Teoretyczne i Mierzenie Wydajności

Zrównoleglenie kodu zawsze wiąże się z dodatkowym kosztem – musimy zarządzać wątkami, synchronizować je i przesyłać dane. Aby ocenić, czy ten wysiłek przynosi korzyści, stosujemy miary wydajności oraz klasyczne prawa teoretyczne.

---

## 1. Przyspieszenie (Speedup) i Efektywność (Efficiency)

### Przyspieszenie ($S_p$)
Określa, ile razy szybciej wykonuje się program zrównoleglony na $p$ procesorach (rdzeniach) w porównaniu do najlepszego programu sekwencyjnego na jednym rdzeniu:

$$S_p = \frac{T_1}{T_p}$$

Gdzie:
*   $T_1$ – czas wykonania programu na jednym rdzeniu.
*   $T_p$ – czas wykonania programu na $p$ rdzeniach.
*   W idealnym świecie przyspieszenie byłoby liniowe: $S_p = p$ (np. na 4 rdzeniach kod działa 4 razy szybciej). W rzeczywistości rzadko udaje się to osiągnąć z powodu kosztów komunikacji i synchronizacji.

### Efektywność ($E_p$)
Określa, jak dobrze wykorzystujemy dostępne rdzenie:

$$E_p = \frac{S_p}{p}$$

*   Jeśli $E_p = 1$ (czyli 100%), wykorzystujesz zasoby idealnie.
*   Zazwyczaj efektywność spada wraz ze wzrostem liczby rdzeni, ponieważ wątki spędzają więcej czasu na czekaniu na blokadach lub przesyłaniu danych.

---

## 2. Prawo Amdahla – Granica Przyspieszenia

Prawo Amdahla (sformułowane w 1967 roku) opisuje maksymalne teoretyczne przyspieszenie programu, którego **część** nie może zostać zrównoleglona (część sekwencyjna).

Niech:
*   $P$ – ułamek kodu, który można zrównoleglić (np. obliczenia fizyczne, $P = 0.95$).
*   $1-P$ – ułamek kodu sekwencyjnego, którego nie da się zrównoleglić (np. wczytywanie pliku wejściowego, alokacja pamięci, zapis wyników, $1-P = 0.05$).
*   $N$ – liczba procesorów (rdzeni).

Wzór na maksymalne przyspieszenie wynosi:

$$S(N) = \frac{1}{(1-P) + \frac{P}{N}}$$

### Co z tego wynika?
Jeśli $N$ dąży do nieskończoności (mamy nieskończenie wiele rdzeni), składnik $\frac{P}{N}$ dąży do zera. Wzór upraszcza się do:

$$S(\infty) = \frac{1}{1-P}$$

Dla kodu, który w 95% da się zrównoleglić ($P = 0.95$, część sekwencyjna to 5%), maksymalne możliwe przyspieszenie na dowolnej liczbie rdzeni wynosi:

$$S(\infty) = \frac{1}{0.05} = 20$$

Niezależnie od tego, czy użyjesz 32, 100 czy 10 000 rdzeni, Twój program nigdy nie zadziała szybciej niż 20-krotnie!
> [!IMPORTANT]
> Prawo Amdahla uczy nas, że aby przyspieszyć program, musimy skupić się na minimalizowaniu części sekwencyjnej (np. zoptymalizować wczytywanie i zapis plików), ponieważ to ona bardzo szybko staje się wąskim gardłem.

---

## 3. Prawo Gustafsona – Perspektywa HPC

Prawo Amdahla zakłada, że rozmiar problemu obliczeniowego (np. liczba cząstek w symulacji eduPIC) jest stały. W High-Performance Computing (HPC) zazwyczaj postępujemy inaczej: mając do dyspozycji większy superkomputer, nie chcemy liczyć tego samego problemu szybciej, ale chcemy **policzyć znacznie większy, dokładniejszy problem w tym samym czasie**.

Prawo Gustafsona (1988) formułuje skalowane przyspieszenie:

$$S_{scaled}(N) = N - (1-P)(N-1)$$

Gdzie:
*   $N$ – liczba procesorów.
*   $1-P$ – sekwencyjna część czasu działania na systemie równoległym.
*   Według Prawa Gustafsona przyspieszenie skaluje się liniowo wraz ze wzrostem liczby procesorów, o ile proporcjonalnie zwiększamy rozmiar danych wejściowych. To daje zielone światło dla budowy superkomputerów z milionami rdzeni.

---

## 4. Zrównoważenie Obciążenia (Load Balancing)

Nawet jeśli cały algorytm jest równoległy, program może działać wolno, jeśli jeden z wątków dostanie znacznie więcej pracy niż pozostałe. Wszystkie wątki będą musiały czekać na tego najwolniejszego w punkcie bariery (`JOIN`).

*   **Statyczny podział pracy (Static Load Balancing)**: Dzielimy dane równo na początku (np. wątek 1 dostaje cząstki o indeksach 0-999, wątek 2 1000-1999). Działa świetnie, jeśli czas obliczeń dla każdej cząstki jest taki sam.
*   **Dynamiczny podział pracy (Dynamic Load Balancing / Work Stealing)**: Wątki pobierają zadania z centralnej kolejki w miarę kończenia poprzednich prac. Zapobiega to sytuacji, w której jeden rdzeń stoi bezczynnie, podczas gdy drugi wykonuje trudniejsze obliczenia.

---

## Polecana literatura i źródła zewnętrzne:
*   **Artykuł**: John L. Gustafson (1988) – *„Reevaluating Amdahl's Law”*.
*   **Podręcznik**: *„Introduction to Parallel Computing”* Ananth Grama, Anshul Gupta, George Karypis, Vipin Kumar – Rozdział 5.
