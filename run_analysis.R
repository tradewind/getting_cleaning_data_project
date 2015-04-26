# Installing and loading necessary packages
if (!require("dplyr")) install.packages("dplyr")
library(dplyr)
if (!require("reshape2")) install.packages("reshape2")
library(tidyr)

# Read training and test data and combine them into three separate data frames 
trainSubjects <- read.table("./train/subject_train.txt")
trainActivities <- read.table("./train/y_train.txt")
trainMeasures <- read.table("./train/X_train.txt")
testSubjects <- read.table("./test/subject_test.txt")
testActivities <- read.table("./test/y_test.txt")
testMeasures <- read.table("./test/X_test.txt")
allSubjects <- rbind(trainSubjects, testSubjects)
allActivities <- rbind(trainActivities, testActivities)
allMeasures <- rbind(trainMeasures, testMeasures)

# Replace activity label IDs with activity label names
labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")
names(labels) <- c("label_id", "label_name")
names(features) <- c("feature_id", "feature_name")
names(allSubjects) <- "subject_id"
names(allActivities) <- "activity"
allActivities <- mutate(allActivities, activity = labels[activity, "label_name"])

# Look for feature names containing "mean" or "std" to subset the measurements data frame
colWanted <- grep("mean\\(\\)|std\\(\\)", features$feature_name)
allMeasures <- allMeasures[, colWanted]

# Modify feature names to make them more descriptive
names(allMeasures) <- features$feature_name[colWanted] 
names(allMeasures) <- gsub("-", "", names(allMeasures))
names(allMeasures) <- gsub("\\(", "", names(allMeasures))
names(allMeasures) <- gsub("\\)", "", names(allMeasures))
names(allMeasures) <- gsub("mean", "Mean", names(allMeasures))
names(allMeasures) <- gsub("std", "Std", names(allMeasures))
names(allMeasures) <- gsub("BodyBody", "Body", names(allMeasures))

# Finally merge the three data frames into one
mergedData <- cbind(allSubjects, allActivities, allMeasures)

# Melt the "wide" data frame into a "narraow" data frame
meltData <- melt(mergedData, id.vars = c("subject_id", "activity"))

# Calculate the average measurements of each feature for each activity and each subject
avgData <- aggregate(meltData$value, list(meltData$subject_id, meltData$activity, meltData$variable), mean)
names(avgData) <- c("subject", "activity", "feature", "average")

# Write the data frame into a txt file 
write.table(avgData, file = "tidy_data.txt", row.names = FALSE)