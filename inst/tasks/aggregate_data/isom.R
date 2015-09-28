# script for joining / merging erd, reforms, parlgov, 


#### setting things up 

setwd("z:/gesch\u00e4ftsordnungen/database/aggregats/")

library(idep)
library(dplyr)
library(foreign)


#### loading data

load("reforms.Rdata")
reforms[,1:8]

load("../external_data/erd_cleaned_up.Rdata")
erd[,1:11]
erd <- 
  erd %>% 
  mutate(
    erd_cab_id = cab_id
  )

load("../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
cabinets[,1:10]


#### merging data

isord <- 
  erd  %>% 
  left_join(cabinets, by="erd_pg_mp_matcher")  %>% 
  left_join(reforms,  by="erd_cab_id") %>% 
  mutate(
    country = country.x,
    ctr     = ctr.x
  ) %>% 
  select(-country.x, -country.y, -ctr.x, -ctr.y)

# t(as_data_frame(classes(isord)))


#### saving data

save(     isord, file="isord.Rdata")
write.dta(isord, file="isord.dta")
write.csv(isord, file="isord.csv")













