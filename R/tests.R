#' checks : check that all text lines ( max(lnr) ) ar included

dtest <- function(text_meta){
  dtest <- sum(is.na(text_meta[, c("daccept","dpromul","denact")])) /
    sum(!is.na(text_meta[, c("daccept","dpromul","denact")]))
  if(sum(dtest)==0){
    message("--- OK all dates extracted ---")
  }else{
    return(text_meta)
  }
}


#' checks : check that all text lines ( max(lnr) ) ar included
ltest <- function(text_texts){
  ltest <- link_data_check_textlength(text_texts)
  if(sum(ltest)==0){
    message("--- OK length test OK ---")
  }else{
    return(ltest)
  }
}


#' checks : check that the second text of version n 
#'          is equal to the first text of version n+1
#'      ... which should be the case because these are 
#'          supposed to be the same texts
ctest <- function(link_texts, filelist_full){
  ctest <- link_data_check_textconsistency(link_texts, filelist_full)
  if ( dim(ctest[[2]])[1]==0 ) {
    message("--- OK text consistency OK --")
  }else{
    return(ctest)
  }
}


