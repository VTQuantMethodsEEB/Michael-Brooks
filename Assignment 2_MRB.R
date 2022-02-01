rm(list=ls()) # clears workspace


#load necessary packages
library(tidyverse)
library(reshape2)
library(tidyr)

Campylobacter <- read.csv("campylobacterreview_data.csv") #reads csv file from my meta-analysis data into workspace
head(Campylobacter) #first 6 rows
hist(Campylobacter$mass, breaks=150) #histogram of weights

Campylobacter$cjejuni <- as.factor(Campylobacter$cjejuni) #force cjejuni variable into a factor
levels(Campylobacter$cjejuni) #levels of cjejuni variable

Campylobacter$ccoli <- as.factor(Campylobacter$ccoli) #force ccoli variable into a factor
levels(Campylobacter$ccoli) #levels of ccoli variable

Campylobacter$campylobacter <- as.factor(Campylobacter$campylobacter) #force campylobacter variable into a factor
levels(Campylobacter$campylobacter) #levels of campylobacter variable

view(Campylobacter) #pulls up Campylobacter table

#group by campylobacter and mean mass (in grams)
Campylobacter %>%
  group_by(campylobacter) %>%
  summarise(mean.mass=mean(mass, na.rm=TRUE))

#group by cjejuni and mean mass (in grams)
Campylobacter %>%
  group_by(cjejuni) %>%
  summarise(mean.mass=mean(mass, na.rm=TRUE))

#group by ccoli and mean mass (in grams)
Campylobacter %>%
  group_by(ccoli) %>%
  summarise(mean.mass=mean(mass, na.rm=TRUE))



