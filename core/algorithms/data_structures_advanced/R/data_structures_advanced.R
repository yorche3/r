# Reference classes retain identity across operations; Node is a virtual base.
setRefClass("Node", contains = "VIRTUAL", fields = c(value = "numeric"))
setRefClass(
  "TreeNode", contains = "Node", fields = c(left = "ANY", right = "ANY")
)
setRefClass("BinaryTree", fields = c(root = "ANY", count = "numeric"))
setRefClass(
  "GraphNode", contains = "Node",
  fields = c(neighbors = "ANY", next_vertex = "ANY")
)
setRefClass(
  "Graph",
  fields = c(vertices = "ANY", vertex_total = "numeric", edges = "numeric")
)

# Node value accessor: Node -> numeric. The virtual base has no initializer.
node_get_value <- function(node) {
  node$value
}

# TreeNode: init(numeric) -> TreeNode; getters -> TreeNode or NULL;
# setters accept TreeNode or NULL, mutate the node and return it.
tree_node_init <- function(value) {
  new("TreeNode", value = value, left = NULL, right = NULL)
}

# The value getter above also accepts a TreeNode.
tree_node_get_left <- function(node) {
  node$left
}

tree_node_get_right <- function(node) {
  node$right
}

tree_node_set_left <- function(node, left) {
  node$left <- left
  node
}

tree_node_set_right <- function(node, right) {
  node$right <- right
  node
}

# BinaryTree: init() -> BinaryTree; insert mutates and returns TRUE;
# contains -> TRUE or FALSE;
# is_empty -> logical; size -> numeric.
binary_tree_init <- function() {
  new("BinaryTree", root = NULL, count = 0)
}

tree_insert_node <- function(node, value) {
  if (is.null(node)) {
    return(list(node = tree_node_init(value), inserted = TRUE))
  }
  if (value == node$value) {
    return(list(node = node, inserted = FALSE))
  }
  if (value < node$value) {
    result <- tree_insert_node(node$left, value)
    node$left <- result$node
  } else {
    result <- tree_insert_node(node$right, value)
    node$right <- result$node
  }
  list(node = node, inserted = result$inserted)
}

binary_tree_insert <- function(tree, value) {
  result <- tree_insert_node(tree$root, value)
  tree$root <- result$node
  if (isTRUE(result$inserted)) {
    tree$count <- tree$count + 1
  }
  TRUE
}

binary_tree_contains <- function(tree, value) {
  node <- tree$root
  while (!is.null(node)) {
    if (value == node$value) {
      return(TRUE)
    }
    node <- if (value < node$value) node$left else node$right
  }
  FALSE
}

binary_tree_is_empty <- function(tree) {
  tree$count == 0
}

binary_tree_size <- function(tree) {
  tree$count
}

# Internal GraphNode constructor: numeric label -> GraphNode.
graph_node_init <- function(label) {
  new("GraphNode", value = label, neighbors = numeric(0), next_vertex = NULL)
}

# Graph: init() -> Graph; add_vertex mutates and returns TRUE;
# add_edge mutates on success; add_edge/has_edge -> TRUE or FALSE;
# get_neighbors -> independent numeric vector, or NULL if the vertex is absent;
# is_empty -> logical; vertex_count/edge_count -> numeric.
graph_init <- function() {
  new("Graph", vertices = NULL, vertex_total = 0, edges = 0)
}

find_vertex <- function(graph, label) {
  current <- graph$vertices
  while (!is.null(current)) {
    if (current$value == label) {
      return(current)
    }
    current <- current$next_vertex
  }
  NULL
}

# Sorted insertion without duplicates: no library sort or search.
insert_neighbor <- function(neighbors, label) {
  if (length(neighbors) == 0) {
    return(label)
  }
  if (label <= neighbors[[1]]) {
    return(c(label, neighbors))
  }
  c(neighbors[[1]], insert_neighbor(neighbors[-1], label))
}

has_neighbor <- function(neighbors, label) {
  for (neighbor in neighbors) {
    if (neighbor == label) {
      return(TRUE)
    }
  }
  FALSE
}

graph_add_vertex <- function(graph, label) {
  if (!is.null(find_vertex(graph, label))) {
    return(TRUE)
  }
  new_vertex <- graph_node_init(label)
  new_vertex$next_vertex <- graph$vertices
  graph$vertices <- new_vertex
  graph$vertex_total <- graph$vertex_total + 1
  TRUE
}

graph_add_edge <- function(graph, u, v) {
  u_vertex <- find_vertex(graph, u)
  if (is.null(u_vertex) || is.null(find_vertex(graph, v))) {
    return(FALSE)
  }
  if (has_neighbor(u_vertex$neighbors, v)) {
    return(TRUE)
  }
  u_vertex$neighbors <- insert_neighbor(u_vertex$neighbors, v)
  graph$edges <- graph$edges + 1
  TRUE
}

graph_has_edge <- function(graph, u, v) {
  u_vertex <- find_vertex(graph, u)
  if (is.null(u_vertex)) {
    return(FALSE)
  }
  has_neighbor(u_vertex$neighbors, v)
}

graph_get_neighbors <- function(graph, u) {
  u_vertex <- find_vertex(graph, u)
  if (is.null(u_vertex)) {
    return(NULL)
  }
  u_vertex$neighbors
}

graph_is_empty <- function(graph) {
  graph$vertex_total == 0
}

graph_vertex_count <- function(graph) {
  graph$vertex_total
}

graph_edge_count <- function(graph) {
  graph$edges
}
