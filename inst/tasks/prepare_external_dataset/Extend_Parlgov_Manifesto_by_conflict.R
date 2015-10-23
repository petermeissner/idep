# script for extending cmp_parlgov_cabinets.csv dataset 
# with ideological conflict variables


#### Setting things up =========================================================

library(reshape)
library(stringr)
library(foreign)
library(idep)
library(dplyr)


setwd("Z:/Gesch\xe4ftsordnungen/Database/external_data")


#### load data =================================================================

load("cmp_parlgov_parties.Rdata")


#### generating general variables ==============================================

parties <- 
  parties  %>% 
  mutate(
    seats_share   = (seats / seats_total),
    seats_percent = (seats / seats_total) * 100,
    idl = left_right_cmp
  )

  

#### generating ideology variables =============================================

# all : 
# ideal point, 
# range        : absolute difference between min and max idealogy point
# polarization : weighted sum of deviations from ideological mean
# distance     : idealogical weighted mean distance between ideal point of 
#                government and each opposition party
#                = sum( (p_gov - p_opp_i) * p_opp_i_share )


# seats government, opposition, government-opposition
tmp <- 
  aggregate(
    list(
      seats  = parties$seats
    ), 
    list(
      cabinet_id    = parties$cabinet_id, 
      cabinet_party = parties$cabinet_party
    ), 
    sum
  )

seats_opp <- 
  tmp %>% 
  filter(cabinet_party==0)  %>% 
  select(-cabinet_party) 
names(seats_opp)[-1] <- paste0(names(seats_opp)[-1], "_opp")

parties <- 
  left_join(parties, seats_opp, by="cabinet_id")


seats_gov <- 
  tmp %>% 
  filter(cabinet_party==1)  %>% 
  select(-cabinet_party) 
names(seats_gov)[-1] <- paste0(names(seats_gov)[-1], "_gov")

parties <- 
  left_join(parties, seats_gov, by="cabinet_id")


parties$seats_gop <- ifelse(parties$cabinet_party==1, parties$seats_gov, parties$seats_opp)

parties$seats_opp <- ifelse(parties$cabinet_party==0, parties$seats_opp, NA)
parties$seats_gov <- ifelse(parties$cabinet_party==1, parties$seats_gov, NA)

parties$seats_share_opp <- parties$seats / parties$seats_opp
parties$seats_share_gov <- parties$seats / parties$seats_gov
parties$seats_share_gop <- parties$seats / parties$seats_gop

# parties  %>% select(cabinet_name, contains("seats")) %>% head



# idl point, range, polarization all
parties <- 
  parties  %>% 
  group_by(cabinet_id) %>% 
  mutate(
    idl_pnt_all = sum( idl * seats_share ),
    idl_rng_all = diff( range( idl ) ),
    idl_pol_all = sum(  abs(   idl - idl_pnt_all ) * seats_share )
  )


parties <- 
  parties  %>% 
  group_by(cabinet_id, cabinet_party) %>% 
  mutate(
    idl_pnt_gov = sum( idl * seats_share_gov ),
    idl_rng_gov = diff( range( idl * cabinet_party ) ),
    idl_pol_gov = sum(  abs( idl - idl_pnt_gov ) * seats_share_gov ),
    idl_pnt_opp = sum( idl * seats_share_opp ),
    idl_rng_opp = diff( range( idl * !cabinet_party ) ),
    idl_pol_opp = sum(  abs( idl - idl_pnt_opp ) * seats_share_opp )
  ) 

parties <- 
  parties  %>% 
  group_by(cabinet_id) %>% 
  mutate(
    idl_pnt_gov  = max( idl_pnt_gov, na.rm=TRUE),
    idl_dist_gop = mean( abs(idl_pnt_gov - idl)*seats_share_opp, na.rm=TRUE)
  ) 

# parties  %>%  filter(ctr=="AUT")  %>% select(cabinet_name, seats_share_opp, seats_share_gov, seats_share_gop, contains("idl"))  %>% head
parties <- 
  parties %>% 
  group_by(cabinet_id) %>% 
  mutate(
    seats_opp = max(seats_opp, na.rm=T),
    seats_gov = max(seats_gov, na.rm=T),
    idl_pnt_gov  = max(idl_pnt_gov, na.rm=T),
    idl_rng_gov  = max(idl_rng_gov, na.rm=T),
    idl_pol_gov  = max(idl_pol_gov, na.rm=T),
    idl_pnt_opp  = max(idl_pnt_opp, na.rm=T),
    idl_rng_opp  = max(idl_rng_opp, na.rm=T),
    idl_pol_opp  = max(idl_pol_opp, na.rm=T),
    idl_dist_gop = max(idl_dist_gop, na.rm=T),
    n_parties    = sum(!is.na(cabinet_party))
  ) %>% 
  select(-seats_share_gop, -seats_share_gov, -seats_share_opp, -seats_gop)


#### save ======================================================================

write.dta( parties,        "cmp_parlgov_parties_ideo_confl.dta" )
write.csv( parties,        "cmp_parlgov_parties_ideo_confl.csv" )
save(      parties, file = "cmp_parlgov_parties_ideo_confl.Rdata" )



