library(snow)

cl <- makeCluster(4, type="SOCK")

ignore  <- clusterEvalQ(cl, {library(MASS); NULL})
results <- clusterApply(cl, rep(25, 4), function(nstart) kmeans(Boston, 4, nstart=nstart))
i       <- sapply(results, function(result) result$tot.withinss)
result  <- results[[which.min(i)]]
print(result)

stopCluster(cl)

