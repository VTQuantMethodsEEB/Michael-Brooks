rm(list=ls())

#loads packages
library(tidyverse)
library(reshape2)
library(tidyr)

#create dataframe from csv file
campylobacter <- read.csv('campylobacterreview_data.csv')

campylobacter2 <- campylobacter %>%
  filter(urban=="Avoider" | urban=="Dweller")

herbivoremass <-

campylobacter2

#random number generator
set.seed(101)

res <- NA #this sets up the permutation as well


for (i in 1:10000) {
  campyboot <- sample(c(campylobacter2$))
}


