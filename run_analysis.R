# my working directory 
setwd("~/Dropbox/GettingCleaningData/Project/")
#this cripts wants the data uncompressed in the working directory

#library("reshape")
library(plyr)

# Read Files into data frames
# general
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
features <- read.table(file = "UCI HAR Dataset/features.txt")
#test values
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
#body_acc_x_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
#body_acc_y_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
#body_acc_z_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
#body_gyro_x_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
#body_gyro_y_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
#body_gyro_z_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
#total_acc_x_test <- read.table(file = "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")

#train values
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
#body_acc_x_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
#body_acc_y_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
#body_acc_z_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
#body_gyro_x_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
#body_gyro_y_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
#body_gyro_z_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
#total_acc_x_train <- read.table(file = "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")

# prepare general data frame
colnames(activity_labels) <- c("ID_activity", "activity")
relevant_variables <- c("subject", "ID_activity","tBodyAcc-mean()-X" , "tBodyAcc-mean()-Y" , "tBodyAcc-mean()-Z" , "tBodyAcc-std()-X" , "tBodyAcc-std()-Y" , "tBodyAcc-std()-Z" , "tGravityAcc-mean()-X" , "tGravityAcc-mean()-Y" , "tGravityAcc-mean()-Z" , "tGravityAcc-std()-X" , "tGravityAcc-std()-Y" , "tGravityAcc-std()-Z" , "tBodyAccJerk-mean()-X" , "tBodyAccJerk-mean()-Y" , "tBodyAccJerk-mean()-Z" , "tBodyAccJerk-std()-X" , "tBodyAccJerk-std()-Y" , "tBodyAccJerk-std()-Z" , "tBodyGyro-mean()-X" , "tBodyGyro-mean()-Y" , "tBodyGyro-mean()-Z" , "tBodyGyro-std()-X" , "tBodyGyro-std()-Y" , "tBodyGyro-std()-Z" , "tBodyGyroJerk-mean()-X" , "tBodyGyroJerk-mean()-Y" , "tBodyGyroJerk-mean()-Z" , "tBodyGyroJerk-std()-X" , "tBodyGyroJerk-std()-Y" , "tBodyGyroJerk-std()-Z" , "tBodyAccMag-mean()" , "tBodyAccMag-std()" , "tGravityAccMag-mean()" , "tGravityAccMag-std()" , "tBodyAccJerkMag-mean()" , "tBodyAccJerkMag-std()" , "tBodyGyroMag-mean()" , "tBodyGyroMag-std()" , "tBodyGyroJerkMag-mean()" , "tBodyGyroJerkMag-std()" , "fBodyAcc-mean()-X" , "fBodyAcc-mean()-Y" , "fBodyAcc-mean()-Z" , "fBodyAcc-std()-X" , "fBodyAcc-std()-Y" , "fBodyAcc-std()-Z" , "fBodyAccJerk-mean()-X" , "fBodyAccJerk-mean()-Y" , "fBodyAccJerk-mean()-Z" , "fBodyAccJerk-std()-X" , "fBodyAccJerk-std()-Y" , "fBodyAccJerk-std()-Z" , "fBodyGyro-mean()-X" , "fBodyGyro-mean()-Y" , "fBodyGyro-mean()-Z" , "fBodyGyro-std()-X" , "fBodyGyro-std()-Y" , "fBodyGyro-std()-Z" , "fBodyAccMag-mean()" , "fBodyAccMag-std()" , "fBodyBodyAccJerkMag-mean()" , "fBodyBodyAccJerkMag-std()" , "fBodyBodyGyroMag-mean()" , "fBodyBodyGyroMag-std()" , "fBodyBodyGyroJerkMag-mean()" , "fBodyBodyGyroJerkMag-std()" , "angle(tBodyAccMean,gravity)" , "angle(tBodyAccJerkMean),gravityMean)" , "angle(tBodyGyroMean,gravityMean)" , "angle(tBodyGyroJerkMean,gravityMean)" , "angle(X,gravityMean)" , "angle(Y,gravityMean)" , "angle(Z,gravityMean)")
# merge files for test
test_beta <- cbind(subject_test, y_test, X_test )
colnames(test_beta) <- c("subject","ID_activity",as.character(features[,2]))
# merge activity names
test <- merge(activity_labels, test_beta[relevant_variables], by = "ID_activity")

# merge files for train
train_beta <- cbind(subject_train, y_train, X_train )
colnames(train_beta) <- c("subject","ID_activity",as.character(features[,2]))
# merge activity names
train <- merge(activity_labels, train_beta[relevant_variables], by = "ID_activity")

#merge test and train in one dataset
dataset_beta <- rbind(test,train)
dataset <- dataset_beta[2:75]

# clean up intermediate steps
rm("dataset_beta","X_test","X_train","features","subject_test","subject_train","test","test_beta","y_test","y_train","train","train_beta","activity_labels")

# Summarize data on activity and subject
dataset_2 <- ddply(dataset,c("activity","subject"),colwise(mean))
