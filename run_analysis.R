# loading usefull packages
library(plyr)
library(reshape2)

# set working directory
setwd("~/UCI_HAR_Dataset/")


# FIRST TIDY DATA SET 

# create a list of file names which have "train" in their names from directory 'train'
train_files <- list.files("train", pattern = "train")

# read each files from train_files by specific order and convert it to another list - train_list 
train_list <- lapply(file.path("train", train_files[c(1,3,2)]), read.table)

# bind each data frame from train_list by column
train_df <- do.call("cbind", train_list)

# this three codes below is identical to previous three codes.
test_files <- list.files("test", pattern = "test")
test_list <- lapply(file.path("test", test_files[c(1,3,2)]), read.table)
test_df <- do.call("cbind", test_list)

# merging two data frame - train_df and test_df
merge_df <- rbind(train_df, test_df)

# read features.txt and create column names 
features <- read.table("./features.txt", col.names = c("id", "labels"))

# create column names in merge_df data frame 
colnames(merge_df) <- c("subject", "activity", as.character(features$labels))

# Extract the relevant features name from the features vector
mean_std_names <- grep("mean\\(|std\\(", features$labels, value=T)

# subset merge_df by specific column names and character vector mean_std_names
mean_std_df <- merge_df[, c("subject", "activity", mean_std_names)]

# read activity_labels.txt and create column names
act_lab <- read.table("./activity_labels.txt", col.names = c("activity_id", "labels"))

# name activity id numbers in data set by activity labels from act_lab using merge
# function
tidy_df <- merge(act_lab, mean_std_df, by.x = "activity_id", by.y = "activity")

# relocate data set columns and order activity_id variables by subject for better overview 
tidy_df <- tidy_df[c("subject", "labels", "activity_id", mean_std_names)]
tidy_df <- arrange(tidy_df, subject, activity_id)


# SECOND TIDY DATA SET

# set id and measure variables with melt function
tidy_df_melt <- melt(tidy_df, id=c("subject", "labels","activity_id"), measure.vars = mean_std_names)

# create average tidy data frame through the dcast function. each
# variables for subject with labels and activity is processed by mean.
tidy_df_avg <- dcast(tidy_df_melt, subject + labels + activity_id ~ variable, mean)

# save the tidy data sets
write.csv(tidy_df, "tidy_dataset.csv", row.names = F)
write.csv(tidy_df_avg, "tidy_avg_dataset.csv", row.names = F)











 
