#' function for re-setting dates in linkage files 

check_link_dates <- function(){
  
  # selecting file
  message("Choose file for which to check dates")
  file  <- file.choose("Choose file for which to check dates")
  fname <- basename(file)
  
  # paste function
  '%.%' <- function(a,b) paste0(a,b)
  
  # get info
  finfo <- get_meta_from_fname(file)
  fdate_old <-  finfo$date1 %.% "." %.% finfo$dplus1
  fdate_new <-  finfo$date2 %.% "." %.% finfo$dplus2
  # security copy
  #  file.copy(file, paste0(file,".SAVE"), overwrite=T)
  # laoding content
  load(file)
  # get info
  date_ol_index <- grep("Date of",RESULTS$oldtext, ignore.case = TRUE)
  date_ol_text  <- RESULTS$oldtext[date_ol_index]
  date_nl_index <- grep("Date of",RESULTS$newtext, ignore.case = TRUE)
  date_nl_text  <- RESULTS$newtext[date_nl_index]
  
  
  # verifying input
  message("\n\nDates in  ... \n")
  message(fname)
  message("\nare  ... \n")
  message("-------------------------------------------------\nOLD FILE dates are:")
  message(date_ol_text  %.% "\n\n")
  message("-------------------------------------------------\nNEW FILE dates are:")
  message(date_nl_text  %.% "\n\n")
  message("-------------------------------------------------")
  
  message(file)
}



