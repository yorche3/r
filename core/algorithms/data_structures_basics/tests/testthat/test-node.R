# Casos del contrato `Node` de la especificación 06_Data_Structures_Basics.
#
# `Node` es la única celda enlazada del módulo y la comparten `LinkedList`,
# `Stack` y `Queue`. La ausencia del enlace usa la representación nativa de R,
# `NULL`, y los valores son enteros positivos para no colisionar con el
# indicador de fallo `-1`.

first_value <- 10
second_value <- 20
absent_node <- NULL
failure_indicator <- -1

test_that("Node", {
  first <- node_init(first_value)
  expect_contract(node_get_value(first), first_value, "Node 1", "get_value should be 10")
  expect_contract(node_get_next(first), absent_node, "Node 1", "init should leave next absent")

  second <- node_init(second_value)
  first <- node_set_next(first, second)
  expect_contract(node_get_value(node_get_next(first)), second_value, "Node 2", "traversal should reach 20")
  expect_contract(node_get_next(second), absent_node, "Node 2", "the second node's next should be absent")
})

# Caso nulo controlado: R representa la ausencia con `NULL` y el contrato
# devuelve su indicador en lugar de lanzar una excepción.
test_that("Node: nodo ausente", {
  expect_contract(node_get_value(absent_node), failure_indicator, "Node 3", "get_value of the absent node should return -1")
  expect_contract(node_get_next(absent_node), absent_node, "Node 3", "get_next of the absent node should be absent")
})
