# Data Structures Basics — R

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **R**, con **testthat** como framework de pruebas unitarias.

Estructuras de datos elementales sobre una celda enlazada compartida: un único tipo `Node` y tres estructuras de acceso construidas manualmente sobre él —**lista enlazada** (`LinkedList`), **pila** (`Stack`) y **cola** (`Queue`)—, gestionando independientemente sus propios punteros y contadores, sin envolver `LinkedList` ni delegar en colecciones estándar de R.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`DESCRIPTION`](DESCRIPTION) | Manifiesto del paquete `dataStructuresBasics`: versión, licencia, importación de `methods` y dependencia de `testthat`. |
| [`NAMESPACE`](NAMESPACE) | Exporta las 4 clases S4 (`Node`, `LinkedList`, `Stack`, `Queue`) y las 22 funciones del contrato. |
| [`R/data_structures_basics.R`](R/data_structures_basics.R) | Módulo principal: clases S4, helpers auxiliares de encadenamiento sobre `Node`, y operaciones del contrato para `Node`, `LinkedList`, `Stack` y `Queue`. |
| [`Makefile`](Makefile) | Punto de entrada del módulo: `make test` y `make clean`. |
| [`tests/testthat/helper-contract.R`](tests/testthat/helper-contract.R) | Helper compartido de aserción contractual (`expect_contract`). |
| [`tests/testthat/test-node.R`](tests/testthat/test-node.R) | Suite para `Node`: 2 tests (6 expectativas). |
| [`tests/testthat/test-linked-list.R`](tests/testthat/test-linked-list.R) | Suite para `LinkedList`: 1 test (19 expectativas secuenciales). |
| [`tests/testthat/test-stack.R`](tests/testthat/test-stack.R) | Suite para `Stack`: 1 test (15 expectativas secuenciales). |
| [`tests/testthat/test-queue.R`](tests/testthat/test-queue.R) | Suite para `Queue`: 1 test (15 expectativas secuenciales). |
| [`.gitignore`](.gitignore) | Archivos generados y temporales de R excluidos (`.Rhistory`, `.RData`, `*.Rcheck/`). |
| `README.md` | Este archivo / This file. |

**Estructura de directorios / Directory layout:**

```text
data_structures_basics/
├── DESCRIPTION
├── NAMESPACE
├── Makefile
├── R/
│   └── data_structures_basics.R
├── tests/
│   └── testthat/
│       ├── helper-contract.R
│       ├── test-node.R
│       ├── test-linked-list.R
│       ├── test-stack.R
│       └── test-queue.R
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto sigue la estructura estándar de paquetes de R establecida en el repositorio (`DESCRIPTION`, `NAMESPACE`, `R/` y `tests/testthat/`). Las cuatro estructuras se modelan mediante clases formales **S4** (`methods`). Debido a que R implementa semántica de valor (*copy-on-modify*), los objetos no mutan por referencia: las operaciones que modifican la estructura retornan la instancia actualizada (`obj <- operacion(obj, ...)`). Operaciones como `pop`, `dequeue` y `delete` que retornan tanto un valor o estado como la estructura modificada se empaquetan en listas nombradas (`list(value = ..., updated = ...)` o `list(deleted = ..., updated = ...)`).

**EN:** This project follows the standard R package layout established in the repository (`DESCRIPTION`, `NAMESPACE`, `R/`, and `tests/testthat/`). All four structures are modeled via formal **S4** classes (`methods`). Because R uses value semantics (*copy-on-modify*), objects do not mutate by reference: mutating operations return the updated instance (`obj <- operacion(obj, ...)`). Operations such as `pop`, `dequeue`, and `delete` that return both a value/status and the modified structure return a named list (`list(value = ..., updated = ...)` or `list(deleted = ..., updated = ...)`).

### Inicialización / Initialization

```bash
mkdir -p r/core/algorithms/data_structures_basics/{R,tests/testthat}
```

No requiere herramientas externas ni empaquetado previo; `make test` invoca `testthat::test_local()`, cargando el paquete en memoria con `pkgload::load_all()`.

---

## 📄 Configuración clave / Key Configuration

**ES:** El manifiesto `DESCRIPTION` define el paquete `dataStructuresBasics` declarando dependencia en `methods` para clases S4 y `testthat` (edición 3) en `Suggests`. `NAMESPACE` exporta las clases S4 y cada función pública del contrato bajo nomenclatura `snake_case` con prefijo de la estructura (`node_*`, `linked_list_*`, `stack_*`, `queue_*`).

**EN:** The `DESCRIPTION` manifest defines the `dataStructuresBasics` package with dependencies on `methods` for S4 classes and `testthat` (edition 3) under `Suggests`. `NAMESPACE` exports all S4 classes and each public contract function using `snake_case` with structure prefixes (`node_*`, `linked_list_*`, `stack_*`, `queue_*`).

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Verificación sintáctica / Syntax check
Rscript -e 'invisible(parse("R/data_structures_basics.R")); cat("parse OK\n")'

# Ejecución de la suite completa / Run full test suite
make test
```

**Salida real / Actual output:**

```text
Rscript -e "testthat::test_local()"
✔ | F W  S  OK | Context
⠏ |          0 | linked-list                                                    ✔ |         19 | linked-list
⠏ |          0 | node                                                           ✔ |          6 | node
⠏ |          0 | queue                                                          ✔ |         15 | queue
⠏ |          0 | stack                                                          ✔ |         15 | stack

══ Results ═════════════════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 55 ]
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `node_init(value)` | `numeric → Node` | $O(1)$ | Inicializa celda con valor y `next_node = NULL`. |
| `node_get_value(node)` | `Node? → numeric` | $O(1)$ | Retorna el valor o `-1` si el nodo es `NULL`. |
| `node_get_next(node)` | `Node? → Node?` | $O(1)$ | Retorna el nodo enlazado o `NULL`. |
| `node_set_next(node, next_node)` | `(Node, Node?) → Node` | $O(1)$ | Actualiza el enlace `next_node` y retorna el nodo. |
| `linked_list_init()` | `void → LinkedList` | $O(1)$ | Lista vacía: `head = NULL`, `tail = NULL`, `count = 0`. |
| `linked_list_is_empty(list)` | `LinkedList → logical` | $O(1)$ | `TRUE` si `head` es `NULL` (o `count == 0`). |
| `linked_list_size(list)` | `LinkedList → numeric` | $O(1)$ | Retorna el contador `count`. |
| `linked_list_get_head(list)` | `LinkedList → numeric` | $O(1)$ | Valor de la cabeza o `-1` si está vacía. |
| `linked_list_insert_head(list, value)` | `(LinkedList, numeric) → LinkedList` | $O(1)$ | Inserta al inicio y actualiza `head` (y `tail` si estaba vacía). |
| `linked_list_insert_tail(list, value)` | `(LinkedList, numeric) → LinkedList` | $O(n)$ | Reconstruye la cadena enlazada hasta el final por semántica de valor (*copy-on-modify*). |
| `linked_list_delete(list, value)` | `(LinkedList, numeric) → list` | $O(n)$ | Retorna `list(deleted = logical, updated = LinkedList)`. |
| `stack_init()` | `void → Stack` | $O(1)$ | Pila vacía: `top = NULL`, `count = 0`. |
| `stack_is_empty(stack)` | `Stack → logical` | $O(1)$ | `TRUE` si `top` es `NULL`. |
| `stack_size(stack)` | `Stack → numeric` | $O(1)$ | Retorna el contador `count`. |
| `stack_push(stack, value)` | `(Stack, numeric) → Stack` | $O(1)$ | Inserta nuevo tope apuntando al anterior. |
| `stack_peek(stack)` | `Stack → numeric` | $O(1)$ | Valor del tope o `-1` si está vacía. |
| `stack_pop(stack)` | `Stack → list` | $O(1)$ | Retorna `list(value = numeric, updated = Stack)` (o `-1` si vacía). |
| `queue_init()` | `void → Queue` | $O(1)$ | Cola vacía: `front = NULL`, `rear = NULL`, `count = 0`. |
| `queue_is_empty(queue)` | `Queue → logical` | $O(1)$ | `TRUE` si `front` es `NULL`. |
| `queue_size(queue)` | `Queue → numeric` | $O(1)$ | Retorna el contador `count`. |
| `queue_enqueue(queue, value)` | `(Queue, numeric) → Queue` | $O(n)$ | Reconstruye la cadena enlazada hasta el final por semántica de valor (*copy-on-modify*). |
| `queue_peek(queue)` | `Queue → numeric` | $O(1)$ | Valor de `front` o `-1` si está vacía. |
| `queue_dequeue(queue)` | `Queue → list` | $O(1)$ | Retorna `list(value = numeric, updated = Queue)` (o `-1` si vacía). |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Clases S4 formales (`setClass`, `new`) | Clases S3 (listas con clase) o entornos mutables R6 / `environment` | S4 proporciona verificación de slots y tipos explícitos manteniendo fidelidad a la semántica funcional canónica de R sin recurrir a mutabilidad oculta por entornos. |
| Slot `next_node` en lugar de `next` | Usar nombre `next` con comillas invertidas (`` `next` ``) | `next` es una palabra clave reservada del lenguaje R (control de flujo en bucles). Usar `next_node` evita colisiones de sintaxis y código frágil. |
| Slot `count` como `"numeric"` | Slot `"integer"` | Operaciones aritméticas elementales como `count + 1` en R producen literales `numeric` (`double`), lo que causaría errores de asignación de tipo en S4 si el slot fuera estrictamente `integer`. |
| Retorno compuesto mediante listas nombradas | Modificación *in-place* vía entornos mutables | R opera por defecto con semántica de paso por valor (*copy-on-modify*). Retornar `list(value = ..., updated = ...)` hace explícito y puro el flujo de transformación de datos. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node.next` (nombre de campo) | Slot `next_node` y accesores `node_get_next` / `node_set_next` | `next` es palabra reservada en R. |
| Mutación *in-place* (`set_next`, `insert_*`, `delete`, `push`, `pop`, `enqueue`, `dequeue`) | Semántica funcional de valor: retorno del objeto actualizado (`updated`) | R no dispone de punteros mutables nativos en estructuras estándar; todo objeto se pasa por valor (*copy-on-modify*). |
| Complejidad $O(1)$ en `insert_tail` y `enqueue` | Complejidad $O(n)$ en `linked_list_insert_tail` y `queue_enqueue` | En semántica inmutable/copy-on-modify, actualizar el último nodo requiere reconstruir la cadena desde la cabeza hasta el final para que el cambio persista en la lista resultante. |
| `src/data_structures_basics.ext` | `R/data_structures_basics.R` | Convención obligatoria de layout para paquetes de R. |
| `test/data_structures_basics_test.ext` | `tests/testthat/test-*.R` | Convención de tests bajo el framework testthat. |
| `test/run_tests.ext` | `Makefile` (`make test`) | Entrada estándar de automatización en el monorepo. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `node_get_value` | Nodo ausente (`node = NULL`) | `-1` | `node_get_value(NULL) == -1` |
| `node_get_next` | Nodo ausente o sin siguiente | `NULL` | `node_get_next(NULL) == NULL` |
| `linked_list_get_head` | Lista vacía (`count == 0` o `head == NULL`) | `-1` | `linked_list_get_head(list) == -1` |
| `linked_list_delete` | Valor no encontrado en la lista | `list(deleted = FALSE, updated = list)` | `result$deleted == FALSE` |
| `stack_peek` | Pila vacía (`count == 0` o `top == NULL`) | `-1` | `stack_peek(stack) == -1` |
| `stack_pop` | Pila vacía (`count == 0` o `top == NULL`) | `list(value = -1, updated = stack)` | `result$value == -1` |
| `queue_peek` | Cola vacía (`count == 0` o `front == NULL`) | `-1` | `queue_peek(queue) == -1` |
| `queue_dequeue` | Cola vacía (`count == 0` o `front == NULL`) | `list(value = -1, updated = queue)` | `result$value == -1` |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `Node`: Inicializar y observar valor/enlace | Sí | `tests/testthat/test-node.R:13` | Comprueba `node_get_value` = 10 y `node_get_next` ausente (`NULL`). |
| `Node`: Enlazar y recorrer | Sí | `tests/testthat/test-node.R:18` | Enlaza segundo nodo y recorre observando 20 y `NULL`. |
| `Node`: Ausencia nativa | Sí | `tests/testthat/test-node.R:26` | Comprueba manejo no erróneo de nodo `NULL` (valor `-1`, siguiente `NULL`). |
| `LinkedList`: Paso 1 — Estado vacío | Sí | `tests/testthat/test-linked-list.R:22` | Verifica `is_empty` = `TRUE`, `size` = 0, `get_head` = `-1`. |
| `LinkedList`: Paso 2 — Insertar ambos extremos | Sí | `tests/testthat/test-linked-list.R:27` | Inserta 10, 20 por cola, 5 por cabeza, 10 por cola; tamaño 4 y cabeza 5. |
| `LinkedList`: Paso 3 — Eliminar primera aparición | Sí | `tests/testthat/test-linked-list.R:35` | `delete(10)` tiene éxito; tamaño pasa a 3 y cabeza se mantiene en 5. |
| `LinkedList`: Paso 4 — Valor ausente | Sí | `tests/testthat/test-linked-list.R:42` | `delete(99)` falla (`deleted = FALSE`); tamaño 3 y cabeza 5 intactos. |
| `LinkedList`: Paso 5 — Vaciar lista | Sí | `tests/testthat/test-linked-list.R:49` | Elimina 5, 20 y 10 sucesivamente; verifica `is_empty` = `TRUE`, `size` = 0 y `get_head` = `-1`. |
| `Stack`: Paso 1 — Vacío y extracción fallida | Sí | `tests/testthat/test-stack.R:19` | Verifica `is_empty` = `TRUE`, `size` = 0, `peek` = `-1`, `pop` retorna `-1` y conserva vacío. |
| `Stack`: Paso 2 — LIFO y `peek` no mutante | Sí | `tests/testthat/test-stack.R:28` | Apila 10, 20, 30; verifica `peek` = 30 y tamaño 3. |
| `Stack`: Paso 3 — Extracción y reutilización | Sí | `tests/testthat/test-stack.R:35` | `pop` (30), `push(40)`, tres `pop` (40, 20, 10); verifica `is_empty` = `TRUE`, tamaño 0. |
| `Stack`: Paso 4 — Vacío tras extracción | Sí | `tests/testthat/test-stack.R:55` | `pop` sobre vacía falla (`value` = `-1`) y mantiene `is_empty` = `TRUE`. |
| `Queue`: Paso 1 — Vacío y extracción fallida | Sí | `tests/testthat/test-queue.R:19` | Verifica `is_empty` = `TRUE`, `size` = 0, `peek` = `-1`, `dequeue` retorna `-1` y conserva vacío. |
| `Queue`: Paso 2 — FIFO y `peek` no mutante | Sí | `tests/testthat/test-queue.R:28` | Encola 10, 20, 30; verifica `peek` = 10 y tamaño 3. |
| `Queue`: Paso 3 — Extracción y reutilización | Sí | `tests/testthat/test-queue.R:35` | `dequeue` (10), `enqueue(40)`, tres `dequeue` (20, 30, 40); verifica `is_empty` = `TRUE`, tamaño 0. |
| `Queue`: Paso 4 — Vacío tras extracción | Sí | `tests/testthat/test-queue.R:55` | `dequeue` sobre vacía falla (`value` = `-1`) y mantiene `is_empty` = `TRUE`. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Inserción por cola en $O(n)$ en `LinkedList` y `Queue` | Impacto de rendimiento en secuencias de inserción muy largas al requerir reconstrucción de la cadena enlazada. | Consecuencia intrínseca de la semántica de valor de R (*copy-on-modify*). Se abordará con estructuras con mutabilidad interna por entornos o referencias en fases avanzadas cuando esté permitido. |

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Semántica de valor y persistencia estructural / Value semantics and structural persistence

**ES:** A diferencia de lenguajes imperativos con punteros mutables en memoria libre (como C o Go), R opera bajo *copy-on-modify*. Cuando se añade un elemento al final de la cola o de la lista enlazada, actualizar el puntero `tail` o `rear` no muta el nodo terminal dentro del árbol de referencias que cuelga de `head`. Por tanto, la función auxiliar `append_node_help` recorre y reconstruye de manera recursiva la cadena de nodos desde `head`. De forma análoga, `remove_node_help` reconstruye la cadena desenganchando la primera coincidencia.

**EN:** Unlike imperative languages with mutable raw pointers (such as C or Go), R operates under copy-on-modify. When appending an element at the end of a queue or linked list, updating a `tail` or `rear` field does not mutate the terminal node within the reference chain hanging from `head`. Therefore, the internal helper `append_node_help` recursively traverses and reconstructs the node chain from `head`. Similarly, `remove_node_help` reconstructs the chain unlinking the first match.

### 🧱 Modularidad e independencia de ADTs / Modularity and ADT independence

**ES:** Las estructuras `LinkedList`, `Stack` y `Queue` comparten única y exclusivamente la celda elemental `Node`. Ninguna de las estructuras delega en `LinkedList` ni en las listas genéricas de R (`list`). Cada ADT mantiene su propio puntero (`head`/`tail`, `top`, `front`/`rear`) y gestiona de forma autónoma su propio contador `count`.

**EN:** The `LinkedList`, `Stack`, and `Queue` structures exclusively share the elementary `Node` cell. None of the ADTs delegates to `LinkedList` or to R's generic collection lists (`list`). Each ADT maintains its own pointer set (`head`/`tail`, `top`, `front`/`rear`) and independently manages its own `count`.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`r/core/algorithms/naive_sort/`](../naive_sort/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [S4 Classes in R Documentation](https://stat.ethz.ch/R-manual/R-patched/library/methods/html/Classes_Details.html) |

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
