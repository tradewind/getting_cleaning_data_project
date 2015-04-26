
Getting and Cleaning Data course project

========================================================================================================================================================

The objective of the course project is to prepare a tidy data set.

run_analysis.R is the script that is going to produce a tidy data set 
README.md explains the steps taken in the script
CodeBook.md expalins the variables in the tidy data set

========================================================================================================================================================

Step 1
	The script uses non-basic packages "dplyr" and "reshape2", so the first step is to make sure they are properly installed and loaded.

Step 2
	Read the subjects (subject_train.txt), activities (y_train.txt) and measurements (X_train.txt) data from "train" and "test" folders, respectively.
	Combine the training and test data into three separate data frames called allSubjects, allActivities and allMeasures, respectively.

Step 3
	Replace the activity label IDs in the allActivities data frame with their corresponding activity label names based on activity_labels.txt

Step 4
	Find out what feature names contain the words "mean" or "std" in features.txt.
	I exclude features containing the word "meanFreq". That leaves me with 66 features.
	Using the desired features, I am able to subset the allMeasures data frame into a much smaller data frame.

Step 5
	Modify feature names to make them more descriptive. Specifically, I exclude special characters and observe camelCase naming convention.

Step 6
	Finally merge the three data frames into one.

Step 7
	Melt the "wide form" data frame into a "narraow form" data frame. As a result, the 66 types of features are converted from variables to values of a single variable called "feature".

Step 8
	Calculate the average measurements of each feature for each activity and each subject to make a new variable "average"

Step 9 
	The desired tidy data set is written into a text file called "tidy_data.txt".
	To read the text file, run the following command: data <- read.table("./tidy_data.txt", header = TRUE)
