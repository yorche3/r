library(testthat)

source("../src/calculator.R")

test_that("addition", {
  expect_equal(addition(2, 3), 5)
})

test_that("subtraction", {
  expect_equal(subtraction(5, 2), 3)
})

test_that("multiplication", {
  expect_equal(multiplication(3, 4), 12)
})

test_that("division", {
  expect_equal(division(10, 3), 3)
})

test_that("modulus", {
  expect_equal(modulus(10, 3), 1)
})
