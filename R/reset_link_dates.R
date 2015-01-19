#' function for re-setting dates in linkage files 

reset_link_dates <- function(){
  setwd("z:/")
  # selecting file
  message("Choose file for which to change dates")
  file  <- file.choose("Choose file for which to change dates")
  fname <- basename(file)
  '%.%' <- function(a,b) paste0(a,b)
  finfo <- get_meta_from_fname(file)
  fdate_old <-  finfo$date1 %.% "." %.% finfo$dplus1
  fdate_new <-  finfo$date2 %.% "." %.% finfo$dplus2
  # security copy
  file.copy(file, paste0(file,".SAVE"), overwrite=T)
  # laoding content
  load(file)
  # get info
  date_ol_index <- grep("Date of",RESULTS$oldtext)
  date_ol_text  <- RESULTS$oldtext[date_ol_index]
  date_nl_index <- grep("Date of",RESULTS$newtext)
  date_nl_text  <- RESULTS$newtext[date_nl_index]
  
  correct<-0
  while( correct == 0 ){
    # getting input
    date_ol_new <- rep("", length(date_ol_index))
    for(i in seq_along(date_ol_index)){
      message("\nOLD FILE -- "  %.%  fdate_old  %.% " -- Put in new date for:")
      ok <- F
      while ( ok==F ) {
        message(date_ol_text[i])
        date_ol_new[i] <- readLines(n=1)
        ok <- grepl("\\d{2}.\\d{2}.\\d{4}|^$", date_ol_new[i]) | date_ol_new[i]=="" 
        date_ol_new[i] <- paste( unlist(strsplit(date_ol_new[i], "[. ]")), collapse="." )
      }
    }
    date_nl_new <- rep("", length(date_nl_index))
    for(i in seq_along(date_nl_index)){
      message("\nNEW FILE -- "  %.%  fdate_new  %.% " -- Put in new date for:")
      ok <- F
      while ( ok==F ) {
        message(date_nl_text[i])
        date_nl_new[i] <- readLines(n=1)
        ok <- grepl("\\d{2}.\\d{2}.\\d{4}|^$", date_nl_new[i]) | date_nl_new[i]=="" 
        date_nl_new[i] <- paste( unlist(strsplit(date_nl_new[i], "[. ]")), collapse="." )
      }
    }
    
    # verifying input
    message("\n\nPlease check your inputs ... \n")
    message("-------------------------------------------------\nOLD FILE dates were:")
      message(date_ol_text  %.% "\n")
      message("OLD FILE dates will be:")
      date_ol_text_new <- stringr::str_replace(date_ol_text,":.*",": " %.% date_ol_new)
      message(date_ol_text_new  %.% "\n")
    message("-------------------------------------------------\nNEW FILE dates were:")
      message(date_nl_text  %.% "\n")
      message("NEW FILE dates will be:")
      date_nl_text_new <- stringr::str_replace(date_nl_text,":.*",": " %.% date_nl_new)
      message(date_nl_text_new %.% "\n")
    message("-------------------------------------------------")
    message("... is that correct? Type 'yes' if so type 'no' if you want to redo your assignments:")
    while (correct != "yes" & correct!="no"){
      correct <- grep("yes|no", readLines(n=1), value=T)
      if ( length(correct)==0 ){
        message("illeagal input, type again")
        correct<-0
      }
    }
  }
  
  message("replacing values as requested ...")
  RESULTS[date_ol_index, "oldtext"] <- date_ol_text_new
  RESULTS[date_nl_index, "newtext"] <- date_nl_text_new
  message("changes to date information will be saved to:")
  message(file)
  save(RESULTS, file=file)
  message("done")
}
# !!! testing !!!!!




