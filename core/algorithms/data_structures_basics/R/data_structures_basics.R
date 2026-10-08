# data_structures_basics — Node, LinkedList, Stack y Queue sobre un nodo compartido.
#
# Especificación: 06_Data_Structures_Basics
#
# Contrato R: clases S4 para los cuatro tipos del dominio y funciones
# snake_case para las operaciones del contrato.
#
# Adecuaciones:
#   - S4 es value-semantic (copy-on-modify): las operaciones que actualizarían
#     la estructura reciben el objeto y devuelven la versión nueva, así que el
#     patrón de uso es `x <- operacion(x, ...)`.
#   - `pop`, `dequeue` y `delete` comunican dos valores, así que devuelven una
#     lista con nombre: `list(value = <valor>, updated = <estructura>)` y
#     `list(deleted = <lógico>, updated = <estructura>)`.
#   - Solo el enlace de un `Node` puede ser `NULL`; las lecturas enteras que
#     pueden fallar devuelven el indicador `-1`.
#   - El slot del enlace se llama `next_node` porque `next` es palabra reservada
#     en R y obligaría a comillas inversas en cada acceso.
#   - El contador se guarda en un slot `numeric`: con `integer`, cada
#     `count + 1` (que promueve a double) rompería la asignación.
#
# Esqueleto del contrato (paso 4b): las `init` ya devuelven el estado inicial,
# que es lo que necesita la suite para construir sus escenarios; el algoritmo de
# las operaciones de las tres estructuras es del paso 5, así que mientras no lo
# haya cada operación devuelve su indicador.
#
# Aviso para el paso 5: con copy-on-modify, añadir por la cola exige reconstruir
# el camino desde la cabeza; `set_next` sobre el nodo de cola devuelve una copia
# que no está en la cadena que cuelga de `head`.

setClass("Node", slots = c(value = "numeric", next_node = "ANY"))
setClass("LinkedList", slots = c(head = "ANY", tail = "ANY", count = "numeric"))
setClass("Stack", slots = c(top = "ANY", count = "numeric"))
setClass("Queue", slots = c(front = "ANY", rear = "ANY", count = "numeric"))

# ---------------------------------------------------------------------------
# Node — celda compartida: su init y sus accesores son parte del contrato
# ---------------------------------------------------------------------------

node_init <- function(value) {
  new("Node", value = value, next_node = NULL)
}

node_get_value <- function(node) {
  if (is.null(node)) -1 else node@value
}

node_get_next <- function(node) {
  if (is.null(node)) NULL else node@next_node
}

node_set_next <- function(node, next_node) {
  node@next_node <- next_node
  node
}

# ---------------------------------------------------------------------------
# LinkedList
# ---------------------------------------------------------------------------

linked_list_init <- function() {
  new("LinkedList", head = NULL, tail = NULL, count = 0)
}

# Valor de la cabeza, o -1 con la lista vacía (`get_head`).
linked_list_get_head <- function(linked_list) {
  -1
}

# Inserta al principio y devuelve la lista actualizada (`insert_head`).
linked_list_insert_head <- function(linked_list, value) {
  linked_list
}

# Inserta al final y devuelve la lista actualizada (`insert_tail`).
linked_list_insert_tail <- function(linked_list, value) {
  linked_list
}

# Elimina la primera aparición: `list(deleted = <lógico>, updated = <LinkedList>)`.
linked_list_delete <- function(linked_list, value) {
  list(deleted = FALSE, updated = linked_list)
}

# Cierto exactamente cuando no hay nodos (`is_empty`).
linked_list_is_empty <- function(linked_list) {
  FALSE
}

# Número de nodos (`size`).
linked_list_size <- function(linked_list) {
  0
}

# ---------------------------------------------------------------------------
# Stack — LIFO independiente: no envuelve LinkedList
# ---------------------------------------------------------------------------

stack_init <- function() {
  new("Stack", top = NULL, count = 0)
}

# Apila sobre el tope y devuelve la pila actualizada (`push`).
stack_push <- function(stack, value) {
  stack
}

# Extrae el tope: `list(value = <int>, updated = <Stack>)`, con -1 si está vacía.
stack_pop <- function(stack) {
  list(value = -1, updated = stack)
}

# Observa el tope sin extraerlo, o -1 si está vacía (`peek`).
stack_peek <- function(stack) {
  -1
}

stack_is_empty <- function(stack) {
  FALSE
}

stack_size <- function(stack) {
  0
}

# ---------------------------------------------------------------------------
# Queue — FIFO independiente: no envuelve LinkedList
# ---------------------------------------------------------------------------

queue_init <- function() {
  new("Queue", front = NULL, rear = NULL, count = 0)
}

# Añade por el final y devuelve la cola actualizada (`enqueue`).
queue_enqueue <- function(queue, value) {
  queue
}

# Extrae el frente: `list(value = <int>, updated = <Queue>)`, con -1 si está vacía.
queue_dequeue <- function(queue) {
  list(value = -1, updated = queue)
}

# Observa el frente sin extraerlo, o -1 si está vacía (`peek`).
queue_peek <- function(queue) {
  -1
}

queue_is_empty <- function(queue) {
  FALSE
}

queue_size <- function(queue) {
  0
}
