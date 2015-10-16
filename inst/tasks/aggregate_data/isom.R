# script for joining / merging erd, isor, parlgov, 


#### setting things up 

setwd("z:/gesch\u00e4ftsordnungen/database/aggregats/")

library(idep)
library(dplyr)
library(foreign)


#### loading data

load("isor.Rdata")
isor[,1:8]

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

isom <- 
  erd  %>% 
  left_join(cabinets, by="erd_pg_mp_matcher")  %>% 
  left_join(isor,  by="erd_cab_id") %>% 
  mutate(
    country = country.x,
    ctr     = ctr.x
  ) %>% 
  select(-country.x, -country.y, -ctr.x, -ctr.y)

#### setting NAs right

isom$eff_no_upper  <- ifelse(isom$eff_no_upper  ==88888, NA, isom$eff_no_party)
isom$cab_seats_upp <- ifelse(isom$cab_seats_upp ==88888, NA, isom$cab_seats_upp)
isom$seats_upp     <- ifelse(isom$seats_upp ==88888, NA, isom$seats_upp)
isom$cab_dur_abs1  <- ifelse(isom$cab_dur_abs1 ==99999, NA, isom$cab_dur_abs1)
isom$abs_no_party  <- ifelse(isom$abs_no_party==88888, NA, isom$abs_no_party)
isom$abs_no_party_seat_plus  <- ifelse(isom$abs_no_party_seat_plus==88888, NA, isom$abs_no_party_seat_plus)
isom$cab_n_members_change    <- ifelse(isom$cab_n_members_change==88888, NA, isom$cab_n_members_change)
isom$connect_cab   <- ifelse(isom$connect_cab==88888, NA, isom$connect_cab)
isom$mwc_connected_cab       <- ifelse(isom$mwc_connected_cab==88888, NA, isom$mwc_connected_cab)
isom$seats_low    <- ifelse(isom$seats_low==88888, NA, isom$seats_low)
isom$cab_dur_100  <- ifelse(isom$cab_dur_100==88888, NA, isom$cab_dur_100)




#### expanding isor data for missing values (if applicaple)

isom <- 
  isom  %>% 
  arrange(country, cab_in)

describe(isom, cols=90:120)

# fill holes with lag values 
for(i in seq_len(dim(isom)[1]) ){
  isom$t_id[i] <- 
    ifelse( 
      is.na(isom$t_id[i]) & isom$ctr[i] == lag(isom$ctr)[i], 
      lag(isom$t_id)[i], 
      isom$t_id[i] 
    )                   
}


# fill start values with SOs before cabinet
for ( i in which(is.na(isom$t_id)) ){
  isom$t_id[i] <- 
    suppressWarnings(
      max(isor$t_id[ isor$ctr == isom$ctr[i] & 
                       isor$t_date <= isom$cab_out[i] ]        ,
          na.rm=TRUE))
}

variables <- 
  names(isom)[
    names(isom) %in% names(isor) & 
      !(names(isom) %in% c("ctr", "country", "t_id"))
    ]

isom <- 
  isom[ , -which(names(isom) %in% variables)]

isom <- 
  left_join( isom, isor[, c("t_id", variables)], by="t_id" )


isom %>% 
  select(ctr, cab_in, t_id, wds_clean_rel, wds_chg)  %>% 
  head(50)

# NAs to 0 for all change variables
for (var in grep("_del|_ins|_mdf|_chg", names(isom), value = TRUE) ) {
  isom[is.na(isom[, var]) & !is.na(isom$wds_raw_all), var] <- 0 
}

# non-change to 0 for all change varaibles
var <- grep("_del|_ins|_mdf|_chg", names(isom), value = TRUE)
for (i in seq_len(dim(isom)[1])[-1] ) {
  if ( isom$t_id[i] == isom$t_id[i-1] & all(!is.na(isom$t_id[i:(i-1)])) ){
    isom[i, "wds_chg"] <- 0 
  }
  if ( isom$ctr[i] == isom$ctr[i-1] & is.na(isom$t_id[i-1]) ){
    isom[i, "wds_chg"] <- NA
  }
}


# overview
describe(isom, cols=90:120)

isom %>% 
  select(ctr, cab_in, cab_out, t_id, wds_clean_all, wds_chg)  %>% 
  head(50)





#### saving data
save(     isom, file="isom.Rdata")
write.dta(isom, file="isom.dta")







