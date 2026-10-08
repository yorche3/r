addition <- function(a, b) {
  return(a + b)
}

subtraction <- function(a, b) {
  return(a - b)
}

multiplication <- function(a, b) {
  result <- 0
  for (i in 1:b) {
    result <- addition(result, a)
  }
  return(result)
}

division <- function(a, b) {
  quotient <- 0
  while (a >= b) {
    a <- subtraction(a, b)
    quotient <- addition(quotient, 1)
  }
  return(quotient)
}

modulus <- function(a, b) {
  q <- division(a, b)
  p <- multiplication(q, b)
  return(subtraction(a, p))
}
