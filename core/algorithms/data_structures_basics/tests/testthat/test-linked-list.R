# Casos del contrato `LinkedList` de la especificación 06_Data_Structures_Basics.
#
# Los cinco pasos corren sobre la misma lista: se declara una vez con `init()` y
# cada paso continúa el estado anterior, sin reiniciar el escenario.
#
# Adecuación value-semantic: al modificar, R copia, así que cada operación
# devuelve la estructura actualizada (`x <- operacion(x, ...)`) y `delete`
# devuelve además su éxito o fallo en `list(deleted = <lógico>, updated = <LinkedList>)`.
# El contrato expone el valor de la cabeza (`get_head`), no el nodo, así que el
# orden se observa por esa cabeza en cada paso, como en el módulo Ada.

inserted_tail_first <- 10
inserted_tail_second <- 20
inserted_head_value <- 5
repeated_value <- 10
absent_value <- 99
failure_indicator <- -1

test_that("LinkedList", {
  linked_list <- linked_list_init()

  # Paso 1 — estado vacío.
  expect_contract(linked_list_is_empty(linked_list), TRUE, "LinkedList 1", "is_empty should be true after init")
  expect_contract(linked_list_size(linked_list), 0, "LinkedList 1", "size should be 0 after init")
  expect_contract(linked_list_get_head(linked_list), failure_indicator, "LinkedList 1", "get_head on an empty list should return -1")

  # Paso 2 — inserción por ambos extremos: el orden del contrato es 5, 10, 20, 10.
  linked_list <- linked_list_insert_tail(linked_list, inserted_tail_first)
  linked_list <- linked_list_insert_tail(linked_list, inserted_tail_second)
  linked_list <- linked_list_insert_head(linked_list, inserted_head_value)
  linked_list <- linked_list_insert_tail(linked_list, repeated_value)
  expect_contract(linked_list_size(linked_list), 4, "LinkedList 2", "size should be 4 after the four insertions")
  expect_contract(linked_list_get_head(linked_list), inserted_head_value, "LinkedList 2", "the head of the order 5, 10, 20, 10 should be 5")

  # Paso 3 — eliminar la primera aparición: la lista queda 5, 20, 10.
  removed <- linked_list_delete(linked_list, inserted_tail_first)
  linked_list <- removed$updated
  expect_contract(removed$deleted, TRUE, "LinkedList 3", "deleting a present value should succeed")
  expect_contract(linked_list_size(linked_list), 3, "LinkedList 3", "size should be 3 after delete(10)")
  expect_contract(linked_list_get_head(linked_list), inserted_head_value, "LinkedList 3", "the head should still be 5 after delete(10)")

  # Paso 4 — valor ausente: ni el orden ni el tamaño cambian.
  removed <- linked_list_delete(linked_list, absent_value)
  linked_list <- removed$updated
  expect_contract(removed$deleted, FALSE, "LinkedList 4", "deleting an absent value should fail")
  expect_contract(linked_list_size(linked_list), 3, "LinkedList 4", "size should not change after delete(99)")
  expect_contract(linked_list_get_head(linked_list), inserted_head_value, "LinkedList 4", "the head should not change after delete(99)")

  # Paso 5 — vaciar la lista: cada borrado revela el valor siguiente del orden.
  removed <- linked_list_delete(linked_list, inserted_head_value)
  linked_list <- removed$updated
  expect_contract(removed$deleted, TRUE, "LinkedList 5", "deleting 5 should succeed")
  expect_contract(linked_list_get_head(linked_list), inserted_tail_second, "LinkedList 5", "after delete(5) the next value of the order should be 20")

  removed <- linked_list_delete(linked_list, inserted_tail_second)
  linked_list <- removed$updated
  expect_contract(removed$deleted, TRUE, "LinkedList 5", "deleting 20 should succeed")
  expect_contract(linked_list_get_head(linked_list), repeated_value, "LinkedList 5", "after delete(20) the last value of the order should be 10")

  removed <- linked_list_delete(linked_list, repeated_value)
  linked_list <- removed$updated
  expect_contract(removed$deleted, TRUE, "LinkedList 5", "deleting the last value should succeed")
  expect_contract(linked_list_is_empty(linked_list), TRUE, "LinkedList 5", "is_empty should be true after emptying")
  expect_contract(linked_list_size(linked_list), 0, "LinkedList 5", "size should be 0 after emptying")
  expect_contract(linked_list_get_head(linked_list), failure_indicator, "LinkedList 5", "get_head should return -1 again")
})
