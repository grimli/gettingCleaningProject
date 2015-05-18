#this scripts expect the data uncompressed in a directory named "UCI HAR Dataset" under the working directory 
#as first step load plyr library to be used later
library(plyr)

# Read all the required data into data frame from the files
# the data frame will be named as the files

# general interst data
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
features <- read.table(file = "UCI HAR Dataset/features.txt")
#test values
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
#train values
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")

# prepare general data frame
# define names for activity table
colnames(activity_labels) <- c("ID_activity", "activity")
# the project requires to select some columns, to do this i define the list of column as a vector. This list contains all the useful columns: the required variables and columns required to identify the measuraments  
relevant_variables <- c("subject", "ID_activity","tBodyAcc-mean()-X" , "tBodyAcc-mean()-Y" , "tBodyAcc-mean()-Z" , "tBodyAcc-std()-X" , "tBodyAcc-std()-Y" , "tBodyAcc-std()-Z" , "tGravityAcc-mean()-X" , "tGravityAcc-mean()-Y" , "tGravityAcc-mean()-Z" , "tGravityAcc-std()-X" , "tGravityAcc-std()-Y" , "tGravityAcc-std()-Z" , "tBodyAccJerk-mean()-X" , "tBodyAccJerk-mean()-Y" , "tBodyAccJerk-mean()-Z" , "tBodyAccJerk-std()-X" , "tBodyAccJerk-std()-Y" , "tBodyAccJerk-std()-Z" , "tBodyGyro-mean()-X" , "tBodyGyro-mean()-Y" , "tBodyGyro-mean()-Z" , "tBodyGyro-std()-X" , "tBodyGyro-std()-Y" , "tBodyGyro-std()-Z" , "tBodyGyroJerk-mean()-X" , "tBodyGyroJerk-mean()-Y" , "tBodyGyroJerk-mean()-Z" , "tBodyGyroJerk-std()-X" , "tBodyGyroJerk-std()-Y" , "tBodyGyroJerk-std()-Z" , "tBodyAccMag-mean()" , "tBodyAccMag-std()" , "tGravityAccMag-mean()" , "tGravityAccMag-std()" , "tBodyAccJerkMag-mean()" , "tBodyAccJerkMag-std()" , "tBodyGyroMag-mean()" , "tBodyGyroMag-std()" , "tBodyGyroJerkMag-mean()" , "tBodyGyroJerkMag-std()" , "fBodyAcc-mean()-X" , "fBodyAcc-mean()-Y" , "fBodyAcc-mean()-Z" , "fBodyAcc-std()-X" , "fBodyAcc-std()-Y" , "fBodyAcc-std()-Z" , "fBodyAccJerk-mean()-X" , "fBodyAccJerk-mean()-Y" , "fBodyAccJerk-mean()-Z" , "fBodyAccJerk-std()-X" , "fBodyAccJerk-std()-Y" , "fBodyAccJerk-std()-Z" , "fBodyGyro-mean()-X" , "fBodyGyro-mean()-Y" , "fBodyGyro-mean()-Z" , "fBodyGyro-std()-X" , "fBodyGyro-std()-Y" , "fBodyGyro-std()-Z" , "fBodyAccMag-mean()" , "fBodyAccMag-std()" , "fBodyBodyAccJerkMag-mean()" , "fBodyBodyAccJerkMag-std()" , "fBodyBodyGyroMag-mean()" , "fBodyBodyGyroMag-std()" , "fBodyBodyGyroJerkMag-mean()" , "fBodyBodyGyroJerkMag-std()")
# merge tables for test data
test_beta <- cbind(subject_test, y_test, X_test )
# assign proper names to the columns: except for the first two columns i'm going to get the names from the features table. 
colnames(test_beta) <- c("subject","ID_activity",as.character(features[,2]))
# merge activity names
# I have postponed this step because of the ordering produced by the merge function
test <- merge(activity_labels, test_beta[relevant_variables], by = "ID_activity")

# merge files for train data
train_beta <- cbind(subject_train, y_train, X_train )
# assign proper names to the columns: except for the first two columns i'm going to get the names from the features table. 
colnames(train_beta) <- c("subject","ID_activity",as.character(features[,2]))
# merge activity names
# I have postponed this step because of the ordering produced by the merge function
train <- merge(activity_labels, train_beta[relevant_variables], by = "ID_activity")

#merge test and train in one dataset
dataset_beta <- rbind(test,train)
# remove the activity ID: not required
dataset <- dataset_beta[2:68]

# clean up intermediate steps
# not required but i don't like to leave all these unused variables
rm("dataset_beta","X_test","X_train","features","subject_test","subject_train","test","test_beta","y_test","y_train","train","train_beta","activity_labels")

# Summarize data on activity and subject
dataset_2 <- ddply(dataset,c("activity","subject"),colwise(mean))
