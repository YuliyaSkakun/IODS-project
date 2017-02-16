
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
colnames(hd)[1]<- "HDI"
colnames(hd)[3]<- "HDIR"
colnames(hd)[4]<-"Life_exp" 
colnames(hd)[5]<-"years_of_ecduc"
colnames(hd)[6]<-"m_educyears"
colnames(hd)[7]<-"GNI" 
colnames(hd)[8]<- "GNI-HDI"
colnames(hd)

colnames(gii)
colnames(gii)[1]<-"GIIR"
colnames(gii)[3]<-"GII"
colnames(gii)[4]<-"maternal_mort"
colnames(gii)[5]<-"adol_birt"
colnames(gii)[6]<-"repre_parl"
colnames(gii)[7]<-"secon_educ_fem"
colnames(gii)[8]<-"secon_educ_male"
colnames(gii)[9]<-"labforce_fem"
colnames(gii)[10]<-"labforce_male"
colnames(gii)


#Make mutation. Create variable ratio and particip
library(dplyr)

gii <- mutate(gii, ratio = (secon_educ_fem/secon_educ_male))
gii <-mutate(gii, particip=(labforce_fem/labforce_male))

# Join two datasets
join_by <- c("Country")
human <- inner_join(hd, gii, suffix=c(".hd", ".gii"), by =join_by)
str(human)
