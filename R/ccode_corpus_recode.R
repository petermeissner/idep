#' coler scheme 
ccode_color_scheme  <- c("#ec7014","#fcbba1", "#D94801", "#41ab5d", "#e7298a", 
                         "#C0C0C0", "#FFFFFF")

#' coler scheme 
ccode_color_scheme2 <- c("#E6FFCC","#FFE6B2", "#D191BC", "#B8B8FF", "#D6C299", 
                         "#ECECEC", "#FFFFFF")

#' function for aggregating corpus codes into topic categories
ccode_corpus_recode <- function(ccode){
  codes <- rbind(
    cbind(c(111,112,113,114,121,122,123,124,125,131,132,133,134,141,142,143,144,145),1),
    cbind(c(21,22,23,241,242,243,244,26,27,28,29,67,71,72,73),2),
    cbind(c(25,31,32,33,411,421,441),3),
    cbind(c(412,53,54,636,637,66),4),
    cbind(c(121,51,52,53,55,56,611,612,613),5),
    cbind(c(652, 631, 632, 633, 8, 34, 634, 6351, 651, 6212, 10, 9, 6211,
            68,  641, 6221, 6222,  638, 43,  639, 6352,  642,  643,  653,
            442,   45,  422),66),
    cbind(c(999),77)
  )
  code_new <- codes[,2][match(ccode, codes[,1])]
  code_new[is.na(code_new)] <- -999
  code_new
}

ccode_to_color <- function(ccode){
  ccode_color_scheme[ccode_corpus_recode(ccode)]
}

# function for aggregating corpus codes to actors 
ccode_corpus_recode2 <- function(ccode){
  codes <- rbind(
    cbind(c(111,651,652,653), 1),
    cbind(c(641,642,643), 2),
    cbind(c(125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639), 3),
    cbind(c(612, 6211, 6212, 6221, 6222), 4),
    cbind(c(112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 
            26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 
            244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 
              422, 421, 144, 67), 66),
    cbind(c(999), 77)
  )
  code_new <- codes[,2][match(ccode, codes[,1])]
  code_new[is.na(code_new)] <- -999
  code_new
}


