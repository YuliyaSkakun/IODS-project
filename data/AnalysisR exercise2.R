setwd("/Users/skakunyuliya/IODS-project/data")
learning2014 <- read.csv(file='learning2014.csv', header=TRUE, sep=",")
learning2014

# Task 2 in the alnalysis 

#Create summary of the variales
summary(learning2014)

library(ggplot2)
# In this plot I will analyse the trend of what is the attitude of the students (depending on their gender) to their exam results
# The regression line was added in order to be able to clearly see the trend and be able to compare attitude to points between genders. It is clearly seen that a positive correlation betwwen attitude and pounts which is logical as the higher the grade the more the person is dedicated to studying and the more he or she is reacting to the grades(show his/her attitude) 
p1 <- ggplot(learning2014, aes(x = attitude, y = points, col=gender))
p1
p2 <- p1+geom_point()
p3 <- p2 + geom_smooth(method = "lm")
p4 <- p3+ggtitle("Student's attitude versus exam points")
p4

install.packages("GGally")
# Also I will analyse the relationship between variables by creating a scatterplot
pairs(learning2014[-1], col=learning2014$gender)
library(GGally)
library(ggplot2)
# In order to have a brighter picture of the interrelationships, I will create more colourfull graph with ggplot function
p5 <- ggpairs(learning2014, mapping = aes(col=gender), lower = list(combo = wrap("facethist", bins = 20)))
p5
# Plots show that there 

# Task 3 in the analysis 

# Create a regreesion
reg1 <- lm(points ~ attitude + gender+ age, data = learning2014)
summary(reg1)
# The only variable that is statistacally significant at 1% level is the attitude. Therefore, one can say that in case attiutde of the student increases by 1, points will be more likely to increase by 0.33
#This result is inline with the  p4 graph that was plotted and described previously 
# Explanatory variables gender and age are not statistically significant
# Model explaine 20% of the variation in the data

reg2 <- lm(points ~ attitude , data = learning2014)

#Task 4 in the analysis

summary(reg2)
# Due to the elimination of the insignificant variables the attitude t-statically has slightly increased, as well as its estimate. Also, because variables had no impact on the points (dependent variable) the R-squared has decrease only by 1%. That is also indicating to the fact that eliminated variables had no effect on points.

# Task 5 in the analysis
par(mfrow=c(2,2))
plot(reg2, c(1,2,5))

# As the analysed model includes only one explanatory variable attitude, one can intuition that the higher the attitude of the person to studies, the more time and effort he or she is spending on education. Thereofre, this effect will defenitely be reflected in the points for the exam or test (examination) the person gets. Therefore, I do believe that between these variables should be obsereved a clear positive relatioship.
# Diagnosis plots are showing that

