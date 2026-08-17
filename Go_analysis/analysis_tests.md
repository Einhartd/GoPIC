# Analiza Plików Testowych GoPIC (Parallel Chunking)

Poniższy raport przedstawia kompleksową analizę metodologii testowania wariantu wielowątkowego (chunking) symulacji GoPIC, w bezpośrednim porównaniu do testów referencyjnej wersji sekwencyjnej i równoległej w C++ (z wykorzystaniem OpenMP).

## 1. Jakie aspekty kodu są testowane?

Zestaw testów w języku Go zorganizowano wokół poszczególnych modułów fizycznych i architektonicznych kodu Particle-In-Cell. Najważniejsze testowane scenariusze to:

*   **Granice fizyczne (`boundaries_test.go`):**
    Sprawdza, czy po opuszczeniu przez cząstkę obszaru symulacji (np. za lewą elektrodą, pozycja ujemna), elektron jest właściwie rejestrowany (inkrementacja `N_e_abs_pow` na lewej elektrodzie) oraz prawidłowo usuwany z głównej tablicy. W teście weryfikowany jest szybki algorytm *Swap-with-last*, który podmienia wygasłą cząstkę ostatnim elementem tablicy, aby zachować ciągłość danych bez przesuwania całej pamięci w czasie O(N).
*   **Przekroje czynne i zderzenia (`cross_sections_test.go`):**
    Sprawdza, czy makroskopowe przekroje czynne (`SigmaTotE`), które stanowią sumę przekrojów elastycznych, wzbudzeń i jonizacji, odpowiadają oczekiwanej wartości gęstości gazu z uwzględnieniem interpolacji dla określonego bin-u energii (np. 50 eV).
*   **Ważenie przestrzenne do siatki (`density_test.go`):**
    Weryfikuje fundamentalny dla metody PIC proces dystrybucji gęstości cząstek z wykorzystaniem wag (first-order weighting). Poprawnie implementuje ułamek do lewego i prawego węzła, w tym specjalny przypadek *Boundary Doubling*, gdzie ładunek docierający do krawędzi (węzeł 0) jest odpowiednio modyfikowany.
*   **Rozwiązywanie Równania Poissona (`poisson_test.go`):**
    Waliduje macierzowe rozwiązywanie profilu potencjału elektrostatycznego. Testuje skrajne fizyczne warianty: brak ładunków w próżni (potencjał musi opadać liniowo miedzy napięciami elektrod, a pole E być stałe), oraz weryfikuje pochodną pola na samej krawędzi elektrod w obecności ładunku przestrzennego.
*   **Przemieszczanie cząstek i mechanika Newtona (`push_test.go`):**
    Sprawdza czy elektrony (ładunek ujemny) i jony (dodatni) przyśpieszają w dobrych kierunkach pod wpływem stałego pola elektrycznego. Test `TestEfieldInterpolationMidpoint` wylicza także bit-perfect pozycję po wykonaniu modyfikatora skoku prędkości (metoda Boris-push dla 1D).

## 2. Testy Równoległości (Multithreading Verification)

Pliki `parallel_density_test.go` oraz `parallel_push_test.go` służą do udowodnienia pełnego determinizmu i bezpiecznego wykorzystania pamięci (brak *data race*) w środowisku *goroutines*.

*   **Jak weryfikują?**
    Dla ustalonych, powtarzalnych warunków losowych `seed`, test najpierw wymusza sekwencyjne środowisko uruchomieniowe poprzez zablokowanie planisty do jednego wątku operacyjnego: `runtime.GOMAXPROCS(1)`. Następnie wywołuje metodę, zrzuca wynik i restartuje środowisko w modelu zrównoleglonym: `runtime.GOMAXPROCS(4)`. Tablice danych, wskaźniki błędów oraz akumulatory energii (zależnie od fizyki danego sub-steppu) są poddawane brutalnemu, pętlowemu zestawieniu wzdłuż całej domeny pamięci.
*   **Poprawność wielowątkowa Push vs Density:**
    Dla przemieszczania cząstek (Push), każdy wątek w Go operuje tylko i wyłącznie wewnątrz swojego niezależnego wycinka tablicy (`chunk`). Dzięki temu wynik prędkości `Vx_e` i pozycji `X_e` musi się zgadzać dosłownie co do bitu z wariantem sekwencyjnym (użyto w teście silnego sprawdzenia `!=`). 
    Z kolei przy projektowaniu na siatkę (Density), wiele *goroutines* wstawia ładunki do wspólnych przestrzennych *bins*, więc kolejność sumowania zmiennoprzecinkowego może ulec zmianie między wątkami. Z tego powodu dla gęstości weryfikuje się błąd relatywny zmiennoprzecinkowy `isCloseRel`.

## 3. Test Regresji i "Golden Files" (`regression_test.go`)

Symulacje PIC są skomplikowanymi, powiązanymi ze sobą układami niestabilnych nieliniowych układów równań. Unit testy pojedynczych modułów nie wyłapią wczesnego załamania reżimu fizycznego symulacji.

Plik `regression_test.go` używa wzorca **Golden Master Testing**. Kod buduje poprzez `exec.Command` własny binarny podproces `regression_runner`. Aplikacja ta zostaje uruchomiona w tle. Na wyjściu generowany jest log parametrów konwergencji `conv.dat`. 
Następnie uruchamiany jest własny parser `compareNumericFiles`, który analizuje linia po linii nowy plik z referencyjnym plikiem wejściowym przechowywanym w repozytorium na sztywno (`regression_gold/conv.dat`). Tolerancje różnic kolumn są ustalane na restrykcyjne 1e-12.
Posiada inteligentny *bootstrap*: Jeśli system nie znajdzie folderu "gold", po prostu przebiegnie symulację i sam utworzy katalog ze swoim outputem oznaczając test w `t.Skip()`.

## 4. Null Collision Test — Weryfikacja Metodyki (`null_collision_test.go`)

Metoda "Null collision" to wysoce efektywny trik algorytmiczny, pozwalający pominąć proces sprawdzania zderzeń dla każdej cząstki w każdym kroku poprzez wyestymowanie maksymalnej globalnej częstości "jakichkolwiek" zdarzeń na drodze cząstki ($\nu_{max}$). 
Test sprawdza fundamentalne założenia stochastyki:
*   Czy symulacja skompilowana z tagiem wyłapuje brak logiki (aktywuje `t.Skip` jeśli nie użyto flagi kompilacji `-tags nullcollision`).
*   Prawdopodobieństwo fizyczne `PStarE` (elektron-neutralny) i `PStarI` (jon-neutralny) wyliczone w procesie integracji czasowej musi gwarantować stabilność schematu Leapfrog i utrzymywać się w limicie mniejszym niż 5% (`PStar < 0.05`).
*   Wykonuje profilowanie pełnej matrycy energii, szukając energii gdzie lokalne $v \cdot \Sigma(v)$ byłoby wyższe od prekomputowanego globalnego maksimum `NuStarE/I`.

## 5. Tolerancje Floating-Point i różnice w testowaniu Go vs GTest (C/OMP)

Środowisko `Go` stawia na proste idiomy:
*   **Brak rozbudowanych makr:** Zamiast GTestowego `EXPECT_NEAR` / `EXPECT_DOUBLE_EQ`, użyto wewnętrznych funkcji pomocniczych takich jak `isClose` i wywołań wprost `t.Errorf` i `t.Fatalf`.
*   **Błąd względny (Relative Error):** Ekstremalnie małe bądź ogromne numery w fizyce ($e^- = 1.6 \times 10^{-19}$ C) powodują, że absolutny $\epsilon$ jest bezużyteczny. Zdefiniowano w locie *closure* `isCloseRel`, sprawdzające czy odchyłka zachowuje rzędy wielkości wyników poprzez wzór $|a-b| / \max(|a|, |b|) \le \text{tol}$.
*   **Izolacja i Zależności (State Injection):** W C++ stan makrocząstek był globalny (`test_boundaries.cc`). Przed każdym testem w GTest uruchamiano w SetUp funkcję `reset_state()`, następnie ręcznie kopiowano miliony cząstek do buforów `std::vector`, co generowało rozwlekłe testy podatne na błędy test runnera.
    W Go użyto wstrzykiwania stanu — symulacja to odrębna alokacja na stercie: `sim := gopic.NewSimulationState(seed)`. Dwa różne wątki moga testować dwie różne symulacje z kompletnie rożnymi stanami bez mutexów.

## 6. Pokrycie Testami (Luki)

Brakuje testów dla kilku zaawansowanych mechanizmów:
*   **Fizyczny Sort Cząstek:** Moduł odpowiedzialny za przestrzenne sortowanie cząstek nie jest nigdzie sprawdzany pod kątem zgubienia referencji.
*   **Subcycling:** System przyspieszonej integracji cięższych jonów nie jest oddzielnie testowany.
*   **Monte Carlo Core:** Brakuje testu deterministycznego, weryfikującego sam moment losowania wektora pędu rozproszenia zaraz po zdarzeniu zderzenia.

## 7. Optymalizacje procesów testowych w projekcie

Poniżej omówiono wysoce interesujące rozwiązania algorytmiczne zastosowane wyłącznie dla rygorystycznego systemu testów:

### A) Dependency-injected Isolated State (Zamiast modyfikowania Globals)
*   **CO:** Odseparowanie globalnych zmiennych programu i enkapsulacja silnika do oddzielnego unikalnego wskaźnika.
*   **GDZIE:** Pliki testów środowiska testowego, m.in. `parallel_density_test.go:17`.
*   **JAK:** Klasa `SimulationState` na etapie konstrukcji alokuje stertę i przypisuje z dedykowanym własnym silnikiem `math/rand` (seedowanym na sztywno).
*   **DLACZEGO:** W C++ wyścig na tablicach globalnych i generatorze PRNG rujnował testowanie jednostkowe i testy równoległe rzucały "race condition". Izolacja to naprawia.
*   **LINK:** [Go FAQ: Why does Go not have global state constructs in testing?](https://go.dev/doc/faq#Testing)

### B) Strict Bitwise Testing for Lock-free Operations
*   **CO:** Sprawdzanie spójności na poziomie struktury bajtów dla zmiennych numerycznych zamiast obustronnych epsilonów.
*   **GDZIE:** `parallel_push_test.go:51` (`simSeq.X_e[k] != simPar.X_e[k]`)
*   **JAK:** Zrównoleglenie podziałem iteracji w kodzie pozbawionym operacji zapisu z wielu wątków (Zero Data Race) musi zachować bitową identyczność instrukcji asemblera układu zmiennoprzecinkowego. Test sprawdza przez `!=` pełną spójność 64-bitowych floatów.
*   **DLACZEGO:** Sprawia to, że deweloper dowiaduje się natychmiastowo o drobnym "overlappingu" indexów chunków przy zrównoleglaniu.
*   **LINK:** [Comparing Floating Point Numbers](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)

### C) Golden Master Integration Regression
*   **CO:** Test regresji zapisujący historię konwergencji jako plik bazowy (Golden File).
*   **GDZIE:** W `regression_test.go` z użyciem zmiennej `goldDir`.
*   **JAK:** Odczytuje log `conv.dat` od uruchomionego podprocesu symulacji. Porównuje to linia po linii ze stabilnym wygenerowanym wcześniej "złotym standardem".
*   **DLACZEGO:** Zapewnia to absolutne bezpieczeństwo przy optymalizowaniu, gdy nawet trywialne zsumowanie inaczej kolejnych milionów ułamków fizycznych nie ma racji bytu i popsuje końcowy potencjał układu plazmy.
*   **LINK:** [Golden Files w Go](https://xdg.me/golden-files-in-go/)

### D) Zastosowanie Dynamicznego Skalowania Relatywnego w Float (Relative FP Tolerances)
*   **CO:** Zastosowanie testowania bliskości FP względem bieżącego rzędu wartości numerycznej.
*   **GDZIE:** Użycie lokalnej metody anonimowej `isCloseRel(a,b, relTol)` np. w `parallel_density_test.go:40`.
*   **JAK:** Weryfikuje zrównanie formułą `|a - b| / max(|a|, |b|) <= relTol`.
*   **DLACZEGO:** W fizyce wartości ładunków ($10^{-19}$) czy gęstości ($10^{15}$) mają totalnie skrajne wartości dziesiętne, w Go to podejście ujednolica sprawdzanie rozbieżności z precyzji obliczeń podwójnych bez twardego definiowania `epsilonów`.
*   **LINK:** [Floating Point Comparison Standards](https://floating-point-gui.de/errors/comparison/)

### E) End-to-End Binaries w środowisku Go Test
*   **CO:** Natywne wstrzyknięcie paczki `os/exec` do zbudowania testowanej symulacji od 0 jako proces `os`.
*   **GDZIE:** `regression_test.go:87`.
*   **JAK:** Kompiluje symulację w czasie trwania komendy `go test` i w pętli wywołuje binarne `./regression_runner`. Usuwa artefakty na końcu używając pętli `defer`.
*   **DLACZEGO:** Wyłącza potrzebę pisania skryptów Bash do budowania procesu regresji w CI/CD i sprawia, że samo uruchomienie `go test ./...` testuje 100% zachowania od Maina.
*   **LINK:** [os/exec package - Go Docs](https://pkg.go.dev/os/exec#example-Cmd-Output)
