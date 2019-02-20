##My personal WD is "C://Users//Daniel//Documents//Coursera//Course_3//project"

library(plyr)

# 0. DOWNLOAD AND UNZIP DATA SETS
  # 0.1 Download Data Set (and create "data" directory into WD)

  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")

  # Unzip Data Set
  
  unzip(zipfile="./data/Dataset.zip",exdir="./data")


# 1. MERGE THE TRAINING AND TEST SETS INTO A SINGLE DATA SET

  # 1.1 Read the files

    # 1.1.1 Read training data:
    
    x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
    subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

    # 1.1.2 Read testing data:
    
    x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

    # 1.1.3 Read features:
    
    features <- read.table('./data/UCI HAR Dataset/features.txt')

    # 1.1.4 Read activity labels:
    
    activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

  # 1.2 Assign column names:
  
  colnames(x_train) <- features[,2] 
  colnames(y_train) <-"activityId"
  colnames(subject_train) <- "subjectId"
  
  colnames(x_test) <- features[,2] 
  colnames(y_test) <- "activityId"
  colnames(subject_test) <- "subjectId"
  
  colnames(activityLabels) <- c('activityId','activityType')
  
  # 1.3 Merge all data into a single set:
  
  mrg_train <- cbind(y_train, subject_train, x_train)
  mrg_test <- cbind(y_test, subject_test, x_test)
  setAllInOne <- rbind(mrg_train, mrg_test)

# 2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

  # 2.1 Read column names:
  
  colNames <- colnames(setAllInOne)
  
  # 2.2 Create vector for defining ID, mean and standard deviation:
  
  mean_and_std <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
  )
  
  # 2.3 Make subset from setAllInOne:
  
  setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# 3. NAME THE ACTIVITIES IN THE DATA SET WITH DESCRIPTIVE ACTIVITY NAMES

setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# 4. THE LABELING OF THE DATA SET WITH THE DESCRIPTIVE VARIABLE NAMES WAS DONE IN STEPS 1.3, 2.2 AND 2.3

# 5. CREATE A 2ND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
## it will be named "secTidySet.txt"

# 5.1 Make 2nd tidy data set

secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# 5.2 Write second tidy data set in txt file

write.table(secTidySet, "secTidySet.txt", row.name=FALSE)