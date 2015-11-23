# script for adding cabinet ids of erd data to isor

#### setting things up =========================================================

library(idep)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")



#### loading data ==============================================================

load("Z:/Gesch\xe4ftsordnungen/Database/external_data/erd_cleaned_up.Rdata")
load("isor.Rdata")

isor <- as.data.frame(isor)
#isor$t_date <- as.Date(isor$t_date)

erd     <- as_data_frame(erd)
erd  <- 
  erd %>% 
  select(country, ctr, cab_id, cab_in, cab_out, cab_pm)
#erd$cab_in  <- as.numeric(erd$cab_in)
#erd$cab_out <- as.numeric(erd$cab_out)


#### adding cabinet ids from erd data to isor dataset =======================

isor$erd_cab_id <- NA

for ( i in seq_along(isor$t_id) ) {
  reform_country <- substring(isor$ctr[i], 1, 3)
  erd_cab_id_1   <- erd$cab_id[erd$ctr == reform_country & isor$t_date[i]    >= erd$cab_in & na_to_true(isor$t_date[i]    <= erd$cab_out) ]
  erd_cab_id_2   <- erd$cab_id[erd$ctr == reform_country & isor$t_daccept[i] >= erd$cab_in & na_to_true(isor$t_daccept[i] <= erd$cab_out) ]
  erd_cab_id_3   <- erd$cab_id[erd$ctr == reform_country & isor$t_dpromul[i] >= erd$cab_in & na_to_true(isor$t_dpromul[i] <= erd$cab_out) ]
  erd_cab_id_4   <- erd$cab_id[erd$ctr == reform_country & isor$t_denact[i]  >= erd$cab_in & na_to_true(isor$t_denact[i]  <= erd$cab_out) ]
  erd_cab_id     <- sort(c(erd_cab_id_1, erd_cab_id_2, erd_cab_id_3, erd_cab_id_4))[1]
  isor$erd_cab_id[i] <- ifelse(length(erd_cab_id)==0, NA, erd_cab_id)
}

#### still missing cabinet ids for isor        

#   1 # aut 1928-02-01 --> no data in erd         --> should be ok

# 179 # deu 2005-10-31 --> between two cabinets   --> Merkel I (628)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="deu" & t_date=="2005-10-31")] <- 628

# 183 # irl 1943-05-26 --> no data in erd         --> should be ok

# 268 # ita 1987-03-24 --> between cabinets       --> Craxi (1038)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="ita" & t_date=="1987-03-24")] <- 1038

# 269 # ita 1987-07-18 --> between cabinets       --> Goria (1040)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="ita" & t_date=="1987-07-18")] <- 1040

# 270 # ita 1987-07-25 --> between cabinets       --> Goria (1040)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="ita" & t_date=="1987-07-25")] <- 1040

# 309 # nld 1938-03-10 --> no data in erd         --> should be ok

# 327 # nld 1977-09-18 --> between cabinets       --> van Agt I (1215)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nld" & t_date=="1977-09-18")] <- 1215

# 339 # nld 1986-06-24 --> between cabinets       --> Luebbers II (1219)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nld" & t_date=="1986-06-24")] <- 1219

# 352 # nld 2002-07-04 --> between cabinets       --> Balkenende I (1223)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nld" & t_date=="2002-07-04")] <- 1223

# 353 # nld 2003-04-15 --> between cabinets       --> Balkenende II (1224)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nld" & t_date=="2003-04-15")] <- 1224

# 371 # nld 2010-07-01 --> between cabinets       --> Ruette (1228)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nld" & t_date=="2010-07-01")] <- 1228

# 398 # nor 1972-10-10 --> between cabinets       --> Bratteli I (1312)
isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nor" & t_date=="1972-10-10")] <- 1312



### FIRST VERSION MATCHING TO LATER CABINETS ### 

#   1 # aut 1928-02-01
# isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="aut" & t_date=="1928-02-01")] <- 101

# 183 # irl 1943-05-26
# isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="irl" & t_date=="1943-05-26")] <- 901

# 309 # nld 1938-03-10
# isor$erd_cab_id[with(isor, is.na(erd_cab_id) & ctr=="nld" & t_date=="1938-03-10")] <- 1201




#### isor without cabinet id of erd dataset

isor  %>%
  mutate(lnr = seq_along(isor$t_id) )  %>%
  select(lnr, ctr, t_date, erd_cab_id)  %>%
  filter(is.na(erd_cab_id),  !grepl("che",ctr) )

# i <- 179
# reform_country <- "deu"
# 
# isor[i, c("t_date", "t_daccept", "t_dpromul", "t_denact")]
# data.frame(cab_id=erd$cab_id, erd$ctr, erd$cab_pm, erd$cab_in , erd$cab_out )[erd$ctr == reform_country,]



#### saving ====================================================================

isor <- as_data_frame(isor)

# save isor dataset
setwd("Z:/Gesch\xe4ftsordnungen/database/aggregats")
save(isor, file="isor.Rdata")
write.dta(isor, file="isor.dta")






