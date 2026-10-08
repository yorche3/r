# Prueba de arranque del módulo: valida que `make test` descubre y ejecuta la
# suite. Los cuatro casos de la especificación se añaden en el paso 4c.

test_that("el contrato de Stack se carga", {
  expect_s4_class(stack_init(), "Stack")
})
