#' function getting things set up for working
#'

get_ready <- function(){
  message("sourcing sql functions")
  fname <- "D:/Users/Peter/DBConnections/DBSOconnection.r"
  if ( file.exists(fname) ) {
    source(fname)
  } else {
    source("C:/Users/Peter/DBConnections")
  }
  try(setwd("Z:/Gesch\u00e4ftsordnungen/AggregatedData/working"))
}
