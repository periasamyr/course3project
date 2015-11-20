## Reference for run_analysis.R script 

This script will create the required tidy data set for course 3 project. Step-by-step summary of the code is given below. Refer to script for more detailed comments.

### 1. Preparatory work
Load libraries - dplyr and reshape2 

### 2. Download the files
Check if working directory contain the required data files and if they do not exist, download and uncompress them from the link specified in our project assignment. This is optional as our assignment assumes that data is available in our working directory but I have included it to make this script to run stand-alone by any user.

### 3. Load the features and activity lables
Navigate to UCI HAR Dataset directory in uncompressed data and load features names and activity lables using read.table(). Assign descriptive column names while reading the files itself.

### 4. Merge the test and train data 
Navigate to test directory and read suject_test.txt, y_test.txt using read.table() and assign descriptive column names. Then read X_test.txt and assign it descriptive column names using colnames() function and features names vector created in step 3 above.Use cbind() to combine these three dataframes as single dataframe called test_data.

Repeat the similar steps by naviagating to train directory using files subject_train.txt, y_train.txt and X_train.txt and create train_data dataframe.

Use rbind() to merge both the test and training dataframes with name aggregat_data.

### Extract select measures
Extract only measures of 'mean' and 'standard deviation' identified by string 'mean' and 'std' respectively in the column names of aggregate_date. This was implemented by using subseting of aggregate_date using grepl() to select columns, whose names contain the strings 'mean' and 'std'. 

### Update activity label
Use merge() to update the descriptive activity labels for aggregate data, combining them 'Activity.Code' variable.

### Summarize aggregate dataset
Group the aggregate data by Subject.ID and Activity.Code using group_by() and pipe the result to summarize() to compute means of all feature variables

### Create second independent tidy data set
Finally use melt() to fold feature variable names and their corresponding means keeping Subject.ID and Activity.Code as id variables and get a long and tidy data set of required data

### Write result and clean-up
Write the result data set to file titled 'results.txt' in the starting directory where the script was originally invoked and clean up downloaded files and working directories.


