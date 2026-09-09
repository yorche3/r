# Numbers — R

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **R**, con **testthat** como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/numbers.R`](src/numbers.R) | Módulo `numbers` — único archivo con las 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers `_help`. |
| [`test/recursive_tests.R`](test/recursive_tests.R) | Suite recursiva: 5 tests (11 casos). |
| [`test/iterative_tests.R`](test/iterative_tests.R) | Suite iterativa: 5 tests (11 casos). |
| [`test/run_tests.R`](test/run_tests.R) | Punto de entrada: ejecuta las dos suites. |
| [`.gitignore`](.gitignore) | Ignora `.Rhistory`, `.RData` y otros artefactos de R. |

**Estructura de directorios esperada:**

```text
numbers/
├── src/
│   └── numbers.R             # Único archivo: 3 enfoques en 1
├── test/
│   ├── recursive_tests.R     # Tests: enfoque recursivo
│   ├── iterative_tests.R     # Tests: enfoque iterativo
│   └── run_tests.R           # Punto de entrada
├── .gitignore
└── README.md                 # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que `calculator`: un archivo de funciones cargado con `source()` y suites **testthat**. Las 15 funciones se organizan en 3 grupos por enfoque:

**EN:** This project uses the same pattern as `calculator`: a file of functions loaded with `source()` and **testthat** suites. The 15 functions are organized into 3 groups by approach:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec(n)` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc(n)` | ❌ No (ver nota TCO) |
| Iterativo | `_ite` | `fibonacci_ite(n)` | ✅ Sí |

**Combinación aplicada:** TCO ❌ + iteración ✅ → `_rec` + `_ite` = **2 suites × 5 tests = 10 tests (22 casos)**.

**Applied combination:** No TCO + iteration ✅ → `_rec` + `_ite` = **2 suites × 5 tests = 10 tests (22 cases)**.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p r/core/foundations/numbers/{src,test}
   ```

2. Escribir `src/numbers.R` y las suites en `test/`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. Las suites cargan el módulo con `source("../src/numbers.R")`.

### `src/numbers.R` — Implementación (3 enfoques en 1 archivo)

**ES:** Cada algoritmo tiene 3 implementaciones con los sufijos `_rec`, `_acc` e `_ite`; los helpers son privados por convención (`_help`). Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations with the suffixes `_rec`, `_acc` and `_ite`; helpers are private by convention (`_help`). For example, `fibonacci`:

```r
# Recursión directa / Direct recursion
fibonacci_rec <- function(n) {
  if (n <= 1) {
    return(n)
  }
  return(fibonacci_rec(n - 1) + fibonacci_rec(n - 2))
}

# Recursión con acumulador / Accumulator recursion
fibonacci_acc <- function(n) {
  return(fibonacci_acc_help(n, 0, 1))
}

fibonacci_acc_help <- function(n, acc2, acc1) {
  if (n <= 0) {
    return(acc2)
  }
  if (n <= 2) {
    return(acc1 + acc2)
  }
  return(fibonacci_acc_help(n - 1, acc1, acc1 + acc2))
}

# Iterativo / Iterative
fibonacci_ite <- function(n) {
  if (n <= 1) {
    return(n)
  }
  acc2 <- 0
  acc1 <- 1
  for (i in 2:n) {
    temp <- acc1 + acc2
    acc2 <- acc1
    acc1 <- temp
  }
  return(acc1)
}
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `n + sum_rec(n-1)` | helper con `acc + n` | bucle `seq_len(n)` |
| `factorial` | `n * fact_rec(n-1)` | helper con `acc * n` | bucle `seq_len(n)` |
| `fibonacci` | `fib_rec(n-1) + fib_rec(n-2)` | helper con `acc2, acc1` | bucle con intercambio `temp` |
| `greatest_common_divisor` | Euclides recursivo | helper (Euclides) | `while (b != 0)` |
| `least_common_multiple` | `(a / gcd) * b` | `(a / gcd) * b` | `(a / gcd) * b` |

### Suites de pruebas — testthat

**ES:** Dos suites, una por enfoque probado. Cada suite agrupa un `test_that` por función (5 por suite); los 11 casos del pseudocódigo viven como `expect_equal` dentro de ellas (22 en total).

**EN:** Two suites, one per tested approach. Each suite groups one `test_that` per function (5 per suite); the specification pseudocode's 11 cases live as `expect_equal`s within them (22 in total).

```r
library(testthat)

source("../src/numbers.R")

test_that("sum_of_first_n_rec", {
  expect_equal(sum_of_first_n_rec(0), 0)
  expect_equal(sum_of_first_n_rec(3), 6)
})

test_that("fibonacci_rec", {
  expect_equal(fibonacci_rec(0), 0)
  expect_equal(fibonacci_rec(1), 1)
  expect_equal(fibonacci_rec(6), 8)
})
```

### `test/run_tests.R` — Punto de entrada

**ES:** testthat solo descubre por defecto archivos con prefijo `test*`, así que el punto de entrada ejecuta explícitamente las suites con el nombre `*_tests.R` de la especificación:

**EN:** testthat only discovers files with the `test*` prefix by default, so the entry point explicitly runs the suites with the specification's `*_tests.R` names:

```r
library(testthat)

# Run all test files in the project
test_file("test/recursive_tests.R")
test_file("test/iterative_tests.R")
```

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
cd r/core/foundations/numbers
Rscript test/run_tests.R
```

**Alternativa (una suite):**

```bash
Rscript -e 'testthat::test_file("test/recursive_tests.R")'
```

### Salida esperada / Expected output

```text
══ Testing recursive_tests.R ═══════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 11 ] Done!

══ Testing iterative_tests.R ═══════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 11 ] Done!
```

> **ES:** 10 tests en total (5 `test_that` por suite); los 22 casos viven como `expect_equal` dentro de ellos, todos pasando (`FAIL 0`).
> **EN:** 10 tests in total (5 `test_that` per suite); the 22 cases live as `expect_equal`s within them, all passing (`FAIL 0`).

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

En R, **no se garantiza TCO**: el intérprete no optimiza las llamadas de cola y la recursión profunda termina con `Error: C stack usage is too close to the limit`. La versión con acumulador se conserva únicamente con fines educativos, como puente conceptual entre la recursión directa (`_rec`) y la versión iterativa (`_ite`). Como no hay un beneficio práctico de rendimiento, **no se desarrollan pruebas unitarias específicas para las funciones `_acc`**. Su comportamiento queda validado a través de las suites recursiva e iterativa, que ejercitan los mismos resultados.

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

In R, **TCO is not guaranteed**: the interpreter does not optimize tail calls and deep recursion ends with `Error: C stack usage is too close to the limit`. The accumulator version is kept purely for educational purposes, as a conceptual bridge between direct recursion (`_rec`) and the iterative version (`_ite`). Since there is no practical performance benefit, **no dedicated unit tests are written for the `_acc` functions**. Their behavior is validated through the recursive and iterative suites, which exercise the same results.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** R no tiene importación de módulos para scripts sueltos; `source()` es el mecanismo idiomático para cargar el código fuente en las suites.
- **EN:** R has no module imports for loose scripts; `source()` is the idiomatic mechanism to load source code into the suites.
- **ES:** Los bucles iterativos usan `seq_len(n)` en lugar de `1:n` porque en R `1:0` vale `c(1, 0)` (¡no es vacío!), lo que rompería `sum_of_first_n_ite(0)` y `factorial_ite(0)`.
- **EN:** Iterative loops use `seq_len(n)` instead of `1:n` because in R `1:0` evaluates to `c(1, 0)` (not empty!), which would break `sum_of_first_n_ite(0)` and `factorial_ite(0)`.
- **ES:** El MCM usa `(a / gcd(a, b)) * b`; la división devuelve `double` y testthat lo compara con tolerancia, por lo que los casos del pseudocódigo pasan sin cambios.
- **EN:** LCM uses `(a / gcd(a, b)) * b`; division returns a `double` and testthat compares with tolerance, so the pseudocode cases pass unchanged.
- **ES:** En `greatest_common_divisor` se usa `%%` (operador módulo de R), legítimo en este algoritmo (la restricción de no usar operadores de módulo aplica solo al módulo `calculator` de la especificación 03).
- **EN:** `greatest_common_divisor` uses `%%` (R's modulus operator), which is legitimate in this algorithm (the no-modulus-operator restriction applies only to the `calculator` module of specification 03).
- **ES:** `run_tests.R` existe porque testthat no descubre archivos `*_tests.R` con su patrón por defecto (`test*`); el punto de entrada los ejecuta con `test_file`.
- **EN:** `run_tests.R` exists because testthat does not discover `*_tests.R` files with its default (`test*`) pattern; the entry point runs them with `test_file`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
