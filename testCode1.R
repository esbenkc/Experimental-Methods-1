# Setup of document
library(foreign);library(chron);library(ggplot2);library(Rcmdr);
setwd("C:/Users/esben/Desktop/Study/Experimental Methods/R");

# Friend data test
friendsNames<-c("Freya","Søren","Lærke","Verus","Anne-Line");
friendsAges<-c("21","21","21","22","20");
friends<-data.frame(name=friendsNames,age=friendsAges);
friends$affiliation<-c("Friend","Student Group","Student Group","Student Group","Student Group");
friends;

# Setup of "lecturers" data set
lecturers<-data.frame(c(1,2,3,4,5));
lecturers$name<-c("Ben","Martin","Andy","Paul","Graham");
lecturers$birthDate<-as.Date(c("1977-07-03","1969-05-24","1923-06-21","1970-07-16","1949-10-10"));
lecturers$status<-c(rep(0,2),1,2,2);
lecturers$status<-factor(lecturers$status,levels = c(0:2), labels = c("single","engaged","married"));
lecturers$numberOfFriends<-c(5,2,0,4,1);
lecturers$alcoholConsumption<-c(10,15,20,5,30);
lecturers$income<-c(20000,40000,35000,22000,50000);
lecturers$neuroticism<-c(10,17,14,13,21);
lecturers;
# Data subsets
highEarning<-lecturers[c("income")>10000,c("name","income","status")];
highEarning;
responsibleLecturers<-lecturers[alcoholConsumption>=10,c("alcoholConsumption","name","status","neuroticism")];
responsibleLecturers;

# Importing and manipulation of "Sleep-sheet"
sleepData=read.csv("Sleep-sheet - Ark1.csv", header = TRUE);
sleepData$date<-as.Date(sleepData$date);
sleepData$toBed<-chron(times=sleepData$toBed, format = c(times="h:m:s"));
# Time is a tough one
sleepData;

# D9cps
D9cps <- readClipboard();