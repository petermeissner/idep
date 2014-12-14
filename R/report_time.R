#' function for reporting the time it took to execute statement
report_time <- function(expr){
  message(paste(system.time(expr)[3],"sec"))
}
