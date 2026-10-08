# Prueba de arranque del módulo: valida que `make test` descubre y ejecuta la
# suite. Los dos casos de la especificación se añaden en el paso 4c.

test_that("el contrato de Node se carga y funciona la celda compartida", {
  first <- node_init(10)
  second <- node_init(20)
  first <- node_set_next(first, second)

  expect_s4_class(first, "Node")
  expect_equal(node_get_value(first), 10)
  expect_equal(node_get_value(node_get_next(first)), 20)
  expect_null(node_get_next(second))
})
