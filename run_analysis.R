#reading in the test files and merging
test_x = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt",na.string="?",header=F,sep='')
head(test_x)
dim(test_x)


test_y = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt",na.string="?",header=F,sep='')
dim(test_y)

test_subs = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt",na.string="?",header=F,sep='')
test_subs$dataset="TEST"

test = cbind(test_x, test_y)
head(test)
#dim(test)

#reading in train files and merging
train_x = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt",na.string="?",header=F,sep='')
#head(train_x)
#dim(train_x)

train_y = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt",na.string="?",header=F,sep='')
dim(train_y)

train_subs = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt",na.string="?",header=F,sep='')
train_subs$dataset="TRAIN"

train = cbind(train_x, train_y)
#head(train)
#dim(train)

#merging both the train and test
har = rbind(train, test)
#dim(har)
#head(har)

#reading in features.txt in order to see where the mean() and std() are in the vector
feats = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/features.txt",na.string="?",header=F,sep='')
head(feats)
dim(feats)

feats = feats[,2] #just taking the names vector
#length(feats)
#names(har)[1] = "subjects"
names(har) = feats
head(har)

#combining the subjects
subs = rbind(train_subs,test_subs)
head(subs)
#adding the subjects to the data set in this order because if I tried earlier, the feature names weren't behaving properly
har2 = cbind(subs,har)
str(har2)
#head(har2)

#could definitely use some regex here
names(har2)[1] = "subjects" #naming the first column subjects
har3 = har2[,c(1,2,3:8, 43:48, 83:88, 123:128, 163:168, 203,204,216,217,229,230,242,243,255,256,268:273,347:352,426:431,505,506,518,519,531,532,544,545,564)]
#dim(har3)
str(har3)
# Dr. Campbell's way
#variablelist<-features$V2[grepl("mean\\(\\)|std\\(\\)",features$V2)==TRUE]

names(har3)<-tolower(gsub("[^0-9A-Za-z]","",names(har3)))
har3$dataset<-as.factor(har3$dataset)

#3 and 4 in the assignment
names(har3)[68] = "activity"
har3$activity = factor(har3$activity,
                       levels = c(1, 2, 3, 4, 5, 6),
                       labels = c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
#summary(har3) #double checking I was successful
str(har3)
# #5 in the assignment
fin_data = aggregate(har3[, 2:67], by=list(subjects = har3$subjects,activity = har3$activity), mean)

write.csv(fin_data, "final_data.csv")
write.table(fin_data, "final_data_1a.txt", row.names = FALSE)
