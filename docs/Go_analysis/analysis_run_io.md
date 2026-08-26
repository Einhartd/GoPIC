# Analiza kodu GoPIC - Pliki Orchestracji i I/O

Poniższy dokument przedstawia szczegółową analizę wskazanych plików implementacji GoPIC, ze szczególnym uwzględnieniem mechanizmów zrównoleglania (lub ich wspierania), wejścia/wyjścia (I/O) oraz architektury względem oryginalnego seryjnego kodu C++ i jego portu OMP.

## /home/oliwier/Dev/GoPIC/Go/parallel_chunking/run.go

### Struktura kodu
Plik `run.go` pełni funkcję głównego koordynatora (orkiestratora) symulacji. Odpowiada za:
1. Parsowanie argumentów wejściowych (liczba cykli, tryb pomiarowy).
2. Tworzenie obiektu stanu symulacji `SimulationState`.
3. Inicjalizację fizyki plazmy (przekroje czynne, algorytm null-collision).
4. Główną pętlę symulacji, która decyduje czy symulacja startuje od zera, czy kontynuuje z zapisanego zrzutu (`picdata.bin`).

### Zrównoleglenie i GOMAXPROCS
Choć sam plik `run.go` nie zawiera dyrektyw `go func()` (są one zaszyte w metodzie `sim.DoOneCycle()`, która nie znajduje się w analizowanym zbiorze), to stanowi punkt wejścia do symulacji rozproszonej. W Go począwszy od wersji 1.5, `runtime.GOMAXPROCS` jest domyślnie ustawiane na liczbę logicznych rdzeni procesora. Plik ten całkowicie polega na domyślnym schedulerze Go do dystrybucji pracy między dostępne wątki OS. 

### Różnice względem C++
W monolitycznej wersji `eduPIC.cc` logika startowa (funkcja `main`) jest ściśle spięta z implementacją pętli `do_one_cycle()`. W podejściu Go wyodrębniono logikę sterującą do pakietu, pozostawiając wejściową binarkę jako cienką warstwę (co zobaczymy w `main.go`).

---

## /home/oliwier/Dev/GoPIC/Go/parallel_chunking/cmd/pic/main.go

### Struktura kodu
Jest to "entry point" głównego programu symulacyjnego. Zawiera wyłącznie wywołanie `gopic.Run()`.

### Architektura pakietu
Podejście z wyodrębnieniem pliku `main` do podkatalogu `cmd/pic/` to idiomatyczny układ projektów w Go (standard układu katalogów Go). Pozwala na eksportowanie logiki symulacji z pakietu głównego (`gopic`), dzięki czemu można łatwo kompilować inne binarki (np. profilery, testy regresyjne) oparte na tej samej domenie biznesowej. W C++ kod był zdefiniowany w jednym ogromnym pliku.

---

## /home/oliwier/Dev/GoPIC/Go/parallel_chunking/cmd/regression/main.go

### Struktura kodu i optymalizacje
Ten program to wejście do trybu testów regresyjnych. Aby zapewnić idealną zgodność (bit-perfect) z wynikami C++, symulator musi mieć powtarzalny ciąg losowań RNG po odtworzeniu ze stanu początkowego.

Z powodu hermetyzacji (pola nieeksportowane) w użytej bibliotece Mersenne Twister, Go uniemożliwia normalny zapis stanu.

**Optymalizacja / Hak architektoniczny:**
Zastosowano `unsafe.Pointer` do wykonania _type punningu_:
```go
type mt19937Shadow struct {
	State []uint64
	Index int
}
shadow := (*mt19937Shadow)(unsafe.Pointer(sim.MtSrc))
```
Pozwala to dostać się do prywatnych struktur generatora by móc zapisać na dysk cały bufor RNG, bez potrzeby modyfikowania kodu zewnętrznej biblioteki.

---

## /home/oliwier/Dev/GoPIC/Go/parallel_chunking/io_manager.go

### Struktura kodu
Plik dostarcza metody do obsługi zapisu i odczytu cząstek (`SaveParticleData`, `LoadParticleData`) oraz danych diagnostycznych (gęstości, EEPF, IFED).

### Analiza Memory/Data i Bottlenecków
To najsłabsze ogniwo implementacji w kontekście wydajności, szczególnie gdy porównamy je z bagnetycznym zrzutem pamięci w C++:
```cpp
fwrite(x_e, sizeof(double),N_e,f); // C++: jeden wywołanie dla całej tablicy
```

W kodzie Go napotykamy pętlę i użycie pakietu `encoding/binary`:
```go
func readFloat64(r *bufio.Reader) float64 {
	var v float64
	binary.Read(r, binary.LittleEndian, &v)
	return v
}
```
**Bottleneck O(N):** Pakiet `encoding/binary` dla pojedynczych elementów wykorzystuje mechanizm refleksji (w starszych wersjach Go) lub type-switche, a przy iteracji przez miliony cząstek generuje to gigantyczny narzut i liczne wywołania funkcji. Mimo zastosowania buforowania I/O (`bufio`), to CPU blokuje I/O na rozkodowywaniu little-endian element po elemencie.

### Optymalizacje zastosowane
Zastosowano `bufio.Writer` oraz `bufio.Reader`. Zapobiega to bezpośredniemu wywoływaniu funkcji jądra (syscall `write`/`read`) w każdej iteracji, grupując zapisy w 4KB bloki w RAM.

---

## /home/oliwier/Dev/GoPIC/Go/parallel_chunking/go.mod

To plik zarządzający modułem Go. Definiuje on zależność do implementacji `github.com/seehuhn/mt19937`, wskazując, że twórca postanowił przenieść C++'owy algorytm Mersenne Twister do oddzielnej zewnętrznej paczki, starając się unikać wpływu standardowego `math/rand` na niekompatybilność z oryginalnym seryjnym kodem.

---

## Architektura pakietu Go vs monolityczny C++

Oryginalny plik `eduPIC.cc` w C (oraz w C/OMP) jest strukturą wysoce monolityczną (ponad 1000 linii w jednym pliku), opartą o zmienne globalne dostępne w całej przestrzeni. Utrudnia to testowanie i uruchamianie współbieżne.
Architektura w Go rozdziela program na paczkę ("gopic") bazującą na strukturze `SimulationState`. Hermetyzacja ta (`sim *SimulationState`) pozwala w razie potrzeby na odpalenie wielu instancji symulacji niezależnie w tych samych procesach, ułatwia mockowanie i izolację.

---

## Bottlenecki I/O
Jak wspomniano przy `io_manager.go`, bottleneckiem I/O w Go nie jest sam dysk (o ile symulacja zajmuje RAM), lecz konwersja typów tablic (slice of float64). W C zapisywano bezpośrednio bloki binarne na dysk funkcją `fwrite`. Aby zbliżyć Go do tej wydajności można byłoby zaimplementować to z wykorzystaniem rzutowania bufora przez pakiet `unsafe` do `[]byte`, tak by wykonywać tylko jedno wywołanie zapisujące cały wycinek cząstek z ominięciem `encoding/binary`.

---

## Podsumowanie i Słownik Optymalizacji

W analizowanych plikach odnaleziono następujące optymalizacje:

1. **Buforowane Wejście/Wyjście (Buffered I/O)**
   - **Co:** Wykorzystanie paczki `bufio` (bufio.NewWriter).
   - **Gdzie:** `io_manager.go`, `SaveParticleData`.
   - **Jak:** Gromadzi wiele małych zapisów w jeden wielki bufor rezydujący w RAM przed wysłaniem na blokowe urządzenie dyskowe, redukując wywołania systemowe.
   - **Dlaczego:** Operacje przejścia między _user space_ a _kernel space_ na systemie operacyjnym są niezwykle kosztowne. Zbieranie zrzutów minimalizuje narzut kontekstu.
   - **Link:** [https://pkg.go.dev/bufio](https://pkg.go.dev/bufio)

2. **Dostęp "pod maską" do bibliotek bez ich naruszania (Type Punning / Unsafe)**
   - **Co:** Pobieranie niedostępnego (unexported) pola ze struktury i odczytywanie jego pamięci przy użyciu bliźniaczego interfejsu.
   - **Gdzie:** `cmd/regression/main.go`, `mt19937Shadow`.
   - **Jak:** Odczytanie wskaźnika zmiennej jako typu `unsafe.Pointer` i natychmiastowe rzutowanie go na lokalnie zdefiniowaną bliźniaczą strukturę o takich samych wielkościach w pamięci.
   - **Dlaczego:** Pozwala to obejść zasady kompilatora na rzecz bezpośredniej manipulacji layoutem pamięci, zachowując bezcenny stan generatora RNG potrzebny do bit-perfect powtarzalności symulacji.
   - **Link:** [https://pkg.go.dev/unsafe](https://pkg.go.dev/unsafe)

3. **Oddzielne Entrypointy (Idiomatic `cmd/` pattern)**
   - **Co:** Utworzenie folderu `cmd` z kilkoma `main.go`.
   - **Gdzie:** Cały projekt.
   - **Jak:** Logika ląduje do pakietu, a pliki `main.go` pełnią role zaledwie wywoływacza pakietów (bootstrap).
   - **Dlaczego:** Pozwala to na uniknięcie monolitycznego bloku plików jak w oryginalnym C, pozwalając na mniejsze pliki binarne, lepszy martwy kod i rozłączność modułową.
   - **Link:** [https://go.dev/doc/modules/layout](https://go.dev/doc/modules/layout)
