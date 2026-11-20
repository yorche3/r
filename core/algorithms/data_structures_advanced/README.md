# Data Structures Advanced — R

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **R**, con **testthat** como framework de pruebas unitarias.

Estructuras de datos avanzadas con múltiples enlaces por nodo: una clase base virtual `Node` con valor, dos tipos derivados (`TreeNode` para enlaces izquierdo/derecho y `GraphNode` para adyacencias dirigidas), un árbol binario de búsqueda (`BinaryTree`) y un grafo dirigido (`Graph`) con registro enlazado canónico de vértices y listas de adyacencia ordenadas implementadas manualmente.

Implementation of specification [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) in **R**, using **testthat** as unit testing framework.

Advanced data structures with multiple links per node: a virtual base class `Node` carrying the value, two derived types (`TreeNode` with left/right links and `GraphNode` with directed adjacencies), a binary search tree (`BinaryTree`), and a directed graph (`Graph`) with a manual canonical linked vertex registry and sorted adjacency lists.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`DESCRIPTION`](DESCRIPTION) | Manifiesto del paquete `dataStructuresAdvanced`: metadatos, dependencia de `methods` y `testthat`. |
| [`NAMESPACE`](NAMESPACE) | Exporta las clases (`Node`, `TreeNode`, `BinaryTree`, `Graph`) y las funciones del contrato público. |
| [`R/data_structures_advanced.R`](R/data_structures_advanced.R) | Código fuente principal: clases de referencia (`setRefClass`), helpers recursivos e implementación de los cuatro ADTs. |
| [`Makefile`](Makefile) | Automatización del módulo: `make test` y `make clean`. |
| [`tests/testthat.R`](tests/testthat.R) | Punto de entrada del runner para `R CMD check` (`test_check`). |
| [`tests/testthat/helper-contract.R`](tests/testthat/helper-contract.R) | Helper compartido para aserciones contractuales bilingües (`expect_contract`). |
| [`tests/testthat/test-data-structures-advanced.R`](tests/testthat/test-data-structures-advanced.R) | Suite completa: 23 tests unitarios (156 aserciones) agrupados por estructura. |
| [`.gitignore`](.gitignore) | Archivos temporales y artefactos de R excluidos del repositorio. |
| `README.md` | Este archivo / This file. |

**Estructura de directorios / Directory layout:**

```text
data_structures_advanced/
├── DESCRIPTION
├── NAMESPACE
├── Makefile
├── R/
│   └── data_structures_advanced.R
├── tests/
│   ├── testthat.R
│   └── testthat/
│       ├── helper-contract.R
│       └── test-data-structures-advanced.R
├── .gitignore
└── README.md
```

**Nota de desviación de ubicación / Location deviation note:**  
La especificación propone ubicaciones genéricas como `src/data_structures_advanced.ext` y `test/run_tests.ext`. Siguiendo el estándar de paquetes de R establecido en las bases de referencia del repositorio (`data_structures_basics` y `numbers`), el código fuente se ubica en `R/data_structures_advanced.R`, las pruebas en `tests/testthat/` y el punto de entrada es el `Makefile` con `testthat::test_local()`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto implementa las estructuras requeridas mediante **clases de referencia** de R (`setRefClass` del paquete estándar `methods`). Las clases de referencia proporcionan semántica de referencia mutable con punteros internos, permitiendo modificar enlaces *in-place* sin reconstruir el árbol o el grafo en cada mutación. La clase base `Node` se define como virtual (`contains = "VIRTUAL"`) y almacena únicamente el slot `value`; `TreeNode` y `GraphNode` heredan formalmente de `Node`. El registro de vértices del grafo se modela manualmente mediante una lista simplemente enlazada interna a través del campo `next_vertex`, y la adyacencia de cada vértice se gestiona mediante inserción ordenada manual recursiva (`insert_neighbor`) garantizando orden ascendente y ausencia de duplicados sin delegar en ordenamientos ni tablas hash de biblioteca.

**EN:** This project implements the required structures using R's **Reference Classes** (`setRefClass` from standard package `methods`). Reference classes provide mutable reference semantics with internal pointers, enabling *in-place* link updates without rebuilding the tree or graph on every mutation. The base class `Node` is defined as virtual (`contains = "VIRTUAL"`) and holds only the `value` slot; `TreeNode` and `GraphNode` formally inherit from `Node`. The graph's vertex registry is modeled manually as an internal singly linked list via the `next_vertex` field, and vertex adjacency is managed through manual recursive sorted insertion (`insert_neighbor`) ensuring ascending order and no duplicates without delegating to library sorting or hash tables.

### Inicialización / Initialization

```bash
mkdir -p r/core/algorithms/data_structures_advanced/{R,tests/testthat}
```

No requiere empaquetado externo ni herramientas de compilación; `make test` carga el paquete en memoria con `pkgload::load_all()` y ejecuta la suite con `testthat::test_local()`.

---

## 📄 Configuración clave / Key Configuration

**ES:** El manifiesto `DESCRIPTION` define el paquete `dataStructuresAdvanced`, declarando dependencia obligatoria de `methods` (para clases formales S4 y de referencia) y `testthat` (edición 3) en `Suggests`. El archivo `NAMESPACE` importa `methods`, exporta las 4 clases (`Node`, `TreeNode`, `BinaryTree`, `Graph`) y cada función pública del contrato bajo la convención de nomenclatura `snake_case` con prefijo del ADT (`node_*`, `tree_node_*`, `binary_tree_*`, `graph_*`).

**EN:** The `DESCRIPTION` manifest defines package `dataStructuresAdvanced`, declaring mandatory dependencies on `methods` (for formal S4 and reference classes) and `testthat` (edition 3) in `Suggests`. The `NAMESPACE` file imports `methods`, exports all 4 classes (`Node`, `TreeNode`, `BinaryTree`, `Graph`), and exports every public contract function using `snake_case` naming prefixed by ADT name (`node_*`, `tree_node_*`, `binary_tree_*`, `graph_*`).

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Verificación sintáctica y análisis estático / Syntax and static analysis check
Rscript -e 'invisible(parse("R/data_structures_advanced.R")); cat("parse OK\n")'
Rscript -e 'pkgload::load_all(); codetools::checkUsageEnv(asNamespace("dataStructuresAdvanced"))'

# Ejecución de la suite completa / Run full test suite
make test
```

**Salida real / Actual output:**

```text
Rscript -e "testthat::test_local()"
✔ | F W  S  OK | Context

⠏ |          0 | data-structures-advanced                                       
⠧ |         28 | data-structures-advanced                                       
⠦ |         77 | data-structures-advanced                                       
⠹ |        133 | data-structures-advanced                                       
✔ |        156 | data-structures-advanced

══ Results ═════════════════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 156 ]
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `node_get_value(node)` | `Node → numeric` | $O(1)$ | Retorna el valor encapsulado en el nodo base. |
| `tree_node_init(value)` | `numeric → TreeNode` | $O(1)$ | Inicializa nodo de árbol con valor y enlaces `left = NULL`, `right = NULL`. |
| `tree_node_get_left(node)` | `TreeNode → TreeNode?` | $O(1)$ | Retorna el hijo izquierdo o `NULL` si está ausente. |
| `tree_node_get_right(node)` | `TreeNode → TreeNode?` | $O(1)$ | Retorna el hijo derecho o `NULL` si está ausente. |
| `tree_node_set_left(node, left)` | `(TreeNode, TreeNode?) → TreeNode` | $O(1)$ | Asigna enlace izquierdo *in-place* y retorna el nodo. |
| `tree_node_set_right(node, right)` | `(TreeNode, TreeNode?) → TreeNode` | $O(1)$ | Asigna enlace derecho *in-place* y retorna el nodo. |
| `binary_tree_init()` | `void → BinaryTree` | $O(1)$ | Crea un árbol vacío utilizable (`root = NULL`, `count = 0`). |
| `binary_tree_insert(tree, value)` | `(BinaryTree, numeric) → logical` | $O(h)$ | Inserta según la invariante del ABB; duplicados no alteran el tamaño. Retorna `TRUE`. |
| `binary_tree_contains(tree, value)` | `(BinaryTree, numeric) → logical` | $O(h)$ | Búsqueda iterativa siguiendo la invariante del ABB; retorna `TRUE` o `FALSE`. |
| `binary_tree_is_empty(tree)` | `BinaryTree → logical` | $O(1)$ | Retorna `TRUE` si `count == 0`. |
| `binary_tree_size(tree)` | `BinaryTree → numeric` | $O(1)$ | Retorna la cantidad de nodos únicos en el árbol. |
| `graph_node_init(label)` | `numeric → GraphNode` | $O(1)$ | Constructor interno: nodo con etiqueta, adyacencia vacía y `next_vertex = NULL`. |
| `graph_init()` | `void → Graph` | $O(1)$ | Crea un grafo dirigido vacío utilizable (`vertices = NULL`, contadores en 0). |
| `graph_add_vertex(graph, label)` | `(Graph, numeric) → logical` | $O(V)$ | Registra un vértice explícito en el registro enlazado; duplicados retornan `TRUE` sin alterar. |
| `graph_add_edge(graph, u, v)` | `(Graph, numeric, numeric) → logical` | $O(V + d(u))$ | Añade arista dirigida insertando `v` ordenado en la adyacencia de `u`. Falla si falta algún extremo. |
| `graph_has_edge(graph, u, v)` | `(Graph, numeric, numeric) → logical` | $O(V + d(u))$ | Verifica existencia de arista dirigida; retorna `FALSE` si falta o si algún extremo no existe. |
| `graph_get_neighbors(graph, u)` | `(Graph, numeric) → numeric[]?` | $O(V)$ | Retorna vector numérico ordenado con los vecinos de `u`, `numeric(0)` si está aislado, o `NULL` si no existe. |
| `graph_is_empty(graph)` | `Graph → logical` | $O(1)$ | Retorna `TRUE` si `vertex_total == 0`. |
| `graph_vertex_count(graph)` | `Graph → numeric` | $O(1)$ | Retorna el número total de vértices registrados. |
| `graph_edge_count(graph)` | `Graph → numeric` | $O(1)$ | Retorna el número total de aristas dirigidas registradas. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Clases de referencia estándar (`setRefClass`) | Clases S4 funcionales inmutables o entornos ad-hoc | Permite semántica de referencia mutable con punteros internos sin recurrir a paquetes externos (R6). Facilita la actualización *in-place* de enlaces de árbol y el encadenamiento del registro de vértices (`next_vertex`) de forma natural. |
| Clase base `Node` virtual (`contains = "VIRTUAL"`) | Composición con valor embebido | R soporta herencia directa en clases de referencia. Definir `Node` como virtual garantiza que almacene exclusivamente el valor y no pueda ser instanciada por sí sola, cumpliendo estrictamente con la especificación. |
| Registro de vértices como lista enlazada simple interna | Entornos (`environment`), tablas hash o vectores indexados | Cumple con la exigencia pedagógica del módulo de implementar manualmente el registro y su búsqueda en $O(V)$ mediante punteros propios sin delegar en índices o diccionarios. |
| Vector atómico numérico para vecinos con inserción ordenada manual | Lista enlazada de vecinos (`NeighborNode`) | En R, un vector numérico atómico (`numeric`) devuelto por `graph_get_neighbors` tiene semántica de copia (*copy-on-modify*), lo que garantiza de forma idiomática y nativa el aislamiento defensivo sin coste adicional ni conversiones complejas. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Base `Node` con valor | `setRefClass("Node", contains = "VIRTUAL", fields = c(value = "numeric"))` | En R las clases virtuales expresan formalmente un tipo no instanciable que define slots compartidos para tipos derivados. |
| Ausencia de enlace o subárbol | `NULL` | Representación idiomática y canónica de ausencia de objeto o puntero en R. |
| Falla en `graph_get_neighbors(u)` | `NULL` | Permite distinguir de forma no ambigua entre un vértice inexistente (`NULL`) y un vértice existente aislado sin vecinos (`numeric(0)`). |
| Falla en `contains`, `add_edge`, `has_edge` | `FALSE` | Booleano nativo (`logical`) no ambiguo en R. |
| Caso "Adaptación inmutable (si aplica)" de `TreeNode` | Omitido | La implementación adopta clases de referencia mutables (`setRefClass`), por lo que la variante puramente inmutable no aplica en este módulo. |
| `src/data_structures_advanced.ext` | `R/data_structures_advanced.R` | Convención estándar del sistema de empaquetado de R. |
| `test/run_tests.ext` | `Makefile` (`make test`) y `tests/testthat.R` | Punto de entrada del flujo de automatización y framework estándar en R. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `tree_node_get_left` / `tree_node_get_right` | Enlace ausente (hijo no asignado) | `NULL` | `tree_node_get_left(tree_node_init(10)) == NULL` |
| `binary_tree_contains` | Valor no presente en el árbol | `FALSE` | `binary_tree_contains(tree, 99) == FALSE` |
| `graph_add_edge` | Extremo `u` o `v` inexistente en el grafo | `FALSE` | `graph_add_edge(graph, 10, 99) == FALSE` |
| `graph_has_edge` | Arista ausente o extremos inexistentes | `FALSE` | `graph_has_edge(graph, 10, 30) == FALSE` |
| `graph_get_neighbors` | Vértice `u` inexistente en el grafo | `NULL` | `is.null(graph_get_neighbors(graph, 99)) == TRUE` |

---

## ✅ Cobertura de pruebas / Test coverage

**ES:** Mapeo de casos: `unidad/variante → casos aplicables → grupo lógico → archivo/suite → runner`:
- `TreeNode` → 5 casos aplicables (1 omitido por mutabilidad de Reference Classes) → `TreeNode 1..5` → `tests/testthat/test-data-structures-advanced.R` → `testthat::test_local()`.
- `BinaryTree` → 7 casos aplicables → `BinaryTree 1..7` → `tests/testthat/test-data-structures-advanced.R` → `testthat::test_local()`.
- `Graph` → 11 casos aplicables → `Graph 1..11` → `tests/testthat/test-data-structures-advanced.R` → `testthat::test_local()`.

### `TreeNode`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear un nodo de árbol / Create a tree node | Sí | `test-data-structures-advanced.R:13` | Comprueba `node_get_value(node) == 10`. |
| Enlaces iniciales ausentes / Absent initial links | Sí | `test-data-structures-advanced.R:18` | Verifica que `tree_node_get_left` y `tree_node_get_right` son `NULL`. |
| Enlazar dos hijos / Link two children | Sí | `test-data-structures-advanced.R:24` | Enlaza 20 y 30; verifica sus valores desde el nodo padre. |
| Recorrer cada enlace / Traverse each link | Sí | `test-data-structures-advanced.R:32` | Recorre enlaces izquierdo y derecho, comprobando hojas con enlaces `NULL`. |
| Desenlazar hijos / Unlink children | Sí | `test-data-structures-advanced.R:46` | Desenlaza izquierdo y derecho con `NULL`, comprobando preservación de valores y enlaces. |
| Adaptación inmutable (si aplica) / Immutable adaptation (if applicable) | Omitido | N/A | No aplica: `TreeNode` se implementa mediante Reference Classes mutables. |

### `BinaryTree`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear vacío / Create empty | Sí | `test-data-structures-advanced.R:75` | Verifica `is_empty == TRUE`, `size == 0`, `contains(50) == FALSE`. |
| Insertar la raíz / Insert the root | Sí | `test-data-structures-advanced.R:82` | Inserta 50; verifica tamaño 1, no vacío y pertenencia. |
| Insertar menor y mayor / Insert lower and higher | Sí | `test-data-structures-advanced.R:90` | Inserta 50, 30, 70; éxito en cada una, tamaño 3 y los 3 presentes. |
| Ramas de varios niveles / Multilevel branches | Sí | `test-data-structures-advanced.R:97` | Inserta 50, 30, 70, 20, 40; 5 éxitos, tamaño 5 y todos presentes. |
| Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí | `test-data-structures-advanced.R:104` | Consulta 99 en árbol con 50; retorna `FALSE`, tamaño 1 intacto. |
| Duplicado idempotente / Idempotent duplicate | Sí | `test-data-structures-advanced.R:112` | Inserta 50, 30, 70, 30; tamaño 3 y los 3 valores presentes. |
| Inserciones ordenadas / Ordered insertions | Sí | `test-data-structures-advanced.R:119` | Inserta 20, 30, 40, 50, 70; tamaño 5, todos presentes y 99 ausente. |

### `Graph`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear vacío / Create empty | Sí | `test-data-structures-advanced.R:139` | Verifica `is_empty == TRUE`, contadores en 0, `has_edge == FALSE` y `get_neighbors == NULL`. |
| Vértice aislado / Isolated vertex | Sí | `test-data-structures-advanced.R:147` | Registra 10; verifica no vacío, 1 vértice, 0 aristas y vecinos vacíos (`numeric(0)`). |
| Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí | `test-data-structures-advanced.R:155` | Registra 10, 70; arista (10,70); verifica arista directa `TRUE`, inversa `FALSE`, 2 vértices, 1 arista. |
| Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí | `test-data-structures-advanced.R:164` | Registra 10, 30; arista (10,30); re-registra 10; adyacencia intacta `[30]`. |
| Arista duplicada / Duplicate edge | Sí | `test-data-structures-advanced.R:173` | Registra 10, 30; arista (10,30) dos veces; mantiene 1 arista y adyacencia `[30]`. |
| Extremo inexistente sin mutación / Missing endpoint without mutation | Sí | `test-data-structures-advanced.R:182` | Intenta aristas con 98 y 99; fallan sin mutar contadores ni adyacencias existentes. |
| Vecinos ordenados y contadores / Sorted neighbours and counts | Sí | `test-data-structures-advanced.R:201` | Registra 10, 30, 50, 70; añade 4 aristas; verifica orden `[30, 50, 70]`, `[50]` y vacíos. |
| Consulta de arista ausente / Missing-edge query | Sí | `test-data-structures-advanced.R:214` | Registra 10, 30; `has_edge(10,30) == FALSE`, 2 vértices, 0 aristas. |
| Vecinos de vértice inexistente / Neighbours of missing vertex | Sí | `test-data-structures-advanced.R:222` | Verifica que `get_neighbors(99)` retorna `NULL`, distinguiéndose de `numeric(0)`. |
| Bucle y duplicado / Self-loop and duplicate | Sí | `test-data-structures-advanced.R:230` | Registra 10; arista (10,10) duplicada; verifica bucle presente `[10]`, 1 vértice, 1 arista. |
| Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí | `test-data-structures-advanced.R:239` | Modificar copia de vecinos no altera el grafo; consultas posteriores reflejan nuevas aristas. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Límite de profundidad de recursión en R sin TCO | Inserciones en árboles desbalanceados o inserción de vecinos en vértices con grado extremo podrían alcanzar el límite de pila (`expressions`). | En R el límite estándar de expresiones de pila (~5000) es amplio para casos típicos de algoritmos puros; si fuera necesario en fases posteriores se migrará a bucles iterativos explícitos. |

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Semántica de referencia y mutabilidad controlada / Reference semantics and controlled mutability

**ES:** A diferencia de las clases S4 puras utilizadas en `data_structures_basics`, donde cada mutación genera una copia del objeto por la semántica funcional *copy-on-modify* de R, este módulo utiliza **Reference Classes** (`setRefClass`). Las clases de referencia instancian entornos de R con identidad persistente, lo que permite enlazar nodos hijos en el árbol o encadenar vértices en el grafo directamente mediante punteros sin clonar la estructura contenedora en cada operación.

**EN:** Unlike the pure S4 classes used in `data_structures_basics`, where each mutation triggers a copy of the object due to R's functional copy-on-modify semantics, this module employs **Reference Classes** (`setRefClass`). Reference classes instantiate R environments with persistent identity, allowing child node links in the tree or vertex chaining in the graph to be updated directly via pointers without cloning the container structure on each operation.

### 🧱 Herencia formal de valor / Formal value inheritance

**ES:** La clase base `Node` encapsula exclusivamente el slot `value` y se declara con `contains = "VIRTUAL"`, prohibiendo su instanciación directa. Tanto `TreeNode` como `GraphNode` heredan de `Node`, cumpliendo estrictamente con el principio contractual de que la base contiene el valor y cada clase derivada gestiona y valida sus propios enlaces sin duplicar la lógica de almacenamiento del valor.

**EN:** The base class `Node` exclusively encapsulates the `value` slot and is declared with `contains = "VIRTUAL"`, prohibiting direct instantiation. Both `TreeNode` and `GraphNode` inherit from `Node`, strictly adhering to the contractual principle that the base holds the value and each derived class manages and validates its own links without duplicating value storage logic.

### 🛡️ Aislamiento defensivo en adyacencias / Defensive isolation in adjacencies

**ES:** En `graph_get_neighbors(graph, u)`, R devuelve el vector numérico `neighbors`. Debido a que los vectores atómicos en R se rigen por *copy-on-modify*, cualquier modificación realizada por el consumidor sobre el vector retornado (por ejemplo, `copy[1] <- 999`) opera sobre una copia local en memoria sin afectar el estado interno del grafo.

**EN:** In `graph_get_neighbors(graph, u)`, R returns the numeric vector `neighbors`. Because atomic vectors in R are governed by copy-on-modify, any modification performed by the consumer on the returned vector (e.g., `copy[1] <- 999`) operates on a local memory copy without affecting the graph's internal state.

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
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/README.md`](../data_structures_basics/README.md) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/README.md`](../../foundations/numbers/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Reference Classes in R Documentation](https://stat.ethz.ch/R-manual/R-patched/library/methods/html/refClass.html) |

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
