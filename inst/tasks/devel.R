setwd("Z:/Geschäftsordnungen/CodingChanges/NED/coded changes")

files        <- list.files(pattern="coded.*Rdata")
RESULTS_list <- list()
cols         <- NULL
rows         <- NULL
for(i in seq_along(files)){
  load(files[i]) 
  RESULTS_list[[i]] <- RESULTS
  cols <- c(cols, dim(RESULTS)[2])
  rows <- c(rows, dim(RESULTS)[1])
}

data.frame(cols=cols, rows=rows)


