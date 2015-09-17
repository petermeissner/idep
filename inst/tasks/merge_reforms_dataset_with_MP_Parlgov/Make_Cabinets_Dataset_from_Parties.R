
# script for boiling down and aggregating party data set to cabinets ===========


#### setting things up =========================================================

library(idep)
library(stringr)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database//external_data/Manifesto Project and ParlGov/")


#### load data =================================================================

# parties data
load("cmp_parlgov_parties_ideo_confl.Rdata")
parties <- as_data_frame(parties)



#### boil parties down to cabinets =============================================

cabinets <- 
  parties  %>% 
  select(
    countryname          ,
    election_date        ,
    start_date           ,
    cabinet_name         ,
    cabinet_id           ,
    previous_cabinet_id  ,
    election_seats_total ,
    pervote              ,
    voteest              ,
    presvote             ,
    absseat              ,
    totseats             ,
    seats_gov_b          ,
    seats_gov            ,
    seat_share_gov       ,
    seats_opp_b          ,
    seats_opp            ,
    seat_share_opp       ,
    ideal_gov            ,
    ideal_gov_2          ,
    polar_gov_1          ,
    polar_gov_2          ,
    polar_gov            ,
    range_opp_2          ,
    range_opp            ,
    ideal_opp_2          ,
    polar_opp_1          ,
    polar_opp_2          ,
    polar_opp            ,
    ideal_gov_tot        ,
    ideal_opp_tot        ,
    opp_gov_dist_a       ,
    ideal_gov_b          ,
    opp_gov_dist_b       ,
    dist_b 
  )

for (cab in unique(cabinets$cabinet_id) ) {
  iffer <- cabinets$cabinet_id == cab
  cabinets$seats_opp_b[iffer]     <- max(cabinets$seats_opp_b[iffer], na.rm=TRUE)
  cabinets$seat_share_opp[iffer]  <- max(cabinets$seat_share_opp[iffer], na.rm=TRUE)
  cabinets$range_opp_2[iffer]     <- max(cabinets$range_opp_2[iffer], na.rm=TRUE)
  cabinets$ideal_opp_2[iffer]     <- max(cabinets$ideal_opp_2[iffer], na.rm=TRUE)
  cabinets$polar_opp_1[iffer]     <- max(cabinets$polar_opp_1[iffer], na.rm=TRUE)
}

cabinets <- 
  cabinets %>% 
  group_by(cabinet_id) %>%
  slice(1) %>% 
  group_by() %>% 
  arrange(countryname, election_date, start_date)

# cabinets  %>% head




#### save data =================================================================

save(cabinets, file="cmp_parlgov_cabinets_ideo_confl.Rdata")
write.csv(cabinets, "cmp_parlgov_cabinets_ideo_confl.csv")
write.dta(cabinets, "cmp_parlgov_cabinets_ideo_confl.dta")


















