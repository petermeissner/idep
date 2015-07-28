#' function for checking diff in a coded file

check_diff <- function(res){
  if( any( !(res$diff %in% c(0, 1, 2, NA)) )){
    message("problem with diff codings outside of scheme ... ")
    message(res$Aorigfile[1])
    message(paste0(seq_along(res$diff)[!(res$diff %in% c(0, 1, 2, NA))], collapse = ", "))
    stop("problem with diff codings outside of scheme")
    }
}
