
# script for boiling down and aggregating party data set to cabinets ===========


#### setting things up =========================================================

library(idep)
library(stringr)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database/external_data")


#### load data =================================================================

# parties data
load("cmp_parlgov_parties_ideo_confl_volatility.Rdata")
parties <- as_data_frame(parties)



#### boil parties down to cabinets =============================================

cabinets <- 
  parties  %>% 
  group_by(cabinet_id) %>%
  slice(1) %>% 
  group_by() %>% 
  arrange(country, election_date, start_date) %>% 
  rename(
    cab_name_pg    = cabinet_name,
    cab_id_pg      = cabinet_id,
    cab_id_prev_pg = previous_cabinet_id,
    el_id_pg       = election_id,
    el_first_pg    = first_election,
    sts_tot_pg     = seats_total,
    cab_start_pg   = start_date, 
    el_date_pg     = election_date
  ) %>% 
  select(
    -prime_minister, -seats, -cmp, -cabinet_party, 
    -country_id, -seats_share, -seats_percent, votes_percent,
    -party_id, -volatility_pi, -left_right_cmp, -votes_percent
  ) %>% 
  mutate(
    ctr = tolower(ctr)
  )
cabinets <- cabinets[ , sort(names(cabinets)) ]




#### save data =================================================================

save(cabinets, file="cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
write.csv(cabinets, "cmp_parlgov_cabinets_ideo_confl_volatility.csv")
write.dta(cabinets, "cmp_parlgov_cabinets_ideo_confl_volatility.dta")


















