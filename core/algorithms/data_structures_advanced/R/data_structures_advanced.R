# Reference classes retain identity across operations; Node is a virtual base.
setRefClass("Node", contains = "VIRTUAL", fields = c(value = "numeric"))
setRefClass("TreeNode", contains = "Node", fields = c(left = "ANY", right = "ANY"))
setRefClass("BinaryTree", fields = c(root = "ANY", count = "numeric"))
setRefClass(
  "GraphNode", contains = "Node",
  fields = c(neighbors = "ANY", next_vertex = "ANY")
)
setRefClass(
  "Graph",
  fields = c(vertices = "ANY", vertex_total = "numeric", edges = "numeric")
)

# Node value accessor: Node -> numeric. The virtual base has no public initializer.
node_get_value <- function(node) {
  NULL
}

# TreeNode: init(numeric) -> TreeNode; getters -> TreeNode or NULL;
# setters accept TreeNode or NULL, mutate the node and return it.
tree_node_init <- function(value) {
  NULL
}

# The value getter above also accepts a TreeNode.
tree_node_get_left <- function(node) {
  NULL
}

tree_node_get_right <- function(node) {
  NULL
}

tree_node_set_left <- function(node, left) {
  NULL
}

tree_node_set_right <- function(node, right) {
  NULL
}

# BinaryTree: init() -> BinaryTree; insert mutates and returns TRUE;
# contains -> TRUE or FALSE;
# is_empty -> logical; size -> numeric.
binary_tree_init <- function() {
  NULL
}

binary_tree_insert <- function(tree, value) {
  NULL
}

binary_tree_contains <- function(tree, value) {
  NULL
}

binary_tree_is_empty <- function(tree) {
  NULL
}

binary_tree_size <- function(tree) {
  NULL
}

# Internal GraphNode constructor: numeric label -> GraphNode.
graph_node_init <- function(label) {
  NULL
}

# Graph: init() -> Graph; add_vertex mutates and returns TRUE;
# add_edge mutates on success; add_edge/has_edge -> TRUE or FALSE;
# get_neighbors -> independent numeric vector, or NULL if the vertex is absent;
# is_empty -> logical; vertex_count/edge_count -> numeric.
graph_init <- function() {
  NULL
}

graph_add_vertex <- function(graph, label) {
  NULL
}

graph_add_edge <- function(graph, u, v) {
  NULL
}

graph_has_edge <- function(graph, u, v) {
  NULL
}

graph_get_neighbors <- function(graph, u) {
  NULL
}

graph_is_empty <- function(graph) {
  NULL
}

graph_vertex_count <- function(graph) {
  NULL
}

graph_edge_count <- function(graph) {
  NULL
}
