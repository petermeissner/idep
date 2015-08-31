#### setting things up =========================================================
library(idep)
library(dplyr)
library(RMySQL)
'%.%' <- function(a,b) paste0(a,b)

# error handling
if( !interactive() ){
  options(error = quote({email_error("undefined error in regen temp tables" , s=ctr, anyways=T); q(save = "no")}) )
}

# connection function
get_ready <- function(){
  lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)
  source("~/DBConnections/so_local.r")
  #source("~/DBConnections/so_latin1_local.r")
  #source("~/DBConnections/DBSOconnection.r")
}


# MAKE SURE TO generate new temporary tables in db!
get_ready() 
message("regenerate temp tables")
system.time(dbGetQuery(socon, "CALL make_temp_linelinkage_textlines_texts();"))
