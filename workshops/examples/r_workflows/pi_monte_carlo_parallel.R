library(parallel)

monte_carlo_pi <- function(n) {
  z = sqrt(runif(1)^2+runif(1)^2)
  return(if(z<=1) 1 else 0)
}

args = commandArgs(trailing=TRUE)
n = strtoi(args[1])
c = strtoi(args[2])
cl = makeCluster(getOption("cl.cores", c))
result = clusterApply(cl, 1:n, fun=monte_carlo_pi)
sum(unlist(result))*4/n
stopCluster(cl)

