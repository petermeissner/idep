#' function that cleans up text from link data 
#' 

link_data_clean_text <- function(text){
  str_trim(str_replace(text, "#\u00a7#",""))
}
