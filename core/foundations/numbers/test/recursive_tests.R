library(testthat)

source("../src/numbers.R")

test_that("sum_of_first_n_rec", {
  expect_equal(sum_of_first_n_rec(0), 0)
  expect_equal(sum_of_first_n_rec(3), 6)
})

test_that("factorial_rec", {
  expect_equal(factorial_rec(0), 1)
  expect_equal(factorial_rec(4), 24)
})

test_that("fibonacci_rec", {
  expect_equal(fibonacci_rec(0), 0)
  expect_equal(fibonacci_rec(1), 1)
  expect_equal(fibonacci_rec(6), 8)
})

test_that("greatest_common_divisor_rec", {
  expect_equal(greatest_common_divisor_rec(12, 8), 4)
  expect_equal(greatest_common_divisor_rec(7, 5), 1)
})

test_that("least_common_multiple_rec", {
  expect_equal(least_common_multiple_rec(4, 6), 12)
  expect_equal(least_common_multiple_rec(6, 8), 24)
})
