# script for checking link data and uploading it to server

# setting things up
rm(list = ls())
require(idep)
library(dplyr)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen")

path   <- "Z:/Geschäftsordnungen/CodingChanges/GER/R Files/"
lfiles <- paste0(path,list.files(path, pattern="coded.*Rdata"))


# select linkage files
link_files_select(lfiles)
  head(filelist_full,  1)
  head(filelist_fname, 1)
  head(filelist_path,  1)
  country_path
  country

# load linkage files
link_files_load(filelist_full)
  linkage_env
  ls(linkage_env001)


# testing general working of functions
for ( i in seq_along(filelist_full) ) {
  message(paste("", i, "", basename(filelist_full[i])))
  try(link_files_get_text(linkage_env[i]))
}
                        

# resolving missing variables problem
redo = F

if ( redo==T ) {
  names <-   c( "oldline", "newline", "oldtext", "newtext", "similarity", 
                "relevant", "CompMaxSim", "coder","duration", "Date",
                "Afile","Aorigtext","Bfile","Borigtext","diff","coder2","comments" )
  for ( i in seq_along(filelist_full) ) {
    print(filelist_full[i])
    load(filelist_full[i])
    names2      <- names(RESULTS)
    names_amiss <- names[!(names %in% names2)]
    if( length(names_amiss) > 0 & !grepl("1949.*1952|1962.*1964", filelist_full[i])) {
      for( k in seq_along(names_amiss) ){
        print(names_amiss[k])
        RESULTS[, names_amiss[k] ] <- ""
      }
      save(RESULTS, file=filelist_full[i])
    }
  }
}



# correcting first file 
# -----------------------------------

  # correct missing newlines
  # ........................
  load(filelist_full[1])
  table(RESULTS$relevant)

  # all oldlines included? --> yes
  sort(as.numeric(unique(RESULTS$oldline)))
    
  # all newline included? --> no 
  sort(as.numeric(unique(RESULTS$newline)))

  # including newlines that are not relevant
  # filename
    basename(filelist_full[1])
  
  # getting text
    newtext <- readLines("Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1952_01_01.txt")
    newline <- seq_along(newtext)
  
  # making sure sequence is same for that in linkage and that in txt
  newline[  match(RESULTS$newline[!is.na(RESULTS$newline)], newline)]
  
  newline[  match(RESULTS$newline[!is.na(RESULTS$newline)], newline)] %in% 
  RESULTS$newline[!is.na(RESULTS$newline)]

  iffer <- !(newline %in% RESULTS$newline[!is.na(RESULTS$newline)])
  head(cbind(substring(newtext, 0, 50), iffer), 20)

  # assembling data 
  names(RESULTS)
  further_data <- 
    data.frame(
      oldline = NA, 
      newline = newline[iffer],
      oldtext = NA, 
      newtext = newtext[iffer],
      similarity = 0, 
      relevant = 0,
      CompMaxSim=0,
      coder="Peter",
      diff=NA,
      coder2="",
      comments=""
      )
  RESULTS <- rbind(RESULTS, further_data)

  # all newline included? --> yes
  sort(as.numeric(unique(RESULTS$newline)))


  # correct missing columns
  # .......................
  not_matched(names(linkage_env002$RESULTS), names(RESULTS))
  linkage_env002$RESULTS$Afile[1]


  RESULTS$duration=0
  RESULTS$Date=as.character(Sys.time())
  RESULTS$Afile=
  RESULTS$Bfile=
  RESULTS$Aorigtext=
  RESULTS$Bfile=
  RESULTS$Borigtext=
  














