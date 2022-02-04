rm(list=ls()) # clears workspace


#loads necessary packages
library(tidyverse)
library(reshape2)

campylobacter <- read.csv("campylobacterreview_data.csv") #reads csv file from my meta-analysis data into workspace
view(campylobacter) #calls up dataset into a separate window for review

campylobacter[1] #calls first column
campylobacter[1,] #calls first row
campylobacter[1:6,] #calls first 6 rows
summary(campylobacter) #summary statistics of the dataset for each variable
head(campylobacter) #calls first 6 rows

#adds campylobacter jejuni presence data and campylobacter coli presence data to create a new variable (campyrichness)
campylobacter$campyrichness <- (campylobacter$cjejuni +
  campylobacter$ccoli)

#aggregates data for C jejuni presence by C coli presence using the mean function
m1 <- aggregate(cjejuni ~ ccoli,data=campylobacter, FUN=mean)
m1
#aggregates data for C jejuni presence by C coli presence using the sum function
m2 <- aggregate(cjejuni ~ ccoli,data=campylobacter, FUN=sum)
m2
#aggregates data for C jejuni presence by C coli presence using the length function
m3 <- aggregate(cjejuni ~ ccoli,data=campylobacter, FUN=length)
m3
#aggregates data for mass by cjejuni presence using the mean function
m4 <- aggregate(mass ~cjejuni,data=campylobacter, FUN=mean)
m4

#creates a data table with the variables 'urban' and 'campylobacter' from my dataset
tab1 <- table(campylobacter$urban, campylobacter$campy)
tab1
