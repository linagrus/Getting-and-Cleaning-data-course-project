# Getting and Cleaning Data - Course Project

## Project Description
This project is about collecting and tidying data that can be used for later analysis.
Human Activity Recognition Using Smartphones Data Set
The project uses Human Activity Recognition Using Smartphones data that can be downloaded from [here:](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a full description could be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Files
### Data processing script: 'run_analysis.R'
The R script does the following:

1. Downloads the data sets if they do not already exist.
2. Reads data tables and creates meaningful column names.
3. Merges subject, activity, train and test data sets.
4. Creates a subset keeping only columns which reflect a mean or standard deviation of measurements.
5. Uses descriptive activity names to name the activities in the data set and labels the data set with descriptive variable names.
6. Creates a tidy data set that consists of the average of each variable for each activity and each subject. 

### Output: 'tidy_dataset.txt'
Tidied data is grouped by subject and activity, and summarized by average of each variable. The tidy data set is written to the file 'tidy_dataset.txt'.

### Description of data, transformations and variables: 'CodeBook.md'
The code book 'CodeBook.md' describes data, variables and transformations that were used in the processing script 'run_analysis.R'
