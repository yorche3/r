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
# Implementación (paso 5): el estado vive en las cadenas de `Node`. Con
# copy-on-modify, el nodo de cola está *dentro* de la cadena que cuelga de la
# cabeza, así que engancharlo desde `tail`/`rear` —o desenganchar un nodo
# intermedio desde su anterior— modificaría una copia que ya no está en la
# cadena: las operaciones que crecen o encogen por el final rehacen el camino
# desde la cabeza, y esa copia deja la inserción por la cola en `O(n)` frente al
# `O(1)` del pseudocódigo: es la adaptación de la semántica de valor, que el
# README declara. Los tres helpers `_help` operan sobre la cadena de `Node` (el
# tipo compartido), nunca sobre `LinkedList`: cada ADT sigue gestionando sus
# propios punteros y su contador.

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
# Helpers de la cadena compartida: operan sobre `Node`, no sobre las estructuras
# ---------------------------------------------------------------------------

# Engancha `new_node` al final de la cadena que empieza en `current` y devuelve
# la cadena reconstruida: el nodo final está dentro de la cadena que cuelga de
# la cabeza, así que hay que rehacer el camino desde ahí.
append_node_help <- function(current, new_node) {
  if (is.null(node_get_next(current))) {
    current@next_node <- new_node
  } else {
    current@next_node <- append_node_help(node_get_next(current), new_node)
  }
  current
}

# Último nodo de la cadena que empieza en `current`, o `NULL` si está vacía.
last_node_help <- function(current) {
  if (is.null(current)) {
    return(NULL)
  }
  while (!is.null(node_get_next(current))) {
    current <- node_get_next(current)
  }
  current
}

# Saca la primera aparición de `value` de la cadena que empieza en `current`:
# `list(node = <cadena reconstruida>, deleted = <lógico>)`.
remove_node_help <- function(current, value) {
  if (is.null(current)) {
    return(list(node = NULL, deleted = FALSE))
  }
  if (current@value == value) {
    return(list(node = node_get_next(current), deleted = TRUE))
  }
  rest <- remove_node_help(node_get_next(current), value)
  current@next_node <- rest$node
  list(node = current, deleted = rest$deleted)
}

# ---------------------------------------------------------------------------
# LinkedList
# ---------------------------------------------------------------------------

linked_list_init <- function() {
  new("LinkedList", head = NULL, tail = NULL, count = 0)
}

# Valor de la cabeza, o -1 con la lista vacía (`get_head`).
linked_list_get_head <- function(linked_list) {
  if (is.null(linked_list@head)) -1 else linked_list@head@value
}

# Inserta al principio y devuelve la lista actualizada (`insert_head`).
linked_list_insert_head <- function(linked_list, value) {
  new_head <- node_init(value)
  new_head@next_node <- linked_list@head
  linked_list@head <- new_head
  if (is.null(linked_list@tail)) {
    linked_list@tail <- new_head
  }
  linked_list@count <- linked_list@count + 1
  linked_list
}

# Inserta al final y devuelve la lista actualizada (`insert_tail`).
linked_list_insert_tail <- function(linked_list, value) {
  new_tail <- node_init(value)
  if (is.null(linked_list@head)) {
    linked_list@head <- new_tail
  } else {
    linked_list@head <- append_node_help(linked_list@head, new_tail)
  }
  linked_list@tail <- new_tail
  linked_list@count <- linked_list@count + 1
  linked_list
}

# Elimina la primera aparición: `list(deleted = <lógico>, updated = <LinkedList>)`.
linked_list_delete <- function(linked_list, value) {
  result <- remove_node_help(linked_list@head, value)

  if (!result$deleted) {
    return(list(deleted = FALSE, updated = linked_list))
  }

  linked_list@head <- result$node
  linked_list@tail <- last_node_help(result$node)
  linked_list@count <- linked_list@count - 1
  list(deleted = TRUE, updated = linked_list)
}

# Cierto exactamente cuando no hay nodos (`is_empty`).
linked_list_is_empty <- function(linked_list) {
  is.null(linked_list@head)
}

# Número de nodos (`size`).
linked_list_size <- function(linked_list) {
  linked_list@count
}

# ---------------------------------------------------------------------------
# Stack — LIFO independiente: no envuelve LinkedList
# ---------------------------------------------------------------------------

stack_init <- function() {
  new("Stack", top = NULL, count = 0)
}

# Apila sobre el tope y devuelve la pila actualizada (`push`).
stack_push <- function(stack, value) {
  new_top <- node_init(value)
  new_top@next_node <- stack@top
  stack@top <- new_top
  stack@count <- stack@count + 1
  stack
}

# Extrae el tope: `list(value = <int>, updated = <Stack>)`, con -1 si está vacía.
stack_pop <- function(stack) {
  if (is.null(stack@top)) {
    list(value = -1, updated = stack)
  } else {
    value <- stack@top@value
    stack@top <- stack@top@next_node
    stack@count <- stack@count - 1
    list(value = value, updated = stack)
  }
}

# Observa el tope sin extraerlo, o -1 si está vacía (`peek`).
stack_peek <- function(stack) {
  if (is.null(stack@top)) -1 else stack@top@value
}

stack_is_empty <- function(stack) {
  is.null(stack@top)
}

stack_size <- function(stack) {
  stack@count
}

# ---------------------------------------------------------------------------
# Queue — FIFO independiente: no envuelve LinkedList
# ---------------------------------------------------------------------------

queue_init <- function() {
  new("Queue", front = NULL, rear = NULL, count = 0)
}

# Añade por el final y devuelve la cola actualizada (`enqueue`).
queue_enqueue <- function(queue, value) {
  new_rear <- node_init(value)
  if (is.null(queue@front)) {
    queue@front <- new_rear
  } else {
    queue@front <- append_node_help(queue@front, new_rear)
  }
  queue@rear <- new_rear
  queue@count <- queue@count + 1
  queue
}

# Extrae el frente: `list(value = <int>, updated = <Queue>)`, con -1 si está vacía.
queue_dequeue <- function(queue) {
  if (is.null(queue@front)) {
    list(value = -1, updated = queue)
  } else {
    value <- queue@front@value
    queue@front <- queue@front@next_node
    if (is.null(queue@front)) {
      queue@rear <- NULL
    }
    queue@count <- queue@count - 1
    list(value = value, updated = queue)
  }
}

# Observa el frente sin extraerlo, o -1 si está vacía (`peek`).
queue_peek <- function(queue) {
  if (is.null(queue@front)) -1 else queue@front@value
}

queue_is_empty <- function(queue) {
  is.null(queue@front)
}

queue_size <- function(queue) {
  queue@count
}
