# Rozpiska rozdziałów pracy

## Część wstępna
### Rozdział 1. Wstęp i cel pracy
1. Motywacja badawcza
2. Problem badawczy: 
    Czy język Go ze swoim garbage collectorem i gorutynami może stanowić realną i wydajną alternatywę dla C++ (OpenMP) w obliczeniach plazmy metodą Particle-In-Cell?
3. Zakres pracy
    - Wdrożenie równoległego silnika PIC/MCC 1D3V w językach C++ oraz Go przy zachowaniu poprawności obliczeniowej na bazie kodu eduPIC.
    - Porównanie działania języków przy tego typu pracy.

### Rozdział 2. Modelowanie kinetyczne wyładowań plazmowych metodą PIC/MCC
1. Fizyka działania symulacji PIC-MCC
2. Cykl obliczeniowy 1D3V PIC/MCC
3. Architektura oryginalnego kodu referencyjnego eduPIC

### Rozdział 3. Przegląd literatury i stan badań nad optymalizacją symulacji cząstkowych
1. Algorytmiczne metody redukcji złożoności zderzeń kinetycznych
- Metoda Zderzeń Zerowych (null-collision)
- Analityczna kinetyka wymiany ładunku
2. Architektura struktur danych i zarządzanie hierarchią pamięci podręcznej
- Układ Structure of Arrays (SoA)
- Bezkolizyjne techniki depozycji ładunku
- Zjawisko False Sharing i izolacja linii pamięci podręcznej
3. Wyzwania wektoryzacji SIMD i nielokalnego dostępu do pamięci
- wektoryzacja pętli pchnięcia cząstek
- problem nieregularnego odczytu siatki
4. Modele programowania wielowątkowego w obliczeniach o wysokiej częstotliwości synchronizacji

## Część eksperymentalna
### Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go
1. Metodyka pomiarowa i środowisko badawcze
    - Opisanie pracy na klastrze HPC
    - Opisanie specyfikacji klastra HPC
    - Opisanie narzędzi i metodyki pomiarowej (perf itd.)
    - Definicja golden record, czemu, po co?
    - Definicja weryfikacji poprawności zmian w symulacjach. Jak sprawdzamy i upewniamy się, że kod jest prawidłowy?
2. Analiza stanu wyjściowego i diagnoza kodu bazowego (Baseline)
    - Analiza obecnych optymalizacji
    - Profilowanie obecnego kodu
    - Identyfikacja wąskich gardeł do optymalizacji
3. Porównawcza analiza assemblerowa kompilatorów GCC i Go gc
    - Porownać tą samą implementację sekwencyjną Go i C++ z poziomu assemblera i pokazać różnice
3. Ścieżka optymalizacji symulacji w C++ (OpenMP)
4. Ścieżka optymalizacji symulacji w Go
5. Bezpośrednie porównanie międzyjęzykowe i dysusja wyników


### Część końcowa
### Rozdział 5. Podsumowanie i wnioski końcowe
1. Podsumowanie osiągniętych rezultatów
2. Weryfikacja hipotez badawczych
3. Kierunki dalszych badań