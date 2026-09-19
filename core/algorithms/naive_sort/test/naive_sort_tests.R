library(testthat)

source("../src/naive_sort.R")

# Casos de prueba de la especificación 05_Naive_Sort.md
#
# Caso nulo incluido: en R `NULL` es representable y `is.null()` lo distingue de
# un vector vacío (`integer(0)`), así que el indicador de fallo del contrato es
# `NULL` para la entrada nula y el vector vacío se devuelve tal cual. Ojo: `c()`
# NO sirve como vector vacío, porque en R devuelve `NULL`.
# No se esperan excepciones.
#
# Aislamiento: R usa copia al modificar (copy-on-modify), así que ordenar el
# parámetro dentro de la función no altera el fixture compartido.

standard_input <- c(5, 2, 9, 1, 5, 6)
standard_output <- c(1, 2, 5, 5, 6, 9)

sorted_input <- c(1, 2, 3, 4, 5)
sorted_output <- c(1, 2, 3, 4, 5)

reverse_input <- c(5, 4, 3, 2, 1)
reverse_output <- c(1, 2, 3, 4, 5)

identical_input <- c(7, 7, 7, 7)
identical_output <- c(7, 7, 7, 7)

negative_input <- c(3, -1, 4, -5, 0)
negative_output <- c(-5, -1, 0, 3, 4)

single_input <- c(42)
single_output <- c(42)

empty_input <- integer(0)
empty_output <- integer(0)

null_input <- NULL
null_output <- NULL

cases <- list(
  list(description = "an unsorted array", input = standard_input, expected = standard_output),
  list(description = "an already sorted array", input = sorted_input, expected = sorted_output),
  list(description = "a reverse ordered array", input = reverse_input, expected = reverse_output),
  list(description = "an array of identical elements", input = identical_input, expected = identical_output),
  list(description = "an array with negative numbers", input = negative_input, expected = negative_output),
  list(description = "a single element array", input = single_input, expected = single_output),
  list(description = "an empty array", input = empty_input, expected = empty_output),
  list(description = "a null input", input = null_input, expected = null_output)
)

# Helper compartido: recibe la función a probar y el nombre del algoritmo, y
# ejecuta todos los casos con el mensaje descriptivo del contrato.
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

test_that("selection_sort", {
  assert_sorts_all_cases(selection_sort, "selection_sort")
})

test_that("bubble_sort", {
  assert_sorts_all_cases(bubble_sort, "bubble_sort")
})

test_that("insertion_sort", {
  assert_sorts_all_cases(insertion_sort, "insertion_sort")
})
