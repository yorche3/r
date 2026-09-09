library(testthat)

source("../src/numbers.R")

test_that("sum_of_first_n_ite", {
  expect_equal(sum_of_first_n_ite(0), 0)
  expect_equal(sum_of_first_n_ite(3), 6)
})

test_that("factorial_ite", {
  expect_equal(factorial_ite(0), 1)
  expect_equal(factorial_ite(4), 24)
})

test_that("fibonacci_ite", {
  expect_equal(fibonacci_ite(0), 0)
  expect_equal(fibonacci_ite(1), 1)
  expect_equal(fibonacci_ite(6), 8)
})

test_that("greatest_common_divisor_ite", {
  expect_equal(greatest_common_divisor_ite(12, 8), 4)
  expect_equal(greatest_common_divisor_ite(7, 5), 1)
})

test_that("least_common_multiple_ite", {
  expect_equal(least_common_multiple_ite(4, 6), 12)
  expect_equal(least_common_multiple_ite(6, 8), 24)
})
