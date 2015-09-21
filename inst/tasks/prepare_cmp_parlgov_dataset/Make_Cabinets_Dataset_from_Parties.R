
# script for boiling down and aggregating party data set to cabinets ===========


#### setting things up =========================================================

library(idep)
library(stringr)
library(dplyr)
library(foreign)


setwd("Z:/Geschäftsordnungen/Database/external_data")


#### load data =================================================================

# parties data
load("cmp_parlgov_parties_ideo_confl_volatility.Rdata")
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
    #election_seats_total ,
    #pervote              ,
    #voteest              ,
    #presvote             ,
    #absseat              ,
    #totseats             ,
    #seats_gov_b          ,
    seats,
    seats, 
    seats_gov            ,
    seat_share_gov       ,
    #seats_opp_b          ,
    seats_opp            ,
    seat_share_opp       ,
    ideal_gov            ,
    #ideal_gov_2          ,
    #polar_gov_1          ,
    #polar_gov_2          ,
    polar_gov            ,
    #range_opp_2          ,
    range_opp            ,
    #ideal_opp_2          ,
    #polar_opp_1          ,
    #polar_opp_2          ,
    polar_opp            ,
    ideal_gov_tot        ,
    ideal_opp_tot        ,
    #opp_gov_dist_a       ,
    #ideal_gov_b          ,
    #opp_gov_dist_b    ,   
    #dist_b ,
    volatility, 
    first_election
  )




cabinets <- 
  cabinets %>% 
  group_by(cabinet_id) %>%
  slice(1) %>% 
  group_by() %>% 
  arrange(countryname, election_date, start_date)

cabinets  %>% head(20)




#### save data =================================================================

save(cabinets, file="cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
write.csv(cabinets, "cmp_parlgov_cabinets_ideo_confl_volatility.csv")
write.dta(cabinets, "cmp_parlgov_cabinets_ideo_confl_volatility.dta")


















