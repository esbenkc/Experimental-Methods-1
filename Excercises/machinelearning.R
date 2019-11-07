# Setup of document
library(foreign)
library(chron)
library(ggplot2)
library(Rcmdr)
library(ggvis)
library(class)

setwd("C:/Users/esben/Documents/Experimental-Methods-1")


# Friend data test
friendsNames <- c("Freya", "Søren", "Lærke", "Verus", "Anne-Line")

friendsAges <- c("21", "21", "21", "22", "20")

friends <- data.frame(name = friendsNames, age = friendsAges)

friends$affiliation <-
  c("Friend",
    "Student Group",
    "Student Group",
    "Student Group",
    "Student Group")

friends


# Setup of "lecturers" data set
lecturers <- data.frame(c(1, 2, 3, 4, 5))

lecturers$name <- c("Ben", "Martin", "Andy", "Paul", "Graham")

lecturers$birthDate <-
  as.Date(c(
    "1977-07-03",
    "1969-05-24",
    "1923-06-21",
    "1970-07-16",
    "1949-10-10"
  ))

lecturers$status <- c(rep(0, 2), 1, 2, 2)

lecturers$status <-
  factor(
    lecturers$status,
    levels = c(0:2),
    labels = c("single", "engaged", "married")
  )

lecturers$numberOfFriends <- c(5, 2, 0, 4, 1)

lecturers$alcoholConsumption <- c(10, 15, 20, 5, 30)

lecturers$income <- c(20000, 40000, 35000, 22000, 50000)

lecturers$neuroticism <- c(10, 17, 14, 13, 21)

lecturers

# Data subsets
highEarning <-
  lecturers[lecturers$income > 10000, c("name", "income", "status")]

highEarning

responsibleLecturers <-
  lecturers[lecturers$alcoholConsumption >= 10, c("alcoholConsumption", "name", "status", "neuroticism")]

responsibleLecturers

#############################
### Machine learning with ###
### the Iris training set ###
#############################

iris

iris %>% ggvis(~ Sepal.Length, ~ Sepal.Width, fill = ~ Species) %>% layer_points()

iris %>% ggvis(~ Petal.Length, ~ Petal.Width, fill = ~ Species) %>% layer_points()


# Overall correlation `Petal.Length` and `Petal.Width`
cor(iris$Petal.Length, iris$Petal.Width)

# Return values of `iris` levels
x = levels(iris$Species)

# Print Setosa correlation matrix
print(x[1])
cor(iris[iris$Species == x[1], 1:4])

# Print Versicolor correlation matrix
print(x[2])
cor(iris[iris$Species == x[2], 1:4])

# Print Virginica correlation matrix
print(x[3])
cor(iris[iris$Species == x[3], 1:4])

# Return all `iris` data
iris

# Return first 5 lines of `iris`
head(iris)

# Return structure of `iris`
str(iris)

# Division of `Species`
table(iris$Species)

# Percentual division of `Species`
round(prop.table(table(iris$Species)) * 100, digits = 1)

# Division of `Species`
table(iris$Species)

# Percentual division of `Species`
round(prop.table(table(iris$Species)) * 100, digits = 1)

normalize <- function(x) {
  num <- x - min(x)
  
  denom <- max(x) - min(x)
  
  return (num / denom)
  
}

# Normalize the Iris data
normalize(iris$Sepal.Length)

normalizedIris <- as.data.frame(lapply(iris[1:4], normalize))

normalizedIris

set.seed(1234)

ind <-
  sample(2, nrow(iris), replace = TRUE, prob = c(0.67, 0.33)) # Replace = TRUE

# Compose training set
irisTraining <-
  iris[ind == 1, 1:4] # Creates a set based on if previous sampling assigned 1 or 2 (1 with 67% probability) and assigns all columns of row

# Inspect training set
head(irisTraining)

# Compose discriminator test set
irisTest <- iris[ind == 2, 1:4]

# Inspect test set
head(irisTest)

# Compose iris training labels
irisTrainLabels <- iris[ind == 1, 5]

print(irisTrainLabels)

# Compose iris test labels
irisTestLabels <- iris[ind == 2, 5]
print(irisTestLabels)

############################
### THE ACTUAL KNN MODEL ###
############################

# Building the model
irisPrediction <- knn(train = irisTraining, test = irisTest, cl = irisTrainLabels, k = 3)

irisPrediction

# Put testlabels into data frame
irisTestLabels <- data.frame(irisTestLabels)
irisPrediction <- data.frame(irisPrediction)

# Merge irisTestLabels and irisPrediction
merge <- data.frame(irisTestLabels, irisPrediction)

# Specify column names
names(merge) <- c("Observed species", "Predicted species")

merge

# Alright indication of learning model's performance is the fact that only row 29 is wrongly predicted
# LETS GO DEEPER!
library(gmodels)
CrossTable(x = irisTestLabels[,1], y = irisPrediction[,1], prop.chisq = FALSE)


################################################
### With the caret machine learning library! ###
################################################

library(caret)
# Create index to split into training and test sets
index <- createDataPartition(iris$Species, p = 0.75, list = FALSE)

# Subset training and test data sets
irisTraining <- iris[index,]
irisTest <- iris[-index,]

names(getModelInfo())
modelKNN <- train(irisTraining[,1:4],irisTraining[,5],method="knn") # Training a specific machine learning model (see with names(getModelInfo()) and use with method = "<model>" in the train() method) with the data

# Predict the labels of the test set
prediction <- predict(object = modelKNN, irisTest[,1:4], type = "raw")

# Evaluate prediction
table(prediction)

# Confusion matrix
confusionMatrix(prediction, irisTest[,5])


