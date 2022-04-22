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

