rm(list=ls())

#packages
library(ggplot2)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(emmeans)
library(effects)
library(MASS)
library(broom)
library(clipr)
library(magrittr)
library(AICcmodavg)

#data
campy <- read.csv('campylobacterreview_data.csv')
campy
head(campy)

#will be doing a GLM for this project
#glm for cjejuni presence/absence as predicted by 
#logmass and urban adaptation
#my hypotheses are that urban dwellwers are more likely to carry c jejuni than avoiders
#my second hypothesis is that animals with lower body mass are more likely to carry c jejuni
#mass should be log transformed because otherwise it does not follow a normal distribution
glm1 = glm(cjejuni~urban + trophic + sociality,data=campy, family="binomial")
glm1
summary(glm1)
#output indicates that urban visitors, avoiders, and dwellers are more likely to carry c. jejuni than avoiders
#also indicates that omnivores are more likely to carry c.jejuni than carnivores

#model with urban association and trophic level
glm2=glm(cjejuni ~ urban + trophic, data=campy, family="binomial")
glm2
summary(glm2)
#output suggests similar conclusions to the first model, although the AIC is now lower

#model with just urban association
glm3=glm(cjejuni ~ urban, data=campy, family="binomial")
glm3
summary(glm3)
#similar trends to the first two models, higher AIC than model 2


#model with just trophic level
glm4=glm(cjejuni ~ trophic, data=campy, family="binomial")
glm4
summary(glm4)
#higher AIC, but consistent in that omnivores are more likely to carry c jejuni

#model comparison
aictab(cand.set=list(glm1,glm2,glm3,glm4),modnames=c("cjejuni ~ urban + trophic + sociality","cjejuni ~ urban + trophic","cjejuni ~ urban","cjejuni ~ trophic"))

#creates a plot of the predicted probability for each level of the input variables for model 1
plot(allEffects(glm1))

