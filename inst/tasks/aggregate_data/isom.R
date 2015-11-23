# script for joining / merging erd, isor, parlgov, 


#### setting things up =========================================================

setwd("z:/gesch\u00e4ftsordnungen/database/aggregats/")  

library(idep)
library(dplyr)
library(foreign)


#### loading data ==============================================================

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


#### merging data ==============================================================

#### !!!! sicher gehen, dass first versions ebenfalls angematched werden

isom <- 
  erd  %>% 
  left_join(cabinets, by="erd_pg_mp_matcher")  %>% 
  left_join(isor,  by="erd_cab_id") %>% 
  mutate(
    country = country.x,
    ctr     = ctr.x
  ) %>% 
  select(-country.x, -country.y, -ctr.x, -ctr.y)

#### setting NAs right =========================================================

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




# overview
desc_df(isom, cols=90:120)

isom %>% 
  select(ctr,cab_id, cab_pm, cab_in, cab_out, t_id, wds_clean_all, wds_chg)  %>% 
  head(50)



#### saving non aggregated data for later ======================================

isom_non_agg <- isom




#### aggregation ===============================================================
source(
  system.file(package="idep","tasks/aggregate_data/isom_helper_aggregation.R")
)


#### dichotomize pro_maj / pro_min codings =====================================

isom %>% 
  filter( pro_min_sum > 0, pro_maj_sum > 0 ) %>% 
  select(ctr, cab_id, cab_pm, pro_maj_sum, 
         pro_min_sum, pro_non_sum, pro_minmaj_qual_sum )

isom$pro_minmaj_qual <-
  sapply(
    str_split(isom$pro_minmaj_qual_sum, ", "), 
    function(x){ 
      x <- unique(x[ x != "NA" & !is.null(x) ])
      if( length(x)     ==     0      ) return(  0 )
      if( all(unique(x) ==     0     )) return(  0 )
      if( all(unique(x) %in% c(0, 1) )) return(  1 ) 
      if( all(unique(x) %in% c(0,-1) )) return( -1 )
      -99
    } 
  )

isom$pro_minmaj_qual[isom$cab_id==1720] <- -1
isom$pro_minmaj_qual[isom$cab_id==1622] <-  1
isom$pro_minmaj_qual[isom$cab_id==1329] <- -1 
isom$pro_minmaj_qual[isom$cab_id==1042] <- -1
isom$pro_minmaj_qual[isom$cab_id==1710] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1718] <-  0
isom$pro_minmaj_qual[isom$cab_id==1719] <- -1
isom$pro_minmaj_qual[isom$cab_id==1723] <-  0 
isom$pro_minmaj_qual[isom$cab_id==1410] <- -1
isom$pro_minmaj_qual[isom$cab_id==1214] <-  0
isom$pro_minmaj_qual[isom$cab_id==1221] <-  0
isom$pro_minmaj_qual[isom$cab_id==1224] <-  0
isom$pro_minmaj_qual[isom$cab_id==228]  <-  1 
isom$pro_minmaj_qual[isom$cab_id==527]  <-  0
isom$pro_minmaj_qual[isom$cab_id==613]  <-  2
isom$pro_minmaj_qual[isom$cab_id==925]  <-  1 
isom$pro_minmaj_qual[isom$cab_id==1005] <-  1
isom$pro_minmaj_qual[isom$cab_id==1036] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1038] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1328] <- -1 
isom$pro_minmaj_qual[isom$cab_id==1624] <-  0

isom  <- 
  isom %>% select(-pro_minmaj_qual_sum)
  
isom  %>% 
  select(ctr, cab_in, cab_id, n_reforms, 
         pro_minmaj_qual, pro_min_sum, pro_maj_sum)   %>% 
  filter(n_reforms>0, pro_minmaj_qual==-99) %>% 
  head(400) 
  
  
isom$pro_minmaj_auto1 <- 0 # based on words
isom$pro_minmaj_auto1[ isom$pro_maj_sum > isom$pro_min_sum ] <-  1
isom$pro_minmaj_auto1[ isom$pro_min_sum > isom$pro_maj_sum ] <- -1

isom$pro_minmaj_auto2 <- 0 # based on lines
isom$pro_minmaj_auto2[ isom$wds_pro_maj_sum > isom$wds_pro_min_sum ] <-  1
isom$pro_minmaj_auto2[ isom$wds_pro_min_sum > isom$wds_pro_maj_sum ] <- -1

# correlation
isom  %>% 
  select(pro_minmaj_qual, pro_minmaj_auto1, pro_minmaj_auto2) %>% 
  cor() %>% 
  round(2)


#### fill values for isom ======================================================

isom  %>% 
  select(ctr, cab_id, cab_in, t_date_fst, t_date_lst,
       n_reforms, wds_chg_sum, wds_clean_rel_mn)   %>% 
  head(30)

no_change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom), 
    value=TRUE, invert=TRUE
  )

change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom), 
    value=TRUE
  )

# change vars should be 0 by default 
isom[,change_vars] %>% head(10)

# non_change vars should be filled with previous value
isom[,no_change_vars] %>% head(10)

# filling for non-change vars
isom <-
  isom %>% 
  arrange(ctr, cab_in)

for( i in seq_len(dim(isom)[1]) ){
  for( var in no_change_vars ){
    if( 
      i > 1 & 
      as.vector(is.na(isom[i,var])) &
      null_to_false(isom$ctr[i] == isom$ctr[i-1])
    ) 
    {
      isom[i, var] <- isom[i-1, var]
    }
  }
}


#### fill values for isom_non_agg ==============================================

# n_reforms
isom_non_agg$n_reforms <- ifelse(is.na(isom_non_agg$t_date), 0, 1)
isom_non_agg$n_reforms <- ifelse(
                            isom_non_agg$cab_in > isom_non_agg$t_date & 
                              !is.na(isom_non_agg$t_date), 
                            0, 
                            isom_non_agg$n_reforms
                          )

# show some data
isom_non_agg  %>% 
  select(ctr, cab_id, cab_in, t_date, n_reforms, wds_chg, wds_clean_rel)   %>% 
  head(30)

# gen change and non-change-vars
no_change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom_non_agg), 
    value=TRUE, invert=TRUE
  )

change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom_non_agg), 
    value=TRUE
  )

# change vars should be 0 by default 
isom_non_agg[,change_vars] %>% head(10)

# non_change vars should be filled with previous value
isom_non_agg[,no_change_vars] %>% head(10)

# filling for non-change vars
isom_non_agg <-
  isom_non_agg %>% 
  arrange(ctr, cab_in)

for( i in seq_len(dim(isom_non_agg)[1]) ){
  for( var in no_change_vars ){
    if( 
      i > 1 & 
      as.vector(is.na(isom_non_agg[i,var])) &
      null_to_false(isom_non_agg$ctr[i] == isom_non_agg$ctr[i-1])
    ) 
    {
      isom_non_agg[i, var] <- isom_non_agg[i-1, var]
    }
  }
}


#### save data =================================================================
save(      isom, file = "isom.Rdata")
write.dta( isom, file = "isom.dta")

save(      isom_non_agg, file = "isom_non_agg.Rdata")
write.dta( isom_non_agg, file = "isom_non_agg.dta")



#### expanding isor data for missing values (if applicaple) ====================
# if(1 == 2){
# isom <- 
#   isom  %>% 
#   arrange(country, cab_in)
# 
# desc_df(isom, cols=90:120)
# 
# # fill holes with lag values 
# for(i in seq_len(dim(isom)[1]) ){
#   isom$t_id[i] <- 
#     ifelse( 
#       is.na(isom$t_id[i]) & isom$ctr[i] == lag(isom$ctr)[i], 
#       lag(isom$t_id)[i], 
#       isom$t_id[i] 
#     )                   
# }
# 
# 
# # fill start values with SOs before cabinet
# for ( i in which(is.na(isom$t_id)) ){
#   isom$t_id[i] <- 
#     suppressWarnings(
#       max(isor$t_id[ isor$ctr == isom$ctr[i] & 
#                        isor$t_date <= isom$cab_out[i] ]        ,
#           na.rm=TRUE))
# }
# 
# variables <- 
#   names(isom)[
#     names(isom) %in% names(isor) & 
#       !(names(isom) %in% c("ctr", "country", "t_id"))
#     ]
# 
# isom <- 
#   isom[ , -which(names(isom) %in% variables)]
# 
# isom <- 
#   left_join( isom, isor[, c("t_id", variables)], by="t_id" )
# 
# 
# isom %>% 
#   select(ctr, cab_in, t_id, wds_clean_rel, wds_chg)  %>% 
#   head(50)
# 
# # NAs to 0 for all change variables
# for (var in grep("_del|_ins|_mdf|_chg", names(isom), value = TRUE) ) {
#   isom[is.na(isom[, var]) & !is.na(isom$wds_raw_all), var] <- 0 
# }
# 
# # non-change to 0 for all change varaibles
# var <- grep("_del|_ins|_mdf|_chg", names(isom), value = TRUE)
# for (i in seq_len(dim(isom)[1])[-1] ) {
#   if ( isom$t_id[i] == isom$t_id[i-1] & all(!is.na(isom$t_id[i:(i-1)])) ){
#     isom[i, "wds_chg"] <- 0 
#   }
#   if ( isom$ctr[i] == isom$ctr[i-1] & is.na(isom$t_id[i-1]) ){
#     isom[i, "wds_chg"] <- NA
#   }
# }
# 
# 
# }















