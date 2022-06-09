#Prediction using Unsupervised Learning
#data : inbuilt data IRIS 
#problem statement : From Iris dataset, predict optimum number of clusters and represent it visually

View(iris) #Iris is a built-in dataset that comes in R 
summary(iris)

#remove the target variable - Species from our data
iris1 = iris[-5]

#rows and culumns
dim(iris) #150 rows, 5 columns

#data types in iris 
str(iris) #continuous 

#is the data empty 
apply(iris, 2, function(x) sum(is.na(x)))


#for outliers
library(ggplot2)

ggplot(data = iris, aes(x=Species, y=Petal.Length)) +geom_boxplot()
ggplot(data = iris, aes(x=Species, y=Petal.Width)) +geom_boxplot()

ggplot(data = iris, aes(x=Species, y=Sepal.Length)) +geom_boxplot()
ggplot(data = iris, aes(x=Species, y=Sepal.Width)) +geom_boxplot()

ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) + geom_point()

#now for clusters, we have read that it takes just 2 columns, 
#so now is the time to decide which 2 columns are needed to 
#make clusters of flower



#sepal and petal length correlated?
cor(iris1$Sepal.Length, iris1$Petal.Length) 

#what about the widths
cor(iris1$Sepal.Width, iris1$Petal.Width) #-ve correlated, that too not strong

#the cluster needs to be found out and there are 3 methods to find them out :
#: Elbow, Silhouhette and Gap statistic methods t

#Here we use fviz_nbclust() function (from package - factoextra) to find clusters on all 3 methods

#The simplified format is as follow: fviz_nbclust(x, FUNcluster, method = c("silhouette", "wss", "gap_stat"))

#The R code below determine the optimal number of clusters for k-means clustering:

pkgs <- c("factoextra",  "NbClust")
install.packages(pkgs)
library(factoextra)
library(NbClust)

# Elbow method 
fviz_nbclust(iris1, kmeans, method = "wss") +
labs(subtitle = "Elbow method")
#no of cluster = elbow point = 4

# Silhouette method
fviz_nbclust(iris1, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")

# Gap statistic
# nboot = 50 to keep the function speedy. 
# nstart= 25 which means that R will try 25 different random starting assignments and 
# then select the one with the lowest within cluster variation.
# recommended value for nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(iris1, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")


#The disadvantage of elbow and average silhouette methods is that, 
#they measure a global clustering characteristic only.
#A more sophisticated method is to use the gap statistic which provides a 
#statistical procedure to formalize the elbow/silhouette heuristic in order to 
#estimate the optimal number of clusters.

##########3////////////OR////////////##################33

#to find optimum number of clusters
WCSS = vector()
for(i in 1:10){
  WCSS[i] = sum(kmeans(iris1 ,i)$withinss)
}
#plot elbow plot
plot(1:10, WCSS, type = 'b', xlab = 'no. of clusters', ylab = 'WCSS')
#type #p = point #l = line #b = both

# Implementing K-means

#Moving on here with the elbow method, the cluster numbers = 2

kmean = kmeans(iris1, 4)
kmean$centers #return the location of each centroid
kmean$cluster #return a vector of numbers ranging from 1 to 4
#depicting which observations belong to which cluster 1/2/3/4
kmean
#Plot data point in Cluster
#install.packages("ggfortify")
library(ggfortify)
autoplot(kmean, iris1, frame = TRUE)
#OR
library(cluster)
clusplot(iris1, kmean$cluster, lines = 0, shade = TRUE, color = TRUE, labels = 2, xlab = 'h', ylab = 'wot')


#when cluster numbers = 2
kmean1 = kmeans(iris1, 2)
str(kmean1)
kmean1
fviz_cluster(kmean1, data = iris1)


kmean1$centers #return the location of each centroid
kmean1$cluster #return a vector of numbers ranging from 1 to 4
#depicting which observations belong to which cluster 1/2/3/4

#Plot data point in Cluster
#install.packages("ggfortify")
library(ggfortify)
autoplot(kmean1, iris1, frame = TRUE)

#when cluster numbers = 3
kmean2 = kmeans(iris1, 3)
str(kmean2)
kmean2
fviz_cluster(kmean2, data = iris1)


kmean2$centers #return the location of each centroid
kmean2$cluster #return a vector of numbers ranging from 1 to 4
#depicting which observations belong to which cluster 1/2/3/4

#Plot data point in Cluster
#install.packages("ggfortify")
library(ggfortify)
autoplot(kmean2, iris1, frame = TRUE)




#DATA VALIDATION#

#first for cluster = 4

table(kmean$cluster,iris$Species)
#####setosa versicolor virginica
#1      0          0        27
#2      0         27         1
#3      0         23        22
#4     50          0         0

#here we can see that setosa has been clustered properly into cluster 4
#however versicolor has been put on 2 clusters and virginica on 3

#when cluster = 2

table(kmean1$cluster,iris$Species)

##  setosa versicolor virginica
#1     50          3         0
#2      0         47        50


#when cluster = 3

table(kmean2$cluster,iris$Species)

##  setosa versicolor virginica
#1     50          0         0
#2      0         48        14
#3      0          2        36







