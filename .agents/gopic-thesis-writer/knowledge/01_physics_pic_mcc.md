# Kompendium Wiedzy Fizycznej i Numerycznej: Model PIC/MCC 1D-3V

Niniejszy dokument stanowi bazę wiedzy dla asystenta pracy magisterskiej w zakresie fizyki plazmy, sformułowania matematycznego i dyskretyzacji numerycznej metody Particle-In-Cell z Zderzeniami Monte Carlo (PIC/MCC).

---

## 1. Fizyka Układu: Wyładowanie Pojemnościowe RF (CCRF)

Badanym układem fizycznym jest jednowymiarowe wyładowanie pojemnościowe wielkiej częstotliwości (Capacitively Coupled Radio Frequency — CCRF) w argonie (Ar).

### 1.1. Parametry Geometryczne i Plazmowe Symulacji
- **Długość obszaru wyładowania (odległość między elektrodami):** $L = 0.067\text{ m}$ ($6.7\text{ cm}$).
- **Liczba węzłów siatki przestrzennej:** $N_G = 400$.
- **Krok przestrzenny siatki:** $\Delta x = \frac{L}{N_G - 1} \approx 0.1679\text{ mm}$ (spełnia warunek $\Delta x \le \lambda_D$, gdzie $\lambda_D$ to długość Debye'a).
- **Częstotliwość napięcia zasilającego RF:** $f = 13.56\text{ MHz}$ ($\omega = 2\pi f \approx 8.52\times 10^7\text{ rad/s}$).
- **Amplituda napięcia zasilającego:** $V_{\text{rf}} = 450\text{ V}$.
- **Ciśnienie gazu obojętnego (Argon):** $p = 3.9996\text{ Pa}$ ($30\text{ mTorr}$).
- **Temperatura gazu neutralnego:** $T_g = 300\text{ K}$.
- **Gęstość gazu obojętnego:**  
  $$n_g = \frac{p}{k_B T_g} \approx 9.64\times 10^{20}\text{ m}^{-3}$$
- **Masa elektronu:** $m_e = 9.10938356\times 10^{-31}\text{ kg}$.
- **Masa jonu argonu:** $m_i = 6.6335209\times 10^{-26}\text{ kg}$ ($M_{\text{Ar}} \approx 39.948\text{ u}$).
- **Ładunek elementarny:** $e = 1.602176634\times 10^{-19}\text{ C}$.
- **Przenikalność elektryczna próżni:** $\varepsilon_0 = 8.854187817\times 10^{-12}\text{ F/m}$.

---

## 2. Dyskretyzacja Czasowa i Technika Podkroków (Subcycling)

Ze względu na gigantyczną dysproporcję mas ($m_i / m_e \approx 72820$), elektrony poruszają się z prędkościami o rzędy wielkości większymi od jonów i wymagają znacznie gęstszego kroku czasowego, aby poprawnie opisać oscylacje plazmowe $\omega_{pe}$:

- **Krok czasowy elektronów:** $\Delta t_e = 1.0\times 10^{-11}\text{ s}$ ($10\text{ ps}$).
- **Liczba kroków elektronowych w jednym okresie RF ($T_{\text{rf}} = 1/f \approx 73.75\text{ ns}$):**  
  $$N_T = 4000\text{ kroków/cykl}$$
- **Współczynnik subcyclingu jonów:** $N_{\text{sub}} = 16$.
- **Krok czasowy jonów:** $\Delta t_i = N_{\text{sub}} \cdot \Delta t_e = 1.6\times 10^{-10}\text{ s}$ ($160\text{ ps}$).
- Jony podlegają integracji ruchu i zderzeniom tylko co $16$-ty krok czasowy ($t \pmod{N_{\text{sub}}} == 0$), natomiast ich gęstość ładunku akumuluje się w każdym kroku elektronowym, zapobiegając błędom aliansingu.

---

## 3. Cykl Obliczeniowy 1D-3V PIC/MCC

W każdym kroku czasowym $t$ realizowany jest sekwencyjny cykl operacji:

```
        ┌────────────────────────────────────────────────────────┐
        │  1. Depozycja Ładunku (CIC): Cząstki -> Siatka rho(x)   │
        └──────────────────────────┬─────────────────────────────┘
                                   ▼
        ┌────────────────────────────────────────────────────────┐
        │  2. Rozwiązanie Równania Poissona: d2phi/dx2 = -rho/eps│
        │     Obliczenie Pola Elektrycznego: E = -grad(phi)      │
        └──────────────────────────┬─────────────────────────────┘
                                   ▼
        ┌────────────────────────────────────────────────────────┐
        │  3. Integracja Ruchu (Leap-Frog Boris/Verlet):          │
        │     Przyspieszenie: v(t+dt/2) = v(t-dt/2) + q/m*E*dt   │
        │     Pozycja: x(t+dt) = x(t) + v(t+dt/2)*dt             │
        └──────────────────────────┬─────────────────────────────┘
                                   ▼
        ┌────────────────────────────────────────────────────────┐
        │  4. Obsługa Warunków Brzegowych:                       │
        │     Absorpcja na elektrodach (x < 0 lub x > L)         │
        │     Kompaktacja tablic cząstek O(dead)                 │
        └──────────────────────────┬─────────────────────────────┘
                                   ▼
        ┌────────────────────────────────────────────────────────┐
        │  5. Zderzenia Kinetyczne Monte Carlo (MCC):            │
        │     Metoda Zderzeń Zerowych (Null-Collision)           │
        │     e- / Ar (Phelps) oraz Ar+ / Ar (CX, sprężyste)     │
        └──────────────────────────┬─────────────────────────────┘
                                   ▼
        ┌────────────────────────────────────────────────────────┐
        │  6. Zbieranie Diagnostyk Czasoprzestrzennych (XT)      │
        └────────────────────────────────────────────────────────┘
```

---

## 4. Szczegóły Matematyczne Poszczególnych Faz

### 4.1. Depozycja Ładunku metodą Cloud-in-Cell (CIC)
Cząstka o ciągłej pozycji $x_k$ rzutowana jest na węzły siatki $p = \lfloor x_k / \Delta x \rfloor$ oraz $p+1$ z wagami liniowymi:
$$d = \frac{x_k}{\Delta x} - p, \quad w_1 = 1 - d, \quad w_2 = d$$
Ładunek w węzłach:
$$\rho[p] += w_1 \cdot W_p, \quad \rho[p+1] += w_2 \cdot W_p$$
gdzie $W_p$ to waga statystyczna makrocząstki.  
**Korekta skrajnych półkomórek na elektrodach:** Węzły brzegowe $0$ oraz $N_G-1$ reprezentują objętość komórki o połowę mniejszą ($\Delta x / 2$), dlatego ich gęstość musi zostać podwojona:
$$\rho[0] \leftarrow 2 \cdot \rho[0], \quad \rho[N_G-1] \leftarrow 2 \cdot \rho[N_G-1]$$

### 4.2. Równanie Poissona i Solver Thomasa
Równanie Poissona w 1D:
$$\frac{\partial^2 \phi}{\partial x^2} = -\frac{\rho(x)}{\varepsilon_0}$$
Dyskretyzacja drugą pochodną ilorazem różnicowym:
$$\frac{\phi_{p-1} - 2\phi_p + \phi_{p+1}}{\Delta x^2} = -\frac{\rho_p}{\varepsilon_0}$$
Warunki brzegowe Dirichleta:
$$\phi(0, t) = V_{\text{rf}} \sin(\omega t), \quad \phi(L, t) = 0$$
Prowadzi to do układu równań z macierzą trójprzekątniową o stałych współczynnikach $A = 1, B = -2, C = 1$.  
Rozwiązywany algorytmem Thomasa ($O(N_G)$ operacji). Współczynniki eliminacji w przód $w_p$ są stałe w czasie i prekomputowane podczas inicjalizacji symulacji:
$$w_1 = \frac{C}{B}, \quad w_p = \frac{C}{B - A \cdot w_{p-1}} \quad (p = 2 \dots N_G-2)$$

Pole elektryczne wyznaczane centralnym ilorazem różnicowym wewnątrz domeny:
$$E_p = \frac{\phi_{p-1} - \phi_{p+1}}{2\Delta x}$$
oraz jednostronnymi ilorazami na brzegach.

### 4.3. Integrator Czasowy Leap-Frog
Schemat Leap-Frog (Boris/Verlet dla siły elektrostatycznej):
$$v_x^{t+\Delta t/2} = v_x^{t-\Delta t/2} + \frac{q}{m} E(x^t) \Delta t$$
$$x^{t+\Delta t} = x^t + v_x^{t+\Delta t/2} \Delta t$$
Dla diagnostyk energii kinetycznej i prądu plazmy w chwili całkowitej $t$, prędkość synchronizowana jest do półkroku wstecz:
$$\bar{v}_x^t = v_x^{t+\Delta t/2} - \frac{1}{2} \frac{q}{m} E(x^t) \Delta t$$

### 4.4. Zderzenia Kinetyczne: Metoda Zderzeń Zerowych (Null-Collision)
Metoda Null-Collision (Skullerud, Vahedi & Surendra) eliminuje konieczność wyliczania prawdopodobieństwa zderzenia dla każdej cząstki z osobna:
1. Określa się maksymalną częstość zderzeń w całym zakresie energii:
   $$\nu^* = \max_E (\sigma_{\text{tot}}(E) \cdot v(E)) \cdot n_g$$
2. Maksymalne prawdopodobieństwo zderzenia cząstki w kroku $\Delta t$:
   $$P^* = 1 - \exp(-\nu^* \Delta t) \approx \nu^* \Delta t$$
3. Liczba cząstek typowanych do testu zderzeniowego $N_{\text{coll}}$ losowana jest z rozkładu dwumianowego $B(N, P^*)$ (w optymalizacji: aproksymacja de Moivre'a-Laplace'a rozkładem normalnym).
4. Dla $N_{\text{coll}}$ wylosowanych cząstek testuje się rzeczywisty przekrój czynny $\sigma_{\text{tot}}(E)$ i wykonuje zderzenie właściwe lub fikcyjne (zderzenie zerowe — brak zmiany pędu).
