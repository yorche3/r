# 🚀 Fundamentos / Foundations — R

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **R**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **R**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **R**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
r/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── helloworld.r
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hellouser.r
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── src/
        │       │   └── calculator.R
        │       ├── test/
        │       │   └── calculator_test.R
        │       ├── .gitignore
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── src/
            │   └── numbers.R
            ├── test/
            │   ├── recursive_tests.R
            │   ├── iterative_tests.R
            │   └── run_tests.R
            ├── .gitignore
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `print`, ejecución con `Rscript` | — | ❌ Solo stdlib |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `cat` + `readLines("stdin")`, `paste0`, `flush` | — | ❌ Solo stdlib |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | testthat, `test_that`, `expect_equal`, `source()` | 5 | ✅ testthat (solo test) |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, iteración, acumuladores, TCO, `seq_len` | 10 | ✅ testthat (solo test) |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo, ejecutados directamente con `Rscript`. Usan exclusivamente la biblioteca estándar.
2. **Calculator**: Primer proyecto con framework de pruebas (**testthat**, el estándar de R y de CRAN). Introduce la separación `src/` + `test/` y la carga del módulo con `source()`.
3. **Numbers**: Expande el patrón a dos suites con punto de entrada `run_tests.R`. R **no garantiza TCO**, por lo que `_acc` se conserva como puente didáctico sin pruebas propias: `_rec` + `_ite` = 10 tests (22 casos).

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file programs, run directly with `Rscript`. Use only the standard library.
2. **Calculator**: First project with a test framework (**testthat**, the standard for R and CRAN). Introduces the `src/` + `test/` separation and module loading with `source()`.
3. **Numbers**: Expands the pattern to two suites with a `run_tests.R` entry point. R **does not guarantee TCO**, so `_acc` is kept as an educational bridge without dedicated tests: `_rec` + `_ite` = 10 tests (22 cases).

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd r/core/foundations/helloworld
Rscript helloworld.r
```

### Hello User

```bash
cd r/core/foundations/hellouser
Rscript hellouser.r
```

### Calculator (pruebas)

```bash
cd r/core/foundations/unit_test/calculator
Rscript -e 'testthat::test_file("test/calculator_test.R")'
```

### Numbers (pruebas)

```bash
cd r/core/foundations/numbers
Rscript test/run_tests.R
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
