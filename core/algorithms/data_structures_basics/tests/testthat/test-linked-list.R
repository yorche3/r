# Prueba de arranque del módulo: valida que `make test` descubre y ejecuta la
# suite. Los cinco casos de la especificación se añaden en el paso 4c.

test_that("el contrato de LinkedList se carga", {
  expect_s4_class(linked_list_init(), "LinkedList")
})
