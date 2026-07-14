import pytest
import os
import subprocess
import shutil
import sys

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
TESTS_DIR = os.path.join(ROOT_DIR, 'tests')
GOLD_DIR = os.path.join(TESTS_DIR, 'regression_gold')

def compare_numeric_files(file1, file2, tolerance=1e-12):
    if not os.path.exists(file1) or not os.path.exists(file2):
        return False, "Jeden z plików nie istnieje."

    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    if len(lines1) != len(lines2):
        return False, f"Różna liczba linii: {len(lines1)} vs {len(lines2)}"

    for idx, (l1, l2) in enumerate(zip(lines1, lines2)):
        parts1 = l1.strip().split()
        parts2 = l2.strip().split()
        if len(parts1) != len(parts2):
            return False, f"Linia {idx+1}: różna ilość kolumn ({len(parts1)} vs {len(parts2)})"

        for col, (p1, p2) in enumerate(zip(parts1, parts2)):
            try:
                v1 = float(p1)
                v2 = float(p2)
                diff = abs(v1 - v2)
                if diff > tolerance:
                    return False, f"Linia {idx+1}, kolumna {col+1}: mismatch {v1} vs {v2} (diff = {diff:.2e}, tol = {tolerance:.2e})"
            except ValueError:
                if p1 != p2:
                    return False, f"Linia {idx+1}, kolumna {col+1}: {p1} != {p2}"
    return True, ""

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_regression_golden_run(version):
    """
    Test regresyjny (Golden Run):
    1. Uruchamia inicjalizację (cykl 0 -> 1) z seedem 67 i zapisuje picdata.bin.
    2. Uruchamia 5 kolejnych cykli (z odczytem picdata.bin i rng_state.pkl).
    3. Porównuje wyjściowy plik conv.dat z zapisanym wzorcem 'golden run'.
    4. Jeśli wzorzec nie istnieje, tworzy go na podstawie tego przebiegu (bootstrap).
    """
    version_gold_dir = os.path.join(GOLD_DIR, version)
    gold_conv_path = os.path.join(version_gold_dir, 'conv.dat')

    # Przygotowanie tymczasowego folderu roboczego na test, aby nie zaśmiecać głównego katalogu
    temp_work_dir = os.path.join(TESTS_DIR, f'temp_work_{version}')
    if os.path.exists(temp_work_dir):
        shutil.rmtree(temp_work_dir)
    os.makedirs(temp_work_dir)

    try:
        # 1. Init: python run_regression.py <version> init
        cmd_init = [sys.executable, os.path.join(TESTS_DIR, 'run_regression.py'), version, 'init']
        subprocess.run(cmd_init, cwd=temp_work_dir, check=True, capture_output=True, text=True)

        # 2. Run: python run_regression.py <version> run 5 (łącznie 6 cykli)
        cmd_run = [sys.executable, os.path.join(TESTS_DIR, 'run_regression.py'), version, 'run', '5']
        subprocess.run(cmd_run, cwd=temp_work_dir, check=True, capture_output=True, text=True)

        generated_conv = os.path.join(temp_work_dir, 'conv.dat')
        assert os.path.exists(generated_conv), "Plik conv.dat nie został wygenerowany!"

        # Jeśli plik wzorcowy nie istnieje, tworzymy go (bootstrap)
        if not os.path.exists(gold_conv_path):
            os.makedirs(version_gold_dir, exist_ok=True)
            shutil.copy(generated_conv, gold_conv_path)
            print(f"\n[Bootstrap] Utworzono plik wzorcowy golden run dla {version} w: {gold_conv_path}")
            pytest.skip(f"Utworzono plik wzorcowy dla {version}. Pomijanie asercji w tym przebiegu.")
        else:
            # Porównujemy wygenerowany plik z plikiem wzorcowym
            # Dla numba_version, ponieważ nie zapisujemy wewnętrznego stanu generatora JIT,
            # odczyt z picdata.bin i kontynuacja w osobnym wywołaniu procesu 'run'
            # może się różnić od ciągłego biegu z powodu braku serializacji RNG.
            # Z tego powodu dla numba_version używamy wyższej tolerancji lub porównujemy tylko pierwsze cykle,
            # ale zbadajmy czy przejdzie z tolerancją 1e-12.
            tol = 1e-12
                
            success, msg = compare_numeric_files(generated_conv, gold_conv_path, tolerance=tol)
            assert success, f"Błąd regresji dla {version}: {msg}"
            print(f"\n[Regresja OK] {version} zgadza się ze wzorcem w tolerancji {tol}")

    finally:
        # Sprzątanie tymczasowego katalogu
        if os.path.exists(temp_work_dir):
            shutil.rmtree(temp_work_dir)
