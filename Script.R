#remove all variables stored previously

rm(list = ls())


#import the data

mydata<-read.csv("D:/Projects/R-Covid19/COVID19_line_list_data.csv")

#data exploration

mydata

View(mydata)

#Look at the first 6 rows

head(mydata)

tail((mydata))


#check the datatype of each column in Data

str(mydata)


install.packages("Hmisc")
library(Hmisc)

#Description of data using (Hmisc) command

describe(mydata)

#Clean death column (remove date)

mydata$death_dummy<-as.integer(mydata$death !=0)

#Make sure it has only two values (0 and 1)

unique(mydata$death_dummy)

#Calculate the death rate
#We need to know how many people died and who were injured

sum(mydata$death_dummy)/nrow(mydata)

#precentege

sum(mydata$death_dummy)/nrow(mydata)*100

#people dying (older)&Alive

dead<-subset(mydata,death_dummy==1)
alive<-subset(mydata,death_dummy==0)

#Calculate the average lifespan of both dead and alive

mean(dead$age,na.rm = T)
mean(alive$age,na.rm = T)

#is this statistically significant?

t.test(alive$age,dead$age,alternative = "two.sided",conf.level = 0.95)
#normally , if p value <0.05,we reject null hypothesis
#here  p value ~0, so we reject the null hypothesis 
#and  conclude that this is statistically significant.

#(We found that people who die from the corona virus 
#are older than those who do not die from the corona virus)


#Gender
#people dying (Male or Female)

men<-subset(mydata,gender=="male")
women<-subset(mydata,gender=="female")

#Calculate the average lifespan of both dead and alive

mean(men$death_dummy,na.rm = T)*100
mean(women$death_dummy,na.rm = T)*100

#is this statistically significant?

t.test(men$death_dummy,women$death_dummy,alternative = "two.sided",conf.level = 0.95)

#99% confidence: Men have from 0.8% to 8.8% higher chance of dying.
# p value =0.002 < 0.05, so this statistically significant.

#Men have a higher death rates(in the sample representing population)

