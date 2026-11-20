# Casos de 07_Data_Structures_Advanced: 5 TreeNode, 7 BinaryTree, 11 Graph
# (el caso "Adaptación inmutable (si aplica)" de TreeNode no aplica: RefClass mutable).
#
# Adecuaciones: las Reference classes mutan en el sitio, así que cada caso crea
# su instancia. Ausencia de enlace = NULL; fallo de contains/has_edge/add_edge =
# FALSE; fallo de get_neighbors = NULL, distinto de numeric(0) (vecinos vacíos).

absent_value <- 99

# --- TreeNode ---------------------------------------------------------------

test_that("TreeNode 1: create a tree node", {
  node <- tree_node_init(10)
  expect_contract(node_get_value(node), 10, "TreeNode 1", "get_value should return 10")
})

test_that("TreeNode 2: absent initial links", {
  node <- tree_node_init(10)
  expect_contract(tree_node_get_left(node), NULL, "TreeNode 2", "get_left should be absent")
  expect_contract(tree_node_get_right(node), NULL, "TreeNode 2", "get_right should be absent")
})

test_that("TreeNode 3: link two children", {
  parent <- tree_node_init(10)
  tree_node_set_left(parent, tree_node_init(20))
  tree_node_set_right(parent, tree_node_init(30))
  expect_contract(node_get_value(tree_node_get_left(parent)), 20, "TreeNode 3", "the left child value should be 20")
  expect_contract(node_get_value(tree_node_get_right(parent)), 30, "TreeNode 3", "the right child value should be 30")
})

test_that("TreeNode 4: traverse each link", {
  parent <- tree_node_init(10)
  tree_node_set_left(parent, tree_node_init(20))
  tree_node_set_right(parent, tree_node_init(30))
  left <- tree_node_get_left(parent)
  right <- tree_node_get_right(parent)
  expect_contract(node_get_value(left), 20, "TreeNode 4", "following get_left should lead to 20")
  expect_contract(node_get_value(right), 30, "TreeNode 4", "following get_right should lead to 30")
  expect_contract(tree_node_get_left(left), NULL, "TreeNode 4", "the left child's left link should be absent")
  expect_contract(tree_node_get_right(left), NULL, "TreeNode 4", "the left child's right link should be absent")
  expect_contract(tree_node_get_left(right), NULL, "TreeNode 4", "the right child's left link should be absent")
  expect_contract(tree_node_get_right(right), NULL, "TreeNode 4", "the right child's right link should be absent")
})

test_that("TreeNode 5: unlink children", {
  parent <- tree_node_init(10)
  tree_node_set_left(parent, tree_node_init(20))
  tree_node_set_right(parent, tree_node_init(30))

  tree_node_set_left(parent, NULL)
  expect_contract(tree_node_get_left(parent), NULL, "TreeNode 5", "the left link should be absent after clearing it")
  expect_contract(node_get_value(parent), 10, "TreeNode 5", "the value should stay 10 after clearing left")
  expect_contract(node_get_value(tree_node_get_right(parent)), 30, "TreeNode 5", "the right child 30 should be preserved after clearing left")

  tree_node_set_right(parent, NULL)
  expect_contract(tree_node_get_left(parent), NULL, "TreeNode 5", "the left link should remain absent after clearing right")
  expect_contract(tree_node_get_right(parent), NULL, "TreeNode 5", "the right link should be absent after clearing it")
  expect_contract(node_get_value(parent), 10, "TreeNode 5", "the value should stay 10 after clearing right")
})

# --- BinaryTree -------------------------------------------------------------

insert_all <- function(tree, values, scenario) {
  for (value in values) {
    expect_contract(binary_tree_insert(tree, value), TRUE, scenario, paste0("insert(", value, ") should succeed"))
  }
}

expect_members <- function(tree, values, scenario) {
  for (value in values) {
    expect_contract(binary_tree_contains(tree, value), TRUE, scenario, paste0("contains(", value, ") should succeed"))
  }
}

test_that("BinaryTree 1: create empty", {
  tree <- binary_tree_init()
  expect_contract(binary_tree_is_empty(tree), TRUE, "BinaryTree 1", "is_empty should be true after init")
  expect_contract(binary_tree_size(tree), 0, "BinaryTree 1", "size should be 0 after init")
  expect_contract(binary_tree_contains(tree, 50), FALSE, "BinaryTree 1", "contains(50) on an empty tree should fail")
})

test_that("BinaryTree 2: insert the root", {
  tree <- binary_tree_init()
  insert_all(tree, 50, "BinaryTree 2")
  expect_contract(binary_tree_size(tree), 1, "BinaryTree 2", "size should be 1")
  expect_contract(binary_tree_is_empty(tree), FALSE, "BinaryTree 2", "is_empty should be false")
  expect_members(tree, 50, "BinaryTree 2")
})

test_that("BinaryTree 3: insert lower and higher", {
  tree <- binary_tree_init()
  insert_all(tree, c(50, 30, 70), "BinaryTree 3")
  expect_contract(binary_tree_size(tree), 3, "BinaryTree 3", "size should be 3")
  expect_members(tree, c(50, 30, 70), "BinaryTree 3")
})

test_that("BinaryTree 4: multilevel branches", {
  tree <- binary_tree_init()
  insert_all(tree, c(50, 30, 70, 20, 40), "BinaryTree 4")
  expect_members(tree, c(50, 30, 70, 20, 40), "BinaryTree 4")
  expect_contract(binary_tree_size(tree), 5, "BinaryTree 4", "size should be 5")
})

test_that("BinaryTree 5: missing value in a nonempty tree", {
  tree <- binary_tree_init()
  insert_all(tree, 50, "BinaryTree 5")
  expect_contract(binary_tree_contains(tree, absent_value), FALSE, "BinaryTree 5", "contains(99) should fail")
  expect_contract(binary_tree_size(tree), 1, "BinaryTree 5", "size should stay 1")
  expect_members(tree, 50, "BinaryTree 5")
})

test_that("BinaryTree 6: idempotent duplicate", {
  tree <- binary_tree_init()
  insert_all(tree, c(50, 30, 70, 30), "BinaryTree 6")
  expect_contract(binary_tree_size(tree), 3, "BinaryTree 6", "size should be 3 after the duplicate")
  expect_members(tree, c(50, 30, 70), "BinaryTree 6")
})

test_that("BinaryTree 7: ordered insertions", {
  tree <- binary_tree_init()
  insert_all(tree, c(20, 30, 40, 50, 70), "BinaryTree 7")
  expect_contract(binary_tree_size(tree), 5, "BinaryTree 7", "size should be 5")
  expect_members(tree, c(20, 30, 40, 50, 70), "BinaryTree 7")
  expect_contract(binary_tree_contains(tree, absent_value), FALSE, "BinaryTree 7", "contains(99) should fail")
})

# --- Graph ------------------------------------------------------------------

add_vertices <- function(graph, labels, scenario) {
  for (label in labels) {
    expect_contract(graph_add_vertex(graph, label), TRUE, scenario, paste0("add_vertex(", label, ") should succeed"))
  }
}

expect_counts <- function(graph, vertices, edges, scenario) {
  expect_contract(graph_vertex_count(graph), vertices, scenario, paste0("vertex_count should be ", vertices))
  expect_contract(graph_edge_count(graph), edges, scenario, paste0("edge_count should be ", edges))
}

test_that("Graph 1: create empty", {
  graph <- graph_init()
  expect_contract(graph_is_empty(graph), TRUE, "Graph 1", "is_empty should be true after init")
  expect_counts(graph, 0, 0, "Graph 1")
  expect_contract(graph_has_edge(graph, 10, 30), FALSE, "Graph 1", "has_edge(10, 30) should fail")
  expect_contract(graph_get_neighbors(graph, 10), NULL, "Graph 1", "get_neighbors(10) should fail")
})

test_that("Graph 2: isolated vertex", {
  graph <- graph_init()
  add_vertices(graph, 10, "Graph 2")
  expect_contract(graph_is_empty(graph), FALSE, "Graph 2", "is_empty should be false")
  expect_counts(graph, 1, 0, "Graph 2")
  expect_contract(graph_get_neighbors(graph, 10), numeric(0), "Graph 2", "the neighbours of 10 should be empty")
})

test_that("Graph 3: nonconsecutive labels and directed edge", {
  graph <- graph_init()
  add_vertices(graph, c(10, 70), "Graph 3")
  expect_contract(graph_add_edge(graph, 10, 70), TRUE, "Graph 3", "add_edge(10, 70) should succeed")
  expect_contract(graph_has_edge(graph, 10, 70), TRUE, "Graph 3", "the forward edge should be present")
  expect_contract(graph_has_edge(graph, 70, 10), FALSE, "Graph 3", "the reverse edge should be absent")
  expect_counts(graph, 2, 1, "Graph 3")
})

test_that("Graph 4: duplicate vertex preserves adjacency", {
  graph <- graph_init()
  add_vertices(graph, c(10, 30), "Graph 4")
  expect_contract(graph_add_edge(graph, 10, 30), TRUE, "Graph 4", "add_edge(10, 30) should succeed")
  expect_contract(graph_add_vertex(graph, 10), TRUE, "Graph 4", "the duplicate add_vertex(10) should succeed")
  expect_counts(graph, 2, 1, "Graph 4")
  expect_contract(graph_get_neighbors(graph, 10), 30, "Graph 4", "the neighbours of 10 should be [30]")
})

test_that("Graph 5: duplicate edge", {
  graph <- graph_init()
  add_vertices(graph, c(10, 30), "Graph 5")
  expect_contract(graph_add_edge(graph, 10, 30), TRUE, "Graph 5", "the first add_edge(10, 30) should succeed")
  expect_contract(graph_add_edge(graph, 10, 30), TRUE, "Graph 5", "the second add_edge(10, 30) should succeed")
  expect_counts(graph, 2, 1, "Graph 5")
  expect_contract(graph_get_neighbors(graph, 10), 30, "Graph 5", "the neighbours of 10 should be [30]")
})

test_that("Graph 6: missing endpoint without mutation", {
  graph <- graph_init()
  add_vertices(graph, c(10, 30), "Graph 6")
  expect_contract(graph_add_edge(graph, 10, 30), TRUE, "Graph 6", "add_edge(10, 30) should succeed")
  expect_contract(graph_add_edge(graph, 10, 99), FALSE, "Graph 6", "add_edge(10, 99) should fail")
  expect_contract(graph_add_edge(graph, 99, 10), FALSE, "Graph 6", "add_edge(99, 10) should fail")
  expect_contract(graph_add_edge(graph, 98, 99), FALSE, "Graph 6", "add_edge(98, 99) should fail")
  expect_contract(graph_add_edge(graph, 99, 99), FALSE, "Graph 6", "add_edge(99, 99) should fail")
  expect_counts(graph, 2, 1, "Graph 6")
  expect_contract(graph_get_neighbors(graph, 10), 30, "Graph 6", "the neighbours of 10 should stay [30]")
  expect_contract(graph_get_neighbors(graph, 30), numeric(0), "Graph 6", "the neighbours of 30 should be empty")
  expect_contract(graph_has_edge(graph, 10, 99), FALSE, "Graph 6", "has_edge(10, 99) should fail")
  expect_contract(graph_has_edge(graph, 99, 10), FALSE, "Graph 6", "has_edge(99, 10) should fail")
  expect_contract(graph_has_edge(graph, 98, 99), FALSE, "Graph 6", "has_edge(98, 99) should fail")
  expect_contract(graph_has_edge(graph, 99, 99), FALSE, "Graph 6", "has_edge(99, 99) should fail")
  expect_contract(graph_get_neighbors(graph, 98), NULL, "Graph 6", "get_neighbors(98) should fail")
  expect_contract(graph_get_neighbors(graph, 99), NULL, "Graph 6", "get_neighbors(99) should fail")
})

test_that("Graph 7: sorted neighbours and counts", {
  graph <- graph_init()
  add_vertices(graph, c(10, 30, 50, 70), "Graph 7")
  expect_contract(graph_add_edge(graph, 10, 70), TRUE, "Graph 7", "add_edge(10, 70) should succeed")
  expect_contract(graph_add_edge(graph, 10, 30), TRUE, "Graph 7", "add_edge(10, 30) should succeed")
  expect_contract(graph_add_edge(graph, 10, 50), TRUE, "Graph 7", "add_edge(10, 50) should succeed")
  expect_contract(graph_add_edge(graph, 30, 50), TRUE, "Graph 7", "add_edge(30, 50) should succeed")
  expect_contract(graph_get_neighbors(graph, 10), c(30, 50, 70), "Graph 7", "the neighbours of 10 should be [30, 50, 70]")
  expect_contract(graph_get_neighbors(graph, 30), 50, "Graph 7", "the neighbours of 30 should be [50]")
  expect_contract(graph_get_neighbors(graph, 50), numeric(0), "Graph 7", "the neighbours of 50 should be empty")
  expect_contract(graph_get_neighbors(graph, 70), numeric(0), "Graph 7", "the neighbours of 70 should be empty")
  expect_counts(graph, 4, 4, "Graph 7")
})

test_that("Graph 8: missing-edge query", {
  graph <- graph_init()
  add_vertices(graph, c(10, 30), "Graph 8")
  expect_contract(graph_has_edge(graph, 10, 30), FALSE, "Graph 8", "has_edge(10, 30) should fail")
  expect_counts(graph, 2, 0, "Graph 8")
  expect_contract(graph_is_empty(graph), FALSE, "Graph 8", "is_empty should be false")
})

test_that("Graph 9: neighbours of a missing vertex", {
  graph <- graph_init()
  add_vertices(graph, 10, "Graph 9")
  expect_contract(graph_get_neighbors(graph, absent_value), NULL, "Graph 9", "get_neighbors(99) should fail")
  expect_contract(is.null(graph_get_neighbors(graph, 10)), FALSE, "Graph 9", "the empty neighbours of 10 should differ from failure")
  expect_counts(graph, 1, 0, "Graph 9")
})

test_that("Graph 10: self-loop and duplicate", {
  graph <- graph_init()
  add_vertices(graph, 10, "Graph 10")
  expect_contract(graph_add_edge(graph, 10, 10), TRUE, "Graph 10", "the first add_edge(10, 10) should succeed")
  expect_contract(graph_add_edge(graph, 10, 10), TRUE, "Graph 10", "the second add_edge(10, 10) should succeed")
  expect_contract(graph_has_edge(graph, 10, 10), TRUE, "Graph 10", "the loop should be present")
  expect_contract(graph_get_neighbors(graph, 10), 10, "Graph 10", "the neighbours of 10 should be [10]")
  expect_counts(graph, 1, 1, "Graph 10")
})

test_that("Graph 11: neighbour-result isolation", {
  graph <- graph_init()
  add_vertices(graph, c(10, 30, 50), "Graph 11")
  expect_contract(graph_add_edge(graph, 10, 30), TRUE, "Graph 11", "add_edge(10, 30) should succeed")
  saved <- graph_get_neighbors(graph, 10)
  copy <- graph_get_neighbors(graph, 10)
  copy[1] <- 999
  expect_contract(graph_get_neighbors(graph, 10), 30, "Graph 11", "changing the returned copy should not change the graph")
  expect_contract(graph_add_edge(graph, 10, 50), TRUE, "Graph 11", "add_edge(10, 50) should succeed")
  expect_contract(saved, 30, "Graph 11", "the saved result should remain [30]")
  expect_contract(graph_get_neighbors(graph, 10), c(30, 50), "Graph 11", "a fresh query should return [30, 50]")
  expect_counts(graph, 3, 2, "Graph 11")
})
