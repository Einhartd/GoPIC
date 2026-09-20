# Poradnik Stylistyczny i Szablony LaTeX dla Pracy Magisterskiej

Niniejszy dokument definiuje reguły edytorskie, konwencje językowe oraz szablony środowisk LaTeX, które asystent musi stosować podczas formułowania treści pracy dyplomowej.

---

## 1. Konwencje Językowe i Styl Naukowy

### 1.1. Forma Gramatyczna
- Obowiązuje wyłącznie **język polski w rejestrze formalnym / akademickim**.
- Stosowanie **formy bezosobowej** lub **strony biernej**:
  - PRAWIDŁOWO: *"W pracy przedstawiono..."*, *"Zaimplementowano algorytm..."*, *"Pomiary wykazały..."*, *"Zaobserwowano spadek opóźnień..."*.
  - NIEDOPUSZCZALNE: *"Zrobiłem..."*, *"Napisałem funkcję..."*, *"Zauważyliśmy..."*, *"W moim kodzie..."*.

### 1.2. Słownik Standardowej Terminologii Informatycznej i Fizycznej
Aby uniknąć żargonu środowiskowego i kalk językowych z angielskiego, należy stosować ujednoliconą terminologię:

| Pojęcie Angielskie | Poprawne Polskie Tłumaczenie Akademickie |
| :--- | :--- |
| **Garbage Collector (GC)** | Odśmiecacz pamięci / moduł automatycznego zarządzania pamięcią |
| **Stop-The-World (STW) pause** | Faza wstrzymania wykonania wątków / faza STW |
| **Bounds Check Elimination (BCE)** | Eliminacja sprawdzania granic tablic |
| **Loop Unrolling** | Rozwinięcie pętli (np. 4-krotne rozwinięcie pętli) |
| **False Sharing** | Fałszywe współdzielenie (linii pamięci podręcznej) |
| **Cache Line Bouncing** | Odrzucanie / migracja linii pamięci podręcznej w protokole spójności |
| **Lock-Free Barrier** | Bezblokadowa bariera synchronizacyjna |
| **Star Topology** | Topologia gwiazdy (bariera w architekturze gwiazdy) |
| **Gather / Scatter** | Operacja rozproszonego odczytu (zbierania) / zapisu (rozpraszania) |
| **Autovectorization** | Autowektoryzacja (wektoryzacja automatyczna) |
| **Instruction-Level Parallelism (ILP)** | Równoległość na poziomie instrukcji |
| **Charge Deposition (CIC)** | Depozycja ładunku metodą chmury w komórce (Cloud-in-Cell) |
| **Charge Exchange (CX)** | Zderzenie wymiany ładunku (przeładowanie) |
| **Null-Collision Method** | Metoda Zderzeń Zerowych |
| **Throughput / Bandwidth** | Przepustowość magistrali pamięci |

---

## 2. Szablony Środowisk LaTeX

### 2.1. Tabele z Pakietem `booktabs`
Wszystkie tabele z wynikami powinny być formatowane w sposób czytelny, z liniami `\toprule`, `\midrule`, `\bottomrule` (bez pionowych linii):

```latex
\begin{table}[htbp]
\centering
\caption{Zestawienie narzutu barier synchronizacyjnych dla $20\,000$ wywołań na procesorze AMD Zen 4.}
\label{tab:barrier_latency}
\begin{tabular}{lrrrr}
\toprule
\textbf{Mechanizm bariery} & \textbf{Liczba wątków $P$} & \textbf{Czas cyklu [ms]} & \textbf{Narzut / bariera [ns]} & \textbf{Przyspieszenie} \\
\midrule
Go Channels (CSP)       & 8 & 128 & 6395.9 & 1.00$\times$ (ref) \\
\texttt{sync.WaitGroup} & 8 & 69  & 3466.1 & 1.85$\times$ \\
\textbf{StarBarrier (PAUSE)} & 8 & \textbf{17} & \textbf{842.2} & \textbf{7.59$\times$} \\
\bottomrule
\end{tabular}
\end{table}
```

### 2.2. Wzory Matematyczne (`amsmath` / `align`)
Równania fizyczne powinny być numerowane i czytelnie opisane:

```latex
\begin{equation}
\label{eq:leapfrog_velocity}
v_x^{t+\Delta t/2} = v_x^{t-\Delta t/2} + \frac{q}{m} E(x^t) \Delta t
\end{equation}

\begin{equation}
\label{eq:leapfrog_position}
x^{t+\Delta t} = x^t + v_x^{t+\Delta t/2} \Delta t
\end{equation}
```

Dla układu równań:
```latex
\begin{align}
\nu^* &= \max_{E} \left( \sigma_{\text{tot}}(E) \cdot v(E) \right) \cdot n_g, \label{eq:nu_star} \\
P^*   &= 1 - \exp(-\nu^* \Delta t) \approx \nu^* \Delta t. \label{eq:p_star}
\end{align}
```

### 2.3. Wykresy w Pakiecie `pgfplots`
Wykres skalowalności przyspieszenia ($S(P)$ względem liczby wątków):

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}
\begin{axis}[
    width=0.85\textwidth,
    height=6.5cm,
    xlabel={Liczba rdzeni / wątków ($P$)},
    ylabel={Przyspieszenie ($S$)},
    xmin=1, xmax=16,
    ymin=1, ymax=16,
    grid=both,
    legend pos=north west,
    legend cell align={left}
]
\addplot[dashed, color=gray, line width=1pt] coordinates {(1,1) (2,2) (4,4) (8,8) (16,16)};
\addlegendentry{Liniowe (idealne)}

\addplot[color=blue, mark=square*, line width=1.2pt] coordinates {
    (1, 1.00) (2, 1.94) (4, 3.81) (8, 7.42)
};
\addlegendentry{C++ OpenMP}

\addplot[color=red, mark=*, line width=1.2pt] coordinates {
    (1, 1.00) (2, 1.88) (4, 3.65) (8, 6.89)
};
\addlegendentry{Go StarBarrier (Krok 5)}
\end{axis}
\end{tikzpicture}
\caption{Przyspieszenie symulacji w funkcji liczby wątków na module AMD EPYC CCX.}
\label{fig:scaling_comparison}
\end{figure}
```
