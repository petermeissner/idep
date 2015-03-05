# package loading
require(idep)

# data loading
load("Z:/geschäftsordnungen/CodingChanges/IRE/Majority-Minority Coded/coded IRE-1962_05_22 VS IRE-1962_10_30.Rdata")

# putting data in html table for visual inspection
linkage_to_html(RESULTS, "pre_check.html")


# correction of 
#   150 -> 154 
#   151 -> 155 

  # selections
  iffer1 <- !is.na(RESULTS$newline) & RESULTS$newline==154
  RESULTS[iffer1,]

  iffer2 <- !is.na(RESULTS$newline) & RESULTS$newline==155
  RESULTS[iffer2,]

  # corrections
  RESULTS$newtext[iffer1]   <- paste0(RESULTS$newtext[iffer1],   " ", RESULTS$newtext[iffer2])
  RESULTS$Borigtext[iffer1] <- paste0(RESULTS$Borigtext[iffer1], " ", RESULTS$Borigtext[iffer2])
  
  RESULTS$newline[iffer2]   <- RESULTS$newline[iffer1]
  RESULTS$newtext[iffer2]   <- RESULTS$newtext[iffer1]
  RESULTS$Borigtext[iffer2] <- RESULTS$Borigtext[iffer1]
  
  
# correction of 
#   153 -> 157
#   154 -> 158 

  # selections
  iffer1 <- !is.na(RESULTS$newline) & RESULTS$newline==157
  RESULTS[iffer1,]

  iffer2 <- !is.na(RESULTS$newline) & RESULTS$newline==158
  RESULTS[iffer2,]

  # corrections
  RESULTS$newtext[iffer1]   <- paste0(RESULTS$newtext[iffer1],   " ", RESULTS$newtext[iffer2])
  RESULTS$Borigtext[iffer1] <- paste0(RESULTS$Borigtext[iffer1], " ", RESULTS$Borigtext[iffer2])
  
  RESULTS$newline[iffer2]   <- RESULTS$newline[iffer1]
  RESULTS$newtext[iffer2]   <- RESULTS$newtext[iffer1]
  RESULTS$Borigtext[iffer2] <- RESULTS$Borigtext[iffer1]
  
  
  
# correction of line numbers > 155   ==>   lnr - 1 

  # selection 
  iffer1 <- as.numeric(RESULTS$newline) > 154 & !is.na(RESULTS$newline)
  iffer2 <- as.numeric(RESULTS$newline) > 157 & !is.na(RESULTS$newline)
    
  # correction
  RESULTS$newline[iffer1] <- as.numeric(RESULTS$newline[iffer1]) - 1 
  RESULTS$newline[iffer2] <- as.numeric(RESULTS$newline[iffer2]) - 1 
  
  
# checking RESULTS  
linkage_to_html(RESULTS, "post_check.html")
browseURL("pre_check.html")
browseURL("post_check.html")


# cleaning up 
rm( list = ls()[ !(ls() %in% "RESULTS") ] )
Sys.sleep(2)
file.remove("pre_check.html")
file.remove("post_check.html")
  
  
# SAVE  MANUALLY (has to be done only once) 
  
  
  
  
  
  
  