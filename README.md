# kmeansClustering

Problem Statement: From a built in dataset - IRIS, in R, predict the number of clusters and predict it visually.

Since this is an unsupervised learning and we had to use clustering, I have gone with K-means 

There are various methods while using K means to find out the optimum  number of clusters. Such as:
1. Elbow point
2. Silhouette Method
3. Gap Statistics
 
 I have gone with the elbow point because it was easier\\
 
 The answer to the PS is 3
 
 Predicted the clusters visually using cluster package.
 Code:
 clusplot(iris1, kmean2$cluster, lines = 0, shade = TRUE, color = TRUE, labels = 4, xlab = 'Sepal.Length', ylab = 'Sepal.Width')
 

 At the end this is the resultant confusion matrix:
 #             1  2  3
setosa         0  0 50
versicolor    48  2  0
virginica     14 36  0
 
