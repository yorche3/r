# Calculator — R

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **R**, con **testthat** como framework de pruebas unitarias — el estándar de facto de R, usado por CRAN y `R CMD check`.

Operaciones aritméticas básicas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) con implementaciones intuitivas y educativas, validadas mediante pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/calculator.R`](src/calculator.R) | Código fuente: las 5 funciones del módulo `calculator`. |
| [`test/calculator_test.R`](test/calculator_test.R) | Suite de pruebas: 5 `test_that` con `expect_equal`. |
| [`.gitignore`](.gitignore) | Ignora `.Rhistory`, `.RData` y otros artefactos de R. |

**Estructura de directorios esperada:**

```text
calculator/
├── src/
│   └── calculator.R        # Código fuente
├── test/
│   └── calculator_test.R   # Suite de pruebas
├── .gitignore
└── README.md               # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. R no tiene sistema de importación para scripts sueltos: el módulo `calculator` es un archivo `calculator.R` con funciones que la suite carga con `source()`. Las pruebas usan **testthat**, la biblioteca de tests más robusta y extendida de R (verifica con `expect_equal` y reporta `FAIL/WARN/SKIP/PASS` por test).

**EN:** The project was created manually, without scaffolding tools. R has no import system for loose scripts: the `calculator` module is a `calculator.R` file with functions that the suite loads with `source()`. Tests use **testthat**, R's most robust and widespread test library (verifies with `expect_equal` and reports `FAIL/WARN/SKIP/PASS` per test).

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p r/core/foundations/unit_test/calculator/{src,test}
   ```

2. Escribir `src/calculator.R` y `test/calculator_test.R`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El módulo se carga en la suite con `source()`.

### `src/calculator.R` — Implementaciones educativas

**ES:** Cada operación compleja se construye a partir de las simples (concepto que se explora a fondo en `04_Numbers`): `multiplication` suma repetidamente, `division` resta repetidamente y `modulus` reutiliza `division` y `multiplication`. Por eso **no** se usan los operadores `*`, `/` ni `%%`.

**EN:** Each complex operation is built from the simple ones (a concept explored in depth in `04_Numbers`): `multiplication` adds repeatedly, `division` subtracts repeatedly, and `modulus` reuses `division` and `multiplication`. That's why the operators `*`, `/` and `%%` are **not** used.

```r
addition <- function(a, b) {
  return(a + b)
}

subtraction <- function(a, b) {
  return(a - b)
}

multiplication <- function(a, b) {
  result <- 0
  for (i in 1:b) {
    result <- addition(result, a)
  }
  return(result)
}

division <- function(a, b) {
  quotient <- 0
  while (a >= b) {
    a <- subtraction(a, b)
    quotient <- addition(quotient, 1)
  }
  return(quotient)
}

modulus <- function(a, b) {
  q <- division(a, b)
  p <- multiplication(q, b)
  return(subtraction(a, p))
}
```

| Función | Implementación educativa |
|---------|-------------------------|
| `addition(a, b)` | Suma directa (`a + b`) |
| `subtraction(a, b)` | Resta directa (`a - b`) |
| `multiplication(a, b)` | Suma repetitiva: `for (i in 1:b)` suma `a` a `result` |
| `division(a, b)` | Resta repetitiva: `while (a >= b)` resta `b` y cuenta |
| `modulus(a, b)` | `q <- division(a, b)`; `p <- multiplication(q, b)`; `subtraction(a, p)` |

### `test/calculator_test.R` — Suite testthat

**ES:** La suite agrupa un `test_that` por función (5 tests, uno por operación), cada uno con su `expect_equal`. El `source("../src/calculator.R")` carga el módulo para que las funciones estén disponibles.

**EN:** The suite groups one `test_that` per function (5 tests, one per operation), each with its `expect_equal`. `source("../src/calculator.R")` loads the module so the functions are available.

```r
library(testthat)

source("../src/calculator.R")

test_that("addition", {
  expect_equal(addition(2, 3), 5)
})

test_that("subtraction", {
  expect_equal(subtraction(5, 2), 3)
})

test_that("multiplication", {
  expect_equal(multiplication(3, 4), 12)
})

test_that("division", {
  expect_equal(division(10, 3), 3)
})

test_that("modulus", {
  expect_equal(modulus(10, 3), 1)
})
```

> **ES:** testthat ya incluye su propio runner, así que no se crea el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).
> **EN:** testthat already includes its own runner, so the pseudocode's `run_tests` is not created (the specification asks for it only if the framework doesn't include one).

> **ES:** No se usa `testthat::test_dir("test")` porque su patrón por defecto solo descubre archivos con prefijo `test*`; la suite se llama `calculator_test.R` según la especificación, por lo que se ejecuta con `test_file`.
> **EN:** `testthat::test_dir("test")` is not used because its default pattern only discovers files with a `test*` prefix; the suite is called `calculator_test.R` per the specification, so it is run with `test_file`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **R** (`Rscript`).
- **testthat** (`library(testthat)`).

```bash
# Verificar instalación
R --version
Rscript -e 'packageVersion("testthat")'

# Instalar testthat (Linux/Debian)
sudo apt install r-cran-testthat
```

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto:

```bash
cd r/core/foundations/unit_test/calculator
Rscript -e 'testthat::test_file("test/calculator_test.R")'
```

### Salida esperada / Expected output

```text
══ Testing calculator_test.R ═══════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ] Done!
```

> **ES:** `PASS 5` confirma que las 5 operaciones se verificaron correctamente (equivale al `Tests run: 5, Passed: 5, Failed: 0` de la especificación).
> **EN:** `PASS 5` confirms that all 5 operations were verified correctly (equivalent to the specification's `Tests run: 5, Passed: 5, Failed: 0`).

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** R no tiene importación de módulos para scripts sueltos; `source()` es el mecanismo idiomático para cargar el código fuente en la suite.
- **EN:** R has no module imports for loose scripts; `source()` is the idiomatic mechanism to load source code into the suite.
- **ES:** La división por cero no se maneja en este ejemplo educativo (según el pseudocódigo de la especificación); las pruebas usan valores válidos.
- **EN:** Division by zero is not handled in this educational example (per the specification's pseudocode); tests use valid values.
- **ES:** Solo se usa la biblioteca estándar en el código fuente; `testthat` es la única dependencia externa y únicamente para pruebas.
- **EN:** Only the standard library is used in the source code; `testthat` is the only external dependency and only for tests.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
