rm(list=ls()) # clears workspace


#load necessary packages

library(tidyverse)
library(reshape2)

#Prompt 1
campylobacter <- read.csv("campylobacterreview_data.csv") #reads csv file from my meta-analysis data into workspace
view(campylobacter) #calls up dataset into a separate window

#Prompt 2
campylobacter[1] #calls first column
campylobacter[1,] #calls first row
campylobacter[1:6,] #calls first 6 rows
summary(campylobacter) #summary statistics
head(campylobacter) #calls first 6 values

#adds campylobacter jejuni presence data and campylobacter coli presence data to create a new variable (CampySpecRich)
campylobacter$campyrichness <- (campylobacter$cjejuni +
  campylobacter$ccoli)

#prompt 3
?aggregate
#aggregates data by C jejuni presence by C coli presence using the mean function
m1 <- aggregate(cjejuni ~ ccoli,data=campylobacter, FUN=mean)
m1

#aggregates data by C jejuni presence by C coli presence using the sum function
m2 <- aggregate(cjejuni ~ ccoli,data=campylobacter, FUN=sum)
m2

#aggregates data by C jejuni presence by C coli presence using the length function
m3 <- aggregate(cjejuni ~ ccoli,data=campylobacter, FUN=length)
m3

#prompt 4
#creates a data table with the variables 'Urban' and 'Campylobacter' from my dataset
tab1 <- table(campylobacter$urban, campylobacter$campy)
tab1
