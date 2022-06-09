#Prediction using Unsupervised Learning
#data : inbuilt data IRIS 
#problem statement : From Iris dataset, predict optimum number of clusters and represent it visually

#View(iris) #Iris is a built-in dataset that comes in R 
summary(iris)

#remove the target variable - Species from our data
iris1 = iris[-5]

#rows and culumns
dim(iris) #150 rows, 5 columns

#data types in iris 
str(iris) #continuous 

#is the data empty 
apply(iris, 2, function(x) sum(is.na(x)))


#checking for outliers
library(ggplot2)

ggplot(data = iris, aes(x=Species, y=Petal.Length)) +geom_boxplot()
ggplot(data = iris, aes(x=Species, y=Petal.Width)) +geom_boxplot()

ggplot(data = iris, aes(x=Species, y=Sepal.Length)) +geom_boxplot()
ggplot(data = iris, aes(x=Species, y=Sepal.Width)) +geom_boxplot()

ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) + geom_point()

#Multicollinearity?
#are sepal and petal length correlated?
cor(iris1$Sepal.Length, iris1$Petal.Length) 
#what about the widths
cor(iris1$Sepal.Width, iris1$Petal.Width) #-ve correlation, that too not strong

############///Kmeans///############################

#to find optimum number of clusters
WCSS = vector()
for(i in 1:10){
  WCSS[i] = sum(kmeans(iris1 ,i)$withinss)
}

#elbow plot
plot(1:10, WCSS, type = 'b', xlab = 'no. of clusters', ylab = 'WCSS')
#take cluster val = 3 based on the point on the plot

######### Implementing K-means

#when cluster numbers = 3
kmean2 = kmeans(iris1, 3)
kmean2$centers #return the location of each centroid
kmean2$cluster #return a vector of numbers ranging from 1 to 3
#depicting which observations belong to which cluster from 1 to 3

kmean2#check WCSS Value
#The 3 clusters are made which are of 62, 38, 50 sizes respectively. 
#Within the cluster, the sum of squares = 88.4%.

#Plot data point in Cluster
library(cluster)
clusplot(iris1, kmean2$cluster, lines = 0, shade = TRUE, color = TRUE, labels = 4, xlab = 'Sepal.Length', ylab = 'Sepal.Width')


#DATA VALIDATION#

table(iris$Species, kmean2$cluster)

#            1  2  3

#setosa      0  0 50
#versicolor 48  2  0
#virginica  14 36  0

#here we can see that all setosa values have been clustered properly into cluster 3
#however versicolor(total values = 50) has most values(48) in cluster 1 and least values(2) in cluster 2
#additionally, virginica(total values = 50)  has most values(36) in cluster 2 and lesser values(14) in cluster 1







