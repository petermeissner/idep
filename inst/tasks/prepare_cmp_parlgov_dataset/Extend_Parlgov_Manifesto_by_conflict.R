# script for extending cmp_parlgov_cabinets.csv dataset 
# with ideological conflict variables


#### Setting things up =========================================================

library(reshape)
library(stringr)
library(foreign)
library(dplyr)

setwd("Z:/Geschäftsordnungen/Database/external_data")


#### generating variables ======================================================

# execute stata file 
fname <- system.file("tasks/prepare_cmp_parlgov_dataset/Extend_Parlgov_Manifesto_by_conflict.do", package = "idep")
system(paste0('"C:/Program Files (x86)/Stata11/Stata-64" /e do ', fname))


# laod data and save as Rdata and csv

parties <- 
  read.dta("cmp_parlgov_parties_ideo_confl.dta") %>% 
  as_data_frame() %>% 
  arrange(country_name_x, election_date, start_date, -cabinet_party) 

write.csv(parties, "cmp_parlgov_parties_ideo_confl.csv")
save(parties, file="cmp_parlgov_parties_ideo_confl.Rdata")
