Michael-Brooks
Meta-analysis data for campylobacter in wild mammals

# Paragraph about data

This dataset is from a meta-analysis that I did looking at the relationship between life history traits and Campylobacter carriage. Papers were retrieved indicating the presence or absence of Campylobacter in 
an animal species and the data were recorded in a database. Sample sizes ranged from 1 to more than 
1000, so each record was transformed from a proportion to a binary variable (0 for absence, 1 for 
presence). This was recorded for Campylobacter jejuni, Campylobacter coli, and the Campylobacter 
genus depending on how the study was conducted. If no data could be found at the species level for 
Campylobacter, it was recorded as ‘NA’. For life history data, I used the framework from Santini et al. 
(2019) to assign the animal species to urban ‘dweller’, ‘avoider’, or ‘visitor’. For trophic level and 
sociality, I utilized the PanTHERIA database (Jones et al. 2009) to assign an animal species to a category. 
Finally, for human consumption I utilized the IUCN red list (https://www.iucnredlist.org/). If a species 
was not located in any of the databases, a literature search was conducted to locate this information. 
This manuscript has already been submitted to a journal and I have previously analyzed relationships 
between life history traits and Campylobacter carriage using chi-squared analysis. However, I would like 
to explore the data a bit more and use transformation to look for interesting patterns. As all of my data 
are categorical currently, I will likely have to do something to it to make the analyses work. If this is not 
feasible, I will look for some other data from a public repository. I don’t currently have data for my 
proposed thesis topic unfortunately because I have not made it out to the field yet

# Week 1: intro to R.

Script: week1_michaelbrooks.r

Data: campylobacterreview_data.csv

This week I pulled my Campylobacter dataset into the workspace. I called rows and columns and aggregated data using several functions (sum, mean, length). I also created a new table using columns from the dataset (urban and campylobacter presence/absence data). 

# Week 2: tidyverse, data input and checking for mistakes

Script: week2_michaelbrooks.r

Data: campylobacterreview_data.csv

In this script I forced campylobacter, cjejuni, and ccoli variables into becoming factors rather than integers because they are binary data. I made a histogram of the new variable that I created (mass, in grams). I used group_by to summarize mass data using campylobacter, cjejuni, and ccoli variables, also repeated with trophic levels. I also created a new tibble using the mutate function to create a new variable mean.mass.campy, which is mean mass for campy infection status. After looking at the data, I'm starting to suspect mass may be an important variable related to life history traits. 

# Week 3: data visualization

Script: week3_michaelbrooks.r

Data: campylobacterreview_data.csv

In this script I created several plots for visualization of my data. I used the example script to create several boxplots that allowed me to use my quantitative variable (mass) to examine several different connections between my categorical variables. I also created several bar charts to explore the relationship between the categorical variables used. 

#week 5: hypothesis testing and permutations

Script: week5_michaelbrooks.r

Data: campylobacterreview_data.csv

I tested two hypotheses
1. The mean mass of urban avoiders is higher than urban dwellers. This is intuitive as larger species should have a harder time adapting to an urban environment, but it was nice to see support for this. For this test I used a permutation and T-test.

2. Probability of Campylobacter jejuni carriage differs between urban avoiders and urban dwellers. For this hypothesis, I used a Fisher's exact test and 2x2 contingency table. 

#week 8: simple linear regression

Script: week8_michaelbrooks.r
Data: campylobacterreview_data.csv

I created a simple linear regression using a categorical predictor variable (trophic level) and a continuous output variable (mass). From this analysis, carnivores appear to differ significantly in weight from herbivores and omnivores (they are lighter than these two trophic levels). Just eyeballing the data, I suspect that the shrews are weighting things, so I don't know that these results are general. I also concluded that mass is often skewed, so log transformation is key to creating a normal distribution for regression analysis. I also created an additive model with trophic level and sociality as well as an interactive model between these two variables. Finally, I attempted to plot to predicted values against the raw values, but this didn't visually look great. 

#week 10/11

Script: week10_michaelbrooks.r
Data: campylobacterreview_data.csv

I created a generalized linear model to assess the effect of urban association and mass (log 10 for normalization) on Campylobacter jejuni carriage. From the first model (additive) only, it can be seen that there is a statistically signigicant difference between urban avoiders and dwellers on the probability of Campylobacter carriage. Mass (or the log version of it) does not appear to have a significant effect on Campylobacter carriage, however, based on the models that I have created. 

