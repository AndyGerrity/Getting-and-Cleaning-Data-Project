###Get the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")


###assign data to variables
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table('./data/UCI HAR Dataset/features.txt')
activitylabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

###Merge data set
data_subject <- rbind(subject_test, subject_train)
data_activity <- rbind(y_test, y_train)
data_features <- rbind(x_train, x_test)

###Name coloumns
names(data_subject)<-c("subject")
names(data_activity)<- c("activity")
names(data_features) <-features$V2
colnames(activitylabels) <- c('activity','activityType')

###Combine datesets
data_combined <- cbind(data_activity, data_subject)
data <- cbind(data_combined, data_features)

###Subset data
data_meanstd <- data[,grepl("mean|std|subject|activity", names(data))]


###Name the data
names(data_meanstd)<-gsub("^t", "time", names(data_meanstd))
names(data_meanstd)<-gsub("^f", "frequency", names(data_meanstd))
names(data_meanstd)<-gsub("Acc", "Accelerometer", names(data_meanstd))
names(data_meanstd)<-gsub("Gyro", "Gyroscope", names(data_meanstd))
names(data_meanstd)<-gsub("Mag", "Magnitude", names(data_meanstd))
names(data_meanstd)<-gsub("BodyBody", "Body", names(data_meanstd))

##name the columns
data_tidynames <- merge(data_meanstd, activitylabels, by='activity', all.x=TRUE)


##create tidy dataset
data_tidyset <- aggregate(. ~subject + activity, data_tidynames, mean)
data_tidyset <- data_tidyset[order(data_tidyset$subject, data_tidyset$activity),]


###write tidy dataset

write.table(data_tidyset, "data_tidyset.txt", row.name=FALSE)
