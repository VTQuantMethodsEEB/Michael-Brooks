rm(list=ls())

#WEEK 10
#loads packages
library(tidyverse)
library(tidyr)
library(ggplot2)
library(emmeans)
library(effects)
library(MASS)
library(broom)
library(clipr)
library(magrittr)

#print function for descriptive statistics
pr <- function(m) printCoefmat(coef(summary(m)),
                               digits=3,signif.stars=FALSE)

#creates dataframe from csv file
campy <- read.csv('campylobacterreview_data.csv')
na.exclude(campy)
head(campy)
campy

#creates log of mass as a new variable
campy$logmass <-log(campy$mass)

#converts cjejuni to factor
campy$cjejuni <- as.factor(campy$cjejuni)

#plots logmass against cjejuni and groups by urban association via color
plot1 <- campy %>%
filter(!is.na(cjejuni)) %>%
  ggplot(aes(x=logmass, y=cjejuni, color=urban)) +
  geom_point(size=3, shape=1)
plot1

#glm for cjejuni presence/absence as predicted by 
#logmass and urban adaptation
#my hypotheses are that urban dwellwers are more likely to carry c jejuni than avoiders
#my second hypothesis is that animals with lower body mass are more likely to carry c jejuni
#mass should be log transformed because otherwise it does not follow a normal distribution
glm1 = glm(cjejuni~logmass+urban,data=campy, family="binomial") %>%
  tidy()%>%
  write_clip()
#output indicates that urban dwellers are 
#more likely to carry c jejuni than urban avoiders
#mass (logmass in this case) does not appear to have an appreciable effect


#second model follows the model above but introduces an interaction term because
#I suspect that logmass is related to urban adaptation
#with smaller species more likely to adapt to urban environments
glm2 = glm(cjejuni~logmass*urban,data=campy, family="binomial")
summary(glm2)
#introducing the interaction term reduces the statistical clarity, indicating that
#there may not be a difference in avoiders vs. dwellers when mass is considered
#as interacting with urban adaptation

#creates new dataframe 
campy.new=expand.grid(mass=seq(from = min(campy$logmass, na.rm=TRUE), to = max(campy$logmass, na.rm=TRUE), length.out = 100),
                    urban = unique(campy$urban))
campy.new

#predicts output for category of input
predict(glm1,newdata = campy.new)

#creates new variable of predicted y aka yhat (probability of infection)
campy.new$yhat  = predict(glm1,type="response",newdata = campy.new)
campy$yhat2 = predict(glm1,type="response")
head(campy.new)
campy.new

#effects output for the binomial glm
summary(allEffects(glm1))
pr(summary(allEffects(glm1)))


#creates second plot of cjejuni presence/absence as predicted by mass and urban association
plot2=ggplot(data=campy,aes(x=mass,y=cjejuni,color=urban))+
  geom_point(size=2,shape =1) +
  geom_line(data=campy.new, aes(x=mass,y=yhat,col=urban))
plot2








#WEEK 11
library(ggplot2)
library(MASS)
library(reshape2)
library(tidyverse)
library(car)
library(AICcmodavg)

