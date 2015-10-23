#' function setting Encoding value of string vectors in data frame to utf-8
#' 
#' @param df data.frame to be cured 
#' 

set_enc_utf8 <- function(df){
  for ( i in seq_along(df) ){
    if ( class(df[[i]])=="character" ){
      Encoding(df[[i]]) <- "UTF-8"
    }
  }
  df
}
