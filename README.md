# Getting and Cleaning Data Project

The script in this repository will elaborate the data in 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

as required in the project description

The scripts assumes that the data are unconpressed in the working directory in a directory named "UCI HAR Dataset". This is the directory name generated unzipping the file.

The script genarate two dataframe named dataset and dataset_2. In dataset there will be the expanded data, in dataset_2 the summarized data



## Project reqirements
- Merges the training and the test sets to create one data set.
   - Line 42 unifies the partial reults for test and train data. I have postponed this step to work on smaller dataframe
- Extracts only the measurements on the mean and standard deviation for each measurement. 
   - Line 24 defines the columns to be extracted and lines 31 and 39 actually extract the required columns
- Uses descriptive activity names to name the activities in the data set
   - Lines 31 and 39 assign names to the activities. These are the last elaboration steps for each subset due to the ordering introduced by the merge function. 
- Appropriately labels the data set with descriptive variable names. 
   - Lines 22, 28 and 36 assign proper names to teh variables. Most of the names are the ones in the feature.txt file that contains the list of the measured values.  
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   - Line 51 summarize the data as required calculating the mean value grouping the data both on activity and subject. We have 6 activities and 30 subjects and, the 180 rows in the dataframe.




Line 3
The script start loading the *plyr* library that will be used to aggregate th data in the last step of the script. 

Line 8-18 
all the relevant files are loaded in dataframe to be used later.

Line 22
names are assigned to columns in the activity_labels dataframe

