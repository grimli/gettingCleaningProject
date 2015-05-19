# Code Book for Getting and Cleaning Data Project
## Data Source
The analyzed data are derived from the "Human Activity Recognition Using Smartphones Data Set", originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data elaborated by this script can be get at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Plaes refer to the Readme file included in the data archive for a more detailed description expecially for the data not included in  the results of this elaboration.

## General description of the Original Data
The aim of the original experiment was to show the possibility to understent which kind of activity was performing a subject wearing a smartphone analyzing data from the accelerometers and giroscope in the smartphone. 

Measurements have been taken on 30 subjects performing 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 

The original data are divided in train and test data: the first to be used to train tha procedure, the last to be used to test the forecasts of the procedure.

As reported in the original feature_info.txt file the data come from a 50Hz sampling of each of the 3 axial components (X,Y and Z).
- To generate **tBodyAcc-XYZ** and **tGravityAcc-XYZ** these data are filtered with a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Furthermore another low pass Butterworth filter with a corner frequency of 0.3 Hz is applied to the acceleration data to separate the costant component (gravity). 
- To generate Jerk signals ( **tBodyAccJerk-XYZ** and **tBodyGyroJerk-XYZ** ) derivation is applied to the previous variables.
- To calculate the magnitude of these vectors ( **tBodyAccMag**, **tGravityAccMag**, **tBodyAccJerkMag**, **tBodyGyroMag**, **tBodyGyroJerkMag** )  Euclidean norm is used.
- Data in the frequency domain ( **fBodyAcc-XYZ**, **fBodyAccJerk-XYZ**, **fBodyGyro-XYZ**, **fBodyAccJerkMag**, **fBodyGyroMag**, **fBodyGyroJerkMag** ) are calculated using FFT (Fast Fourier Transform).

Several statistical values are estimated for the previous variables (mean, std etc..). 

Moreover angle are estimated between the previous vectors.

The measurements units aren`t reported in the original data

## Applied elaborations
To obtain the final dataset, as required in the project description, I have applied the following elaborations on the original data:
- I have mixed test and train data in one dataset
- I have extracted the mean value and the std value of each variable managing them as measured variables.
- I have united activities, subjects and measurements in the same table.
- I have substitued the activity ID with an explicit lable
- I have used variables names in feature.txt files to giva a name to the various columns

For the dataset_2 table only:
- I have calculated the mean value on each activity and subject for the various variables.

## Resulting data

The script produces two tables:
- **dataset**: contains several measures for each (activity,subject)
- **dataset_2**: contains one value for each (activity, subject) calculated as the mean of the values in **dataset**

- **activity**: label identifying the activity of the subject during the measure
- **sobject**: number identifying the subject
- **tBodyAcc-mean()-[XYZ]**: these three values are the three mean components of the linear acceleration  
- **tBodyAcc-std()-[XYZ}**: these three values are the standard deviation of the three components of the linear acceleration  
- **tGravityAcc-mean()-[XYZ]**: these three values are the three mean components of the gravitational acceleration (costant component)
- **tGravityAcc-std()-[XYZ]**: these three values are the standard deviation of the three components of the gravitational acceleration  
- **tBodyAccJerk-mean()-[XYZ]**: three values with the derivative of the mean of the linear acceleration
- **tBodyAccJerk-std()-[XYZ]**: three values with the derivative of the std of the linear acceleration  
- **tBodyGyro-mean()-[XYZ]**: three components of the mean value of the angular acceleration
- **tBodyGyro-std()-[XYZ]**: three components of the std value of the angular acceleration
- **tBodyGyroJerk-mean()-[XYZ]**: three values with the derivative of the mean of the angular acceleration 
- **tBodyGyroJerk-std()-[XYZ]**:  three values with the derivative of the std of the angular acceleration  
- **tBodyAccMag-mean()**: magnitude of the mean linear acceleration
- **tBodyAccMag-std()**: magnitude of the std value of the linear acceleration
- **tGravityAccMag-mean()**: magnitude of the mean gravitational acceleration (constant component)
- **tGravityAccMag-std()**: magnitude of the std value of the gravitational acceleration (constant component)
- **tBodyAccJerkMag-mean()**: magnitude of the derivative of the mean of the linear acceleration
- **tBodyAccJerkMag-std()**: magnitude of the derivative of the std value of the linear acceleratio
- **tBodyGyroMag-mean()**: magnitude  of the mean value of the angular acceleration
- **tBodyGyroMag-std()**: magnitude of the  std value of the angular acceleration
- **tBodyGyroJerkMag-mean()**: magnitude of the derivative of the mean of the angular acceleration
- **tBodyGyroJerkMag-std()**: magnitude of the derivative of the std of the angular acceleration
- **fBodyAcc-mean()-[XYZ]**: frequency components of mean value of linear acceleration
- **fBodyAcc-std()-[XYZ]**:  frequency components of std value of linear acceleration
- **fBodyAccJerk-mean()-[XYZ]**: frequency components of the derivative of the mean value of linear acceleration
- **fBodyAccJerk-std()-[XYZ]**: frequency components of the derivative of the std value of the linear acceleration
- **fBodyGyro-mean()-[XYZ]**: frequency components of the mean value of the angular acceleration
- **fBodyGyro-std()-[XYZ]**: frequency components of the std value of the angular acceleration
- **fBodyAccMag-mean()**: frequency magnitude of the  mean value of linear acceleration
- **fBodyAccMag-std()**: frequency magnitude of the std value of linear acceleration
- **fBodyBodyAccJerkMag-mean()**: frequency magnitude of the derivative of the mean value of linear acceleration
- **fBodyBodyAccJerkMag-std()**: frequency magnitude of the derivative of the std value of the linear acceleration
- **fBodyBodyGyroMag-mean()**: frequency magnitude of the mean value of the angular acceleration
- **fBodyBodyGyroMag-std()**: frequency magnitude of the std value of the angular acceleration
- **fBodyBodyGyroJerkMag-mean()**: frequency magnitude of the  derivative of the mean of the angular acceleration
- **fBodyBodyGyroJerkMag-std()**: frequency magnitude of the derivative of the std of the angular acceleration
