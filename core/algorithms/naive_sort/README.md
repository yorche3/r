# Naive Sort — R

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **R**, con **testthat** como framework de pruebas unitarias.

Tres algoritmos de ordenación con coste $O(n^2)$: **selection sort**, **bubble sort** e **insertion sort**, trabajando sobre vectores atómicos (el «array» de R), con asignación `<-`, bucles indexados y sin invocar `sort()`, `order()` ni ninguna biblioteca de ordenamiento.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/naive_sort.R`](src/naive_sort.R) | Módulo `naive_sort` — las 3 funciones del contrato. |
| [`test/naive_sort_tests.R`](test/naive_sort_tests.R) | Suite única: 3 tests (8 casos cada uno). |
| [`test/run_tests.R`](test/run_tests.R) | Punto de entrada: ejecuta la suite. |
| [`.gitignore`](.gitignore) | Ignora `.Rhistory`, `.RData`, `.Rproj.user`, `.Renviron`, `*.tar.gz`, `*.Rcheck/`. |

**Estructura de directorios esperada:**

```text
naive_sort/
├── src/
│   └── naive_sort.R          # 3 funciones del contrato
├── test/
│   ├── naive_sort_tests.R    # Tests: los 3 algoritmos
│   └── run_tests.R           # Punto de entrada
├── .gitignore
└── README.md                 # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que [`numbers`](../../foundations/numbers/) y [`calculator`](../../foundations/unit_test/calculator/): un archivo de funciones cargado con `source()` y suites **testthat**. Las 3 funciones son autónomas: no hay helpers compartidos ni estructuras auxiliares más allá de los índices y la variable `key`.

**EN:** This project uses the same pattern as [`numbers`](../../foundations/numbers/) and [`calculator`](../../foundations/unit_test/calculator/): a file of functions loaded with `source()` and **testthat** suites. The 3 functions are self-contained: there are no shared helpers and no auxiliary structures beyond the indices and the `key` variable.

**Combinación aplicada:** implementación iterativa + vectores mutables localmente → **1 suite × 3 tests = 3 tests (24 casos)**.

**Applied combination:** iterative implementation + locally mutable vectors → **1 suite × 3 tests = 3 tests (24 cases)**.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p r/core/algorithms/naive_sort/{src,test}
   ```

2. Escribir `src/naive_sort.R` y la suite en `test/`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

**ES:** No se requieren archivos de configuración de build. La suite carga el módulo con `source("../src/naive_sort.R")`.

**EN:** No build configuration files are required. The suite loads the module with `source("../src/naive_sort.R")`.

### `src/naive_sort.R` — Implementación

**ES:** Las tres funciones reciben un vector, comprueban el caso nulo con `is.null()`, resuelven `n < 2` y ordenan con bucles indexados. Extracto de `bubble_sort`, que conserva la bandera `swapped` y la salida temprana del pseudocódigo:

**EN:** All three functions take a vector, check the null case with `is.null()`, resolve `n < 2` and sort with indexed loops. Excerpt from `bubble_sort`, which keeps the pseudocode's `swapped` flag and early exit:

```r
bubble_sort <- function(arr) {
  if (is.null(arr)) {
    return(NULL)
  }
  n <- length(arr)
  if (n < 2) {
    return(arr)
  }
  for (i in seq_len(n - 1)) {
    swapped <- FALSE
    for (j in seq_len(n - i)) {
      if (arr[j] > arr[j + 1]) {
        tmp <- arr[j]
        arr[j] <- arr[j + 1]
        arr[j + 1] <- tmp
        swapped <- TRUE
      }
    }
    if (!swapped) {
      break
    }
  }
  return(arr)
}
```

### Suites de pruebas — testthat

**ES:** Una única suite con un `test_that` por algoritmo. Los 8 casos viven en una lista de listas compartida y un único helper los recorre para cualquier función; el mensaje del contrato viaja en el argumento `info` de `expect_equal`:

**EN:** A single suite with one `test_that` per algorithm. The 8 cases live in a shared list of lists and a single helper walks them for any function; the contract message travels in `expect_equal`'s `info` argument:

```r
assert_sorts_all_cases <- function(sort_function, algorithm) {
  for (test_case in cases) {
    actual <- sort_function(test_case$input)
    expect_equal(
      actual,
      test_case$expected,
      info = paste(algorithm, "should sort", test_case$description)
    )
  }
}
```

### `test/run_tests.R` — Punto de entrada

**ES:** testthat solo descubre por defecto archivos con prefijo `test*`, así que el punto de entrada ejecuta explícitamente la suite con el nombre `*_tests.R` de la especificación:

**EN:** testthat only discovers files with the `test*` prefix by default, so the entry point explicitly runs the suite with the specification's `*_tests.R` name:

```r
library(testthat)

# Run all test files in the project
test_file("test/naive_sort_tests.R")
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

### Verificación estática / Static check

**ES:** R no compila a un artefacto previo, así que la verificación estática es el análisis sintáctico con `parse()` más el analizador `lintr`, que en este módulo no encuentra ningún aviso:

**EN:** R does not compile to a prior artifact, so the static check is the syntactic analysis with `parse()` plus the `lintr` analyzer, which finds no warnings in this module:

```bash
cd r/core/algorithms/naive_sort
Rscript -e 'invisible(parse("src/naive_sort.R")); cat("parse OK\n")'
Rscript -e 'print(lintr::lint("src/naive_sort.R"))'
```

```text
parse OK
```

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto:

```bash
cd r/core/algorithms/naive_sort
Rscript test/run_tests.R
```

**Alternativa (la suite directamente):**

```bash
Rscript -e 'testthat::test_file("test/naive_sort_tests.R")'
```

### Salida esperada / Expected output

```text
══ Testing naive_sort_tests.R ══════════════════════════════════════════════════
…
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 24 ] Done!
```

> **ES:** 3 tests (`test_that`, uno por algoritmo); los 24 casos viven como `expect_equal` dentro de ellos (8 por algoritmo), todos pasando (`FAIL 0`).
> **EN:** 3 tests (`test_that`, one per algorithm); the 24 cases live as `expect_equal`s within them (8 per algorithm), all passing (`FAIL 0`).

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Función | Estrategia | Entrada ordenada | Entrada invertida |
|-----------|---------|-----------|:----------------:|:-----------------:|
| Selection sort | `selection_sort` | Busca el mínimo del tramo no ordenado con `min_idx` y lo intercambia al inicio | $O(n^2)$ | $O(n^2)$ |
| Bubble sort | `bubble_sort` | Compara e intercambia adyacentes; bandera `swapped` con `break` (**salida temprana**) | $O(n)$ | $O(n^2)$ |
| Insertion sort | `insertion_sort` | Toma cada elemento como `key` y desplaza el sub-tramo ordenado con `while` | $O(n)$ | $O(n^2)$ |

**ES:** Los tres usan bucles indexados sobre el vector, sin recursión: los índices se ajustan a la numeración **1-based** de R.

**EN:** All three use indexed loops over the vector, without recursion: indices are adjusted to R's **1-based** numbering.

### Casos cubiertos / Covered cases

| # | Caso | Entrada | Salida esperada |
|:-:|------|---------|-----------------|
| 1 | Array estándar desordenado | `c(5, 2, 9, 1, 5, 6)` | `c(1, 2, 5, 5, 6, 9)` |
| 2 | Array ya ordenado | `c(1, 2, 3, 4, 5)` | `c(1, 2, 3, 4, 5)` |
| 3 | Array en orden inverso | `c(5, 4, 3, 2, 1)` | `c(1, 2, 3, 4, 5)` |
| 4 | Elementos idénticos | `c(7, 7, 7, 7)` | `c(7, 7, 7, 7)` |
| 5 | Con números negativos | `c(3, -1, 4, -5, 0)` | `c(-5, -1, 0, 3, 4)` |
| 6 | Un solo elemento | `c(42)` | `c(42)` |
| 7 | Vector vacío | `integer(0)` | `integer(0)` |
| 8 | Entrada nula | `NULL` | `NULL` |

**ES:** Son los 7 casos obligatorios de la especificación más el caso nulo, que en R sí es representable (ver la nota correspondiente).

**EN:** These are the 7 mandatory cases from the specification plus the null case, which is representable in R (see the corresponding note).

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Copia al modificar: el resultado vuelve por el `return` / Copy-on-modify: the result comes back through `return`

**ES:** El pseudocódigo ordena el propio array con `swap(arr, i, j)`. En R los argumentos se pasan por promesa y `arr[i] <- …` **modifica la copia local** del vector, no la del llamador (semántica *copy-on-modify*), así que el ordenamiento no es *in-place* observable: las tres funciones ordenan su copia y devuelven el vector ordenado con `return(arr)`. Por eso los tests no necesitan duplicar el fixture: es imposible que un caso contamine al siguiente.

**EN:** The pseudocode sorts the array itself with `swap(arr, i, j)`. In R arguments are passed as promises and `arr[i] <- …` **modifies the local copy** of the vector, not the caller's (*copy-on-modify* semantics), so the sort is not observably *in-place*: all three functions sort their copy and return the sorted vector with `return(arr)`. That is why the tests need no fixture duplication: a case cannot contaminate the next one.

### ➿ `seq_len()` y el rango que no es vacío / `seq_len()` and the range that is not empty

**ES:** En R el operador `:` **no devuelve vacío** cuando el inicio supera el fin: `1:0` es `c(1, 0)` y `(n + 1):n` es `c(n + 1, n)` (descendente). Un bucle exterior con el rango `1:n` llevaría al caso `i == n`, y ahí `arr[n + 1]` sería `NA` (error `missing value where TRUE/FALSE needed`) y `arr[0]` sería `numeric(0)` (error `argument is of length zero`). Por eso las cotas exteriores se escriben con `seq_len(n - 1)`, que es el `0 to n - 2` del pseudocódigo y nunca produce un rango descendente, y la interior de bubble con `seq_len(n - i)`. La composición es la misma que usa `numbers/` (`for (i in seq_len(n))`).

**EN:** In R the `:` operator **does not return empty** when the start exceeds the end: `1:0` is `c(1, 0)` and `(n + 1):n` is `c(n + 1, n)` (descending). An outer loop with the range `1:n` would reach `i == n`, where `arr[n + 1]` would be `NA` (`missing value where TRUE/FALSE needed` error) and `arr[0]` would be `numeric(0)` (`argument is of length zero` error). That is why the outer bounds are written with `seq_len(n - 1)`, which is the pseudocode's `0 to n - 2` and never produces a descending range, and bubble's inner bound with `seq_len(n - i)`. This is the same composition used by `numbers/` (`for (i in seq_len(n))`).

### 🚫 Caso nulo incluido: `NULL` como indicador de fallo / Null case included: `NULL` as the failure indicator

**ES:** La especificación pide devolver el indicador de fallo del lenguaje si la entrada es nula o inválida, sin lanzar excepciones. En R ese indicador es **`NULL`**: `is.null(arr)` lo detecta y las tres funciones lo devuelven antes de leer `length(arr)`. El caso vacío del contrato se representa con `integer(0)`, el vector vacío **tipado**, porque `c()` devuelve `NULL` y se confundiría con el indicador de fallo.

**EN:** The specification requires returning the language's failure indicator when the input is null or invalid, without throwing exceptions. In R that indicator is **`NULL`**: `is.null(arr)` detects it and all three functions return it before reading `length(arr)`. The contract's empty case is represented with `integer(0)`, the **typed** empty vector, because `c()` returns `NULL` and would be confused with the failure indicator.

### 🔁 `bubble_sort` y la bandera de intercambio / `bubble_sort` and the swap flag

**ES:** El criterio de aceptación exige la optimización de salida temprana. `bubble_sort` pone `swapped <- FALSE` al inicio de cada pasada, lo activa al intercambiar y ejecuta `if (!swapped) break` al terminar, que es el `if not swapped then break` del pseudocódigo: un vector ya ordenado se resuelve en **una sola pasada** y el mejor caso es $O(n)$. La bandera **no es observable en la salida** (las tres funciones devuelven un vector ordenado), así que la suite no puede detectar su ausencia: su presencia se verifica comparando el código con el pseudocódigo, no con los tests.

**EN:** The acceptance criteria require the early-exit optimisation. `bubble_sort` sets `swapped <- FALSE` at the start of each pass, sets it when swapping and runs `if (!swapped) break` at the end, which is the pseudocode's `if not swapped then break`: an already sorted vector is solved in **a single pass** and the best case is $O(n)$. The flag is **not observable in the output** (all three functions return a sorted vector), so the suite cannot detect its absence: its presence is verified by comparing the code against the pseudocode, not by the tests.

### 🔀 Estabilidad de `insertion_sort` / `insertion_sort` stability

**ES:** El desplazamiento usa la comparación estricta `arr[j] > key` con la guarda `j >= 1` (la numeración de R es 1-based), así que `insertion_sort` es estable: los elementos iguales conservan su orden relativo. El caso 1 (`c(5, 2, 9, 1, 5, 6)`, con dos cincos) se beneficia de ello, aunque los tests comparan valores y no identidad.

**EN:** The shifting uses the strict comparison `arr[j] > key` with the `j >= 1` guard (R's numbering is 1-based), so `insertion_sort` is stable: equal elements keep their relative order. Case 1 (`c(5, 2, 9, 1, 5, 6)`, with two fives) benefits from it, although the tests compare values rather than identity.

### 🏷️ Naming y ausencia de `main` / Naming and missing `main`

**ES:** Las funciones usan `snake_case` (`selection_sort`), que coincide con el nombre de la especificación, y el parámetro conserva el nombre `arr` de la documentación. No hay `main`: el punto de entrada es `test/run_tests.R`, que ejecuta la suite.

**EN:** Functions use `snake_case` (`selection_sort`), matching the specification's name, and the parameter keeps the documentation's `arr` name. There is no `main`: the entry point is `test/run_tests.R`, which runs the suite.

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `src/naive_sort.R` | Nombre exacto del módulo; solo cambia la extensión (`.R`, como `numbers.R`). |
| `test/naive_sort_test.ext` | `test/naive_sort_tests.R` | El sufijo va en plural (`_tests.R`), como `recursive_tests.R` e `iterative_tests.R` en `numbers/`. |
| `test/run_tests.ext` | `test/run_tests.R` | testthat no descubre archivos `*_tests.R` con su patrón por defecto (`test*`), así que el punto de entrada los ejecuta con `test_file`. |

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
