rm(list=ls())

#loads packages
library(tidyverse)
library(tidyr)
library(ggplot2)

#creates dataframe from csv file
campy <- read.csv('campylobacterreview_data.csv')

#mass looks very right-skewed, not normal
hist(campy$mass)

#creates a new variable of the log of masses
#this looks much better
campy$logmass <- log(campy$mass)
hist(campy$logmass)

#I am going to create a univariate model testing the effect of trophic level (categorical) 
#on mass (continuous) and I suspect that herbivores will generally be heavier based on the dataset
mod1=lm(logmass~trophic, data=campy)
summary(mod1)
plot(mod1)
#carnivore is the base with a log(mass) of 5.16
#herbivores have a significantly higher log(mass) compared to carnivores (+3.8)
#omnivores also have a significantly higher log(mass) (+2.03) compared to carnivores although
#the results are not as statistically clear as those of herbivores
#I blame all the shrews in the dataset

#tests of normality of residuals
hist(resid(mod1))
shapiro.test(resid(mod1))
#appears to be a normal distribution of residuals after log transformation of mass
#based on histogram and p value >0.05 on the shapiro-wilk test

#diagnostic plot of logmass by trophic level
ggplot(campy, aes(x=trophic, y=logmass)) +
  geom_point()+
  stat_summary(color='red') +
  xlab('Trophic level') +
  ylab('Log of mass')