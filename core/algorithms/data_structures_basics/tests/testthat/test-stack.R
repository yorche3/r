# Casos del contrato `Stack` de la especificación 06_Data_Structures_Basics.
#
# Los cuatro pasos corren sobre la misma pila: se declara una vez con `init()` y
# cada paso continúa el estado anterior, sin reiniciar el escenario.
#
# Adecuación value-semantic: cada operación devuelve la pila actualizada
# (`x <- operacion(x, ...)`) y `pop` devuelve además el valor extraído en
# `list(value = <entero>, updated = <Stack>)`.

pushed_first <- 10
pushed_second <- 20
pushed_third <- 30
pushed_after_pop <- 40
failure_indicator <- -1

test_that("Stack", {
  stack <- stack_init()

  # Paso 1 — estado vacío y extracción fallida.
  expect_contract(stack_is_empty(stack), TRUE, "Stack 1", "is_empty should be true after init")
  expect_contract(stack_size(stack), 0, "Stack 1", "size should be 0 after init")
  expect_contract(stack_peek(stack), failure_indicator, "Stack 1", "peek on an empty stack should return -1")

  popped <- stack_pop(stack)
  expect_contract(popped$value, failure_indicator, "Stack 1", "pop on an empty stack should return -1")
  expect_contract(stack_is_empty(popped$updated), TRUE, "Stack 1", "a failed pop should keep the stack empty")

  # Paso 2 — LIFO y `peek` no mutante.
  stack <- stack_push(stack, pushed_first)
  stack <- stack_push(stack, pushed_second)
  stack <- stack_push(stack, pushed_third)
  expect_contract(stack_peek(stack), pushed_third, "Stack 2", "peek should return 30")
  expect_contract(stack_size(stack), 3, "Stack 2", "size should be 3 after three pushes")

  # Paso 3 — extracción y reutilización.
  popped <- stack_pop(stack)
  stack <- popped$updated
  expect_contract(popped$value, pushed_third, "Stack 3", "the first pop should return 30")

  stack <- stack_push(stack, pushed_after_pop)
  popped <- stack_pop(stack)
  stack <- popped$updated
  expect_contract(popped$value, pushed_after_pop, "Stack 3", "the reused top should return 40")

  popped <- stack_pop(stack)
  stack <- popped$updated
  expect_contract(popped$value, pushed_second, "Stack 3", "the next pop should return 20")

  popped <- stack_pop(stack)
  stack <- popped$updated
  expect_contract(popped$value, pushed_first, "Stack 3", "the final pop should return 10")
  expect_contract(stack_is_empty(stack), TRUE, "Stack 3", "is_empty should be true after removing everything")
  expect_contract(stack_size(stack), 0, "Stack 3", "size should be 0 after removing everything")

  # Paso 4 — vacío tras la extracción.
  popped <- stack_pop(stack)
  expect_contract(popped$value, failure_indicator, "Stack 4", "pop on an empty stack should fail")
  expect_contract(stack_is_empty(popped$updated), TRUE, "Stack 4", "a failed pop should keep the stack empty")
})
