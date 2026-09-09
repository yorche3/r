# R

Proyectos en **R**, con programas simples ejecutados con el intérprete
`Rscript` y proyectos con pruebas unitarias gestionados con **testthat**, el
framework de pruebas estándar de R (usado por CRAN y `R CMD check`).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
Rscript helloworld.r

# Hello, User!
cd core/foundations/hellouser
Rscript hellouser.r

# Calculator Tests
cd core/foundations/unit_test/calculator
Rscript -e 'testthat::test_file("test/calculator_test.R")'

# Numbers Tests
cd core/foundations/numbers
Rscript test/run_tests.R
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [R](https://www.r-project.org/) | `sudo apt install r-base` (Linux) / [Descargar](https://cran.r-project.org/) |
| [testthat](https://testthat.r-lib.org/) | `sudo apt install r-cran-testthat` (Linux/Debian) / `install.packages("testthat")` |

```bash
# Verificar instalación
R --version
Rscript -e 'packageVersion("testthat")'
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (interpretado con `Rscript`)

**ES:** Un único archivo fuente, sin dependencias externas, ejecutado directamente
con `Rscript`, la herramienta de ejecución por lotes de R. Ideal para `helloworld`
y `hellouser`. Solo requiere la biblioteca estándar.

**EN:** A single source file, no external dependencies, run directly with
`Rscript`, R's batch execution tool. Ideal for `helloworld` and `hellouser`. Only
the standard library is required.

```bash
Rscript <File>.r
```

### 2. Proyecto con pruebas unitarias (testthat)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **testthat** como
framework de test. El código fuente se organiza en `src/` y las pruebas en `test/`.
R no tiene importación de módulos para scripts sueltos: las suites cargan el
código con `source()` y se ejecutan con `test_file`.

**EN:** For projects that require unit tests, **testthat** is used as the test
framework. Source code goes in `src/` and tests in `test/`. R has no module
imports for loose scripts: suites load the code with `source()` and run it with
`test_file`.

```bash
Rscript -e 'testthat::test_file("test/<suite>.R")'   # una suite
Rscript test/run_tests.R                              # punto de entrada (todas)
```

> **ES:** testthat solo descubre por defecto archivos con prefijo `test*`; para
> suites con otros nombres se usa `test_file` o un `run_tests.R` propio.
> **EN:** testthat only discovers files with the `test*` prefix by default; for
> suites with other names, use `test_file` or a custom `run_tests.R`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio
principal](https://github.com/yorche3/programming_languages) para ver todas las
versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*