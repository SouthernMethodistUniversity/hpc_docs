library(MASS)
result <- kmeans(Boston, 4, nstart=100)
print(result)

