GettingAndCleaningData
======================

This is the Course Project for the course Getting and Cleaning Data.

There is only one script included **run_analysis.R** with the following functions:

* createTidyData: Generates the tidy data set with the average of each variable for each activity and each subject.
* extractMeanAndStdCols: From the original merged data set it returns a new data set with only mean and std values.
* contains: Auxiliar function that returns a boolean value depending if one substring is contained in a string.
* mergeData: Merge the train and test sets.
* getCompleteData: Receives a type of set parameter (test or train) and generates the complete data merging several files from the directory, including X_test.txt / X_train.txt, subjectId, labelId and label. It reads as well the name of the columns from the text file and assign them to the data.frame columns.

In order to correct execute the script you need to set the working directory to the parent folder of "UCI HAR Dataset".

Once the working directory is correct, to execute the script just call:
> source("run_analysis.R")

Note: It's using some functions from the pylr library. I am not using library(pylr) since it is producing an error in my environment, but without that call it works correctly. In case something unexpected happens regarding those functions make sure you have loaded the pylr package.
