# Name: Yuliya Skakun
# Date: 07.02.2017
#The file is containing the information on the alcochol consumprion of students in Portugal (resource: https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION)

#Read The CSV file
setwd("/Users/skakunyuliya/IODS-project/data")
math <-read.csv("student-mat.csv",sep=";",header=TRUE)
por <- read.csv("student-por.csv",sep=";",header=TRUE)

# Merge two datasets
library(dplyr)
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

math_por <- inner_join(math, por, suffix=c(".math", ".por"), by =join_by)

#See the structure and the dimension
str(math_por)
dim(math_por)


alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

#average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Then use 'alc_use' to create a new logical column 'high_use' 
alc <- mutate(alc, high_use = alc_use > 2)

#Glimpse at the newly created data
glimpse(alc)

write.csv(alc, file="write.csv", row.names = FALSE)
