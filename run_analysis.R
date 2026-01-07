---
title: "Claning_data"
author: "Juan Quijia"
date: "2026-01-06"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example 
this article 
. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 

Here are the data for the project:

 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  

You should create one R script called run_analysis.R that does the following. 

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. 

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Good luck!

#
library(tidyverse)

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id","feature"))  

activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id","activity"))  

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
y_train <- left_join(y_train, activity, by="activity_id")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

str(y_train)
length(subject_train$subject)
str(x_train)

train <- cbind(subject_train,y_train,x_train) 


x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
y_test <- left_join(y_test, activity, by="activity_id")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

str(y_test)
length(subject_test$subject)
str(x_test)

test <- cbind(subject_test,y_test,x_test) 

total <- rbind(cbind(group="test", test), cbind(group="train", train))

col_names <- grep("mean|std", names(total), value = T)

total_select <- select(total, c("group","subject","activity_id","activity", col_names))

total_select_summary <- total_select %>% group_by(., activity, subject) %>% summarise(across(where(is.numeric), mean))

write.csv(total_select, "total_select.csv", row.names = FALSE)
write.csv(total_select_summary, "total_select_summary.csv", row.names = FALSE)

