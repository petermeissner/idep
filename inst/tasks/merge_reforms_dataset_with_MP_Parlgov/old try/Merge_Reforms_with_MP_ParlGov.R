# script merging reforms data set with parlgov and manifesto 


#### setting things up =========================================================

library(idep)
library(stringr)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")

#### load data =================================================================

# standing orders reforms data
load("reforms.Rdata")
reforms <- as_data_frame(reforms)

# parties data
load("../external_data/Manifesto Project and ParlGov/cmp_parlgov_cabinets_ideo_confl.Rdata")
cabinets <- as_data_frame(cabinets)


#### select countries ==========================================================

countries <-  
  c(
    "Austria",
    "Belgium",
    "Denmark",
    "France",
    "Germany",
    "Ireland",
    "Italy",
    "Luxembourg",
    "Netherlands",
    "Norway",
    "Portugal",
    "Spain",
    "Sweden",
    "Switzerland",
    "Great Britain"
  )
stopifnot( countries %in% cabinets$countryname )

cabinets <- 
  cabinets  %>% 
  filter( cabinets$countryname %in% countries )




#### putting things together ===================================================































