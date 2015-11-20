## Project Description
The purpose of this project is to demonstrate my ability to get and clean-up raw data for subsequent analysis and modelling. This project requires us to prepare a tidy data set out of Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. A detailed description of the origional study is available at below link 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
	

##Study design and data processing
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 561 features was obtained by calculating variables from the time and frequency domain. 

Detailed list of variables collected can be found in file 'features_info.txt' available at the above link

###Collection of the raw data
The dataset includes the following files:

* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Notes on the original (raw) data 
* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

##Creating the tidy datafile

###1. Download the raw data files
The raw data files from this study can be downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###2. Merging of data
The readings from test and training set have to be merged. Data of each of these sample sets are found in two seperate directories titled 'test' and 'train'. 

In each of these directories, the data is spread across three different files relating to:
* subject - id of the subject participating in the test in files subject_test.txt and subject_train.txt
* activity - code denoting the activity being performed by subject in files y_test.txt and y_train.txt
* feature reading - vector of 561 feature reading associated with the activity performed by subject in files X_test.txt and X_train.txt

Other data files relating to raw internal signals using which the features vector were obtained can be ignored.

The data from these three files have to be combined for both test and training set and therafter merged together to get an aggregate set of features reading across entire sample of 30 subjects.

###3. Clean and extract required subset of data
The data has to be cleaned by assigning descriptive variable names and activity code have to be associated with their corresponding activity name. 

This project requires us to extract all 'mean' and standard deviation readings (denoted by 'std' in feature name) from this cleaned set.

###4. Group and summarize
The extracted subset of processed data has to be further grouped by suject id and activity code and summarized to obtain the mean value of the selected feature readings.

###5. Transform the summary data into long tidy data set
Finally, the summarized mean values are melted by subject id and activity code to get a long tidy data set, which is written into a seperate file titled 'result.txt'.

Further detailed steps performed in R to implement the above can be found in README.md file and in commented run_analysis.R code file.
 

##Description of the variables in the result.txt file
The file contain the following variables:
* Subject.ID - integer representing unique identifier of the 30 subject who performed the test
* Activity.Code - intger representing a code identifyig the activity performed by subject
* Activity.Label - factor of descriptive label for the activity code
* Signal.Type - factor representing the type of features variable signal
* Avg.Value - numeric value representing mean value of corresponding feature variable signal for given subject and given activity


##Acknowledgements
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

