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
campy$order <- as.factor(campy$ï..order) #ran into an issue because this variable is named strangely 

#confirmed that this was coded as a factor
length(campy$order)
str(campy$order) #needed the number of levels for p value calculation
campy$order

#creates a mixed model
#studying the effect of urban adaptation on c jejuni presence/absence
#will be using order a random effect
#my hypothesis is that urban dwellers will be more likely than avoiders to carry c jejuni
glm1 <- glmer(cjejuni~urban + (1|order),data=campy, family="binomial")
glm2 <- glmer(cjejuni~urban*trophic + (1|order), data=campy, family="binomial")

summary(glm1)
anova(glm1)
plot(glm1)
ggplot()
