# Ejecutor compartido: `<escenario>: <sujeto> should <conducta esperada>`.
expect_contract <- function(actual, expected, scenario, behavior) {
  expect_equal(actual, expected, info = paste0(scenario, ": ", behavior))
}
