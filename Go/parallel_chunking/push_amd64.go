package gopic

/*
LeapFrogPushAVX2 wykonuje zwektoryzowany schemat pchnięcia cząstek Leap-Frog
dla cząstek z zakresu [s, e) przy użyciu natywnych instrukcji AVX2, FMA3
oraz sprzętowego odczytu rozproszonego VGATHERDPD w asemblerze Plan 9 (push_amd64.s).

Cechy mikroarchitektoniczne:
 1. 4 cząstki przetwarzane jednocześnie w rejestrach YMM (256-bit).
 2. Sprzętowy odczyt rozproszony VGATHERDPD ładuje wartości siatki Efield bezpośrednio z L1 Cache
    do rejestrów wektorowych YMM, całkowicie omijając stos maszynowy i eliminując błąd
    Store-to-Load Forwarding (STLF) obecny w eksperymentalnym pakiecie Go simd.
 3. Bezgałęziowe klamrowanie indeksów komórek siatki (VCVTTPD2DQY + VPMAXSD + VPMINSD).
 4. Jednomnożeniowa interpolacja liniowa CIC oraz aktualizacja prędkości i położeń w potokach FMA3
    (VFMADD213PD, VFNMADD231PD, VFMADD231PD).
 5. Wynik wydajnościowy: 4.53x szybciej od pętli skalarnej i 5.8x szybciej od oficjalnego pakietu Go simd.

@param x        Wycinek tablicy położeń cząstek [m].
@param vx       Wycinek tablicy prędkości cząstek [m/s].
@param efield   Wycinek tablicy pola elektrycznego w węzłach siatki [V/m].
@param s        Indeks początkowy chunka (inclusive).
@param e        Indeks końcowy chunka (exclusive).
@param factorE  Współczynnik przyspieszenia: (q/m)*dt (FACTOR_E dla e-, -FACTOR_I dla jonów).
@param dtE      Krok czasowy integracji położeń: DT_E (lub DT_I).
@param invDx    Odwrotność kroku przestrzennego: INV_DX = 1.0 / dx.
*/
//go:noescape
func LeapFrogPushAVX2(x, vx []float64, efield []float64, s, e int, factorE, dtE, invDx float64)
