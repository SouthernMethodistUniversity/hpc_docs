library(MASS)
results <- lapply(rep(25, 4), function(nstart) kmeans(Boston, 4, nstart=nstart))
i       <- sapply(results, function(result) result$tot.withinss)
result  <- results[[which.min(i)]]
print(result)

