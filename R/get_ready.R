#' function getting things set up for working
#'

get_ready <- function(case){
  if(missing(case)) case = "web" 
  fname = 
    switch(case, 
           local_utf8   = "so_local.r",
           local_latin1 = "so_latin1_local.r",
           web          = "DBSOconnection.r",
           sqlite       = "so_sqlite.r"
    )
  source(paste0("~/DBConnections/", fname))
  return(socon)
}
