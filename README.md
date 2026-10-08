# R

Proyectos en **R**, con programas simples ejecutados con el intérprete
`Rscript` y proyectos con pruebas unitarias gestionados con **testthat**, el
framework de pruebas estándar de R (usado por CRAN y `R CMD check`).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |
| [`core/algorithms/`](core/algorithms/) | **Fase 1 — Algoritmos Puros**: `naive_sort`, `data_structures_basics` |

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
make test

# Numbers Tests
cd core/foundations/numbers
make test

# Naive Sort Tests
cd core/algorithms/naive_sort
make test

# Data Structures Basics Tests
cd core/algorithms/data_structures_basics
make test
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
framework de test y el módulo se estructura como **paquete de R**: `DESCRIPTION`
(nombre, versión, licencia y dependencias), `NAMESPACE` (lo que se exporta), el
código en `R/` y las suites en `tests/testthat/`, con el prefijo `test-` que
testthat descubre por defecto. No hace falta instalar el paquete: `test_local()`
lo carga con `pkgload::load_all()`.

**EN:** For projects that require unit tests, **testthat** is used as the test
framework and the module is laid out as an **R package**: `DESCRIPTION` (name,
version, license and dependencies), `NAMESPACE` (what is exported), the code in
`R/` and the suites in `tests/testthat/`, with the `test-` prefix testthat
discovers by default. There is no need to install the package: `test_local()`
loads it with `pkgload::load_all()`.

```bash
make test                                             # todas las suites
Rscript -e 'testthat::test_local(filter = "<suite>")' # una sola suite
```

> **ES:** El punto de entrada es un `Makefile` con el objetivo `test`: el módulo
> se ejecuta con un único comando, `make test`, y testthat descubre las suites
> por sí solo.
> **EN:** The entry point is a `Makefile` with the `test` target: the module runs
> with a single command, `make test`, and testthat discovers the suites on its
> own.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio
principal](https://github.com/yorche3/programming_languages) para ver todas las
versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*