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
#if I didn't code it as a factor I kept getting weird errors
length(campy$order)
str(campy$order) #thought I needed the number of levels for p value calculation, but I'm just running a glm
campy$order

#creates a mixed model
#studying the effect of urban adaptation on c jejuni presence/absence
#will be using family a random effect
#I chose family because it may have some influence on life history traits (urban association) that
#I didn't necessarily control for in my dataset. I don't think that any particular value
#of family is more likely to carry c. jejuni than any other
#my hypothesis is that urban dwellers will be more likely than avoiders to carry c jejuni
#this is consistent with previous analyses, but I haven't incorporated other variables into these analyses
glm1 <- glmer(cjejuni~urban + (1|order),data=campy, family="binomial")
glm2 <- glmer(cjejuni~urban*trophic + (1|family), data=campy, family="binomial")
#from this output, it appears that dwellers, visitors, and visitor/dwellers are all significantly more likely
#to carry c. jejuni than urban avoiders, consistent with other analyses that have been performed oni this dataset

summary(glm1)
anova(glm1)
plot(glm1)
ggplot()
