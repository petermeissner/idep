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
for ( i in seq_along(filelist_full)[1:10] ) {
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


  RESULTS$duration  <- 0
  RESULTS$Date      <- as.character(Sys.time())

  RESULTS$Afile     <- "Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1949_09_20.txt"
  text1             <- readLines(RESULTS$Afile[1])
  RESULTS$Aorigtext <- text1[as.numeric(RESULTS$oldline)]

  RESULTS$Bfile     <- "Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1952_01_01.txt"
  text2             <- readLines(RESULTS$Bfile[1])
  RESULTS$Borigtext <- text2[as.numeric(RESULTS$newline)]
  
  
  # save manually to 
  # save(RESULTS, file=filelist_full[1])
  

# correcting missing dates in '49 version
    
  load(filelist_full[1])
  
  # adding dates
    adding_dates <- 
      data.frame(
          oldline = (max(as.numeric(RESULTS$oldline),na.rm=T)+1):
                   (max(as.numeric(RESULTS$oldline),na.rm=T)+3),
          newline=NA,
          oldtext = c( "#§# Date of Acceptance: 02.09.1949",
                       "#§# Date of Promulgation: ",
                       "#§# Date of Enactment: "),
          newtext=NA,
          similarity=0,
          relevant=0,
          CompMaxSim=0,
          coder="peter",
          diff=NA,
          coder2="",
          comments="",
          duration=0,
          Date=Sys.time(),
          Afile="Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1949_09_20.txt",
          Bfile="Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1952_01_01.txt",
          Aorigtext=c( "#§# Date of Acceptance: 02.09.1949",
                       "#§# Date of Promulgation: ",
                       "#§# Date of Enactment: "),
          Borigtext="",
          stringsAsFactors=F
        )
  
  grep("Date", RESULTS$oldtext, ignore.case=T, value=T)
  
  RESULTS <- rbind(RESULTS, adding_dates)

  # saving manually
  # save(RESULTS, file=filelist_full[1])


# correcting fifths file 
# -----------------------------------

  # correct missing newlines
  # ........................
  load(filelist_full[5])
  table(RESULTS$relevant)
  
  # all oldlines included? --> no
  sort(as.numeric(unique(RESULTS$oldline)))
  
  # all newline included? --> no 
  sort(as.numeric(unique(RESULTS$newline)))
  
  # including newlines that are not relevant
  # filename
  basename(filelist_full[5])
  
  # getting text
  oldtext <- readLines("Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1962_01_02.txt")
  oldline <- seq_along(oldtext)
  
  newtext <- readLines("Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1964_08_24.txt")
  newline <- seq_along(newtext)
  
  
  # making sure sequence is same for that in linkage and that in txt
  # oldtext --> ok !
  # newtext --> ok !
  not_matched(oldline, RESULTS$oldline)
  not_matched(newline, RESULTS$newline)
  
  index <- tail(sort(RESULTS$oldline), 3)
  oldtext[index]
  RESULTS$oldtext[match(index, RESULTS$oldline)]
  
  index <- tail(sort(RESULTS$newline), 3)
  newtext[index]
  RESULTS$newtext[match(index, RESULTS$newline)]

  # assembling data 
  iffer <- !(oldline %in% RESULTS$oldline[!is.na(RESULTS$oldline)])
  head(cbind(substring(oldtext, 0, 50), iffer), 20)
  
  further_data1 <- 
    data.frame(
      oldline = oldline[iffer],
      newline = NA, 
      oldtext = oldtext[iffer],
      newtext = NA,
      similarity = 0, 
      relevant = 0,
      CompMaxSim=0,
      coder="Peter",
      diff=NA,
      coder2=""
    )


  iffer <- !(newline %in% RESULTS$newline[!is.na(RESULTS$newline)])
  head(cbind(substring(newtext, 0, 50), iffer), 20)

  further_data2 <- 
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
      coder2=""
    )
  

  RESULTS <- rbind(RESULTS, further_data1, further_data2)





# all newline included? --> yes
sort(as.numeric(unique(RESULTS$oldline)))
sort(as.numeric(unique(RESULTS$newline)))


# correct missing columns
# .......................
not_matched(names(linkage_env002$RESULTS), names(RESULTS))


RESULTS$duration  <- 0
RESULTS$Date      <- as.character(Sys.time())

RESULTS$Afile     <- "Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1962_01_02.txt"
text1             <- readLines(RESULTS$Afile[1])
RESULTS$Aorigtext <- text1[as.numeric(RESULTS$oldline)]

RESULTS$Bfile     <- "Z:/Geschäftsordnungen/CodingChanges/GER/TXT/DEU-1964_08_24.txt"
text2             <- readLines(RESULTS$Bfile[1])
RESULTS$Borigtext <- text2[as.numeric(RESULTS$newline)]

RESULTS$comments  <- ""

# save manually to 
# save(RESULTS, file=filelist_full[5])































