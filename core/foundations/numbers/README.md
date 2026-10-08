# Numbers — R

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **R**, con **testthat** como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`DESCRIPTION`](DESCRIPTION) | Manifiesto del paquete `numbers`: versión, licencia y dependencia de testthat. |
| [`NAMESPACE`](NAMESPACE) | Exporta los 15 algoritmos del contrato; los 4 helpers `_help` quedan internos. |
| [`R/numbers.R`](R/numbers.R) | Módulo `numbers` — único archivo con las 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers `_help`. |
| [`Makefile`](Makefile) | Punto de entrada: `make test`. |
| [`tests/testthat/test-recursive.R`](tests/testthat/test-recursive.R) | Suite recursiva: 5 tests (11 casos). |
| [`tests/testthat/test-iterative.R`](tests/testthat/test-iterative.R) | Suite iterativa: 5 tests (11 casos). |
| [`tests/testthat.R`](tests/testthat.R) | `test_check("numbers")`, la comprobación que usa `R CMD check`. |
| [`.gitignore`](.gitignore) | Ignora `.Rhistory`, `.RData` y otros artefactos de R. |

**Estructura de directorios esperada:**

```text
numbers/
├── DESCRIPTION                 # Manifiesto del paquete (numbers)
├── NAMESPACE                   # Los 15 algoritmos exportados
├── Makefile                    # Punto de entrada: make test
├── R/
│   └── numbers.R               # Único archivo: 3 enfoques en 1
├── tests/
│   ├── testthat.R              # test_check() para R CMD check
│   └── testthat/
│       ├── test-recursive.R    # Tests: enfoque recursivo
│       └── test-iterative.R    # Tests: enfoque iterativo
├── .gitignore
└── README.md                   # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que `calculator`: un paquete de R —`DESCRIPTION`, `NAMESPACE` y `R/`— con **testthat** como framework de pruebas. La suite ya no carga el archivo con `source()`: `make test` llama a `testthat::test_local()`, que carga el paquete con `pkgload::load_all()` sin instalarlo. Las 15 funciones se organizan en 3 grupos por enfoque:

**EN:** This project uses the same pattern as `calculator`: an R package —`DESCRIPTION`, `NAMESPACE` and `R/`— with **testthat** as the test framework. The suite no longer loads the file with `source()`: `make test` calls `testthat::test_local()`, which loads the package with `pkgload::load_all()` without installing it. The 15 functions are organized into 3 groups by approach:

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
   mkdir -p r/core/foundations/numbers/{R,tests/testthat}
   ```

2. Escribir `DESCRIPTION`, `NAMESPACE`, `R/numbers.R` y las suites en `tests/testthat/`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias: `test_local()` carga el paquete desde el propio directorio.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No hay paso de compilación. La configuración vive en `DESCRIPTION` (nombre `numbers`, dependencia `testthat`) y en `NAMESPACE`, que declara los 15 algoritmos exportados; las suites no necesitan `source()` porque `test_local()` carga el paquete.

### `R/numbers.R` — Implementación (3 enfoques en 1 archivo)

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

### `Makefile` — Punto de entrada

**ES:** El layout de paquete deja que testthat descubra las suites por su cuenta: se llaman `test-recursive.R` y `test-iterative.R`, así que encajan con el patrón por defecto `test*` y ya no hace falta ejecutarlas con `test_file()`. El punto de entrada queda en un único comando, `make test`:

**EN:** The package layout lets testthat discover the suites on its own: they are named `test-recursive.R` and `test-iterative.R`, so they match the default `test*` pattern and no longer need to be run with `test_file()`. The entry point becomes a single command, `make test`:

```make
R ?= Rscript

.PHONY: test clean

test:
	$(R) -e "testthat::test_local()"

clean:
	rm -rf *.Rcheck
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
make test
```

**Alternativa (una suite):**

```bash
Rscript -e 'testthat::test_local(filter = "recursive")'
```

### Salida esperada / Expected output

```text
Rscript -e "testthat::test_local()"
✔ | F W  S  OK | Context
✔ |         11 | iterative
✔ |         11 | recursive

══ Results ═════════════════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 22 ]
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

- **ES:** R no tiene importación de módulos para scripts sueltos; el layout de paquete (`DESCRIPTION` + `NAMESPACE` + `R/`) es la forma idiomática de que las suites alcancen el código sin `source()`.
- **EN:** R has no module imports for loose scripts; the package layout (`DESCRIPTION` + `NAMESPACE` + `R/`) is the idiomatic way for the suites to reach the code without `source()`.
- **ES:** Los bucles iterativos usan `seq_len(n)` en lugar de `1:n` porque en R `1:0` vale `c(1, 0)` (¡no es vacío!), lo que rompería `sum_of_first_n_ite(0)` y `factorial_ite(0)`.
- **EN:** Iterative loops use `seq_len(n)` instead of `1:n` because in R `1:0` evaluates to `c(1, 0)` (not empty!), which would break `sum_of_first_n_ite(0)` and `factorial_ite(0)`.
- **ES:** El MCM usa `(a / gcd(a, b)) * b`; la división devuelve `double` y testthat lo compara con tolerancia, por lo que los casos del pseudocódigo pasan sin cambios.
- **EN:** LCM uses `(a / gcd(a, b)) * b`; division returns a `double` and testthat compares with tolerance, so the pseudocode cases pass unchanged.
- **ES:** En `greatest_common_divisor` se usa `%%` (operador módulo de R), legítimo en este algoritmo (la restricción de no usar operadores de módulo aplica solo al módulo `calculator` de la especificación 03).
- **EN:** `greatest_common_divisor` uses `%%` (R's modulus operator), which is legitimate in this algorithm (the no-modulus-operator restriction applies only to the `calculator` module of specification 03).
- **ES:** Los cuatro helpers `_help` de la recursión con acumulador **no** se exportan en `NAMESPACE`: en R lo idiomático es que el helper de un algoritmo sea interno. Las suites los alcanzarían igual, porque `test_local()` carga el paquete con `export_all = TRUE`.
- **EN:** The four `_help` helpers of accumulator recursion are **not** exported in `NAMESPACE`: in R the idiomatic choice is to keep an algorithm's helper internal. The suites would reach them anyway, because `test_local()` loads the package with `export_all = TRUE`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
