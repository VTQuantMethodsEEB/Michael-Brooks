# Michael-Brooks
Meta-analysis data for campylobacter in wild mammals

This dataset is from a meta-analysis that I did looking at the relationship between life history traits and 
Campylobacter carriage. Papers were retrieved indicating the presence or absence of Campylobacter in 
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
proposed thesis topic unfortunately because I have not made it out to the field yet. 