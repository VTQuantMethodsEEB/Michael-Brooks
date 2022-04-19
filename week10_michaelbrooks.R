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
campy = campy %>%
  drop_na(cjejuni)

na.exclude(campy)
head(campy)
campy
unique(campy$cjejuni)
str(campy$cjejuni)
campy$cjejuni = as.numeric(as.character(campy$cjejuni))

#creates log of mass as a new variable
campy$logmass <-log(campy$mass)

#converts cjejuni to factor
#campy$cjejuni <- as.factor(campy$cjejuni)
#you don't want this as a factor!

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
glm1

glm1 = glm(cjejuni~logmass+urban,data=campy, family="binomial") 
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
campy.new=expand.grid(logmass=seq(from = min(campy$logmass, na.rm=TRUE), to = max(campy$logmass, na.rm=TRUE), length.out = 100),
                    urban = unique(campy$urban))
campy.new

#predicts output for category of input
#predict(glm1,newdata = campy.new)


#KL: i fixed this for you - it was logmass vs mass

#creates new variable of predicted y aka yhat (probability of infection)
campy.new$yhat  = predict(glm1,type="response",newdata = campy.new)
#campy$yhat2 = predict(glm1,type="response")
head(campy.new)
campy.new

#effects output for the binomial glm
summary(allEffects(glm1))

#not sure what the below is telling you - doesn't run
#pr(summary(allEffects(glm1)))


#creates second plot of cjejuni presence/absence as predicted by mass and urban association
unique(campy$cjejuni)


plot2=ggplot(data=campy,aes(x=logmass,y=cjejuni,color=urban))+
  geom_point(size=2,shape =1) +
  geom_line(data=campy.new, aes(x=logmass,y=yhat,col=urban))
plot2

#much better! 


#WEEK 11
library(ggplot2)
library(MASS)
library(reshape2)
library(tidyverse)
library(car)
library(AICcmodavg)

#creates a new dataframe with all na values omitted, seemed to resolve some issues
campynaomit <-na.omit(campy)

#creates the models for comparison
#I am interested in a model based only on urban association
#an additive model of urban association and trophic
#the model I had tested earlier, urban association and log of mass
#I am also interested in the effect of trophic level on its own
#null model for comparison
glm1=glm(cjejuni~urban, data=campynaomit, family="binomial")
glm2=glm(cjejuni~urban + trophic, data=campynaomit, family="binomial")
glm3=glm(cjejuni~urban + logmass, data=campynaomit, family="binomial")
# models 2 and 3 are not nested - you can't compare them,
# need to jave urban + trophic or urban interacting with tropic. can't add new vars. 
glm4=glm(cjejuni~1, data=campynaomit, family="binomial")


#you want to move from simple to complex
#likelihood ratio test
anova(glm4,glm1, test="LRT")
anova(glm4, glm2, test="LRT")
anova(glm4, glm3, test="LRT")
anova(glm1, glm2, glm3, glm4, test="LRT")#KL: not all nested - shouldn't use!
#based on the likelihood ratio test, no model appears to be "better" than any other
#in predicting the probabililty of C. jejuni carriage
#KL: 1 is better than 4, 2 is marginally better than 4, 3 is better than 4
#AIC section
AIC(glm1, glm2, glm3, glm4)
#from this output, it appears that glm1 (c jejuni carriage as predicted by urban association)
#has the lowest AIC value (97.6) and therefore provides the most explanatory power
#of the models tested
#this differs from the likelihood ratio test, which does not reveal a significant difference
#between any of the models, although the differences in AIC are relatively small
#based on these small differences I might conclude that none of the models provide
#significantly more explanatory power than the null model

#tabular version of AIC
aictab(cand.set=list(glm1,glm2,glm3,glm4),modnames=c("glm1","glm2","glm3","glm4"))
#this provides AICC values, and since this is a relatively small dataset (<100 with NA values removed)
#this output may be more accurate
