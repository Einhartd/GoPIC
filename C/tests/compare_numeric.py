import sys

def compare_files(file1, file2, tolerance):
    try:
        with open(file1, 'r') as f1, open(file2, 'r') as f2:
            lines1 = f1.readlines()
            lines2 = f2.readlines()
    except Exception as e:
        print(f"Error opening files: {e}")
        return False

    if len(lines1) != len(lines2):
        print(f"Files have different number of lines: {len(lines1)} vs {len(lines2)}")
        return False

    for i, (l1, l2) in enumerate(zip(lines1, lines2)):
        parts1 = l1.strip().split()
        parts2 = l2.strip().split()
        if len(parts1) != len(parts2):
            print(f"Line {i+1} has different column counts: {len(parts1)} vs {len(parts2)}")
            return False

        for col, (p1, p2) in enumerate(zip(parts1, parts2)):
            try:
                val1 = float(p1)
                val2 = float(p2)
            except ValueError:
                # Non-numeric comparison (strings/labels)
                if p1 != p2:
                    print(f"Line {i+1}, col {col+1}: '{p1}' != '{p2}'")
                    return False
                continue

            diff = abs(val1 - val2)
            if diff > tolerance:
                print(f"Line {i+1}, col {col+1} mismatch: {val1} vs {val2} (diff: {diff:.2e}, tolerance: {tolerance:.2e})")
                return False

    return True

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python3 compare_numeric.py <file1> <file2> <tolerance>")
        sys.exit(1)
    file1 = sys.argv[1]
    file2 = sys.argv[2]
    tolerance = float(sys.argv[3])

    if compare_files(file1, file2, tolerance):
        print(f"SUCCESS: {file1} and {file2} match within tolerance {tolerance}")
        sys.exit(0)
    else:
        sys.exit(1)
