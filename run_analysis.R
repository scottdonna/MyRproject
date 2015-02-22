# merge the data of all test and train data files

#set working directory and download files
# setwd("C:/Users/Daddy/Documents/R/")
# File URL to download
file_URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# Directory
dirFile <- "./UCI HAR Dataset"
# Local data file
dataFileZIP <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"
# Download the dataset (.zip), if it does not exist
if (file.exists(dataFileZIP) == FALSE) {
        download.file(file_URL, destfile = dataFileZIP)
}
# Uncompress data file
if (file.exists(dirFile) == FALSE) {
        unzip(dataFileZIP)
}
# Directory and filename (txt) of the clean/tidy data:
tidyDataFile <- "./tidy-UCI-HAR-dataset.txt"
# Directory and filename (.txt or csv) of the clean/tidy data
tidyDataFileAVGtxt <- "./tidy-UCI-HAR-dataset-AVG.txt"
tidyDataFileAVG <- "./tidy-UCI-HAR-dataset-AVG.csv"

## 1. Merges the training and the test sets to create one data set
# Read in the datasets from the Train directory
dtSubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
dtX_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
dtY_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
# Read in the data from the Test directory
dtSubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
dtX_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
dtY_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)

# Merges the datasets from train and test
x <- rbind(dtX_train, dtX_test)
y <- rbind(dtY_train, dtY_test)
s <- rbind(dtSubjectTrain, dtSubjectTest)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement:
# Read features labels
features <- read.table("./UCI HAR Dataset/features.txt")
# Friendly names to features column
names(features) <- c('feat_id', 'feat_name')
# Search for matches to argument mean or standard deviation (std)  within each element of character vector
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name) 
x <- x[, index_features] 
# Replaces all matches of a string features 
names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))

## 3. Uses descriptive activity names to name the activities in the data set:
## 4. Appropriately labels the data set with descriptive activity names:
# Read activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Friendly names to activities column
names(activities) <- c('act_id', 'act_name')
y[, 1] = activities[y[, 1], 2]

names(y) <- "Activity"
names(s) <- "Subject"

# Combines data table by columns
tidyDataSet <- cbind(s, y, x)

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject:
p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)
# Activity and Subject name of columns 
names(tidyDataAVGSet)[1] <- "Subject"
names(tidyDataAVGSet)[2] <- "Activity"# Created csv (tidy data set) in diretory

# Created csv (tidy data set) in diretory
write.table(tidyDataSet, tidyDataFile)
# Created csv (tidy data set AVG) in diretory
write.csv(tidyDataAVGSet, tidyDataFileAVG)
# Created txt (tidy data set AVG) in diretory
write.table(tidyDataAVGSet, tidyDataFileAVGtxt)