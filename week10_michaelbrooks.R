rm(list=ls())

#loads packages
library(tidyverse)
library(tidyr)
library(ggplot2)
library(emmeans)
library(effects)
library(MASS)

#creates dataframe from csv file
campy <- read.csv('campylobacterreview_data.csv')
head(campy)

campy$logmass <-log(campy$mass)

campy$cjejuni <- as.factor(campy$cjejuni)

plot1 <- campy %>%
filter(!is.na(cjejuni)) %>%
  ggplot(aes(x=logmass, y=cjejuni, color=urban)) +
  geom_point(size=3, shape=1)
plot1

#glm for cjejuni presence/absence as predicted by logmass and urban adaptation
glm1 = glm(cjejuni~mass+urban,data=campy, family="binomial");
summary(glm1)

#
campy.new=expand.grid(mass=seq(from = min(campy$mass),to = max(campy$mass), length.out = 100),
                    urban = unique(campy$urban))
campy.new

predict(glm1,newdata = campy.new)

campy.new$yhat  = predict(glm1,type="response",newdata = campy.new)
campy$yhat2 = predict(glm1,type="response")
head(campy.new)


hist(campy$mass)

