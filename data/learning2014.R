lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt ", sep="\t", header=TRUE)
#Data contains 183 observations and 60 variables
dim(lrn14)

#Structure shows how the data actually look 
str(lrn14)

install.packages("dplyr")
library(dplyr)

#Create deep
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(lrn14, one_of(deep_questions))
deep_columns
lrn14$deep <- rowMeans(deep_columns)

#Create surf
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

#Create stra
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

lrn1 <- filter(lrn14, Points!=0)
learning2014 <- select(lrn1, one_of("gender", "Age", "Attitude", "deep", "stra", "surf", "Points"))
learning2014
colnames(lrn14)[2] <- "age"
colnames(lrn14)[3] <- "attitude"
colnames(lrn14)[7] <- "points"
learning2014
learning2014 <-filter(learning2014 , points>1)
str(learning2014)
setwd("/Users/skakunyuliya/IODS-project/data")
write.csv(file="learning2014","/Users/skakunyuliya/IODS-project/data")
read.csv(file='learning2014', header=TRUE)
