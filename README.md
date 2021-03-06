## README Document Explaining How the Script Works

The purpose of this exercise was to create a single 'tidy' dataset from multiple datasets provided through the UCI repository.
This github repository contains the run_analysis.R file containing the script, the CodeBook.md file containing descriptions of the variables in the dataset, and this current file, README.md, explaining how the script works.

## The 5 steps of the exercise:
### 1: 
Reading in and merging the test data and the training data to create one single dataset, in the format of the data and the labels.
Reading in the 'features' data set in order to appropriately name the columns of the single dataset was also needed before step 2.
### 2: 
Out of all of the 561 variables in the set, we needed to extract only the mean and std for each of the measurements. I performed this step by going through the columns and finding the pattern to where the mean and std were within the dataset, and only putting those into a newset to perform the other steps on. I believe RegEx code could have been used here, but I am not 100% confident with that topic.
### 3&4: 
Next, the activity labels came in the data as 1-5, but we needed to add the actual activity label names to our tidy data set, so that was performed by giving 1,2,3,4,5 the names of "WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING", respectively, according to 'activity_labels.txt' from the UCI repository.
### 5:
Lastly, we needed to create a new second data set with the average of each variable for each activity and each subject, so this was performedusing the aggregate() in order to group them by activity for each subject. Then the new dataset of 180 (30 subjects x 6 activities) and 68 variables was written out to a text file.
