rm(list=ls())

library(ggplot2)
library(tidyverse)
library(tidyr)

campy <- read.csv('campylobacterreview_data.csv')

ggplot(data=campy, aes(x = urban, y = cjejuni, color=trophic))+
  geom_point(aes(color=trophic)) +
  geom_boxplot()