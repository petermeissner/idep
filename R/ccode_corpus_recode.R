#' function for recoding corpus code aggregation scheme (late 2014)

ccode_color_scheme  <- c("#ec7014","#fcbba1", "#D94801", "#41ab5d", "#e7298a", 
                         "#C0C0C0", "#FFFFFF")
ccode_corpus_recode <- function(ccode){
  codes <- rbind(
    cbind(c(111,112,113,114,121,122,123,124,125,131,132,133,134,141,142,143,144,145),1),
    cbind(c(21,22,23,241,242,243,244,26,27,28,29,67,71,72,73),2),
    cbind(c(25,31,32,33,411,421,441),3),
    cbind(c(412,53,54,636,637,66),4),
    cbind(c(121,51,52,53,55,56,611,612,613),5),
    cbind(c(999),6)
  )
  code_new <- codes[,2][match(ccode, codes[,1])]
  code_new[is.na(code_new)] <- 7
  code_new
}

ccode_to_color <- function(ccode){
  ccode_color_scheme[ccode_corpus_recode(ccode)]
}
