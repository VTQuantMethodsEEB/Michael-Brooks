rm(list=ls())

#PART 1

#loads packages
library(tidyverse)
library(tidyr)
library(ggplot2)
library(emmeans)
library(effects)

#creates dataframe from csv file
campy <- read.csv('campylobacterreview_data.csv')
head(campy)

#mass looks very right-skewed, not normal
hist(campy$mass)

#creates a new variable of the log of masses
#this looks much better
campy$logmass <- log(campy$mass)
hist(campy$logmass)

#I am going to create a univariate model testing the effect of trophic level (categorical) 
#on mass (continuous) and I suspect that herbivores will generally be heavier than carnivores based on the dataset
#Ha=logmass differs across trophic levels
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
#it certainly looks like herbivores and omnivores have a higher logmass than carnivores
ggplot(campy, aes(x=trophic, y=logmass)) +
  geom_point()+
  stat_summary(color='red') +
  xlab('Trophic level') +
  ylab('Log of mass')







#PART 2


#Ha=logmass differs across trophic levels and sociality separately, but there are no interactions between the predictor variables
#the intercept is social carnivore logmass
#all other parameter estimates are comparing herbivore and omnivore logmass while keeping sociality constant
mod2=lm(logmass~trophic+sociality, data=campy)
summary(mod2)
mod2

plot(allEffects(mod2))


#predict function

pr <- with(campy,expand.grid(trophic=unique(trophic),sociality=unique(sociality)))
pr
pr$logmasspred <- predict(mod2,newdata=pr)
pr




ggplot(pp,aes(x=time,y=grahami,colour=light))+
  geom_point()+
  geom_line(aes(group=light))


#Ha=logmass differs across trophic levels and sociality, and there is an interactive effect between these two predictors
#the intercept is still social carnivore logmass
#all other parameter estimates are comparing herbivore and omnivore logmass
#also looks at the interactive effect between sociality and trophic level
mod3=lm(logmass~trophic*sociality, data=campy, na.action=na.exclude)
summary(mod3)
mod3

plot(allEffects(mod3))


#this analysis reveals that when holding sociality constant, the only clear statistical difference
#in logmass is between carnivores and herbivores
lsm1<-emmeans(mod2,pairwise~trophic)
lsm1
pairs(lsm1)
cld(lsm1$emmeans)

#creates new variable in the dataset called 'yhat' which is the predicted values for the model
#I'm getting an error here that the replacement has 92 rows while the data has 120?
#used na.exclude code from stackexchange, got it working
campy$yhat = predict(mod3)
view(campy)

#new dataframe
dd <- with(campy,
           expand.grid(trophic=unique(trophic),
                       sociality=unique(sociality)))

dd

dd$logmass<- predict(mod3,newdata=dd)
view(dd)

#predicted values plot overlaid with raw data points
#I can't figure out why it looks like this though
ggplot(dd,aes(x=trophic,y=logmass,colour=sociality))+ 
  geom_point()
  geom_line(aes(group=trophic))+
  geom_point(data=campy, aes(x=trophic,y=logmass,colour = sociality))



