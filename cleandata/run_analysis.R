library(plyr)
# Merge train set and test set to form one data set
subject_train<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subject_test<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
total_x<-rbind(X_train,X_test)
total_y<-rbind(y_train,y_test)
total_subject<- rbind(subject_train,subject_test)
meanstd_features<- grep("mean|std",features[,2])
total_x<-total_x[,meanstd_features]
names(total_x)<-features[meanstd_features,2]
activity_labels<-read.table("/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
names(total_y)<-"activity"
names(total_subject)<-"subject"
alldata<-cbind(total_x,total_y,total_subject)
alldata$activity<-as.character(alldata$activity)
alldata$activity[alldata$activity==1]<-"WALKING"
alldata$activity[alldata$activity==2]<-"WALKING_UPSTAIRS"
alldata$activity[alldata$activity==3]<-"WALKING_DOWNSTAIRS"
alldata$activity[alldata$activity==4]<-"SITTING"
alldata$activity[alldata$activity==5]<-"STANDING"
alldata$activity[alldata$activity==6]<-"LAYING"
averagedata<- ddply(alldata,.(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averagedata,"average.txt",row.names=FALSE)
