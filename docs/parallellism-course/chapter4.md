# Rozdział 4: Problem Współdzielenia Pamięci (Synchronizacja)

Wątki w ramach jednego procesu współdzielą tę samą pamięć RAM. To ich największa zaleta (szybka komunikacja), ale także największe zagrożenie. Bez odpowiedniej kontroli dostępów do pamięci, program równoległy będzie zachowywał się nieprzewidywalnie.

---

## 1. Wyścig o Dane (Data Race) i Stan Wyścigu (Race Condition)

*   **Wyścig o Dane (Data Race)**: Sytuacja, w której co najmniej dwa wątki uzyskują dostęp do tej samej komórki pamięci w tym samym czasie, co najmniej jeden z tych dostępów jest zapisem, a wątki nie używają żadnej synchronizacji.
*   **Stan Wyścigu (Race Condition)**: Błąd logiczny w działaniu programu, w którym końcowy wynik zależy od kolejności lub czasu wykonania wątków przez scheduler systemu operacyjnego.

### Klasyczny przykład: Inkrementacja licznika (`counter++`)
Operacja `counter++` w języku wysokiego poziomu (C++, Go, Python) wydaje się pojedynczą instrukcją. Pod maską procesora składa się ona jednak z trzech niezależnych kroków maszynowych:
1.  Odczytaj wartość `counter` z pamięci RAM do rejestru CPU.
2.  Zwiększ wartość rejestru o 1.
3.  Zapisz nową wartość z rejestru z powrotem do pamięci RAM.

Jeśli dwa wątki wykonają te operacje jednocześnie bez synchronizacji, dojdzie do wyścigu:

```
Wątek 1 (na Rdzeniu 1)                 Wątek 2 (na Rdzeniu 2)
----------------------                 ----------------------
1. Czyta counter (wartość 0)
                                       1. Czyta counter (wartość 0)
2. Zwiększa rejestr do 1
                                       2. Zwiększa rejestr do 1
3. Zapisuje counter = 1
                                       3. Zapisuje counter = 1
```

**Wynik końcowy**: Chociaż wykonaliśmy dwie inkrementacje, wartość licznika w pamięci wynosi `1` zamiast `2`. Jeden z zapisów został nadpisany i utracony.

---

## 2. Sekcja Krytyczna (Critical Section)

> [!IMPORTANT]
> **Sekcja krytyczna** to fragment kodu, w którym następuje dostęp do współdzielonego zasobu (np. zmiennej, pliku), i który w danej chwili może być wykonywany przez **co najwyżej jeden wątek**.

Aby chronić sekcje krytyczne przed wyścigami, stosujemy mechanizmy synchronizacji.

---

## 3. Mechanizmy Synchronizacji Blokadowej (Locks)

### A. Mutex (Mutual Exclusion)
Najpopularniejszy obiekt blokady. Działa jak klucz do łazienki w restauracji:
*   Wątek, który chce wejść do sekcji krytycznej, musi pobrać mutex (`lock`).
*   Jeśli mutex jest zajęty przez inny wątek, wątek czekający zostaje uśpiony przez system operacyjny. Zwolnienie mutexu (`unlock`) wybudza czekający wątek.
*   *Wada*: Przełączenie wątku w stan uśpienia i jego wybudzenie (Context Switch) kosztuje sporo czasu procesora.

### B. Blokada Wirująca (Spinlock)
Podobna do mutexu, ale wątek czekający nie zasypia, lecz w pętli `while` ciągle odpytuje procesor: *„Czy blokada jest już wolna?”* (tzw. busy-waiting).
*   *Zaleta*: Brak kosztu przełączania kontekstu. Wybudzenie następuje natychmiastowo.
*   *Wada*: Wątek wirujący zużywa 100% czasu rdzenia CPU, na którym się znajduje. Spinlocków używa się wyłącznie dla bardzo krótkich sekcji krytycznych.

### C. Blokada Read-Write (RWLock)
Rozróżnia dostęp do odczytu i zapisu:
*   Wiele wątków może jednocześnie czytać dane (brak blokowania).
*   Tylko jeden wątek może modyfikować dane (wtedy blokowani są wszyscy czytający i piszący).
*   Doskonała do struktur danych, które są bardzo często odczytywane, ale rzadko aktualizowane.

### D. Semafor (Semaphore)
Licznik zasobów. Zezwala na jednoczesny dostęp maksymalnie $N$ wątkom.
*   Semafor binarny ($N=1$) działa jak mutex.

---

## 4. Operacje Atomowe i Pamięć bezblokadowa (Lock-free)

Częste używanie blokad (mutexów) prowadzi do spowolnienia kodu (wątki marnują czas na czekanie na siebie). Alternatywą są **operacje atomowe**.

Operacje te są realizowane bezpośrednio przez instrukcje sprzętowe procesora (np. `LOCK XADD` w x86). Są niepodzielne z perspektywy innych rdzeni CPU.
*   **CAS (Compare-And-Swap)**: Podstawowa instrukcja bezblokadowa. Zapisuje nową wartość do pamięci tylko wtedy, gdy obecna wartość jest równa wartości oczekiwanej: `CAS(adres, stara_wartosc, nowa_wartosc)`. Jeśli inny wątek zdążył zmodyfikować wartość pod adresem, CAS zwraca fałsz, a my możemy spróbować ponownie w pętli.

Programowanie bezblokadowe (lock-free) pozwala na tworzenie kolejek, stosów i liczników, które skalują się znacznie lepiej niż ich odpowiedniki zabezpieczone mutexami.

---

## Polecana literatura i źródła zewnętrzne:
*   **Książka**: *„The Art of Multiprocessor Programming”* Maurice Herlihy, Nir Shavit.
*   **Blog**: *„Concurrency Freaks”*.
