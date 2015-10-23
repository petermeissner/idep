#' function sourcing connection information
#' 

connect_to_sodb <- function(){
  if ( Sys.info()['nodename'] == "ZK1042") {
      source("D:/Users/Peter/DBConnections/dbsoconnection.r")
  }
}
