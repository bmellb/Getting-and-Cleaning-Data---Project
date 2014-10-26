---
title: "CodeBook"
author: "Bart Mellenbergh"
date: "Sunday, October 26, 2014"
output: word_document
---

**Study design**

The data for this project has been obtained by downloading 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

A full description of the data is availabe from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Test and training data are read in and from that data selected features
(measurements) are extracted and put into a dataframe. 
Not having sufficient of an explanation of what the different (calculated)
measurements are in the supplied datasets I have used those measurements
for which the features.txt names of those measurements contained either 
the word "mean" or the word "std". Visual inspection of the selected
features did not show obvious wrong choices.

For readability the data in the dataframe representing the various activities, 
originally a string representing a number, has been replaced by a description 
of the activity itself. The column name of the feautures (measurement) has been
taken from features.txt file. It is relatively easy to change these column names
to something more descriptive but I lack the physical background to do this.

As a last step a tidy dataset is created with the average of each variable 
for each activity and each subject. The chosen method is to implement a nested
loop, looping across every combination of activity and subject, calculating
the mean for each feature and store this in the tidy dataframe. This can be 
done more compactly (a first exmaple is given in the R script itself) but at 
the expense of making the code much more difficult to read.


**Code book**


The combined dataframe and tidy dataframe contain the following columns:

*Subject*               

A string representing a number that identifies the subject 
(person) for whom activities have been measured. For
this particular study this variable ranges from 1 to 30.
                        
*Activity*              

A string representing the activity a subject has been asked
to do and for which measurements have been taken.
The activities are: "Walking", "Walking upstairs",
"Walking downstairs", "Sitting", "Standing" and "Laying down".

*tBodyAcc-mean()-X*      
tBodyAcc-mean()-Y   
tBodyAcc-mean()-Z       
tGravityAcc-mean()-X    
tGravityAcc-mean()-Y    
tGravityAcc-mean()-Z    
tBodyAccJerk-mean()-X   
tBodyAccJerk-mean()-Y   
tBodyAccJerk-mean()-Z   
tBodyGyro-mean()-X      
tBodyGyro-mean()-Y      
tBodyGyro-mean()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyAccMag-mean()
tGravityAccMag-mean()
tBodyAccJerkMag-mean()
tBodyGyroMag-mean()
tBodyGyroJerkMag-mean()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-meanFreq()-X
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-meanFreq()-X
fBodyAccJerk-meanFreq()-Y
fBodyAccJerk-meanFreq()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-meanFreq()-X
fBodyGyro-meanFreq()-Y
fBodyGyro-meanFreq()-Z
fBodyAccMag-mean()
fBodyAccMag-meanFreq()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-meanFreq()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-meanFreq()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-meanFreq()
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-std()
tGravityAccMag-std()
tBodyAccJerkMag-std()
tBodyGyroMag-std()
tBodyGyroJerkMag-std()
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-std()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-std()

The mean and standard deviations extracted from the
original datasets. Features are normalized and 
bounded within [-1,1].The angular velocity means
and standard deviations are in radians/second
(feautures that contain 'Gyro' in their description).
The acceleration feautures ('Acc' in their variable
name) are in standard gravity units 'g'.Frequencies
(variable name contains 'Freq') are in cycles/second (Hz).
For the final tidy dataframe and dataset the mean
has been taken for these variables for every
subject-activity pair.