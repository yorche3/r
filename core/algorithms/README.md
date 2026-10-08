# Algorithms Pure — R

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **R**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **vectores atómicos** (el «array» de R), ordenados con bucles indexados **1-based**, y usan **`NULL`** como indicador de fallo, que `is.null()` distingue del vector vacío `integer(0)`.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `make test` + testthat | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── DESCRIPTION                  # Manifiesto del paquete (naiveSort)
    ├── NAMESPACE                    # Las 3 funciones exportadas
    ├── Makefile                     # Punto de entrada: make test
    ├── R/
    │   └── naive_sort.R             # 3 funciones del contrato
    ├── tests/
    │   ├── testthat.R               # test_check() para R CMD check
    │   └── testthat/
    │       └── test-naive-sort.R    # 3 tests × 8 casos
    ├── .gitignore                   # Ignora artefactos de R
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | R 4.x (`Rscript`), intérprete sin paso de compilación a un artefacto |
| **CLI** | `make test` desde la raíz del módulo |
| **Andamiaje** | ✍️ Estructura manual (`mkdir -p R tests/testthat`), la que ya usa [`foundations/numbers/`](../foundations/numbers/); el manifiesto es el `DESCRIPTION` del paquete |
| **Framework de tests** | testthat (`test_that`, `expect_equal`) |
| **Runner** | `Makefile` (`make test`) sobre `testthat::test_local()`: descubre `tests/testthat/test*.R` y carga el paquete sin instalarlo |
| **Separación** | `R/` (código del contrato) ↔ `tests/testthat/` (suites) |
| **Carga del módulo** | `pkgload::load_all()` a través de `test_local()`; el módulo es un paquete de R (`DESCRIPTION` + `NAMESPACE`), no un script cargado con `source()` |
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
make test
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
