# checking austria coded texts

# setting things up
rm(list = ls())
require(idep)
get_ready()
setwd("Z:/Geschäftsordnungen/codingChanges/AUT/R files")
fnames <- sort(list.files(pattern="coded"))

'%.%'   <- function(a,b) paste0(a,b)
'%..%'  <- function(a,b) paste(a,b)
  

# missing text ?
  for ( i in seq_along(fnames)) {
    load(fnames[i])
    if ( length(unique(RESULTS$oldline)) < max(as.numeric(RESULTS$oldline), na.rm=T) | 
        length(unique(RESULTS$newline)) < max(as.numeric(RESULTS$newline), na.rm=T)){
      message(str_pad(i,3) %..% fnames[i])
      message("lines are missing")
    }
  }


# get data
  i <- 12
  load(fnames[i])


# checking if text in data and that in texts match
  texts_names <- 
    str_split(fnames[i], " VS ")  %>% 
    unlist  %>% 
    str_replace_all("coded |\\.Rdata", "") %>% 
    paste0("../TXT/", . ,".txt")
  texts_txt <- 
    lapply(texts_names, readLines)
  
  oldtext <- 
    RESULTS  %>% 
    select(oldline, oldtext) %>% 
    filter(!duplicated(oldline), !is.na(oldline)) 
    
  comp1 <- cbind(texts_txt[[1]][oldtext$oldline],oldtext$oldtext)
  
  newtext <- 
    RESULTS  %>% 
    select(newline, newtext) %>% 
    filter(!duplicated(newline), !is.na(newline)) 
  
  comp2 <- cbind(texts_txt[[2]][newtext$newline],newtext$newtext)

  # word distances for lines within old data compared to text (should be below 2 or 3)
  apply(comp1, 1, text_dist)
  # comp1[apply(comp1, 1, text_dist) > 2 ,]
  
  apply(comp2, 1, text_dist)
  # comp2[apply(comp2, 1, text_dist) > 2 ,]


# adding missing text // oldlines
  RESULTS$Date <- as.character(file.info(fnames[i])$ctime)
  
  index <- seq_along(texts_txt[[1]]) 
  index <- index[!(index %in% as.numeric(RESULTS$oldline))]
  
  if ( length(index)>0 ) {
    add <- data.frame(
      oldline = index,
      oldtext = clean_text(texts_txt[[1]][index]),
      similarity = 0,
      relevant=0,
      coder= "Peter",
      Date= as.character(Sys.time())
    )
  } else {
    add <- data.frame()
  }

  RESULTS <- rbind.fill(RESULTS, add)
  

  index <- seq_along(texts_txt[[2]]) 
  index <- index[!(index %in% as.numeric(RESULTS$newline))]
  
  if ( length(index) > 0 ) {
    add <- data.frame(
      newline = index,
      newtext = clean_text(texts_txt[[2]][index]),
      similarity = 0,
      relevant=0,
      coder= "Peter",
      Date=as.character(Sys.time())
    )  
  } else{
    add <- data.frame()  
  }
  
  RESULTS <- rbind.fill(RESULTS, add)

# adding Aorigtext / Borigtext and otehr vars 
  
  if ( is.null(RESULTS$Aorigtext) ) {
  RESULTS$Aorigtext <- 
    str_replace(
      texts_txt[[1]][as.numeric(RESULTS$oldline)]
    , "^ ?#§# ?", "")
  }
  
  if ( is.null(RESULTS$Borigtext) ) {
  RESULTS$Borigtext <- 
    str_replace(
      texts_txt[[2]][as.numeric(RESULTS$newline)]
      , "^ ?#§# ?", "")
  }
  
  if ( is.null(RESULTS$duration) ) {
    RESULTS$duration <- NA
  }
  RESULTS$Afile <- str_replace(texts_names,
                               "\\.\\.",
                               "Z:/Geschäftsordnungen/codingChanges/AUT/R files")[1]
  RESULTS$Bfile <- str_replace(texts_names,
                               "\\.\\.",
                               "Z:/Geschäftsordnungen/codingChanges/AUT/R files")[2]

# save(RESULTS, file=fnames[i])






