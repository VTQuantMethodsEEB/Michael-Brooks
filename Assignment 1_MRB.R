rm(list=ls()) # clears workspace


#load necessary packages

library(tidyverse)
library(reshape2)

#Prompt 1
Campylobacter <- read.csv("campylobacterreview_data.csv") #reads csv file from my meta-analysis data into workspace
view(Campylobacter) #calls up dataset into a separate window

#Prompt 2
Campylobacter[1] #calls first column
Campylobacter[1,] #calls first row
Campylobacter[1:6,] #calls first 6 rows
summary(Campylobacter) #summary statistics
head(Campylobacter) #calls first 6 values

#adds campylobacter jejuni presence data and campylobacter coli presence data to create a new variable (CampySpecRich)
Campylobacter$campyrichness <- (Campylobacter$cjejuni +
  Campylobacter$ccoli)

#prompt 3
?aggregate
#aggregates data by C jejuni presence by C coli presence using the mean function
m1 <- aggregate(cjejuni ~ ccoli,data=Campylobacter, FUN=mean)
m1

#aggregates data by C jejuni presence by C coli presence using the sum function
m2 <- aggregate(cjejuni ~ ccoli,data=Campylobacter, FUN=sum)
m2

#aggregates data by C jejuni presence by C coli presence using the length function
m3 <- aggregate(cjejuni ~ ccoli,data=Campylobacter, FUN=length)
m3

#prompt 4
#creates a data table with the variables 'Urban' and 'Campylobacter' from my dataset
tab1 <- table(Campylobacter$urban, Campylobacter$campylobacter)
tab1
