library(snow)

cl <- makeCluster(4, type="SOCK")

set.seed(7777442)

sleeptime <- abs(rnorm(10, 10, 10))
tm        <- snow.time(clusterApply(cl, sleeptime, Sys.sleep))
print(tm)

stopCluster(cl)

