library(snow)

cl <- makeCluster(4, type="SOCK")

bigsleep  <- function(sleeptime, mat) Sys.sleep(sleeptime)
bigmatrix <- matrix(0, 2000, 2000)
sleeptime <- rep(1, 100)

# Time with clusterApply
tm <- snow.time(clusterApply(cl, sleeptime, bigsleep, bigmatrix))
print(tm)

# Time with parLapply
tm <- snow.time(parLapply(cl, sleeptime, bigsleep, bigmatrix))
print(tm)

stopCluster(cl)

