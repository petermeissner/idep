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


#' function sorting alignment data frames according to line numbers
#'
#' @param df the alignment data frame to be sorted
#' @param first name of first column to be sorted
#' @param first name of second column to be sorted
#' @param dnlb a special parameter for sorting NULL per default. 
#' Should be either NULL or a vector of size dim(df)[1]. 
#' If set those lines/rows marked will be tried to put behind second 
#' predecessors

# df <- linkage; dnlb <- linkage$type=="insertion"

sort_align_dev <- function(df, first, second, dnlb=NULL){
  lnr1         <- as.numeric(df[[first]])
  lnr2         <- as.numeric(df[[second]])
  looper       <- seq_len(max(lnr1, lnr2, na.rm=T))
  data_nr      <- seq_len(dim(df)[1])
  df$sadflnr   <- seq_len(dim(df)[1])
  dnlb_sadflnr <- df$sadflnr[dnlb]
  
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
  
  df <- df[sorter, ]
  
  if( !is.null(dnlb) ){
    df1 <- df[ !(df$sadflnr %in% dnlb_sadflnr) | df[[second]]==1  , ]
    df2 <- df[   df$sadflnr %in% dnlb_sadflnr  & df[[second]]!=1, ]
    df2 <- df2[order(as.numeric(df2[[second]])), ]
    for ( l in seq_len(dim(df2)[1]) ){
      ln2  <- as.numeric(df2[[second]][l])
      ind1 <- which( df1[[second]] == (ln2 - 1) )[1]
      df1  <- rbind( df1[1:ind1, ], df2[l,], df1[(ind1+1):dim(df1)[1],] )
    }
    df <- df1
  }

  return(df[, -which(names(df)=="sadflnr")])
}

## DEV ## 
# df <- data.frame(lnr1 = sample(c(1:10, rep(NA, 10)), 1000, T), lnr2 = sample(c(1:10, rep(NA, 10)), 1000, T))
# df <- distinct(df)
# first  <- "lnr1"
# second <- "lnr2"
# sort_align_df2(df, "lnr1", "lnr2")

#RESULTS  %>% 
#  select(oldline, newline, oldtext, newtext) %>% 
#  sort_align_df("oldline", "newline")  %>% 
#  htmltable()
