# Ejecutor compartido de la suite del módulo.
#
# Los escenarios de 06_Data_Structures_Basics no son pares (entrada, salida)
# independientes sino **pasos sucesivos sobre la misma instancia**, así que el
# ejecutor recibe el paso del escenario y la conducta que espera el contrato, y
# compara el valor observado con el esperado. El mensaje queda en el formato de
# la casa, `<sujeto> should <conducta esperada>`:
#
#   LinkedList 2: size should be 4 after the insertions
#
# testthat recoge este archivo antes que los `test-*.R` por su prefijo `helper`.

expect_contract <- function(actual, expected, scenario, behavior) {
  expect_equal(actual, expected, info = paste0(scenario, ": ", behavior))
}
