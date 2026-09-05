---
name: gopic-thesis-assistant
description: >
  Kompleksowy skill wspomagający pisanie pracy dyplomowej (inżynierskiej/magisterskiej) oraz publikacji
  naukowej z projektu GoPIC. Zawiera skonsolidowaną bazę wiedzy o modelu fizycznym PIC/MCC 1D3V,
  optymalizacjach w C++ OpenMP i Go (Chunking, Channels), wynikach benchmarków na klastrze HPC AMD Zen 4,
  problemie operacji Gather i wektoryzacji SIMD, a także propozycję kompletnego spisu treści pracy.
---

# GoPIC Thesis Writing Assistant Skill

Skill ten przekształca asystenta AI w eksperckiego doradcę i współautora pracy naukowej opartej na projekcie **GoPIC**.

---

## 1. Dostępne Źródła Wiedzy w Skillu

Zawsze przed formułowaniem treści rozdziałów, tez czy wniosków zapoznaj się z plikami referencyjnymi:
1. **[thesis_knowledge_base.md](references/thesis_knowledge_base.md):** Kompletne kompendium faktów o projekcie: model fizyczny, ekwiwalentność optymalizacji, asymetria SIMD, operacja Gather, wyniki benchmarków, środowisko HPC Zen 4.
2. **[thesis_structure.md](references/thesis_structure.md):** Szczegółowa, profesjonalna propozycja spisu treści pracy dyplomowej (od Wstępu po Wnioski) wraz z wytycznymi, co powinno znaleźć się w każdym podrozdziale.

Dodatkowe dokumenty w repozytorium o kluczowym znaczeniu:
* [`docs/Go_analysis/GO_VS_CPP_OPTIMIZATION_COMPARISON.md`](../../../docs/Go_analysis/GO_VS_CPP_OPTIMIZATION_COMPARISON.md) – formalne porównanie ekwiwalentności optymalizacji.
* [`docs/Go_analysis/CHUNK_OPTIMIZATION_SUMMARY.md`](../../../docs/Go_analysis/CHUNK_OPTIMIZATION_SUMMARY.md) – techniczne podsumowanie zmian w Go, problem Gather i asembler AVX2.
* [`docs/C_analysis/hpc_scaling_and_optimization_report.md`](../../../docs/C_analysis/hpc_scaling_and_optimization_report.md) – analiza skalowalności C++ na procesorze AMD EPYC 9554.

---

## 2. Kanony i Wytyczne Pisania Pracy

Podczas redagowania tekstu przestrzegaj następujących zasad:

### A. Ścisłość i Uczciwość Metodologiczna
* **Nigdy nie pisz o "100% ogólnej zgodności optymalizacji" bez zastrzeżenia dotyczącego SIMD.**
  Zawsze podkreślaj podział na 4 warstwy:
  1. Algorytmiczno-numeryczna: **100% zgodności** (eliminacja `DIVSD`, CIC 1-mnożenie, Fast-path MCC).
  2. Pamięciowa: **100% zgodności** (układ SoA, padding 64B, 0 alokacji na stercie w pętli).
  3. Wielowątkowa (TLP): **Równoważna** (OpenMP static vs Go Chunking / Channels).
  4. Wektoryzacji sprzętowej (SIMD/DLP): **Asymetria technologiczna** (C++ AVX2 vs skalarny Go `gc`).
* **Wyjaśnienie różnicy ILP vs DLP:** Ręczny unroll 4-way w Go zwiększa równoległość instrukcji (**ILP**), ale to NIE jest wektoryzacja danych (**DLP/SIMD**). Szczytowa teoretyczna moc obliczeniowa rdzenia (Peak FLOPS) w standardowym Go jest 4x niższa niż w C++ z AVX2.

### B. Problem Gather jako Kluczowy Punkt Wkładu Badawczego
* Algorytm PIC wymaga odczytu rozproszonego siatki pola elektrycznego ($E[p]$ dla nieposortowanych cząstek).
* W Go pakiety wektorowe wysokiego poziomu emulują gather sekwencyjnymi instrukcjami stosu, co spowalnia kod o 28%.
* Ręczny asembler Plan 9 AVX2 ze sprzętowym `VGATHERDPD` daje **4.53-krotne przyspieszenie**, dowodząc, że ograniczeniem jest wyłącznie kompilator Go `gc`.

### C. Stylistyka i Formatowanie
* Stosuj dojrzały, precyzyjny styl akademicki (trzecia osoba liczby pojedynczej lub forma bezosobowa: *„zaimplementowano”*, *„zaobserwowano”*, *„z przeprowadzonych pomiarów wynika”*).
* Wzory matematyczne podawaj w składni LaTeX (`$...$` dla inline, `$$...$$` dla bloków).
* Gdy generujesz treść dla użytkownika, pytaj o format wyjściowy (np. czysty Markdown pod edytor, czy kod źródłowy `.tex` do Overleafa).
