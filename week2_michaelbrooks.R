rm(list=ls()) # clears workspace


#loads necessary packages
library(tidyverse)
library(reshape2)
library(tidyr)

campylobacter <- read.csv("campylobacterreview_data.csv") #reads csv file from my meta-analysis data into workspace
head(campylobacter) #first 6 rows
hist(campylobacter$mass, breaks=150) #histogram of weights

unique(campylobacter$cjejuni) #unique values for cjejuni variable (0=absence, 1=presence, NA=no data)
unique(campylobacter$family) #unique values for family variable
str (campylobacter$mass) #structure of the mass variable (numeric, continuous)

campylobacter$cjejuni <- as.factor(campylobacter$cjejuni) #force cjejuni variable into a factor
str(campylobacter$cjejuni) #structure of cjejuni variable

campylobacter$ccoli <- as.factor(campylobacter$ccoli) #force ccoli variable into a factor
str(campylobacter$ccoli) #structure of ccoli variable

campylobacter$campy <- as.factor(campylobacter$campy) #force campylobacter variable into a factor
str(campylobacter$campy) #structure of campylobacter variable

#KL: why are you making these factors?
#KL: some issues here with name changes and capitalization

view(campylobacter) #pulls up Campylobacter table

#group by campylobacter and mean mass (in grams)
campylobacter %>%
  group_by(campy) %>% #KL: maybe you are doing this to use group_by
  summarise(mean.mass=mean(mass, na.rm=TRUE))

#group by cjejuni and mean mass (in grams)
campylobacter %>%
  group_by(cjejuni) %>%
  summarise(mean.mass=mean(mass, na.rm=TRUE))

#group by trophic and mean mass (in grams)
campylobacter %>%
  group_by(trophic) %>%
  summarise(mean.mass=mean(mass, na.rm=TRUE))

#adds a new column mean.mass.campy to a new tibble, groups mean mass by campy infection status
campylobacter_mutated = campylobacter %>%
  group_by(campy) %>%
  mutate(mean.mass.campy=mean(mass, na.rm=TRUE))

#first 6 rows
head(campylobacter_mutated)
view(campylobacter_mutated)

#creates a new variable in the campylobacter_mutated dataframe, difference (different between species mass and average mass for campy infection status)
campylobacter_mutated$difference <- (campylobacter_mutated$mass - campylobacter_mutated$mean.mass.campy)





