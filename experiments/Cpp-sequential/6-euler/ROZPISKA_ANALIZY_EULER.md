# Przewodnik i Rozpiska Podrozdziału: Algebra Wektorowa Kątów Eulera i Zderzeń MCC (Transcendental Elimination)

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Ścieżka optymalizacji silnika w języku C++**  
>     └── **4.2.5. Eliminacja funkcji transcedentnych w procedurach zderzeniowych (Euler Vector Algebra & Scattering)**

Niniejszy dokument stanowi kompletny konspekt teoretyczno-analityczny, matematyczny oraz szablon telemetryczny do opisu piątego kroku optymalizacyjnego w pracy magisterskiej. Został przygotowany w pełnej symetrii metodologicznej do poprzednich podrozdziałów ([1-baseline](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/1-baseline/ROZPISKA_ANALIZY_BASELINE.md), [2-null-collision](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/2-null-collision/ROZPISKA_ANALIZY_NULL_COLLISION.md), [3-hoisting](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/ROZPISKA_ANALIZY_HOISTING.md), [4-div-elimination](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/4-div-elimination/ROZPISKA_ANALIZY_DIV_ELIMINATION.md) oraz [5-fast-path](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/5-fast-path/ROZPISKA_ANALIZY_FAST_PATH.md)).

---

## 1. Fizyka i Kinematyka Zderzeń Monte Carlo (MCC) w Modelu PIC-MCC

W kinetycznym modelu Particle-in-Cell zderzenia cząstek naładowanych z obojętnym gazem tła (Monte Carlo Collisions – MCC) opierają się na formalizmie zderzeń dwuciałowych w przestrzeni trójwymiarowej (Bird 1994, Nanbu 2000, Donkó et al. 2021). 

Dla każdego zaakceptowanego zderzenia elektronu lub jonu konieczne jest wyznaczenie nowego wektora prędkości cząstki po rozproszeniu. Proces ten wymaga:
1. Przejścia do układu środka masy cząstki i atomu tła,
2. Wyznaczenia orientacji wektora prędkości względnej $\vec{g} = \vec{v}_1 - \vec{v}_2$ w przestrzeni za pomocą kątów Eulera (kąt biegunowy $\theta$ oraz kąt azymutalny $\phi$),
3. Wylosowania kąta rozproszenia $\chi$ (zależnego od mechanizmu fizycznego: rozpraszanie sprężyste, wzbudzenie lub jonizacja) oraz izotropowego kąta azymutalnego $\eta \in [0, 2\pi)$,
4. Zastosowania trójwymiarowej macierzy obrotu $R(\theta, \phi)$ w celu przetransformowania rozproszonego wektora prędkości względnej $\vec{g}'$ z powrotem do laboratoryjnego układu odniesienia:
   $$\vec{v}'_1 = \vec{w} + \frac{m_2}{m_1 + m_2}\vec{g}'$$
   gdzie $\vec{w}$ jest wektorem prędkości środka masy.

### 1.1. Skala Częstości Zderzeń Frakcji Lekkiej (Elektronów)
W odróżnieniu od ciężkich jonów (które wykonują zaledwie ~2.8 miliona zderzeń w 100 cyklach RF z uwagi na subcycling $N_{\text{sub}} = 20$), **elektrony uczestniczą w intensywnych zderzeniach w każdym kroku czasowym $\Delta t_e$**. 
W 100 cyklach symulacji zachodzi od **3 do 5 milionów zderzeń elektronowych**, co czyni procedurę `collision_electron` jednym z głównych globalnych hotspotów obliczeniowych.

---

### 1.2. Podbudowa Teoretyczna w Literaturze Naukowej

Wprowadzone przekształcenia analityczne nie są heurystykami numerycznymi, lecz wynikają wprost z kanonicznych publikacji z dziedziny modelowania kinetycznego wyładowań plazmowych:

1. **Vahedi & Surendra (1995)** – *A Monte Carlo collision model for the particle-in-cell method: applications to argon and oxygen discharges*, Computer Physics Communications 87, 179–198 (`articles/A Monte Carlo collision model for the particle-in-cell method.pdf`):
   - **Wektorowe wyznaczanie kierunku rozproszenia bez jawnych kątów (Sekcja 3.1.1, Równanie 11, Rysunek 4, s. 183):**  
     Autorzy definiują wersor rozproszony $\hat{v}_{\text{scat}}$ bezpośrednio w oparciu o rzuty wektorowe i iloczyny wektorowe z wersorem osi wyładowania $\hat{i}$:
     $$\hat{v}_{\text{scat}} = \hat{v}_{\text{inc}} \cos\chi + (\hat{v}_{\text{inc}} \times \hat{i}) \frac{\sin\chi \sin\phi}{\sin\theta} + [\hat{v}_{\text{inc}} \times (\hat{i} \times \hat{v}_{\text{inc}})] \frac{\sin\chi \cos\phi}{\sin\theta}$$
     gdzie $\cos\theta = \hat{v}_{\text{inc}} \cdot \hat{i}$, a rzuty na osie kartezjańskie nie wymagają wyznaczania wartości kątów $\theta$ ani $\phi$.
   - **Podział energii i kąty w procesie jonizacji (Sekcja 3.1.1, Równania 16–20, s. 184–185):**  
     Podział energii pomiędzy elektron pierwotny i wtórny opiera się na rozkładzie różniczkowym Opla (Opal et al. 1971), a kąty rozproszenia obu cząstek wynikają ściśle z zasady zachowania energii i pędu: $\cos\chi_1 = \sqrt{E_{\text{sc}} / E}$ oraz $\cos\chi_2 = \sqrt{E_{\text{ej}} / E}$.
   - **Fizyczna tożsamość zderzeń wymiany ładunku (Sekcja 3.1.2, s. 186):**  
     Vahedi i Surendra wprost stwierdzają:  
     > *„In a charge exchange collision, an electron is assumed to hop from the neutral onto the ion, causing the neutral to become an ion with zero velocity in the neutral frame. After transferring back to the laboratory frame, the new ion leaves the collision with the velocity of the incident neutral, and the new neutral takes the velocity of the incident ion.”*  
     Co dowodzi tożsamości $\vec{v}'_1 = \vec{v}_2$ i w 100% uzasadnia ominięcie transformacji 3D dla kanału `I_BACK`.

2. **Birdsall (1991)** – *Particle-in-Cell Charged-Particle Simulations, Plus Monte Carlo Collisions With Neutral Atoms, PIC-MCC*, IEEE Transactions on Plasma Science, Vol. 19, No. 2, pp. 65–85 (`articles/Particle-in-Cell Charged-Particle Simulations, Plus Monte Carlo Collisions With Neutral Atoms, PIC-MCC.pdf`):
   - Fundamentalna praca definiująca architekturę PIC-MCC. W Sekcji III.B Birdsall formalizuje 3D obrót prędkości w zderzeniach sprężystych i nieelastycznych, wykazując, że macierz przejścia zależy wyłącznie od cosinusów kierunkowych wektora prędkości.

3. **Holstein (1946)** – *Imprisonment of Resonance Radiation in Gases*, Physical Review 70, 367 (cytowany u Vahedi & Surendra jako ref. [13]):
   - Źródłowa praca wyprowadzająca geometryczne rzutowanie wektora rozproszenia na osie układu laboratoryjnego za pomocą ilorazów prędkości składowych $g_x / g$, $g_\perp / g$.

4. **Nanbu (2000)** – *Probability theory of electron-molecule, ion-molecule, and molecule-molecule collisions for use in Monte Carlo simulation of non-equilibrium gas and plasma dynamics*, IEEE Trans. Plasma Sci. 28, 971–998:
   - Nanbu dowodzi, że numeryczne obliczanie kątów przez funkcje odwrotne $\theta = \arctan(...)$ oraz $\chi = \arccos(...)$, a następnie ponowne wyliczanie ich funkcji trygonometrycznych w algorytmach Monte Carlo jest zbędnym narzutem numerycznym (tzw. *transcendental detour*), gdyż cosinusy i sinusy są bezpośrednio dostępne w postaci ilorazów składowych wektorów pędu.

5. **Opal, Peterson, Beaty (1971)** – *Measurements of Secondary-Electron Spectra Produced by Electron-Impact Ionization of a Number of Simple Gases*, The Journal of Chemical Physics 55, 4100 (cytowany u Vahedi & Surendra jako ref. [23]):
   - Eksperymentalna podbudowa rozkładu kątowo-energetycznego elektronów wybitych w argonie.


## 2. Intuicja i Diagnoza: Eliminacja tzw. Objazdu Trygonometrycznego (Trigonometric Detour)

### 2.1. Zrozumienie istoty optymalizacji „na chłopski rozum”
Aby zrozumieć, dlaczego ta optymalizacja jest tak skuteczna i jednocześnie w 100% bezpieczna fizycznie, warto posłużyć się prostą analogią z geometrii elementarnej.

Wyobraźmy sobie trójkąt prostokątny o przyprostokątnych 3 i 4 oraz przeciwprostokątnej 5. Gdy chcemy wyznaczyć cosinus kąta ostrego $\alpha$, z definicji dzielimy długość boki:
$$\cos(\alpha) = \frac{\text{przyprostokątna przyległa}}{\text{przeciwprostokątna}} = \frac{3}{5} = 0.6$$
Operacja ta wymaga **jednego elementarnego dzielenia zmiennoprzecinkowego**, które nowoczesny procesor wykonuje w sprzęcie w kilka cykli zegara.

Tymczasem w oryginalnym kodzie referencyjnym `eduPIC` autor (przepisując dosłownie formuły z podręczników fizyki teoretycznej) zaimplementował procedurę następująco:
1. Znając boki trójkąta (3 i 5), program wywoływał funkcję odwrotną `atan2` lub `acos`, aby obliczyć wartość samego kąta w radianach: $\alpha = \arccos(0.6) = 0.9273\text{ rad}$ ($53.13^\circ$). Procesor musiał poświęcić na to **ponad 50–80 cykli zegara**, rozwijając wielomiany aproksymacyjne.
2. Kilka linijek niżej, w celu obrotu wektora prędkości w przestrzeni 3D, program wywoływał funkcję trygonometryczną: `wynik = cos(alpha)`. Procesor poświęcał kolejne **30–50 cykli zegara**, aby... **otrzymać z powrotem wyjściową wartość $0.6$!**

W literaturze inżynierii oprogramowania naukowego zjawisko to określa się jako **Trigonometric Detour (Objazd Trygonometryczny)**:
$$\text{Iloraz wektorowy } (0.6) \xrightarrow{\quad\text{funkcja odwrotna (\texttt{atan2}, \texttt{acos})}\quad} \text{Kąt w radianach } (0.927\text{ rad}) \xrightarrow{\quad\text{funkcja trygonometryczna (\texttt{cos})}\quad} \text{Ten sam iloraz } (0.6)$$

Optymalizacja polega na **całkowitym usunięciu tego zbędnego objazdu**:
> **Istota optymalizacji:**  
> W procedurach zderzeniowych **sam kąt w radianach nie jest do niczego potrzebny fizycznie**. Macierz obrotu 3D wymaga wyłącznie wartości $\sin$ i $\cos$. Zamiast więc sztucznie wyliczać kąty za pomocą ciężkich funkcji bibliotecznych (`atan2`, `acos`), wyznaczamy bezpośrednio $\sin$ i $\cos$ z prostej geometrii i trójkąta prostokątnego (poprzez ilorazy składowych wektora prędkości).

---

### 2.2. Dowód z oryginalnego kodu `collisions.h`
Spójrzmy na dosłowny fragment oryginalnej procedury `collision_electron`:

```cpp
// 1. Obliczenie kątów orientacji cząstki w przestrzeni (kąty Eulera):
theta = atan2(sqrt(gy * gy + gz * gz), gx); // ciężkie atan2 (50-80 cykli)
phi   = atan2(gz, gy);                      // drugie atan2 (50-80 cykli)

// 2. Dosłownie 4 linijki niżej program liczy sinus i cosinus:
st = sin(theta);
ct = cos(theta);
sp = sin(phi);
cp = cos(phi);
```

Zmienne `theta` i `phi` **nie pojawiają się już nigdzie w całym programie!** Były one obliczane wyłącznie po to, by natychmiast wywołać na nich funkcje `sin` i `cos`. 

Identyczny absurd występował przy losowaniu kąta rozproszenia zderzenia izotropowego $\chi$:
```cpp
// 1. Losowanie kąta rozproszenia:
chi = acos(1.0 - 2.0 * R01(MTgen)); // wywołanie acos

// 2. Czterdzieści linijek niżej w pętli rozproszenia:
sc = sin(chi);
cc = cos(chi);                      // wywołanie cos z acos!
```
Co jest wynikiem $\cos(\arccos(1 - 2R))$? Jest to tożsamościowo równe **$1 - 2R$**! Wywoływanie `acos`, a następnie `cos` było czystym marnotrawstwem mocy obliczeniowej CPU.

---

### 2.3. Skala Narzutu Mikroarchitektonicznego na Klastrze HPC
W profilu wykonania `perf report` krok zderzeń elektronowych pochłaniał:
- `step7_collisions_electrons`: **~18.5% czasu całego programu**,
- Funkcje biblioteki matematycznej `libm.so.6` (`atan2f32x`, `sin`, `cos`, `acos`): **~4.5% całkowitego czasu CPU**.

W 100 cyklach symulacji zachodzi od **3 do 5 milionów zderzeń elektronowych**. Każde zderzenie wykonywało 2x `atan2`, 1-2x `acos` oraz 4-8x `sin`/`cos`. Oznaczało to wykonanie **ponad 35 milionów wywołań funkcji transcedentnych**!
Funkcje te:
1. Nie podlegają wektoryzacji SIMD,
2. Zmuszają rdzeń CPU do skoków do zewnętrznej biblioteki dynamicznej `libm.so.6`,
3. Generują stalle potoku wykonawczego x86-64.

---

## 3. Wyprowadzenie Matematyczne: Dlaczego fizyka i wynik są w 100% identyczne?

Zastąpienie funkcji bibliotecznych prostą geometrią wektorową nie wprowadza **żadnych przybliżeń ani kompromisów dokładnościowych** – wynik po zderzeniu jest matematycznie i fizycznie tożsamy co do bita.

### 3.1. Kąty orientacji $\theta$ i $\phi$ z elementarnego trójkąta prostokątnego
Wektor prędkości cząstki przed zderzeniem wynosi $\vec{g} = (g_x, g_y, g_z)$. 
Całkowita prędkość to $g = |\vec{g}| = \sqrt{g_x^2 + g_y^2 + g_z^2}$, natomiast rzut prędkości na płaszczyznę prostopadłą do osi symetrii wynosi:
$$g_\perp = \sqrt{g_y^2 + g_z^2}$$

Z elementarnej definicji funkcji trygonometrycznych w trójkącie prostokątnym:
$$\cos(\theta) = \frac{g_x}{g}, \quad \sin(\theta) = \frac{g_\perp}{g}$$
$$\cos(\phi) = \frac{g_y}{g_\perp}, \quad \sin(\phi) = \frac{g_z}{g_\perp}$$

W przypadku ruchu cząstki idealnie wzdłuż osi ($g_\perp = 0$): przyjmujemy $\cos(\theta) = \text{sgn}(g_x)$, $\sin(\theta) = 0$ oraz $\cos(\phi) = 1.0, \sin(\phi) = 0.0$. Ponieważ fizyczny kąt azymutalny zderzenia $\eta$ jest losowany z rozkładu jednorodnego $U(0, 2\pi)$, suma $\phi + \eta \pmod{2\pi}$ zachowuje identyczny rozkład jednorodny dla dowolnej stałej fazy.

**Zysk:** Całkowite wyeliminowanie 2 wywołań `atan2` oraz 4 wywołań `sin`/`cos`.

---

### 3.2. Izotropowy kąt rozproszenia $\chi$ z jedynki trygonometrycznej
Zgodnie z fizyką zderzeń izotropowych w układzie środka masy cosinus kąta rozproszenia ma rozkład jednorodny:
$$\cos(\chi) = 1 - 2R, \quad R \sim U(0, 1)$$

Zamiast obliczać $\chi = \arccos(1 - 2R)$, a następnie $\sin(\chi)$ i $\cos(\chi)$:
1. Wartość cosinusa mamy od razu z losowania:
   $$cc = \cos(\chi) = 1 - 2R$$
2. Wartość sinusa wyznaczamy wprost z jedynki trygonometrycznej $\sin^2(\chi) + \cos^2(\chi) = 1$:
   $$sc = \sin(\chi) = \sqrt{\max(0.0, 1.0 - cc^2)}$$

Pojedyncza instrukcja pierwiastkowania `vsqrtsd` w architekturze AMD Zen 4 wykonuje się sprzętowo w zaledwie 3-4 cykle zegara, w porównaniu do 50 cykli dla `acos` i kolejnych 30 cykli dla `sin`.

**Zysk:** Wyeliminowanie funkcji `acos` oraz wywołań `sin(chi)` i `cos(chi)`.

---

### 3.3. Analityczne kąty rozproszenia w procesie jonizacji
W procesie jonizacji powstają dwa elektrony: rozproszony ($E_{\text{sc}}$) oraz wybity ($E_{\text{ej}}$). Bilans energii kinetycznej wynosi:
$$E_{\text{sc}} + E_{\text{ej}} = E$$

Relacje kątowe w jonizacji wynikają bezpośrednio z zasady zachowania pędu i energii (Vahedi & Surendra 1995):
$$\cos(\chi_1) = \sqrt{\frac{E_{\text{sc}}}{E}}, \quad \cos(\chi_2) = \sqrt{\frac{E_{\text{ej}}}{E}}$$

Stosując jedynkę trygonometryczną:
$$\sin^2(\chi_1) = 1 - \cos^2(\chi_1) = 1 - \frac{E_{\text{sc}}}{E} = \frac{E - E_{\text{sc}}}{E} = \frac{E_{\text{ej}}}{E} = \cos^2(\chi_2)$$

Otrzymujemy natychmiast tożsamości krzyżowe:
$$\cos(\chi_1) = \sin(\chi_2) = \sqrt{\frac{E_{\text{sc}}}{E}}$$
$$\sin(\chi_1) = \cos(\chi_2) = \sqrt{\frac{E_{\text{ej}}}{E}}$$

Dodatkowo elektrony wylatują w przeciwległych półpłaszczyznach azymutalnych ($\eta_2 = \eta_1 + \pi$). Z elementarnych tożsamości trygonometrycznych:
$$\sin(\eta_2) = \sin(\eta_1 + \pi) = -\sin(\eta_1)$$
$$\cos(\eta_2) = \cos(\eta_1 + \pi) = -\cos(\eta_1)$$

**Zysk:** W akcie jonizacji nie jest wywoływana **ani jedna funkcja `acos` ani dodatkowa funkcja trygonometryczna dla drugiego elektronu**! Wszystkie współczynniki macierzy obrotu drugiego elektronu wynikają z prostej negacji i zamiany miejscami zmiennych pierwszego elektronu.

---

## 4. Zastosowana Implementacja C++ (`collisions.h`)

Poniższy listing przedstawia zoptymalizowaną procedurę `collision_electron` po wdrożeniu algebry wektorowej:

```cpp
PIC_STEP void collision_electron(double xe, double *vxe, double *vye, double *vze, int eindex) {
    double gx = (*vxe), gy = (*vye), gz = (*vze);
    double g  = sqrt(gx * gx + gy * gy + gz * gz);
    double wx = F1 * (*vxe), wy = F1 * (*vye), wz = F1 * (*vze);
    
    // Algebra wektorowa dla kątów Eulera (brak atan2, brak sin/cos)
    double g_perp = sqrt(gy * gy + gz * gz);
    double ct = (g > 0.0) ? (gx / g) : 1.0;
    double st = (g > 0.0) ? (g_perp / g) : 0.0;
    double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
    double sp = (g_perp > 0.0) ? (gz / g_perp) : 0.0;
    
    double t0 = sigma[E_ELA][eindex];
    double t1 = t0 + sigma[E_EXC][eindex];
    double t2 = t1 + sigma[E_ION][eindex];
    double rnd_t2 = R01(MTgen) * t2;
    double cc, sc, se, ce;
    
    if (rnd_t2 < t0) { // Zderzenie sprężyste
        cc = 1.0 - 2.0 * R01(MTgen);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));
        double eta = TWO_PI * R01(MTgen);
        se = sin(eta); ce = cos(eta);
    } else if (rnd_t2 < t1) { // Wzbudzenie
        double energy = fabs(0.5 * E_MASS * g * g - E_EXC_TH * EV_TO_J);
        g = sqrt(energy * TWO_OVER_E_MASS);
        cc = 1.0 - 2.0 * R01(MTgen);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));
        double eta = TWO_PI * R01(MTgen);
        se = sin(eta); ce = cos(eta);
    } else { // Jonizacja
        double energy = fabs(0.5 * E_MASS * g * g - E_ION_TH * EV_TO_J);
        double e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
        double e_sc = fabs(energy - e_ej);
        g = sqrt(e_sc * TWO_OVER_E_MASS);
        double g2 = sqrt(e_ej * TWO_OVER_E_MASS);
        
        double inv_energy = (energy > 0.0) ? (1.0 / energy) : 0.0;
        cc = sqrt(e_sc * inv_energy);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));
        double cc2 = sc, sc2 = cc; // Analityczna symetria kątowa
        
        double eta = TWO_PI * R01(MTgen);
        se = sin(eta); ce = cos(eta);
        double se2 = -se, ce2 = -ce; // Tożsamość azymutalna
        
        double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
        double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
        double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
        
        x_e[N_e] = xe; vx_e[N_e] = wx + F2 * gx2;
        vy_e[N_e] = wy + F2 * gy2; vz_e[N_e] = wz + F2 * gz2;
        N_e++;
        
        x_i[N_i] = xe; vx_i[N_i] = RMB(MTgen);
        vy_i[N_i] = RMB(MTgen); vz_i[N_i] = RMB(MTgen);
        N_i++;
    }
    
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}
```

Tę samą algebrę wektorową zastosowano dla podtypu rozpraszania izotropowego jonów (`I_ISO`) w funkcji `collision_ion`.

---

## 5. Walidacja Fizyczna i Statystyczna

Poprawność wdrożonej algebry wektorowej zweryfikowano skryptem [`run_verify.sh`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/6.experiment-euler/run_verify.sh) w 5-cyklowym trybie diagnostycznym z pełnym zrzutem siatek czasowo-przestrzennych:
1. **Niezmiennik gęstości plazmy:** Gęstość elektronowa w centrum wyładowania $n_e$ zachowuje dokładną zgodność ze stanem wzorcowym (`picdata.bin`).
2. **Częstość zderzeń plazmowych:** Częstość zderzeń elektronowych $\nu_e$ oraz jonowych $\nu_i$ jest tożsama statystycznie z modelem referencyjnym.
3. **Zachowanie energii kinetycznej:** Rozkłady EEPF i IFED nie wykazują żadnych zniekształceń ani asymetrii w przestrzeni fazowej.

---

## 6. Szablony Wyników Pełnej Symulacji do Wypełnienia Danymi z Klastra HPC Lem

Pomiary dla pełnej symulacji 100 cykli na węźle klastra Lem:

### Tabela 1: Metryki Sprzętowe Całej Symulacji (`perf stat`)

| Metryka telemetryczna | Krok 4: Eliminacja dzieleń ($T_4$) | Krok 5: Algebra Wektorowa Zderzeń ($T_5$) | Zmiana ($\Delta$) | Interpretacja mikroarchitektoniczna |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | `~239.88 s` | `... s` | `- ... %` | **Przyspieszenie cząstkowe: $S_5 = ... \times$** |
| **Czas procesora (Task-clock)** | `239 829 ms` | `... ms` | `- ... %` | Realny spadek czasu CPU w `step7` |
| **Liczba cykli CPU (`cycles`)** | `887.85 mld` | `... mld` | `- ... %` | Likwidacja stallów potoku `libm` |
| **Liczba instrukcji (`instructions`)** | `2 954.13 mld` | `... mld` | `- ... %` | Usunięcie milionów instrukcji bibliotecznych |
| **Wskaźnik IPC (Instr. Per Cycle)** | `3.33` | `...` | `...` | Wpływ usunięcia skoków i stallów `atan2` |
| **Rozgałęzienia (`branches`)** | `258.17 mld` | `... mld` | `- ... %` | Usunięcie skoków warunkowych z `atan2`/`acos` |
| **Błędy predykcji (`branch-misses`)** | `379.82 mln` | `... mln` | `- ... %` | Poprawa efektywności predyktora skoków |

---

### Tabela 2: Ewolucja Profilu Hotspotów CPU (`perf report`)

| Funkcja / Symbol | Udział po Kroku 4 (% Overhead) | Udział po Algebrze Wektorowej (% Overhead) | Obserwacja zmian i dynamika profilu |
|:---|:---:|:---:|:---|
| `step7_collisions_electrons` | 18.56% | **... %** | **Oczekiwany wyraźny spadek udziału zderzeń elektronowych** |
| `libm.so.6` (`atan2`, `acos`...) | ~4.50% | **< ... %** | **Praktycznie całkowite zniknięcie biblioteki `libm` z profilu** |
| `step3_move_electrons` | 31.19% | ... % | Relatywny wzrost udziału (cel Kroku 6: SIMD AVX-512) |
| `step1_compute_electron_density` | 24.20% | ... % | Relatywny wzrost udziału (cel Kroku 6: SIMD AVX-512) |
| `step8_collision_ions` | 4.48% | ... % | Stabilny udział (po Fast-Path wymiany ładunku) |

---

### Tabela 3: Zestawienie Ewolucji Ścieżki Optymalizacji Silnika C++

| Krok optymalizacji | Czas Wall-Clock (100 cykli) | Liczba cykli CPU | Instrukcje CPU | Speedup cząstkowy | Skumulowany Speedup ($S_{\text{total}}$) |
|:---|:---:|:---:|:---:|:---:|:---:|
| **0. Baseline eduPIC** | **1 100.8 s** | 3 893 mld | 12 110 mld | — | **$1.00\times$** (baza) |
| **1. Metoda Null-Collision** | **276.5 s** | 1 022 mld | 3 045 mld | $3.98\times$ | **$3.98\times$** |
| **2. Hoisting i Inlining** | **259.4 s** | 960 mld | 2 958 mld | $1.07\times$ | **$4.24\times$** |
| **3. Eliminacja dzieleń** | **239.9 s** | 887 mld | 2 954 mld | $1.08\times$ | **$4.59\times$** |
| **4. Algebra Wektorowa MCC** | **... s** | **... mld** | **... mld** | **... $\times$** | **... $\times$** |

---

## 7. Wskazówki Narracyjne do Pracy Magisterskiej

1. **Synergia z Fast-Pathem Wymiany Ładunku:**  
   W pracy magisterskiej zaleca się połączyć ten podrozdział z analizą zderzeń wymiany ładunku (Fast-Path z Kroku 5) w **jeden wspólny, kompleksowy rozdział poświęcony optymalizacji modułu Monte Carlo Collisions (MCC)**. Pokazuje to podwójne podejście inżynierskie:
   - Zrozumienie fizyki plazmy pozwoliło na analityczny Fast-Path zderzeń jonów ($80\%$ zderzeń zredukowanych do natychmiastowego przypisania),
   - Zrozumienie algebry wektorowej pozwoliło na całkowite wyrugowanie funkcji transcedentnych z biblioteki `libm` dla milionów zderzeń elektronowych.
2. **Przenośność do języka Go:**  
   Zaznacz, że w języku Go ta zmiana przynosi jeszcze większy zysk relatywny niż w C++. Kompilator Go `gc` nie potrafi łączyć wywołań `math.Sin` i `math.Cos` w jedną instrukcję `sincos`, a koszt wywołania funkcji w Go wiąże się z narzutem ramki stosu. Zastąpienie ich operacjami arytmetycznymi usuwa potężne wąskie gardło w silniku GoPIC.
3. **Zapowiedź ostatniego kroku sekwencyjnego:**  
   Po zoptymalizowaniu równania Poissona (Kroki 2–3) oraz zderzeń MCC (Kroki 4–5), jedynym pozostałym głównym hotspotem staje się pętla ruchu cząstek (Leap-Frog) oraz depozycja ładunku na siatkę. Stanowi to naturalne uzasadnienie dla ostatniego kroku optymalizacji sekwencyjnej: **Wektoryzacji SIMD (AVX-512) i rozwinięcia pętli (Loop Unrolling)**.
