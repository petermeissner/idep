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

# generate ids
erd$erd_pg_mp_matcher      <- str_replace_all(paste0(erd$ctr, "_", erd$cab_in), "[ -]", "_")
cabinets$erd_pg_mp_matcher <- str_replace_all(paste0(cabinets$ctr, "_", cabinets$cab_start_pg), "[ -]", "_")


# manual matching of cabinets 
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="aut_1997_01_28"] <- "aut_1997_01_15"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="bel_1974_06_11"] <- "bel_1974_06_12"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="bel_1991_09_29"] <- "bel_1988_05_09"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="bel_2003_05_05"] <- "bel_1999_07_12"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="dnk_2005_02_18"] <- "dnk_2005_02_08"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="dnk_2007_11_23"] <- "dnk_2007_11_13"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1962_12_06"] <- "fra_1962_11_28"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1968_07_12"] <- "fra_1968_07_10"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1968-07-12"] <- "fra_1968-07-10"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1976_08_27"] <- "fra_1976_08_25"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_1991_05_15"] <- "fra_1991_05_16"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_2002_05_07"] <- "fra_2002_05_06"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="fra_2007_05_18"] <- "fra_2007_05_17"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1949_09_20"] <- "deu_1949_09_15"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1953_10_20"] <- "deu_1953_10_09"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1955_07_15"] <- "deu_1955_07_23"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1956_02_24"] <- "deu_1956_02_25"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1957_10_24"] <- "deu_1957_10_22"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1960_07_01"] <- "deu_1960_07_02"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1961_11_14"] <- "deu_1961_11_07"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1965_10_26"] <- "deu_1965_10_20"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1969_10_22"] <- "deu_1969_10_21"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1972_12_15"] <- "deu_1972_12_14"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1991_01_18"] <- "deu_1991_01_17"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="deu_1994_11_17"] <- "deu_1994_11_15"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1966_10_28"] <- "deu_1965_10_20"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1962_11_19"] <- "deu_1961_11_07"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1962_12_13"] <- "deu_1961_11_07"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1982_10_01"] <- "deu_1983_03_30"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1990_10_30"] <- "deu_1987_03_11"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1980_11_05"] <- "deu_1976_12_15"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1982_09_17"] <- "deu_1976_12_15"
erd$erd_pg_mp_matcher[erd$erd_pg_mp_matcher=="deu_1983_03_29"] <- "deu_1983_03_30"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="irl_1979_12_12"] <- "irl_1979_12_11"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="ita_1960_03_26"] <- "ita_1960_03_25"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="ita_1972_07_26"] <- "ita_1972_06_26"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="ita_1999_12_21"] <- "ita_1999_12_22"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="ita_2000_04_28"] <- "ita_2000_04_25"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="ita_2005_05_28"] <- "ita_2005_04_23"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="lux_1954_06_28"] <- "lux_1954_06_29"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="lux_1995_01_20"] <- "lux_1995_01_26"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nld_1956_10_12"] <- "nld_1956_10_13"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nld_1971_06_07"] <- "nld_1971_07_06"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nld_2002_07_21"] <- "nld_2002_07_22"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_1969_09_07"] <- "nor_1969_09_08"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_1971_03_17"] <- "nor_1971_03_13"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_1972_10_17"] <- "nor_1972_10_18"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_1976_01_12"] <- "nor_1976_01_15"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_1977_09_11"] <- "nor_1977_09_12"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_1985_09_08"] <- "nor_1985_09_09"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="nor_2009_10_20"] <- "nor_2009_09_14"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="prt_1979_07_07"] <- "prt_1979_07_31"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="prt_1985_06_14"] <- "prt_1985_11_06"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="prt_2004_07_23"] <- "prt_2004_07_17"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="esp_1977_07_04"] <- "esp_1977_07_03"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="esp_1979_04_05"] <- "esp_1979_04_04"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="esp_1981_02_26"] <- "esp_1981_02_25"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="esp_1982_12_02"] <- "esp_1982_12_01"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="esp_1986_07_25"] <- "esp_1986_07_23"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="esp_2000_04_26"] <- "esp_2000_04_27"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="swe_1948_11_19"] <- "swe_1948_09_19"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="swe_1956_09_26"] <- "swe_1956_09_16"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="swe_1998_10_07"] <- "swe_1998_09_20"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="swe_2002_10_21"] <- "swe_2002_09_15"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="swe_2006_10_05"] <- "swe_2006_10_06"

cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1950_02_28"] <- "gbr_1950_03_01"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1955_05_26"] <- "gbr_1955_06_07"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1959_10_14"] <- "gbr_1959_10_20"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1963_10_18"] <- "gbr_1963_10_13"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1966_04_05"] <- "gbr_1966_04_18"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1970_06_19"] <- "gbr_1970_06_29"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1974_10_10"] <- "gbr_1974_10_22"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1983_06_09"] <- "gbr_1983_06_15"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1987_06_11"] <- "gbr_1987_06_17"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_1992_04_09"] <- "gbr_1992_04_27"
cabinets$erd_pg_mp_matcher[cabinets$erd_pg_mp_matcher=="gbr_2005_05_06"] <- "gbr_2005_05_05"


# DEV >>>>
cabinets %>%
  select(ctr, cab_name_pg, erd_pg_mp_matcher) %>%
  mutate(
    found = ifelse(cabinets$erd_pg_mp_matcher %in% erd$erd_pg_mp_matcher, "", "not_found")
  ) %>%
  #filter(ctr==ctrs[15]) %>%
  filter(found!="") %>% 
  head(5000)

erd %>%
  select(ctr, cab_pm, erd_pg_mp_matcher, cab_out) %>%
  mutate(
    match = ifelse(erd$erd_pg_mp_matcher %in% cabinets$erd_pg_mp_matcher, "", "no_match")
  )  %>%
  #filter(ctr==ctrs[15]) %>%
  filter(match!="") %>% 
  head(5000)
# <<<< DEV


tmp <- left_join(erd, cabinets, by="erd_pg_mp_matcher")
message("\n",paste("no match found for erd cabinet in parlgov:", tmp$erd_pg_mp_matcher[is.na(tmp$n_parties)], "\n"),"\n")



#### save data set extensions 

save(      cabinets, file="../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
write.dta( cabinets, file="../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
write.csv( cabinets, file="../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")

save(      erd, file="../external_data/erd_cleaned_up.Rdata")
write.dta( erd, file="../external_data/erd_cleaned_up.Rdata")
write.csv( erd, file="../external_data/erd_cleaned_up.Rdata")

















