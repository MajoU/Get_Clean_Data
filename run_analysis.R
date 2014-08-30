# loading usefull packages
library(plyr)
library(reshape2)

# set working directory
setwd("~/Data_Science/Getting_and_Cleaning_Data/Get_and_Clean_Data/UCI_HAR_Dataset/")

# FIRST TIDY DATA SET 

# create a list of file names which have "train" in their names from directory 'train'
files <- file.path(c("test","train"), list.files(c("test","train"), pattern = "*.txt"))
# read train files in specific order from files and convert it to data frame
train_df <- do.call("cbind", lapply(grep("train", files[c(2,6,4)], value = T), read.table))
# read test files in specific order from files and convert it to data frame
test_df <- do.call("cbind", lapply(grep("test", files[c(1,5,3)], value = T), read.table))

# merging two data frame - train_df and test_df
train_test <- data.table(rbind(train_df, test_df))

# read features.txt and create column names 
features <- setnames(fread("./features.txt"), c("V1", "V2"), c("id", "label"))
# data frame for cleaning features labels 
clean <- data.frame(old = c("[()-,]","std","BodyBody","mean"), new = c("","Std", "Body","Mean"))
# clean the features labels through lapply with gsub conditions - change
# old variables for new variables
g <- lapply(1:4, function(x) features[, label := gsub(clean$old[x], clean$new[x], label)])
# change merge_df colnames as sucject, activity and features label names
setnames(train_test, c("subject", "activity", features$label))

# Extract the relevant features name from the features label
mean_std <- grep("Mean|Std", features$label, value=T)
# subset merge_df by specific column and names from mean_std
sub_train_test <- merge_df[, c("subject", "activity", mean_std), with = F]

#--------------------------------------------------------------------
#  ALTERNATIVE 

# --- data table ------------------------------------------- 
# sub_train_test <- subset(merge_df, select = c("subject", "activity", mean_std))

# --- data frame -------------------------------------------
# sub_train_test <- merge_df[, c("subject", "activity", mean_std_names)]

#-------------------------------------------------------------------

# read activity_labels.txt and create new column names
activ <- setnames(fread("./activity_labels.txt"), c("V1", "V2"), c("activity", "label"))

# merge sub_train_test and activ DT by activity id. This allocates
# activity id to activity labels in new column 'label'
tidy_df <- merge(setkey(activ), setkey(sub_train_test), by = "activity")

# relocate data set columns and order activity_id variables by subject for better overview 
setcolorder(tidy_df, c("subject", "label", "activity", mean_std))
# arrange tidy_df by subject
tidy_df <- arrange(tidy_df, subject)


# SECOND TIDY DATA SET

# aggregate all columns of tidy_df by subject and label
tidy_df_mean <- tidy_df[, lapply(.SD, mean), by = c("subject", "label")]

# save the tidy data sets
write.csv(tidy_df, "tidy_dataset.csv", row.names = F)
write.csv(tidy_df_mean, "tidy_avg_dataset.csv", row.names = F)











 
