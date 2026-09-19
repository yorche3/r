# naive_sort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato: recibe un vector de enteros y devuelve el vector ordenado de menor a
# mayor (in-place o como copia ordenada), sin invocar `sort()`, `order()` ni
# ninguna biblioteca de ordenamiento, y sin estructuras auxiliares complejas.
# Si la entrada es NULL devuelve NULL como indicador de fallo; si está vacía
# devuelve el mismo vector vacío. No lanza excepciones.
#
# Implementación pendiente: la escribe el autor. Esta delegación solo genera el
# esqueleto y las pruebas unitarias.
selection_sort <- function(arr) {
  if (is.null(arr)) {
    return(NULL)
  }
  n <- length(arr)
  if (n < 2) {
    return(arr)
  }
  for (i in seq_len(n - 1)) {
    min_idx <- i
    for (j in (i + 1):n) {
      if (arr[j] < arr[min_idx]) {
        min_idx <- j
      }
    }
    if (min_idx != i) {
      tmp <- arr[i]
      arr[i] <- arr[min_idx]
      arr[min_idx] <- tmp
    }
  }
  return(arr)
}

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

insertion_sort <- function(arr) {
  if (is.null(arr)) {
    return(NULL)
  }
  n <- length(arr)
  if (n < 2) {
    return(arr)
  }
  for (i in 2:n) {
    key <- arr[i]
    j <- i - 1
    while (j >= 1 && arr[j] > key) {
      arr[j + 1] <- arr[j]
      j <- j - 1
    }
    arr[j + 1] <- key
  }
  return(arr)
}
