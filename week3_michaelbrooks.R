rm(list=ls()) #clears workspace

#loads packages
library(ggplot2)
library(gridExtra)
library(viridis)
library(tidyverse)
library(reshape2)
library(tidyr)

#reads csv file from my meta-analysis data into workspace
campylobacter <- read.csv("campylobacterreview_data.csv")
#first 6 rows
head(campylobacter)

#is there a more efficient way to do this part than including it in my code every week?
campylobacter$cjejuni <- as.factor(campylobacter$cjejuni) #force cjejuni variable into a factor
campylobacter$ccoli <- as.factor(campylobacter$ccoli) #force ccoli variable into a factor
campylobacter$campy <- as.factor(campylobacter$campy) #force campylobacter variable into a factor

#creates a dot plot of trophic level on the x axis and mass (in grams) on the y axis 
#the color command further breaks it down by cjejuni presence/absence
#was getting a weird graph with the 'NA' values, but used stackexchange advice below!
m1 <- campylobacter %>%
  filter(!is.na(cjejuni)) %>%
  ggplot(aes(x = trophic, y = mass, color=cjejuni))+
  geom_point(size=1.5)
m1

#log transforms mass because there is a large amount of variation across taxa
campylobacter$logmass <- log(campylobacter$mass)

#boxplot of urban association on the x axis and mass on the y axis
#creates two boxplots at levels of urban assocation according to cjejuni presence/absence
#also added the points back in to help with visualization
#also changed the default x and y axis labels to better explain the variables
m2<- campylobacter %>%
  filter(!is.na(cjejuni)) %>%
  ggplot(aes(x = urban, y = logmass))+
  geom_boxplot()+
  geom_point(aes(color=cjejuni)) +
  xlab ("Urban behavior") +
  ylab ("Log of body mass")
m2

#violin plot of trophic on the x axis and mass on the y axis
#creates two boxplots at levesl of trophic level according to campy presence/absence
#also added the points back in to help with visualization
#also changed the default x and y axis labels to better explain the variables
m3<- campylobacter %>%
  filter(!is.na(campy)) %>%
  ggplot(aes(x = trophic, y = logmass))+
  geom_violin()+
  geom_point(aes(color=campy)) +
  xlab ("Trophic") +
  ylab ("Log of body mass")
m3

#bar plot for visualization of categorical values
#urban dwellers/visitors seem much more likely to carry c jejuni
#just an eyeball test but there is likely something there
#Also changed the legend title and used proportion on the y axis
#this allows better visualization of the data in my opinion
#I can't figure out how to change the legend text, basically changing 0 to absence just for the graph
m4 <- campylobacter %>%
  filter(!is.na(cjejuni)) %>%
  ggplot(aes(x=urban, fill=cjejuni))+
  geom_bar(position="fill") +
  theme_bw()+
  theme (panel.grid=element_blank(),
         legend.position="bottom")+
  scale_fill_brewer(palette="YlOrRd") +
  guides(fill=guide_legend(title="Campylobacter jejuni presence/absence")) +
  xlab("Urban association") +
  ylab ("Proportions")
m4

#bar plot for visualization of categorical values
#a similar pattern exists for the campylobacter genus
#maybe not quite as much of a difference between avoiders and dwellers/visitors
#compared to c jejuni presence/absence
m5 <- campylobacter %>%
  filter(!is.na(campy)) %>%
  ggplot(aes(x=urban, fill=campy))+
  geom_bar() +
  theme_bw()+
  theme (panel.grid=element_blank())+
  xlab ("Urban association")
m5

#saves my fourth plot
ggsave(file="cjejuni_urban_bar chart.pdf", 
       plot=m4,
       width=7,height=7,units="in",
       useDingbats=FALSE)










