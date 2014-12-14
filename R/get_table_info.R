#' function that gatheres information on tables in a database

get_table_info <- function(con, tables=""){
  '%.%' <- function(a,b) paste0(a,b)
  if ( tables=="" ) {
    tables <- dbListTables(con)
  } 
  table_info <- list()
  show
  for ( i in seq_along(tables)) {
    sql <- "SELECT COUNT(*) FROM " %.% tables[i] %.% " ; "
    table_info[[tables[i]]]["rows"]    <- dbGetQuery(con, sql)
    sql <- "SELECT * FROM " %.% tables[i] %.% " LIMIT 1 ; "
    table_info[[tables[i]]]["columns"] <- suppressWarnings(dim(dbGetQuery(con, sql))[2])
  }
  do.call(rbind.data.frame, table_info)
}
