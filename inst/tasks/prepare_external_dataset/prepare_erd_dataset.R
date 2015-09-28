# script for preparing erd data for usage

library(foreign)
library(idep)
#### make sure ERD data is prepared ============================================

fname <- system.file("/tasks/prepare_erd_dataset/prepare_erd_dataset.do", package = "idep")
if(fname=="") stop("fname for do file empty .... do file to do duty not found!")
system(paste0('"C:/Program Files (x86)/Stata11/Stata-64" /e do ', fname))



#### load ERD and transform to csv and R as well ===============================

erd <- read.dta("Z:/Gesch\xe4ftsordnungen/Database/external_data/erd_cleaned_up.dta")

save(erd, file="Z:/Gesch\xe4ftsordnungen/Database/external_data/erd_cleaned_up.Rdata")
write.csv(erd, "Z:/Gesch\xe4ftsordnungen/Database/external_data/erd_cleaned_up.csv")


