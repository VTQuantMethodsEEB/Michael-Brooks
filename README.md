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