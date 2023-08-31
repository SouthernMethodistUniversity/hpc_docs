monte_carlo_pi <- function(n) {
  x=runif(n)
  y=runif(n)
  z=sqrt(x^2+y^2)
  length(which(z<=1))*4/n
}

args = commandArgs(trailing=TRUE)
monte_carlo_pi(strtoi(args[1]))

