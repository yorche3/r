# Calculator — R

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **R**, con **testthat** como framework de pruebas unitarias — el estándar de facto de R, usado por CRAN y `R CMD check`.

Operaciones aritméticas básicas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) con implementaciones intuitivas y educativas, validadas mediante pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`DESCRIPTION`](DESCRIPTION) | Manifiesto del paquete `calculator`: versión, licencia y dependencia de testthat. |
| [`NAMESPACE`](NAMESPACE) | Exporta las 5 funciones del módulo. |
| [`R/calculator.R`](R/calculator.R) | Código fuente: las 5 funciones del módulo `calculator`. |
| [`Makefile`](Makefile) | Punto de entrada: `make test`. |
| [`tests/testthat/test-calculator.R`](tests/testthat/test-calculator.R) | Suite de pruebas: 5 `test_that` con `expect_equal`. |
| [`tests/testthat.R`](tests/testthat.R) | `test_check("calculator")`, la comprobación que usa `R CMD check`. |
| [`.gitignore`](.gitignore) | Ignora `.Rhistory`, `.RData` y otros artefactos de R. |

**Estructura de directorios esperada:**

```text
calculator/
├── DESCRIPTION                 # Manifiesto del paquete (calculator)
├── NAMESPACE                   # Las 5 funciones exportadas
├── Makefile                    # Punto de entrada: make test
├── R/
│   └── calculator.R            # Código fuente
├── tests/
│   ├── testthat.R              # test_check() para R CMD check
│   └── testthat/
│       └── test-calculator.R   # Suite de pruebas
├── .gitignore
└── README.md                   # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. El módulo `calculator` es un paquete de R (`DESCRIPTION`, `NAMESPACE` y `R/`) cuyas funciones la suite alcanza sin `source()`: `make test` llama a `testthat::test_local()`, que carga el paquete con `pkgload::load_all()` sin instalarlo. Las pruebas usan **testthat**, la biblioteca de tests más robusta y extendida de R (verifica con `expect_equal` y reporta `FAIL/WARN/SKIP/PASS` por test).

**EN:** The project was created manually, without scaffolding tools. The `calculator` module is an R package (`DESCRIPTION`, `NAMESPACE` and `R/`) whose functions the suite reaches without `source()`: `make test` calls `testthat::test_local()`, which loads the package with `pkgload::load_all()` without installing it. Tests use **testthat**, R's most robust and widespread test library (verifies with `expect_equal` and reports `FAIL/WARN/SKIP/PASS` per test).

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p r/core/foundations/unit_test/calculator/{R,tests/testthat}
   ```

2. Escribir `DESCRIPTION`, `NAMESPACE`, `R/calculator.R` y `tests/testthat/test-calculator.R`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias: `test_local()` carga el paquete desde el propio directorio.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No hay paso de compilación. La configuración vive en `DESCRIPTION` (nombre `calculator`, dependencia `testthat`) y en `NAMESPACE`, que declara las 5 funciones exportadas; la suite no necesita `source()` porque `test_local()` carga el paquete.

### `R/calculator.R` — Implementaciones educativas

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

### `tests/testthat/test-calculator.R` — Suite testthat

**ES:** La suite agrupa un `test_that` por función (5 tests, uno por operación), cada uno con su `expect_equal`. No hace falta cargar nada: el archivo se llama `test-calculator.R`, así que testthat lo descubre y `test_local()` deja las funciones del paquete disponibles.

**EN:** The suite groups one `test_that` per function (5 tests, one per operation), each with its `expect_equal`. Nothing needs to be loaded: the file is named `test-calculator.R`, so testthat discovers it and `test_local()` makes the package functions available.

```r
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

> **ES:** El layout de paquete elimina el motivo por el que antes se usaba `test_file`: el descubrimiento por defecto de testthat (`tests/testthat/test*.R`) se satisface con el nombre `test-calculator.R`, así que basta el `Makefile`.
> **EN:** The package layout removes the reason `test_file` was used before: testthat's default discovery (`tests/testthat/test*.R`) is satisfied by the `test-calculator.R` name, so the `Makefile` is enough.

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
make test
```

### Salida esperada / Expected output

```text
Rscript -e "testthat::test_local()"
✔ | F W  S  OK | Context
✔ |          5 | calculator

══ Results ═════════════════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
```

> **ES:** `PASS 5` confirma que las 5 operaciones se verificaron correctamente (equivale al `Tests run: 5, Passed: 5, Failed: 0` de la especificación).
> **EN:** `PASS 5` confirms that all 5 operations were verified correctly (equivalent to the specification's `Tests run: 5, Passed: 5, Failed: 0`).

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El layout de paquete (`DESCRIPTION` + `NAMESPACE` + `R/`) es la forma idiomática de que la suite alcance el código sin `source()`.
- **EN:** The package layout (`DESCRIPTION` + `NAMESPACE` + `R/`) is the idiomatic way for the suite to reach the code without `source()`.
- **ES:** La división por cero no se maneja en este ejemplo educativo (según el pseudocódigo de la especificación); las pruebas usan valores válidos.
- **EN:** Division by zero is not handled in this educational example (per the specification's pseudocode); tests use valid values.
- **ES:** Solo se usa la biblioteca estándar en el código fuente; `testthat` es la única dependencia externa y únicamente para pruebas.
- **EN:** Only the standard library is used in the source code; `testthat` is the only external dependency and only for tests.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
