# This R script uses the UCI HAR Dataset and does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
        # for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
        # with the average of each variable for each activity and each subject.

# Load dplyr package
library(dplyr)

# Set working directory
setwd('C:/Users/mayag/OneDrive/Desktop/Data Science Foundations Using R/R files/getting_and_cleaning_data_project')

# Read in data and apply labels

## Features and activity labels
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt", col.names = c("id", "activity"))

## Training data set
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt", col.names = "activity")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

## Test data set
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt", col.names = "activity")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")

## Name the columns using features
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]

## Bind subject, y, and x columns for both training and test data sets
train <- cbind(subject_train, y_train, x_train)
test  <- cbind(subject_test, y_test, x_test)

## Merge the training and the test sets to create one data set
full_dataset <- rbind(train, test)

# Extract only the measurements on the mean and standard deviation for each measurement
names(full_dataset)
mean_sd_dataset <- full_dataset %>% 
        select(subject, activity, contains("mean()"), contains("std()"))

# Use descriptive activity names to name the activities in the data set
names(mean_sd_dataset)
mean_sd_dataset$activity <- factor(mean_sd_dataset$activity, 
                                 levels = activity_labels$id, 
                                 labels = activity_labels$activity)

# Label the data set with descriptive variable names. 
names(mean_sd_dataset) <- gsub("^t", "Time", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("^f", "Frequency", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("Acc", "Accelerometer", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("Gyro", "Gyroscope", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("Mag", "Magnitude", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("BodyBody", "Body", names(mean_sd_dataset))

# Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
tidy_dataset <- mean_sd_dataset %>%
        group_by(subject, activity) %>%
        summarise(across(everything(), mean))

# Save tidy dataset
write.table(tidy_dataset, "tidy_dataset.txt", row.name = FALSE)