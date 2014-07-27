## Getting and Cleaning Data

### The run_analysis.R script does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### To achieve this do the following:
* Set the path.to.dataset paramater in the run_analysis.R script to the UCI HAR Dataset.
* Run the run_analysis.R script.
```> source("path.to.dataset/run_analysis.R")```

### How the run_analysis.R script works
* Sets the path to the UCI HAR Dataset.
* Loads and cleans the data to create the tiny data.
* Selects only the mean and std features.
* Calculates the mean of each variable, aggregating over activity and subject.
* Writes the result data frame to csv files in given path (tidy_dataset.csv and tidy_avg_dataset.csv).
