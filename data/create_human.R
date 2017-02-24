
#Read the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# Structure, dimension and summary
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

library(plyr)
# Rename variables
colnames(hd)
colnames(hd)[1]<- "HDIRank"
colnames(hd)[3]<- "HDI"
colnames(hd)[4]<-"Life.Exp" 
colnames(hd)[5]<-"Edu.Exp"
colnames(hd)[6]<-"Education"
colnames(hd)[7]<-"GNI" 
colnames(hd)[8]<- "GNI_HDI"
colnames(hd)

colnames(gii)
colnames(gii)[1]<-"GIIRank"
colnames(gii)[3]<-"GII"
colnames(gii)[4]<-"Mat.Mor"
colnames(gii)[5]<-"Ado.Birth"
colnames(gii)[6]<-"Parli.F"
colnames(gii)[7]<-"Edu2.F"
colnames(gii)[8]<-"Edu2.M"
colnames(gii)[9]<-"Labo.F"
colnames(gii)[10]<-"Labo.M"
colnames(gii)


#Make mutation. Create variable ratio and particip
library(dplyr)

gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)
gii <-mutate(gii, Edu2.FM = Edu2.F / Edu2.M)

# Join two datasets
join_by <- c("Country")
human <- inner_join(hd, gii, suffix=c(".hd", ".gii"), by =join_by)

# Week 4. Data Wrangling Exercise
# Mutate the data
human$GNI <- gsub(",", "", human$GNI)
human$GNI <- as.numeric(human$GNI)
class(human$GNI)

# Exclude unneeded variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))

#Remove all rows with missing values
human <- human[complete.cases(human), ]
dim(human)

#Remove the observations which relate to regions instead of countries
human$Country
human <- human[1:155,]
human$Country

#Define the row names of the data by the country names and remove the country name column from the data
row.names(human) <- human$Country
human <- human[,-1]
str(human)
human
#Save the human data
write.csv(human, file="human.csv", row.names = TRUE) 
