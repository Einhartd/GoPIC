# Rozdział 6: Ciemna Strona Mocy – Pułapki i Typowe Błędy

Pisanie programów równoległych niesie ze sobą ryzyko popełnienia specyficznych błędów, które nie występują w programach jednowątkowych. Błędy te mogą prowadzić do całkowitego zawieszenia programu (deadlock) lub niewytłumaczalnego spadku wydajności (false sharing).

---

## 1. Zakleszczenie (Deadlock)

> [!CAUTION]
> **Deadlock (zakleszczenie)** to sytuacja, w której co najmniej dwa wątki są zablokowane i żaden z nich nie może kontynuować pracy, ponieważ każdy czeka na zwolnienie zasobu (np. locka) przez ten drugi.

Klasyczna ilustracja to sytuacja, gdy Wątek 1 zajmuje Mutex A i czeka na Mutex B, a w tym samym ułamku sekundy Wątek 2 zajmuje Mutex B i czeka na Mutex A. Żaden z nich nie ruszy do przodu.

### Warunki Coffmana (wszystkie 4 muszą zajść jednocześnie, aby powstał deadlock):
1.  **Wzajemne wykluczenie (Mutual Exclusion)**: Zasoby mogą być używane tylko przez jeden wątek naraz.
2.  **Trzymanie i czekanie (Hold and Wait)**: Wątek trzyma przydzielony zasób, czekając na kolejny.
3.  **Brak wywłaszczania (No Preemption)**: Zasób nie może zostać odebrany wątkowi siłą.
4.  **Czekanie kołowe (Circular Wait)**: Istnieje zamknięty krąg wątków, z których każdy czeka na zasób trzymany przez kolejny wątek w kręgu.

### Jak unikać deadlocków?
Najprostszym rozwiązaniem jest **zawsze pobierać blokady w tej samej kolejności** we wszystkich wątkach (np. zawsze blokuj najpierw Mutex A, potem Mutex B). To uniemożliwia powstanie warunku czekania kołowego.

---

## 2. Livelock i Zagłodzenie (Starvation)

*   **Livelock**: Wątki stale zmieniają swój stan w odpowiedzi na działania innych wątków, ale żaden z nich nie wykonuje użytecznej pracy. Działa to jak dwóch uprzejmych ludzi w wąskim przejściu, którzy jednocześnie usuwają się w tę samą stronę, blokując się nawzajem.
*   **Zagłodzenie (Starvation)**: Sytuacja, w której wątek o niskim priorytecie nigdy nie dostaje czasu procesora (lub dostępu do mutexu), ponieważ scheduler systemu operacyjnego stale faworyzuje wątki o wyższym priorytecie.

---

## 3. Fałszywe Współdzielenie (False Sharing)

To niezwykle podstępna pułapka wydajnościowa, która wynika bezpośrednio z budowy pamięci cache procesora (Rozdział 2).

Przypomnijmy: procesor pobiera dane z pamięci RAM w liniach cache o rozmiarze **64 bajtów**.

Wyobraź sobie następujący kod w C++ lub Go:
```cpp
struct ThreadData {
    uint64_t counter1; // wątek 1 modyfikuje tę zmienną (8 bajtów)
    uint64_t counter2; // wątek 2 modyfikuje tę zmienną (8 bajtów)
};
```
Zmienne `counter1` i `counter2` leżą obok siebie w pamięci i mieszczą się w **tej samej 64-bajtowej linii cache**.

```
Linia cache (64 bajty) w RAM: [ counter1 (8B) | counter2 (8B) | ... pozostałe 48B ... ]
```

1.  Rdzeń 1 pobiera linię cache do swojego cache L1, aby modyfikować `counter1`.
2.  Rdzeń 2 pobiera **tę samą linię cache** do swojego cache L1, aby modyfikować `counter2`.
3.  Kiedy Rdzeń 1 zapisuje nową wartość do `counter1`, sprzętowa koherencja cache (protokół MESI) oznacza całą linię w cache Rdzenia 2 jako **Invalid (I)**.
4.  Rdzeń 2, chcąc zapisać do `counter2`, napotyka chybienie cache (Cache Miss), musi czekać na przesłanie linii z Rdzenia 1 przez szynę, po czym modyfikuje ją i unieważnia kopię w Rdzeniu 1.

### Efekt (Cache Thrashing / Ping-Ponging)
Linia cache nieustannie krąży (ping-ponguje) między rdzeniami procesora. Z perspektywy kodu wątki modyfikują zupełnie różne zmienne i nie potrzebują żadnej synchronizacji (brak wyścigu), ale na poziomie sprzętowym program działa niezwykle wolno.

### Rozwiązanie (Cache Padding)
Musimy rozdzielić zmienne tak, aby leżały w różnych liniach cache. Możemy to zrobić, dodając pusty margines (padding) o rozmiarze 64 bajtów lub stosując dyrektywy wyrównania pamięci:
```cpp
struct alignas(64) ThreadData {
    uint64_t counter1;
};
// counter2 umieszczamy w osobnym alignas(64)
```

---

## 4. Koszt Tworzenia Wątków (Overhead)

Utworzenie wątku systemowego wiąże się z alokacją pamięci na jego stos (zazwyczaj 1-8 MB) oraz wykonaniem wywołania systemowego (Syscall) do jądra systemu operacyjnego. Jeśli dla każdego małego zadania (np. obsługa jednego zapytania HTTP) będziesz tworzyć i niszczyć wątek, narzut czasowy (overhead) zje wszystkie korzyści z równoległości.

### Rozwiązanie: Pula Wątków (Thread Pool)
Tworzymy określoną liczbę wątków (np. równą liczbie fizycznych rdzeni CPU) na początku działania programu i utrzymujemy je przy życiu. Wątki te pobierają zadania do wykonania z bezpiecznej kolejki zadań (Task Queue).

---

## Polecana literatura i źródła zewnętrzne:
*   **Wykład wideo**: MIT 6.172 *Performance Engineering* – Wykład o False Sharing.
*   **Artykuł**: Herb Sutter – *„Eliminate False Sharing”*.
