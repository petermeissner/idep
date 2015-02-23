setwd("Z:/Geschäftsordnungen/CodingChanges/NED/coded changes")

files        <- list.files(pattern="coded.*Rdata")

N            <- length(files)
RESULTS_list <- list()
cols         <- rep(NA, N)
rows         <- rep(NA, N)
diff_m99     <- rep(NA, N)
diff_1       <- rep(NA, N)
diff_2       <- rep(NA, N)
diff_NA      <- rep(NA, N)

for(i in seq_along(files)){
  load(files[i]) 
  RESULTS_list[[i]] <- RESULTS
  cols[i] <- dim(RESULTS)[2]
  rows[i] <- dim(RESULTS)[1]
  diff_m99[i] <- sum(RESULTS$diff==-99, na.rm=T)
  diff_1[i] <- sum(RESULTS$diff==1, na.rm=T)
  diff_2[i] <- sum(RESULTS$diff==2, na.rm=T)
  diff_NA[i] <- sum(RESULTS$diff==2, na.rm=T)
}

data.frame(cols=cols, rows=rows, diff_m99, diff_1, diff_2, diff_NA)

files[diff_m99>0]


# these versions have been linked but not coded
load("Z:/Geschäftsordnungen/CodingChanges/NED/linked changes/NDL-2010_04_20 VS NDL-2010_07_01.Rdata")
htmltable(select(RESULTS[RESULTS$similarity!=1 & RESULTS$relevant==1,], oldline, newline, oldtext, newtext, similarity))

# corpus coding seems to be ok ... 
load("Z:/geschäftsordnungen/CodingCorpus/CorpusCoding NED.Rdata")
table(coding[coding$date=="2010_04_20",]$code, useNA="always")
table(coding[coding$date=="2010_07_01",]$code, useNA="always")


