#' function that checks the lengths of texts

link_data_check_textlength <- function(textlist_flat){
  res <- data.frame(length_text=NA)
  for ( i in seq_along(textlist_flat) ) {
    res[i,"length_text"] <- length(textlist_flat[[i]]$lnr) -
                            max(textlist_flat[[i]]$lnr) 
  }
  return(res)
}
