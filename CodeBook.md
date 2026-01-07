The dataset includes the following files:
'README.txt'

'run_analysis.R': Code used for analysis.

'total_select.csv': Dataset containing only the mean and standard deviation for each measurement.

'total_select_summary.csv': The average of each variable for each activity and each subject.

Notes:
The run_analysis.R script performs:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).

The gyroscope units are rad/seg.
