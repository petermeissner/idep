# script for downloading newest data from database and saving it to disk

# setting things up
rm(list = ls())
require(idep)
require(foreign)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen")

socon


# listing tables
dbListTables(socon)
get_table_info(socon)


### data on changes / linelinkage ###
download_linelinkage_info(socon)












