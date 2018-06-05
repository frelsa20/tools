#reading in the test files and merging
test_x = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt",na.string="?",header=F,sep='')
head(test_x)
dim(test_x)

test_y = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt",na.string="?",header=F,sep='')
dim(test_y)

test_subs = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt",na.string="?",header=F,sep='')

test = cbind(test_x, test_y)
#head(test)
#dim(test)

#reading in train files and merging
train_x = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt",na.string="?",header=F,sep='')
#head(train_x)
#dim(train_x)

train_y = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt",na.string="?",header=F,sep='')
dim(train_y)

train_subs = read.table("C:/Users/frels.LAPTOP-VE0KA9O2/Documents/Data Analytics/Tools & Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt",na.string="?",header=F,sep='')

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
#adding the subjects to the data set in this order because if I tried earlier, the feature names weren't behaving properly
har2 = cbind(subs,har)
head(har2)

#could definitely use some regex here
names(har2)[1] = "subjects" #naming the first column subjects
har3 = har2[,c(1,2:7, 42:47, 82:87, 122:127, 162:167, 202,203,215,216,228,229,241,242,254,255,267:272,346:351,425:430,504,505,517,518,530,531,543,544,563)]
#dim(har3)
#summary(har3)

#3 and 4 in the assignment
names(har3)[68] = "activity"
har3$activity = factor(har3$activity,
                       levels = c(1, 2, 3, 4, 5, 6),
                       labels = c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
#summary(har3) #double checking I was successful

# #5 in the assignment
fin_data = aggregate(har3[, 2:67], by=list(subjects = har3$subjects,activity = har3$activity), mean)

write.table(fin_data, "final_data_1a.txt", row.names = FALSE)
