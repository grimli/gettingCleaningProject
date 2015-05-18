# Getting and Cleaning Data Project

The script in this repository will elaborate the data in 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

as required in the project description

The scripts assumes that the data are unconpressed in the working directory in a directory named "UCI HAR Dataset". This is the directory name generated unzipping the file.

The script genarates two dataframe named dataset and dataset_2. In dataset there will be the expanded data, in dataset_2 the summarized data
Both these dataframe are "Tidy Data" because: I have a column for each variable measured (and two descriptive columns to lable the measuremenst) and a measurement for all the variables in each row. 

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


## Script step by step

Line 3
The script start loading the *plyr* library that will be used to aggregate th data in the last step of the script. 

Line 8-18 
all the relevant files are loaded in dataframe to be used later.

Line 22
names are assigned to columns in the activity_labels dataframe

Line 24 
required column subset is saved in a vector

Line 26-31 
test data are elaborated.
In line 26 raw data tables are binded and in line 28 names are assigned to the columns.
In line 31 three elaboration are performed. First of all the merge function is called to add a column with the activity names. The dataframe is ordered: this is not required but comes as side effect of the merge. Unrequired values are removed from the resulting dataset using a subsetted dataset in the merging function (test_beta[relevant_variables]).

Line 33-39
train data are elaborated.
the same steps used for test data

Line 42
test and train data are united

Line 44
the first column with the activity identificator is eliminated to leave only the activity name

Line 48 
temporary variables are removed from memory to clean up environment

Line 51 
the ddply function is called to make the required aggregation: on the dataframe "dataset", grouping on "activity" and "subject" the mean value is calculated for all the variables (colwise).


