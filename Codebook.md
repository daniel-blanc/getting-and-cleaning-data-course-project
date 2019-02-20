# The source data

The source data used was the Human Activity Recognition Using Smartphones Data Set.
A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here is the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# The R script (run_analysis.R)

The code within the file "run_analysis.R" will perform the following five steps (besides downloading and unziping the soure data, considered the zero-numbered step:

1. MERGE THE TRAINING AND TEST SETS INTO A SINGLE DATA SET

1.1 Read the files

1.1.1 Read training data

1.1.2 Read testing data

1.1.3 Read features

1.1.4 Read activity labels

1.2 Assign column names

1.3 Merge all data into a single set

2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

2.1 Read column names

2.2 Create vector for defining ID, mean and standard deviation

2.3 Make subset from setAllInOne

3. NAME THE ACTIVITIES IN THE DATA SET WITH DESCRIPTIVE ACTIVITY NAMES

4. THE LABELING OF THE DATA SET WITH THE DESCRIPTIVE VARIABLE NAMES IS DONE IN STEPS 1.3, 2.2 AND 2.3

5. CREATE A 2ND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

5.1 Make 2nd tidy data set

5.2 Write second tidy data set in txt file


# The variables:
features contains the correct names for the x_data dataset, which are applied to the column names stored.
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets for further analysis.
