## Script to create tidy data set required by course project

## Prep - load required libraries
library(dplyr)
library(reshape2)

## Step 1. Merges the training and the test sets to create one data set
## download file and unzip it
## "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

start_directory <- getwd()

if (!file.exists("UCI HAR Dataset")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile="dataset.zip", mode="wb")
    unzip("dataset.zip")
}

setwd("UCI HAR Dataset")

## read activity label and features vector from top directory
activity_labels <- read.table("activity_labels.txt", col.names=c("Activity.Code", "Activity.Label"))
features <- read.table("features.txt", col.names=c("Feature.ID", "Feature.Name"))

## read file from test directory and rename their cols. Combine them into one test dataset
setwd("test")
subject_test <- read.table("subject_test.txt", col.names = c("Subject.ID"))
y_test <- read.table("y_test.txt", col.names=c("Activity.Code"))
X_test <- read.table("X_test.txt")
colnames(X_test) <- features[ , 2]

## cbind them 
test_data <- cbind(subject_test, y_test, X_test)

## repeat above for files in training directory and combine into one training dataset
setwd("../train")
subject_train <- read.table("subject_train.txt", col.names = c("Subject.ID"))
y_train <- read.table("y_train.txt", col.names=c("Activity.Code"))
X_train <- read.table("X_train.txt")
colnames(X_train) <- features[ , 2]

train_data <- cbind(subject_train, y_train, X_train)

## merge two data sets using rbind
aggregate_data <- rbind(test_data, train_data)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement
## select only column names containing 'mean' and 'std'
aggregate_data_subset <- aggregate_data[ , grepl("(mean)|(std)", names(X_test))]


## 3. Uses descriptive activity names to name the activities in the data set
## update activity names using activity label - use merge() 
activity_updated_data <- merge(aggregate_data_subset, activity_labels, 
                                by.x="Activity.Code", by.y="Activity.Code", all=T)

## 4. Appropriately labels the data set with descriptive variable names
## rename the column names - already done as part of step 1 while reading files

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## group_by and summarize values
reqd_summary <- activity_updated_data %>% 
                group_by(Subject.ID, Activity.Code, Activity.Label) %>% 
                summarize_each(funs(mean))

## Melt the summary to get a long tidy dataset & re-name columns descriptively
tidy_result <- melt(reqd_summary, 
                    id.vars = c("Subject.ID", "Activity.Code", "Activity.Label"), 
                    variable.name = "Signal.Type", 
                    value.name = "Avg.Value")

## Navigate to start directory and write result to as txt file
## and clean up downloaded raw files and working directories

setwd(start_directory)
write.table(tidy_result, file="result.txt", row.names=F)

unlink("dataset.zip")
unlink("UCI HAR Dataset", recursive = T)




