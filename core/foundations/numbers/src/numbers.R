# Direct recursion (_rec)

sum_of_first_n_rec <- function(n) {
  if (n == 0) {
    return(0)
  }
  return(n + sum_of_first_n_rec(n - 1))
}

factorial_rec <- function(n) {
  if (n == 0) {
    return(1)
  }
  return(n * factorial_rec(n - 1))
}

fibonacci_rec <- function(n) {
  if (n <= 1) {
    return(n)
  }
  return(fibonacci_rec(n - 1) + fibonacci_rec(n - 2))
}

greatest_common_divisor_rec <- function(a, b) {
  if (b == 0) {
    return(a)
  }
  return(greatest_common_divisor_rec(b, a %% b))
}

least_common_multiple_rec <- function(a, b) {
  return((a / greatest_common_divisor_rec(a, b)) * b)
}

# Accumulator recursion (_acc): educational bridge, no TCO in R

sum_of_first_n_acc <- function(n) {
  return(sum_of_first_n_acc_help(n, 0))
}

sum_of_first_n_acc_help <- function(n, acc) {
  if (n <= 0) {
    return(acc)
  }
  return(sum_of_first_n_acc_help(n - 1, n + acc))
}

factorial_acc <- function(n) {
  return(factorial_acc_help(n, 1))
}

factorial_acc_help <- function(n, acc) {
  if (n <= 1) {
    return(acc)
  }
  return(factorial_acc_help(n - 1, n * acc))
}

fibonacci_acc <- function(n) {
  return(fibonacci_acc_help(n, 0, 1))
}

fibonacci_acc_help <- function(n, acc2, acc1) {
  if (n <= 0) {
    return(acc2)
  }
  if (n <= 2) {
    return(acc1 + acc2)
  }
  return(fibonacci_acc_help(n - 1, acc1, acc1 + acc2))
}

greatest_common_divisor_acc <- function(a, b) {
  return(greatest_common_divisor_acc_help(a, b))
}

greatest_common_divisor_acc_help <- function(a, b) {
  if (b == 0) {
    return(a)
  }
  return(greatest_common_divisor_acc_help(b, a %% b))
}

least_common_multiple_acc <- function(a, b) {
  return((a / greatest_common_divisor_acc(a, b)) * b)
}

# Iterative (_ite)

sum_of_first_n_ite <- function(n) {
  result <- 0
  for (i in seq_len(n)) {
    result <- result + i
  }
  return(result)
}

factorial_ite <- function(n) {
  result <- 1
  for (i in seq_len(n)) {
    result <- result * i
  }
  return(result)
}

fibonacci_ite <- function(n) {
  if (n <= 1) {
    return(n)
  }
  acc2 <- 0
  acc1 <- 1
  for (i in 2:n) {
    temp <- acc1 + acc2
    acc2 <- acc1
    acc1 <- temp
  }
  return(acc1)
}

greatest_common_divisor_ite <- function(a, b) {
  temp <- 0
  while (b != 0) {
    temp <- b
    b <- a %% b
    a <- temp
  }
  return(a)
}

least_common_multiple_ite <- function(a, b) {
  return((a / greatest_common_divisor_ite(a, b)) * b)
}
