library(readr)
urlfile="https://raw.githubusercontent.com/VTQuantMethodsEEB/clockett/main/All_nozero.csv?token=GHSAT0AAAAAABUBJPRSCEUGEU4IRTQZQQCIYTK2W3Q"

All<-read_csv(url(urlfile))

All<- data.frame(read.csv(file='All_nozero.csv', header=TRUE))
head(All)
library(tidyverse)
All.sum=All%>% 
  group_by(SITE,SPEC,STREAM)%>% 
  summarize(n.STREAM=n())%>%  
  filter(SPEC=="scio"|SPEC=="bart")#created a new dataframe going by site, species, and stream and filtering off two species to use for permutations. 

obs = mean(All.sum$n.STREAM[All.sum$SPEC=="scio"])-mean(All.sum$n.STREAM[All.sum$STREAM=="bart"])

set.seed(350) #set the seed to a random number 
res <- numeric(1000)# did the same with res
comb_SS =c(All.sum$SPEC,All.sum$STREAM)
sample(comb_SS,4, replace=F)
for (i in 1:10000) {
  Allboot <- sample(All.sum$n.STREAM) ## scramble
  scioboot=Allboot[1:length(All.sum$SPEC[All.sum$SPEC=="scio"])] #Used the amountof scio as comparison
  bartboot=Allboot[(length(All.sum$SPEC[All.sum$SPEC=="scio"])+1):length(All.sum$SPEC)] #Used the lenght of everything else (bart)
  
  
  res[i]=mean(scioboot)-mean(bartboot)#Looking at the mean difference between the two 
}

res

#MB: it seems to run fine up to this point

hist(res, col="gray", las=1, main="")
abline(v=obs, col="red")

mean(res>=obs)
2*mean(res>=obs) 
mean(abs(res)>=abs(obs))

#MB: I can't get this permutation test to run, maybe it has something to do with the seed?

#Part 2 linear models 
mod1 <- lm(CL~SPEC+STREAM, data = All)#This is creating a model looking at the different streams  and then seeing if that affects the amount of crayfish that would appear
summary(mod1)#From the summary their is a alarge portion of CL data coming from sink
plot(mod1)     
library(ggplot2)
All$yhat=predict(mod1)
ggplot(data=All,aes(x=SPEC,y=CL,color=STREAM))+ 
  geom_point()+
  geom_boxplot(data=All,aes(x=SPEC,y=yhat,color=STREAM)) 
#MB: this is an interesting graph, a little bit busy which might throw people off
#but does give the reviewer a good visualization of patterns in the data

mod2 <- lm(CL~SPEC*STREAM, data = All)#This is creating a model looking at the different streams  and then seeing if that affects the amount of crayfish that would appear
summary(mod2)#From the summary the p-values I got from smaller than 0.05. Providing evidence for my hypothesis of the larger the CL the more C_fallax would appear
plot(mod2)     
All$Yhat2=predict(mod2)
ggplot(data=All,aes(x=SPEC,y=CL,color=STREAM))+
  geom_point()+
  geom_line(data=All,aes(x=SPEC,y=Yhat2,color=STREAM)) 
#MB: there are some issues getting this plot up and running. The code seems like it should work because the chunk above ran fine. 

#Part 3 mixed model  
library(MASS)
library(reshape2)
library(lme4)

unique(All$SPEC) 
Allb = All %>%
  filter(SPEC!='b')

lm1 <- lmer(CL~SPEC + (1|STREAM),All) ## rand intercept
summary(lm1)
594-8-6# obs minus number of streams minus number of spec of crayfish 
#580  
t.value=2.499  
p.value = 2*pt(t.value, df = 580, lower=FALSE)
Allb$shat3=predict(lm1,type="response",re.form=NA)
#MB: ran into issues running this code, not sure if there's something that I'm not doing right
#seems to be a mismatch between sample sizes?
plot1=ggplot(data=Allb,aes(x=SPEC,y=CL))+
  geom_point(size=2,shape =1) +
  geom_point(data=Allb ,aes(x=SPEC,y=yhat),color="red")
plot1 

#this is a good plot, but it would be nice to have a legend of some kind
