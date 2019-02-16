Columns<-readLines("features.txt") ##561 columns. OK Length

##4. Appropriately labels the data set with descriptive variable names.
Columns<-gsub("^[0-9]{1,3} ","",Columns) ##Deletes initial numbers
Columns<-gsub("^f","Freq.",Columns) ##Replaces f for Freq.
Columns<-gsub("^t","Time ",Columns) ##Replaces t for Time
Columns<-gsub("BodyBody","Body",Columns) 

##3. Uses descriptive activity names to name the activities in the data set
splitActLabels<-strsplit(readLines("activity_labels.txt")," ")
secondElement<-function(x){x[2]}
firstElement<-function(y){y[1]}
MatrixActLabels<-matrix(c(sapply(splitNames,firstElement),sapply(splitNames,secondElement)),ncol=2)
DFActLabels<-as.data.frame(MatrixActLabels)
colnames(DFActLabels)<-c("IDAct","Activity")

TrainLabels<-scan("./train/y_train.txt") ##7352 rows. OK length
DFTrainLabels<-data.frame(IDAct=TrainLabels)
DFTrainLabels$IDAct<-as.factor(DFTrainLabels$IDAct)
DFTrainLabels<-join(DFTrainLabels,DFActLabels) ##Keeps original order

TrainSubjects<-scan("./train/subject_train.txt")
DFTrainSubjects<-data.frame(Subject=TrainSubjects)
DFTrainSubjects$Subject<-as.factor(DFTrainSubjects$Subject)

TRAIN<-matrix(scan("./train/x_train.txt"),ncol=561) ##7352 rows
colnames(TRAIN)<-Columns##includes labels columns
CompleteTrain<-cbind(DFTrainSubjects,DFTrainLabels,TRAIN,Data="Train")
TrainDF<-as.data.frame(CompleteTrain) ##Transforms table into Data Frame

TestLabels<-scan("./test/y_test.txt") ##2947 rows
DFTestLabels<-data.frame(IDAct=TestLabels)
DFTestLabels$IDAct<-as.factor(DFTestLabels$IDAct)
DFTestLabels<-join(DFTestLabels,DFActLabels) ##Keeps original order

TestSubjects<-scan("./test/subject_test.txt")
DFTestSubjects<-data.frame(Subject=TestSubjects)
DFTestSubjects$Subject<-as.factor(DFTestSubjects$Subject)

TEST<-matrix(scan("./test/x_test.txt"),ncol=561) ##2947 rows
colnames(TEST)<-Columns
CompleteTest<-cbind(DFTestSubjects,DFTestLabels,TEST,Data="Test")
TestDF<-as.data.frame(CompleteTest)

##1. Merges the training and the test sets to create one data set
CompleteDF<-rbind(TestDF,TrainDF)
CompleteDF$Subject<-as.numeric(CompleteDF$Subject)
CompleteDF<-arrange(CompleteDF,Subject,IDAct)
CompleteDF$Subject<-as.factor(CompleteDF$Subject)

##2. Extracts only the measurements on the mean and standard deviation for each measurement.             
MeanStdDF<-select(CompleteDF,Subject,Activity,IDAct,Data,contains("mean()"),contains("std()")) 

##5. From the data set in step 4, creates a second, independent tidy data set with
##  the average of each variable for each activity and each subject.
MeanStdDFSubject<-group_by(MeanStdDF,Subject)
MeanStdDFActivity<-group_by(MeanStdDF,Activity)
MeanStdDFSubAct<-group_by(MeanStdDF,Subject,Activity)
MeanStdDFSubSummary<-summarise_all(MeanStdDFSubject,funs(mean))
MeanStdDFActSummary<-summarise_all(MeanStdDFSubActivity,funs(mean))
MeanStdDFSubActSummary<-summarise_all(MeanStdDFSubAct,funs(mean))

write.table(MeanStdDFSubActSummary,"Subject-Activity Summary.txt",row.name=FALSE)

