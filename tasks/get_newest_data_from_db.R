# script for downloading newest data from database and saving it to disk

# setting things up
rm(list = ls())
require(idep)
require(foreign)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen/CodingData")

# connection info
socon

# listing tables
dbListTables(socon)
get_table_info(socon)

### data on changes / linelinkage ###
ll_view <- download_linelinkage_view( socon, saveToFile=T)

### raw data
ll_raw  <- download_linelinkage_raw(  socon, saveToFile=T)
t_raw   <- download_texts_raw(        socon, saveToFile=T)
tl_raw  <- download_textlines_raw(    socon, saveToFile=T)

### producing texts
ll_view_write_texts(tl_raw)




















