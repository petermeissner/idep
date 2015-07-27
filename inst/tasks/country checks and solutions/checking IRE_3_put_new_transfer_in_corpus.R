# package loading
require(idep)
setwd("Z:/Geschäftsordnungen/CodingCorpus/")

# data loading
load("Z:/geschäftsordnungen/CodingChanges/IRE/Majority-Minority Coded/new transfer 1962_05_22 versus 1962_10_30.Rdata")
load("Z:/Geschäftsordnungen/CodingCorpus/CorpusCoding IRE.Rdata")

# security save
save(coding, dates, meta, transfer, file=paste0("SAVES/CC IRE before transfer ", str_replace_all(Sys.time(),":","-"), ".Rdata" ) )

# overview / cleansing
ls()
rm(q)

# delete old transfer add new transfer
tr        <- tr[ tr$similarity!=0 , ]
transfer  <- transfer[ !(transfer$date1 == "1962_05_22") , ]
transfer  <- rbind(transfer, tr)


# check results
tr[ tr$date1 == "1962_05_22" & tr$oldline %in% 150:160 , ]
transfer[ transfer$date1 == "1962_05_22" & transfer$oldline %in% 150:160 , ]


# SAVEING MANUALLY because it only has to be done one time 
rm(tr)

