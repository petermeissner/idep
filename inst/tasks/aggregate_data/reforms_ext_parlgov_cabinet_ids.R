# script for adding cabinet ids of parlgov/manifesto data to reforms

#### setting things up =========================================================

library(idep)
library(dplyr)
library(foreign)


setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")



#### loading data ==============================================================

load("Z:/Geschäftsordnungen/Database/external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
load("reforms.Rdata")
