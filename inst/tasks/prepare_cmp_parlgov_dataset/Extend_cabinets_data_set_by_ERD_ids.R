# script adding ERD cabinet ids to 

#### setting things up =========================================================

library(idep)
library(stringr)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")

#### load data =================================================================

# countries for which matches have to work
ctrs <-
  c("aut", "bel", "dnk", "fra", 
    "deu", "irl", "ita", "lux", 
    "nld", "nor", "prt", "esp", 
    "swe", "che", "gbr")

# cabinets data
load("../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
cabinets <- factors_to_character(cabinets)
cabinets <- as_data_frame(cabinets)
cabinets <- 
  cabinets  %>% 
  filter(substr(ctr, 1, 3) %in% ctrs)


# erd data 
load("../external_data/erd_cleaned_up.Rdata")
erd <- factors_to_character(erd)
erd <- as_data_frame(erd)
erd <- 
  erd  %>% 
  filter(substr(ctr, 1, 3) %in% ctrs)


#### add erd cabinet id to parlgov_manifesto data ==============================

erd$erd_pg_mp_matcher      <- str_replace_all(paste0(erd$ctr, "_", erd$cab_in), "[ -]", "_")
cabinets$erd_pg_mp_matcher <- str_replace_all(paste0(cabinets$ctr, "_", cabinets$cab_start_pg), "[ -]", "_")

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="aut_1997_01_28"] <- "aut_1997_01_15"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="bel_1974_06_11"] <- "bel_1974_06_12"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="bel_1991_09_29"] <- "bel_1988_05_09"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="bel_2003_05_05"] <- "bel_1999_07_12"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="dnk_2005_02_18"] <- "dnk_2005_02_08"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="dnk_2007_11_23"] <- "dnk_2007_11_13"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1962_12_06"] <- "fra_1962_11_28"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1968_07_12"] <- "fra_1968_07_10"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1968-07-12"] <- "fra_1968-07-10"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1976-08-27"] <- "fra_1976-08-25"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher==""] <- ""
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher==""] <- ""

# DEV >>>>
cabinets %>% 
  select(ctr, cab_name_pg, erd_pg_mp_matcher) %>% 
  mutate(
    found = ifelse(cabinets$erd_pg_mp_matcher %in% erd$erd_pg_mp_matcher, "", "not_found")
  ) %>% 
  filter(ctr==ctrs[4]) %>% 
  head(50)

erd %>% 
  select(ctr, cab_pm, erd_pg_mp_matcher, cab_out) %>% 
  mutate(
    match = ifelse(erd$erd_pg_mp_matcher %in% cabinets$erd_pg_mp_matcher, "", "no_match")
  )  %>% 
  filter(ctr==ctrs[4]) %>% 
  head(50)
# <<<< DEV




tmp <- left_join(erd, cabinets)



tmp$erd_pg_mp_matcher[is.na(tmp$n_parties)]
























