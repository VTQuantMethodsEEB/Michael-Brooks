rm(list=ls())

#loads packages
library(tidyverse)
library(tidyr)

#creates dataframe from csv file
campylobacter <- read.csv('campylobacterreview_data.csv')

#Hypothesis 1:
#I want to test my hypothesis that the mean mass of urban avoiders is higher than the mean mass of urban dwellers
#This is intuitive because larger species should have more difficulty adapting to urban environments

#creates a new dataframe using only urban avoiders and dwellers to simplify permutation test
campylobacter2 <- campylobacter %>%
  filter(urban=="Avoider" | urban=="Dweller", na.rm=TRUE)


#creates a vector from mass values subset from 'urban avoiders'
#this took a little bit of noodling around but I sort of remembered what you did in class to get here, the rest I filled in from previous lectures!
#yay learning :)
avoidermass <- c(campylobacter$mass[campylobacter$urban=='Avoider']) 
avoidermass <- avoidermass[!is.na(avoidermass)]#had to remove NAs, very tricky little values
avoidermass
length(avoidermass) #length of avoider mass for permutation annotation below

mean(avoidermass, na.rm=TRUE) #mean of urban avoiders is higher than urban dwellers


#creates a vector from mass values subset from 'urban dwellers'
dwellermass <-c(campylobacter$mass[campylobacter$urban=='Dweller']) 
dwellermass <- dwellermass[!is.na(dwellermass)]#also had remove all the NAs here. Is there a more elegant way to do this?
dwellermass
mean(dwellermass, na.rm=TRUE)

#random number generator
set.seed(101)

res <- NA #this sets up the permutation by creating a storage variable

#10000 iterations of the shuffling
for (i in 1:10000) {
  campyboot <- sample(c(avoidermass, dwellermass))
  avoiderboot <-campyboot[1:length(avoidermass)] #assigns first 17 samples to avoider
  dwellerboot <-campyboot[(length(avoidermass)+1):length(campyboot)] #assigns rest to dweller
  res[i] <-mean(avoiderboot)-mean(dwellerboot) #calculates difference in mean mass of avoiders and dwellers
}
#observed difference in mean mass of avoiders and dwellers
obs <-mean(avoidermass,na.rm=TRUE)-mean(dwellermass,na.rm=TRUE)
obs


res[res>=obs]
length(res[res>=obs])
367/10000
mean(res>=obs)  

