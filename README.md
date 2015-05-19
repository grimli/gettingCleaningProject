# Getting and Cleaning Data Project

The script in this repository will elaborate the data in 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

as required in the project description

The scripts assumes that the data are unconpressed in the working directory in a subdirectoryi named "*UCI HAR Dataset*". This is the directory name generated unzipping the compressed file.

The script genarates two dataframes named **dataset** and **dataset_2**. 

In dataset there will be the expanded data (requirements up to number 4): several measurements of the variables for each activity and for each subject

```
> head(dataset[,1:8])
  activity subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z  [...]
1  WALKING      12         0.2160924      -0.004176104       -0.15008372     -0.074291588      -0.06226707       -0.5661365   ...
2  WALKING      12         0.3434905      -0.059664993       -0.12323190     -0.001657743       0.11093762       -0.5071731   ...
3  WALKING      12         0.3090925      -0.021860848       -0.10267598     -0.011803899       0.05489846       -0.5147740   ...
4  WALKING      12         0.1918730       0.024524630       -0.09281903     -0.075637849      -0.10773918       -0.5591353   ...
5  WALKING      12         0.2842238       0.001572040       -0.09911351     -0.099672146      -0.09454807       -0.5786313   ...
6  WALKING      12         0.3613846      -0.017113522       -0.09523884     -0.048902785      -0.09180568       -0.5544868   ...
```

In dataset_2 there will be the summarized data (requiremnt 5): for each activity the mean value of each subject for all the variables
```
  activity subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z  [...]
1   LAYING       1         0.2215982       -0.04051395        -0.1132036       -0.9280565       -0.8368274       -0.8260614   ...
2   LAYING       2         0.2813734       -0.01815874        -0.1072456       -0.9740595       -0.9802774       -0.9842333   ...
3   LAYING       3         0.2755169       -0.01895568        -0.1013005       -0.9827766       -0.9620575       -0.9636910   ...
4   LAYING       4         0.2635592       -0.01500318        -0.1106882       -0.9541937       -0.9417140       -0.9626673   ...
5   LAYING       5         0.2783343       -0.01830421        -0.1079376       -0.9659345       -0.9692956       -0.9685625   ...
6   LAYING       6         0.2486565       -0.01025292        -0.1331196       -0.9340494       -0.9246448       -0.9252161   ...
```

All the intermediate values generated from the script to get to the final results are removed at the end of the script to produce a cleaner environment.
It is sufficient to comment out line 48 and rerun the script to get access to these values if needed:
```
rm("dataset_beta","X_test","X_train","features","subject_test","subject_train","test","test_beta","y_test","y_train","train","train_beta","activity_labels")
```

Both these dataframe are "Tidy Data": there is a column for each variable measured (including two descriptive columns to lable the measuremenst) and a measurement for all the variables in each row. I have decide to manage mean and std values as indipendent variables: this choice in this context is supported by the fact that later in the requirements we are asked to calculate the mean values of these variables and this choice permits to mage the required aggregation in one step.

## Project reqirements
Below is described as  each requiremnt is fulfilled:

1. Merges the training and the test sets to create one data set.
   * Line 42 unifies the partial results for test and train data. I have decided to postpone this step to work on smaller dataframe.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   * Line 24 defines the columns to be extracted and lines 31 and 39 actually extract the required columns from the dataframes.
3. Uses descriptive activity names to name the activities in the data set
   * Line 9 imports activity names from the data files and Lines 31 and 39 assign names to the activities. This is done ain the lasts elaboration steps for each subset due to the ordering introduced by the merge function: the ordering wouldn't be compatible with the cbind function
4. Appropriately labels the data set with descriptive variable names. 
   * Line 10 import variables names from the data files and  Lines 22, 28 and 36 assign proper names to the variables. in the dataframes. The column get form the subject files is named **subject**, the one get from the y file is named **ID_activity** and the other names are the one get from the features.txt file. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   * Line 51 summarize the data as required calculating the mean value grouping the data both on activity and subject. We have 6 activities and 30 subjects iresulting in the 180 rows in the dataframe dataset_2.

As stated in the previous section both the final dataseti are "Tidy Data": there is a column for each variable measured (including two descriptive columns to lable the measuremenst) and a measurement for all the variables in each row. I have decide to manage mean and std values as indipendent variables: this choice in this context is supported by the fact that later in the requirements we are asked to calculate the mean values of these variables and this choice permits to mage the required aggregation in one step.

## Script step by step
Below the description of the script step by step

**Line 3**
```
library(plyr)
```
The script start loading the *plyr* library that will be used to aggregate th data in the last step of the script. 

**Line 8-18** 
```
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
features <- read.table(file = "UCI HAR Dataset/features.txt")
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
```
all the relevant files are loaded in dataframe to be used later.

**Line 22**
```
colnames(activity_labels) <- c("ID_activity", "activity")
```
names are assigned to columns in the activity_labels dataframe

**Line 24**
```
relevant_variables <- c("subject", "ID_activity","tBodyAcc-mean()-X" , "tBodyAcc-mean()-Y" , "tBodyAcc-mean()-Z" , "tBodyAcc-std()-X" , "tBodyAcc-std()-Y" , "tBodyAcc-std()-Z" , "tGravityAcc-mean()-X" , "tGravityAcc-mean()-Y" , "tGravityAcc-mean()-Z" , "tGravityAcc-std()-X" , "tGravityAcc-std()-Y" , "tGravityAcc-std()-Z" , "tBodyAccJerk-mean()-X" , "tBodyAccJerk-mean()-Y" , "tBodyAccJerk-mean()-Z" , "tBodyAccJerk-std()-X" , "tBodyAccJerk-std()-Y" , "tBodyAccJerk-std()-Z" , "tBodyGyro-mean()-X" , "tBodyGyro-mean()-Y" , "tBodyGyro-mean()-Z" , "tBodyGyro-std()-X" , "tBodyGyro-std()-Y" , "tBodyGyro-std()-Z" , "tBodyGyroJerk-mean()-X" , "tBodyGyroJerk-mean()-Y" , "tBodyGyroJerk-mean()-Z" , "tBodyGyroJerk-std()-X" , "tBodyGyroJerk-std()-Y" , "tBodyGyroJerk-std()-Z" , "tBodyAccMag-mean()" , "tBodyAccMag-std()" , "tGravityAccMag-mean()" , "tGravityAccMag-std()" , "tBodyAccJerkMag-mean()" , "tBodyAccJerkMag-std()" , "tBodyGyroMag-mean()" , "tBodyGyroMag-std()" , "tBodyGyroJerkMag-mean()" , "tBodyGyroJerkMag-std()" , "fBodyAcc-mean()-X" , "fBodyAcc-mean()-Y" , "fBodyAcc-mean()-Z" , "fBodyAcc-std()-X" , "fBodyAcc-std()-Y" , "fBodyAcc-std()-Z" , "fBodyAccJerk-mean()-X" , "fBodyAccJerk-mean()-Y" , "fBodyAccJerk-mean()-Z" , "fBodyAccJerk-std()-X" , "fBodyAccJerk-std()-Y" , "fBodyAccJerk-std()-Z" , "fBodyGyro-mean()-X" , "fBodyGyro-mean()-Y" , "fBodyGyro-mean()-Z" , "fBodyGyro-std()-X" , "fBodyGyro-std()-Y" , "fBodyGyro-std()-Z" , "fBodyAccMag-mean()" , "fBodyAccMag-std()" , "fBodyBodyAccJerkMag-mean()" , "fBodyBodyAccJerkMag-std()" , "fBodyBodyGyroMag-mean()" , "fBodyBodyGyroMag-std()" , "fBodyBodyGyroJerkMag-mean()" , "fBodyBodyGyroJerkMag-std()")
```
required column subset is saved in a vector

**Line 26-31**
test data are elaborated.
```
test_beta <- cbind(subject_test, y_test, X_test )
colnames(test_beta) <- c("subject","ID_activity",as.character(features[,2]))
```
In line 26 raw data tables are binded and in line 28 names are assigned to the columns.
```
test <- merge(activity_labels, test_beta[relevant_variables], by = "ID_activity")
```
In line 31 three elaboration are performed
1. First of all the merge function is called to add a column with the activity names. 
2. The dataframe is ordered: this is not required but comes as side effect of the merge. 
3. Unrequired values are removed from the resulting dataset using a subsetted dataset in the merging function (**test_beta[relevant_variables]**).

**Line 33-39**
train data are elaborated.
the same steps used for test data

**Line 42**
```
dataset_beta <- rbind(test,train)
```
test and train data are united in one dataset

**Line 44**
```
dataset <- dataset_beta[2:68]
```
the first column with the activity identificator is eliminated to leave only the activity name

**Line 48**
```
rm("dataset_beta","X_test","X_train","features","subject_test","subject_train","test","test_beta","y_test","y_train","train","train_beta","activity_labels")
```
temporary variables are removed from memory to clean up environment

**Line 51**
```
dataset_2 <- ddply(dataset,c("activity","subject"),colwise(mean))
```
the ddply function is called to make the required aggregation: the mean value is calculated for all the variables (colwise) in the data frame *dataset* grouping on *activity* and *subject*.

