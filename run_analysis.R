## Getting and cleaning data final project
## Isabel Oñate

## The task is to create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Setting working directory
setwd("~/Documents/Data coursera/UCI HAR Dataset")

## 1. Readng and merging datasets

features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")

## train
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

## test
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

## Column names

colnames(activity) <- c("activity","activity_name")
colnames(subject_train) <- "subject_id"
colnames(subject_test) <- "subject_id"
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activity"

## Merging data bases
data_training = cbind(y_train, x_train, subject_train)
data_test = cbind(y_test, x_test, subject_test)
data = rbind(data_training, data_test)
str(data)

## 2. Extracting the mean and standard deviation
wanted <- c("subject_id", "activity", "mean\\(\\)",  "std\\(\\)")
vector <- grepl(wanted[1], colnames(data)) | grepl(wanted[2], colnames(data)) | grepl(wanted[3], colnames(data)) | grepl(wanted[4], colnames(data))
data_filtered <- data[vector==TRUE]
str(data_filtered)    ##checking dimension of new data set
names(data_filtered)  ##checking names to make sure we only include means and standard deviations

## 3. Using descriptive activity names to name the activities in the data set

data_merged <- merge(data_filtered, activity, by.x="activity", by.y="activity", all.x=TRUE)
head(data_merged$activity_name,30)  ## cheching the activity labels and levels
dim(data_filtered)                   ## to check dimentions before and after merging
dim(data_merged)

## 4. Labeling the data set

names(data_merged) <- gsub("\\(\\)", "", names(data_merged))
names(data_merged) <- gsub("^t", "time", names(data_merged))
names(data_merged) <- gsub("^f", "frequency", names(data_merged))
names(data_merged) <- gsub("Acc", "Accelerometer", names(data_merged))
names(data_merged) <- gsub("Gyro", "Gyroscope", names(data_merged))
names(data_merged) <- gsub("Mag", "Magnitude", names(data_merged))
names(data_merged) <- gsub("BodyBody", "Body", names(data_merged))
names(data_merged)  ## taking a look at the new names

## 5. cerating a tidy data set with averages by activity and subject

data_tidy <- aggregate(. ~subject_id + activity, data_merged, mean)
library(dplyr)
data_tidy <- arrange(data_tidy, subject_id, activity)

## writting the tidy dataset in a text file to submit

write.table(data_tidy, file="tidydata.txt", row.names=FALSE) 
