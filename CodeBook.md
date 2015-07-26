
# Code book

# Data used

This file describes the variables created and used in the "run.analysis.R" script.
The datasets used and the information about the variables they contain can be downloaded at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Variables

activity contains the information about the labels for each activity.

features contains the names for the x_data dataset.

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.

data_training and data_test merge the previous datasets into these 2 groups.

data merges the test and training group into one.

data_filtered contains the data with only meassurments of means and standard deviations, together with the subject id and the activity

data_merged is the same as data_filtered but with the labesl of the diffeent activities

data_tidy constitutes the final data set with averages by activity and subject
