# package loading
require(idep)


# data loading
load("Z:/geschäftsordnungen/CodingChanges/IRE/Majority-Minority Coded/coded IRE-1962_05_22 VS IRE-1962_10_30.Rdata")


# extract transfer data
tr <- 
  data.frame(
    N          = 6 , 
    oldline    = RESULTS$oldline ,
    newline    = RESULTS$newline ,
    date1      = "1962_05_22" ,
    date2      = "1962_10_30" , 
    similarity = RESULTS$similarity ,
    stringsAsFactors=F
  ) 
  
setwd("Z:/geschäftsordnungen/CodingChanges/IRE/Majority-Minority Coded")
save(tr, file="new transfer 1962_05_22 versus 1962_10_30.Rdata") 
