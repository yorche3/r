# Algorithms Pure — R

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **R**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **vectores atómicos** (el «array» de R), ordenados con bucles indexados **1-based**, y usan **`NULL`** como indicador de fallo, que `is.null()` distingue del vector vacío `integer(0)`.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `Rscript test/run_tests.R` + testthat | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── src/
    │   └── naive_sort.R             # 3 funciones del contrato
    ├── test/
    │   ├── naive_sort_tests.R       # 3 tests × 8 casos
    │   └── run_tests.R              # Punto de entrada
    ├── .gitignore                   # Ignora artefactos de R
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | R 4.x (`Rscript`), intérprete sin paso de compilación a un artefacto |
| **CLI** | `Rscript test/run_tests.R` desde la raíz del módulo |
| **Andamiaje** | ✍️ Estructura manual (`mkdir -p src test`), la que ya usa [`foundations/numbers/`](../foundations/numbers/); no hay manifiesto de dependencias |
| **Framework de tests** | testthat (`library(testthat)`, `test_that`, `expect_equal`) |
| **Runner** | `test/run_tests.R` con `test_file(...)`: testthat no descubre archivos `*_tests.R` con su patrón por defecto (`test*`), así que R sí necesita el punto de entrada |
| **Separación** | `src/` (módulo) ↔ `test/` (suites y punto de entrada) |
| **Carga del módulo** | `source("../src/{modulo}.R")` al inicio de la suite; R no tiene importaciones para scripts sueltos |
| **Iteración** | Bucles `for` con `seq_len()` y `while`; R no garantiza recursión de cola (TCO) |
| **Indexación** | 1-based (`arr[i]`), con las cotas calculadas por el algoritmo |
| **API** | Una función por algoritmo, con `arr` como nombre del parámetro (el de la documentación) |
| **Mutabilidad** | *Copy-on-modify*: la función ordena su copia local y devuelve el vector; el del llamador no se modifica |
| **Naming** | `snake_case` idéntico al de la especificación (`selection_sort`), conservado como nombre del test |
| **Nulabilidad** | `NULL` es representable: el caso nulo se incluye y devuelve `NULL`, sin excepciones; el vector vacío es `integer(0)` (¡`c()` es `NULL`!) |
| **Verificación estática** | `parse()` (`Rscript -e 'invisible(parse(...))'`) y `lintr::lint(...)` |
| **Gotcha de rangos** | En R `1:0` es `c(1, 0)` y `(n+1):n` es `c(n+1, n)`, **no** vacíos: las cotas de los bucles se escriben con `seq_len()` |
| **Artefactos** | `.Rhistory`, `.RData`, `.Rproj.user`, `.Renviron`, `*.tar.gz`, `*.Rcheck/` — ignorados por el `.gitignore` del módulo |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
Rscript test/run_tests.R
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
