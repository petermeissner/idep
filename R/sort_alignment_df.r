#' function sorting alignment data frames according to line numbers
#'
#' @param df the alignment data frame to be sorted
#' @param first name of first column to be sorted
#' @param first name of second column to be sorted
#'

sort_align_df <- function(df, first, second){
  lnr1     <- as.numeric(df[[first]])
  lnr2     <- as.numeric(df[[second]])
  looper   <- seq_len(max(lnr1, lnr2, na.rm=T))
  data_nr  <- seq_len(dim(df)[1])

  sorter <- NULL
  for ( i in looper ){
    sorter <- 
      c(  
        sorter                                            ,
        data_nr[ i==lnr1 & !is.na(lnr1) &   is.na(lnr2) ] ,
        data_nr[ i==lnr1 & !is.na(lnr1) &  !is.na(lnr2) ] ,
        data_nr[ i==lnr2 &  is.na(lnr1) &  !is.na(lnr2) ] 
      )
  }
  return(df[sorter,])
}

## DEV ## 
# df     <- RESULTS  %>% select(oldline, newline)
# first  <- "oldline"
# second <- "newline"
# i <- 1

#RESULTS  %>% 
#  select(oldline, newline, oldtext, newtext) %>% 
#  sort_align_df("oldline", "newline")  %>% 
#  htmltable()
