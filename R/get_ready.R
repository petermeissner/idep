#' function getting things set up for working
#'

get_ready <- function(){
  message("sourcing sql functions")
  source("http://mbtnr.net/rsource/sqlFunctions.r")
  source("http://mbtnr.net/rsource/idep/sqlFunctionsExtended.r")
  source("D:/Users/Peter/DBConnections/DBSOconnection.r")
  sqlEscape <<- function(data){
    iffer <- is.na(data)
    data  <- paste0( "'", dbEscapeStrings(socon, as.character(data)) , "'")
    data[iffer] <- "NULL"
    data
  }
  dbGetQueries <<- function(con, SQL){
    dummyfunc <- function(sql){dbGetQuery(con, sql)}
    res <- unlist(plyr::llply(SQL, dummyfunc, .progress="text"))
    res
  }
    
  setwd("Z:/Gesch\u00e4ftsordnungen/AggregatedData/working")
}
