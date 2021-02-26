# Preparation
library(dplyr)

# Download the dataset and description

file <- "data.zip"

# Checking if zip file already exists.
if (!file.exists(file)) {
  descriptionUrl <-
    "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
  dataUrl <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(dataUrl, destfile = file)
}

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) {
  unzip(file)
}


# Merge training and test sets to create one data set

# Read data and assign column names

features <-
  read.table("UCI HAR Dataset/features.txt", col.names = c("v", "functions"))
activity_labels <-
  read.table("UCI HAR Dataset/activity_labels.txt",
             col.names = c("label", "activity"))
subject_test <-
  read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <-
  read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <-
  read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")
subject_train <-
  read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <-
  read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <-
  read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")


# Step 1: Merge the training and the test sets to create one data set by 
# combining subjects, activity labels, and features in test and train sets.

test  <- cbind(subject_test, y_test, x_test)
train <- cbind(subject_train, y_train, x_train)
data_set <- rbind(test, train)

# Step 2: Extract only the measurements on the mean and standard deviation for 
# each measurement.

data_subset <-
  data_set %>% select(subject, label, contains("mean"), contains("std"))

# Step 3: Use descriptive activity names to name the activities in the data set.

data_subset$label <- activity_labels[data_subset$label, 2]

# Step 4: Appropriately label the data set with descriptive variable names.

names(data_subset)[2] = "activity"
names(data_subset) <-
  gsub("mean", "Mean", names(data_subset), ignore.case = TRUE)
names(data_subset) <-
  gsub("std", "Std", names(data_subset), ignore.case = TRUE)
names(data_subset) <- gsub("[[:punct:]]", "", names(data_subset))
names(data_subset) <- gsub("^t", "Time", names(data_subset))
names(data_subset) <- gsub("^f", "Frequency", names(data_subset))
names(data_subset) <- gsub("^anglet", "AngleTime", names(data_subset))
names(data_subset) <- gsub("angle", "Angle", names(data_subset))
names(data_subset) <- gsub("BodyBody", "Body", names(data_subset))
names(data_subset) <- gsub("Acc", "Accelerometer", names(data_subset))
names(data_subset) <- gsub("Gyro", "Gyroscope", names(data_subset))
names(data_subset) <- gsub("Mag", "Magnitude", names(data_subset))
names(data_subset) <- gsub("gravity", "Gravity", names(data_subset))

# Step 5: From the data set in step 4, create a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

tidy_dataset <-
  data_subset %>% group_by(activity, subject) %>% summarise_all(funs(mean))

# Write tidy data to ouput file
write.table(tidy_dataset
            , file = "tidy_dataset.txt", row.names = FALSE)


# Check the tidy data set
 validate <- read.table("tidy_dataset.txt", header = TRUE)
# Take a look at final data
 View(validate)
