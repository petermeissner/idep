
sqlDuration <- function(text){
  require(stringr)
  text <- str_replace_all(text,"sec\n\n","")
  text <- sum(as.numeric(unlist(str_split(text," "))),na.rm=T)
  text
}