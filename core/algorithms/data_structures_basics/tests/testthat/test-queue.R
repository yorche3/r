# Casos del contrato `Queue` de la especificación 06_Data_Structures_Basics.
#
# Los cuatro pasos corren sobre la misma cola: se declara una vez con `init()` y
# cada paso continúa el estado anterior, sin reiniciar el escenario.
#
# Adecuación value-semantic: cada operación devuelve la cola actualizada
# (`x <- operacion(x, ...)`) y `dequeue` devuelve además el valor extraído en
# `list(value = <entero>, updated = <Queue>)`.

enqueued_first <- 10
enqueued_second <- 20
enqueued_third <- 30
enqueued_after_dequeue <- 40
failure_indicator <- -1

test_that("Queue", {
  queue <- queue_init()

  # Paso 1 — estado vacío y extracción fallida.
  expect_contract(queue_is_empty(queue), TRUE, "Queue 1", "is_empty should be true after init")
  expect_contract(queue_size(queue), 0, "Queue 1", "size should be 0 after init")
  expect_contract(queue_peek(queue), failure_indicator, "Queue 1", "peek on an empty queue should return -1")

  dequeued <- queue_dequeue(queue)
  expect_contract(dequeued$value, failure_indicator, "Queue 1", "dequeue on an empty queue should return -1")
  expect_contract(queue_is_empty(dequeued$updated), TRUE, "Queue 1", "a failed dequeue should keep the queue empty")

  # Paso 2 — FIFO y `peek` no mutante.
  queue <- queue_enqueue(queue, enqueued_first)
  queue <- queue_enqueue(queue, enqueued_second)
  queue <- queue_enqueue(queue, enqueued_third)
  expect_contract(queue_peek(queue), enqueued_first, "Queue 2", "peek should return 10")
  expect_contract(queue_size(queue), 3, "Queue 2", "size should be 3 after three enqueues")

  # Paso 3 — extracción y reutilización.
  dequeued <- queue_dequeue(queue)
  queue <- dequeued$updated
  expect_contract(dequeued$value, enqueued_first, "Queue 3", "the first dequeue should return 10")

  queue <- queue_enqueue(queue, enqueued_after_dequeue)
  dequeued <- queue_dequeue(queue)
  queue <- dequeued$updated
  expect_contract(dequeued$value, enqueued_second, "Queue 3", "the next dequeue should return 20")

  dequeued <- queue_dequeue(queue)
  queue <- dequeued$updated
  expect_contract(dequeued$value, enqueued_third, "Queue 3", "the next dequeue should return 30")

  dequeued <- queue_dequeue(queue)
  queue <- dequeued$updated
  expect_contract(dequeued$value, enqueued_after_dequeue, "Queue 3", "the final dequeue should return 40")
  expect_contract(queue_is_empty(queue), TRUE, "Queue 3", "is_empty should be true after removing everything")
  expect_contract(queue_size(queue), 0, "Queue 3", "size should be 0 after removing everything")

  # Paso 4 — vacío tras la extracción.
  dequeued <- queue_dequeue(queue)
  expect_contract(dequeued$value, failure_indicator, "Queue 4", "dequeue on an empty queue should fail")
  expect_contract(queue_is_empty(dequeued$updated), TRUE, "Queue 4", "a failed dequeue should keep the queue empty")
})
