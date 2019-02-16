# Getting-and-Cleaning-Data-Project
Final Project
## Requirements
1.UCI HAR Dataset as working directory
  
  a) activity_labels.txt = Links the class labels with their activity name 
  
  b) features.txt = List of all features
  
  c) ./train/y_train.txt = Training labels
  
  d) ./test/y_test.txt = Test labels
  
  e) ./train/X_train.txt = Training set
  
  f) ./test/x_test.txt = Test set
  
  g) ./train/subject_train.txt = Identifies the subject who performed the activity for the Train Set
  
  h) ./test/subject_test.txt = Identifies the subject who performed the activity for the Test Set
  
## Process followed by code
### 1. Defines Column names (Columns data frame)

	1.1 Searches and loads into R the features.txt file

	1.2 Cleans the names of the columns by removing the number at the beginning of each line, changes the nomenclature "f" for "Freq.", "t" for "Time" and replaces the "BodyBody" with "Body" in order to have an understandable set of variables.

### 2. Prepares the activity labels information (DFActLabels data frame)

	2.1 Searches and loads into R the activity_labels.txt file

	2.2 Splits each line into 2 columns and generates a matrix

	2.3 Defines the matrix as a Data Frame

	2.4 Assigns understandable names to each of the 2 columns (IDAct, Activity)

### 3. Train Set (TrainDF data frame)

	3.1 Searches and loads into R the ./train/y_train.txt file

	3.2 Generate a Data Frame with de information and names the column IDAct to make the direct link with the Activity Labels information

	3.3 Turns the values of the Column IDAct into factors

	3.4 Joins the IDAct Column with the DFActLabels to have a 2 Column frame with the Activity ID and the Activity description. (It does not use "merge" to keep the same order of the items)

	3.5 Searches and loads into R the ./train/subject_train.txt file as Data frame and the values as factors

	3.6 Searches and loads into R the ./train/x_train.txt file as a matrix

	3.7 Names the columns of the matrix with the values of Columns data frame

	3.8 Binds the information on Activity Description, Subject, Set and adds a column (Data) that specifys that all those values are for the Training set

### 4. Test Set (TestDF data frame)

	4.1 Searches and loads into R the ./test/y_test.txt file

	4.2 Generate a Data Frame with de information and names the column IDAct to make the direct link with the Activity Labels information

	4.3 Turns the values of the Column IDAct into factors

	4.4 Joins the IDAct Column with the DFActLabels to have a 2 Column frame with the Activity ID and the Activity description. (It does not use "merge" to keep the same order of the items)

	4.5 Searches and loads into R the ./test/subject_train.txt file as Data frame and the values as factors

	4.6 Searches and loads into R the ./test/x_train.txt file as a matrix

	4.7 Names the columns of the matrix with the values of Columns data frame

	4.8 Binds the information on Activity Description, Subject, Set and adds a column (Data) that specifys that all those values are for the Test set

### 5. Merging Test and Training Sets (CompleteDF data frame)
	5.1 Binds Test and Training Data frames

	5.2 Arranges the Data frame by subject - ActID

### 6. Mean and Standard Deviation values extraction (MeanStdDF data frame)

	6.1 Selects from the Data frame only the columns for Subject, Activity, IDAct, Data and all that contain in the name "mean()" or "std()"

### 7. Summary by Subject and Activity  (MeanStdDFSubActSummary)

	7.1 Groups by Subject, Activity and Subject - Activity
	
	7.2 Summarizes by mean the groups of Subject, Activity and Subject - Activity
	
	7.3 Generates file with the summary for Subject - Activity group
  
