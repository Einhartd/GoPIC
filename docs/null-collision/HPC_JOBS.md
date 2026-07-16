# Konfiguracja zadań HPC (SLURM) dla wersji z Null-Collision

W katalogu `GoPIC_jobs/` znajdują się skrypty wsadowe (batch scripts) przeznaczone do uruchamiania pomiarów profilowania (`perf record` oraz `perf stat`) na superkomputerze (np. PLGrid).

Dostosowałem wszystkie skrypty zadań tak, aby ułatwić przełączanie wersji i uniknąć konfliktów podczas równoległego uruchamiania zadań.

---

## 1. Architektura rozwiązania i kompilacja

Zorganizowałem strukturę tak, aby skrypty automatycznie budowały i rozróżniały dwie binarne wersje oprogramowania:
*   **Wersja Standard (`*_std`)** – uruchamia klasyczne, standardowe prawdopodobieństwo zderzeń MCC.
*   **Wersja Null-Collision (`*_nc`)** – uruchamia szybką metodę zderzeń Null-Collision.

Dzięki temu binarne pliki wykonywalne obu trybów nie nadpisują się wzajemnie w katalogu budowania.

---

## 2. Sterowanie metodą (Zmienna środowiskowa)

Uruchomienie wybranej wersji kontrolowane jest przy użyciu zmiennej środowiskowej **`USE_NULL_COLLISION`**:
*   `USE_NULL_COLLISION=true` (lub `1`) – uruchamia wersję zoptymalizowaną Null-Collision.
*   `USE_NULL_COLLISION=false` (lub pusta) – uruchamia wersję standardową.

Zmienną tę można zadeklarować w linii komend podczas zlecania zadania do kolejki SLURM (`sbatch`).

---

## 3. Instrukcja uruchamiania zadań w SLURM

Przejdź do katalogu głównego repozytorium na HPC i wydaj odpowiednie polecenia:

### Uruchomienie wersji C:
```bash
# Wersja Standard:
sbatch GoPIC_jobs/C/edupic_job_stat.sh

# Wersja Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=true GoPIC_jobs/C/edupic_job_stat.sh
```

### Uruchomienie wersji Go:
```bash
# Wersja Standard:
sbatch GoPIC_jobs/Go/gopic_job_stat.sh

# Wersja Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=true GoPIC_jobs/Go/gopic_job_stat.sh
```

### Uruchomienie wersji Python (obsługuje wersje Native, NumPy, Numba):
Przed zleceniem zadania wybierz wersję Pythona (np. `numpy_version` lub `numba_version`) poprzez odkomentowanie odpowiedniej ścieżki w skrypcie `pypic_stat.sh` lub `pypic_record.sh`.
```bash
# Wersja Standard:
sbatch GoPIC_jobs/python/pypic_stat.sh

# Wersja Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=true GoPIC_jobs/python/pypic_stat.sh
```

---

## 4. Wykaz naprawionych błędów w skryptach
*   **Poprawka ścieżki profilu Python**: Naprawiłem błąd ścieżki w plikach `pypic_record.sh` oraz `pypic_stat.sh`, w których skrypty błędnie odwoływały się do nieistniejącego folderu `PyPIC_jobs/pypic.profile` (prawidłowa ścieżka to `GoPIC_jobs/python/pypic.profile`).
*   **Bezpieczeństwo współbieżności**: Wersje C oraz Go kompilują teraz unikalne nazwy plików tymczasowych zawierające `${SLURM_JOB_ID}`, zapobiegając uszkodzeniu binariów w przypadku jednoczesnego zlecenia wielu zadań.
*   **Uprawnienia do uruchamiania (Permission denied)**: Dodano wymuszenie nadania uprawnień wykonywalnych (`chmod +x`) dla kompilowanych plików binarnych C oraz Go bezpośrednio przed ich wywołaniem w zadaniu. Zapobiega to błędom uprawnień na środowiskach sieciowych (NFS) węzłów obliczeniowych.
