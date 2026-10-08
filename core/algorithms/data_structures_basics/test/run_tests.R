library(testthat)

# Run all test files in the project
test_files <- list.files("test", pattern = "_tests\\.R$", full.names = TRUE)
if (length(test_files) > 0) {
  for (f in test_files) {
    test_file(f)
  }
} else {
  message("No test files found")
}
