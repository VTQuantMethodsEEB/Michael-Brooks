rm(list=ls())


#loads packages
library(ggplot2)
library(MASS)
library(reshape2)
library(tidyverse)
library(lme4)


#creates dataframe from csv file
campy <- read.csv('campylobacterreview_data.csv')
na.exclude(campy)
head(campy)
campy
campy$logmass <- log(campy$mass)
campy$order <- as.factor(campy$ï..order)

#creates a mixed model
#studying the effect of logmass on c jejuni presence/absence
#will be using order a random effect
#my hypothesis is that 

length(campy$order)
str(campy$order)
campy$order

lm2 <- lmer(cjejuni~logmass + (1|order),data=campy) ## rand intercept
lm3 <- lmer(cjejuni~logmass + (Days|Subject),data=sleepstudy)

lm2
