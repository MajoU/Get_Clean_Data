### Info about original data

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The attached R script (run_analysis.R) performs the following to clean up the data:

### 1. Merges the training and test sets to create one data set 

Create data frame from X_train.txt, subject_train.txt and y_train.txt by
column binding. Do the same with files in test directory. Then create data
frame through the rbind function. Dimension of data frame is 10299 x 563 

### 2. Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement.
The result is a data frame, because only 66 out of 563 attributes are measurements on the mean and standard deviation. All measurements appear to be floating point numbers in the range (-1, 1).

### 3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
walking

walkingupstairs

walkingdownstairs

sitting

standing

laying

### 4. The script also appropriately labels the data set with descriptive names: 

The result is saved as tidy_dataset.txt, the data frame such
that the first column contains subject IDs, the second column
activity names, the third activity_id and the last 66 columns are
measurements. Subject IDs are integers between 1 and 30 inclusive. 

### 5. Finally, the script creates a 2nd, independent 
tidy data set with the average of each measurement for
each activity and each subject.  The result is saved as
tidy_avg_dataset.txt, a 180x68 data frame, where
as before, the first column contains subject IDs, the second
column contains activity names, the third column is activity_id, and then
the averages for each of the 66 attributes are in columns 3...68. There are
30 subjects and 6 activities, thus 180 rows in this data set
with averages.
