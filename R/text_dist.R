#' function for calculating the distance between two text snippets
#' 
text_dist  = function(text1, text2, clean=F){
  if ( missing(text2) ) {
    text2 <- text1[[2]]
    text1 <- text1[[1]]
  }
  
  # cleaning text
  if ( clean==T ) {
    text1 <- clean_text(text1)
    text2 <- clean_text(text2)
  } 
  
  # worker function
  worker <- function(text1, text2){
    if(!(is.character(text1) & is.character(text2))){
      stop("Texts supplied should be character")
    }
    text1_split <- unlist(strsplit(text1, "[[:space:][:punct:]]"))
    text2_split <- unlist(strsplit(text2, "[[:space:][:punct:]]"))
    text1_table <- table(text1_split[text1_split!=""])
    text2_table <- table(text2_split[text2_split!=""])
    texts_words <- unique(c(names(text1_table), names(text2_table)))
    texts_comp  <- cbind( text1_table[match(texts_words, names(text1_table))],
                          text2_table[match(texts_words, names(text2_table))] )
    texts_comp[is.na(texts_comp)] <- 0
    dist <- sum(abs(texts_comp[,1]-texts_comp[,2]))
    return(dist)
  }
  
  # applying worker 
  vworker  <- function(text1, text2){
    dist   <- mapply(worker, text1, text2)
    return(dist)
  }
  dist <- outer(text1, text2, vworker)
  
  # return
  return(dist)
}
