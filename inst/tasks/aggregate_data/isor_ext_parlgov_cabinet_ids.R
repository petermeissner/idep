# script for adding cabinet ids of parlgov/manifesto data to reforms

#### setting things up =========================================================

library(idep)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")



#### loading data ==============================================================

load("Z:/Gesch\xe4ftsordnungen/Database/external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
load("reforms.Rdata")

reforms <- as.data.frame(reforms)
#reforms$t_date <- as.Date(reforms$t_date)

cabinets <- as_data_frame(cabinets)
cabinets <- 
  cabinets  %>% 
  select(country, ctr, cab_id_pg, cab_start_pg, cab_name_pg, el_first_pg)


#### subsetting cabinets data to countries in reforms dataset ==================

cabinets <- cabinets[cabinets$ctr %in% substring(reforms$ctr, 1, 3), ]

cabinets <- 
  cabinets  %>% 
  arrange(country, cab_start_pg, cab_id_pg) %>% 
  mutate(
    cab_start_next_pg = lead(cab_start_pg),
    cab_start_next_pg = ifelse(ctr==lead(ctr), cab_start_next_pg, NA)
  )  

#### adding cabinet ids from erd data to reforms dataset =======================

reforms$pg_cab_id <- NA

for ( i in seq_along(reforms$t_id) ) {
  reform_country <- substring(reforms$ctr[i], 1, 3)
  pg_cab_id_1   <- cabinets$cab_id[cabinets$ctr == reform_country & reforms$t_date[i]    >= cabinets$cab_start_pg & na_to_true(reforms$t_date[i]    <= cabinets$cab_start_next_pg) ]
  pg_cab_id_2   <- cabinets$cab_id[cabinets$ctr == reform_country & reforms$t_daccept[i] >= cabinets$cab_start_pg & na_to_true(reforms$t_daccept[i] <= cabinets$cab_start_next_pg) ]
  pg_cab_id_3   <- cabinets$cab_id[cabinets$ctr == reform_country & reforms$t_dpromul[i] >= cabinets$cab_start_pg & na_to_true(reforms$t_dpromul[i] <= cabinets$cab_start_next_pg) ]
  pg_cab_id_4   <- cabinets$cab_id[cabinets$ctr == reform_country & reforms$t_denact[i]  >= cabinets$cab_start_pg & na_to_true(reforms$t_denact[i]  <= cabinets$cab_start_next_pg) ]
  pg_cab_id     <- sort(c(pg_cab_id_1, pg_cab_id_2, pg_cab_id_3, pg_cab_id_4))[1]
  reforms$pg_cab_id[i] <- ifelse(length(pg_cab_id)==0, NA, pg_cab_id)
}

#### still missing cabinet ids for reforms        

#   1 # aut 1928-02-01 --> no data in erd         --> should be ok

# 179 # deu 2005-10-31 --> between two cabinets   --> Merkel I (628)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="deu" & t_date=="2005-10-31")] <- 628

# 183 # irl 1943-05-26 --> no data in erd         --> should be ok

# 268 # ita 1987-03-24 --> between cabinets       --> Craxi (1038)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="ita" & t_date=="1987-03-24")] <- 1038

# 269 # ita 1987-07-18 --> between cabinets       --> Goria (1040)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="ita" & t_date=="1987-07-18")] <- 1040

# 270 # ita 1987-07-25 --> between cabinets       --> Goria (1040)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="ita" & t_date=="1987-07-25")] <- 1040

# 309 # nld 1938-03-10 --> no data in erd         --> should be ok

# 327 # nld 1977-09-18 --> between cabinets       --> van Agt I (1215)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="nld" & t_date=="1977-09-18")] <- 1215

# 339 # nld 1986-06-24 --> between cabinets       --> Luebbers II (1219)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="nld" & t_date=="1986-06-24")] <- 1219

# 352 # nld 2002-07-04 --> between cabinets       --> Balkenende I (1223)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="nld" & t_date=="2002-07-04")] <- 1223

# 353 # nld 2003-04-15 --> between cabinets       --> Balkenende II (1224)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="nld" & t_date=="2003-04-15")] <- 1224

# 371 # nld 2010-07-01 --> between cabinets       --> Ruette (1228)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="nld" & t_date=="2010-07-01")] <- 1228


# 398 # nor 1972-10-10 --> between cabinets       --> Bratteli I (1312)
reforms$pg_cab_id[with(reforms, is.na(pg_cab_id) & ctr=="nor" & t_date=="1972-10-10")] <- 1312


#### reforms without cabinet id of erd dataset

reforms  %>%
  mutate(lnr = seq_along(reforms$t_id) )  %>%
  select(lnr, ctr, t_date, pg_cab_id)  %>%
  filter(is.na(pg_cab_id),  !grepl("che",ctr) )

# i <- 179
# reform_country <- "deu"
# 
# reforms[i, c("t_date", "t_daccept", "t_dpromul", "t_denact")]
# data.frame(cab_id=erd$cab_id, erd$ctr, erd$cab_pm, erd$cab_in , erd$cab_out )[erd$ctr == reform_country,]



#### saving ====================================================================

reforms <- as_data_frame(reforms)

# # save reforms dataset
# setwd("Z:/Gesch\u00e4ftsordnungen/database/aggregats")
# save(reforms, file="reforms.Rdata")
# write.dta(reforms, file="reforms.dta")
# 
# 
# 
# 
# 
