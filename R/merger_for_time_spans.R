# function that merges according to time span overlaps
merger_for_time_spans <- function(df1, df2){
  require(dplyr)
  
  # input check 
  stopifnot( dim(df1)[2] >=3 ) 
  stopifnot( dim(df2)[2] >=3 )
  stopifnot( all(class(df1) =="data.frame") )
  stopifnot( all(class(df2) =="data.frame") )
  stopifnot( lapply(df1[,2:3], class) %in% "Date")
  stopifnot( lapply(df2[,2:3], class) %in% "Date")
  
  # expand min and max date from spans to sequence of dates over whole range
  dmax <- max(c(df1[[2]], df1[[3]], df2[[2]], df2[[3]]), na.rm=TRUE)
  dmin <- min(c(df1[[2]], df1[[3]], df2[[2]], df2[[3]]), na.rm=TRUE)
  full_day_sequence  <- seq(dmin, dmax, "day")
  
  # matching ids from span data sets and whole range of days
  df_fds1 <- mfts_match_dates_to_id(full_day_sequence, df1)
  df_fds2 <- mfts_match_dates_to_id(full_day_sequence, df2)
  
  
  # merge expanded dates and df1 / df2
  # to get data.frame that has all dates 
  # and for each date matched id1, id2 if availible
  #  id1 &  id2  - covered by both
  #  id1 & !id2  - not covered by id2 but by id1
  # !id1 &  id2  - not covered by id1 but by id2
  # !id1 & !id2  - covered by neither 
  df <- 
    data_frame(date=full_day_sequence) %>% 
    left_join(df_fds1) %>% 
    left_join(df_fds2) %>% 
    arrange(date) %>% 
    filter(!is.na(date)) 
  
  # aggregating day sequences to spans, if both ids are not NA
  df_aggregated <- 
    data.frame(
      aggregate(df[,"date"], by=list(id1=df[[2]], id2=df[[3]]), min),
      end= aggregate(df[,"date"], by=list(id1=df[[2]], id2=df[[3]]), max)$date
    )
  if ( dim2(df_aggregated)<4 ){
    df_aggregated[[4]] <- rep(NA, dim1(df_aggregated) )
  }
  names(df_aggregated)[1] <- names(df1)[1]
  names(df_aggregated)[2] <- names(df2)[1]
  names(df_aggregated)[3] <- "start"
  names(df_aggregated)[4] <- "end"
  
  df_aggregated$span_id <- seq_dim1(df_aggregated)
  
  # df_nas days not processed due to missing id
  df_nas <- df[is.na(df[[2]]) | is.na(df[[3]]), ]
  
  # unbroken sequences of days get unique id
  #   - initialize
  if( dim1(df_nas) > 0 ){
    df_nas <- df_nas[order(df_nas[[1]], df_nas[[2]], df_nas[[3]]),]  # sort by date
    df_nas$span_id <- NA                                             # initialize
    df_nas[1,]$span_id <- 
      ifelse(
        length(df_aggregated$span_id)==0,
        1,
        max(df_aggregated$span_id, na.rm=TRUE)
      ) + 1 # set first to next id
  }else{
    df_nas[1,]     <- NA 
    df_nas$span_id <- NA
  }
  #   - process
  for( i in seq_dim1(df_nas)[-1] ){
    if( 
      df_nas$date[i] - df_nas$date[i-1] > 1   | 
      !(df_nas[[2]][i] %in% df_nas[[2]][i-1]) | 
      !(df_nas[[3]][i] %in% df_nas[[3]][i-1]) 
    ) { # broken sequence
      df_nas$span_id[i] <- max(df_nas$span_id, na.rm = TRUE)+1 # -> new id
    }else{
      df_nas$span_id[i] <- df_nas$span_id[i-1] # -> old id
    }
  }
  #   - aggregate
  df_nas_aggregated <- 
    data.frame(
      aggregate(df_nas, by=list(span_id=df_nas$span_id), min)[,-1],
      aggregate(df_nas$date, by=list(df_nas$span_id), max)$x
    )
  names(df_nas_aggregated)[1] <- "start"
  names(df_nas_aggregated)[5] <- "end"
  
  # putting together
  df_res <- rbind(df_aggregated, df_nas_aggregated)
  
  # polish: column names, column order, row order
  df_res <- df_res[order(df_res$start, df_res$end, df_res[[1]], df_res[[2]]), ]
  df_res$span_id <- seq_dim1(df_res)
  df_res <- data.frame(
    span_id=df_res$span_id,
    df_res[,names(df1)[1]],
    df_res[,names(df2)[1]],
    span_start=df_res$start,
    span_end=df_res$end
  )
  names(df_res)[2] <- names(df1)[1]
  names(df_res)[3] <- names(df2)[1]
  
  # return
  return(df_res)
}





#' function splitting sequence after certain date
#' @param start vector of start values
#' @param end vector of end values
#' @param splidate data after which time span shall be split 
#' @param parameter internally needed for recursion, leave it be
split_timespan_after <- function(start, end, splitdate, splitdateold=NA){
  splitdate <- sort(splitdate)
  # check
  stopifnot(length(start) == length(end))
  stopifnot(start <= end)
  # do simple
  if( length(splitdate)>1 & (length(start)>1 | length(end)>1) ){
    stop("cannot recur over splitdates and timespans at the same time")
  }
  if( length(splitdate)==1 & length(start)<=1 & length(end)<=1){
    if( start <= splitdate & splitdate <= end ){
      res <- 
        data.frame(
          start=c(start, splitdate+1),
          end=c(splitdate, end),
          splitdate=splitdate
        )
    }else{
      res <- 
        data.frame(
          start=start,
          end=end,
          splitdate=splitdateold
        )
    }
    return(
      res[ res$start <= res$end , ]
    )
  }else{
    # do recursion
    res <- data.frame(start=start, end=end, splitdate=NA)
    for( i in seq_along(splitdate) ){
      res <- 
        do.call(
          rbind, 
          mapply(
            split_timespan_after,
            start=res$start,
            end=res$end, 
            splitdateold=res$splitdate,
            MoreArgs = list(splitdate = splitdate[i] ) ,
            SIMPLIFY=FALSE
          )
        )
      splitdateold <- splitdate[i]
    }  
    return(res)
  }
}


#' expanding time spans to sequernce of days
#' @param x a matrix like object with dates; column 1: start dates; column 2: end dates
expand_spans <- function(x){ seq( x[1,1], x[1,2], "day") } 





#' matching ids to dates
#' 
#' function matching a sequence of dates and a data frame of id, start, end
#' @param full_day_sequence a sequence of days span ids should be matched to
#' @param df a data frame containing span inforamtion with 
#' @import hellno
mfts_match_dates_to_id <- function(full_day_sequence, df){
  # initialize dataframe for storage 
  # column 1: date; column 2: id
  df_fds <- 
    data.frame(
      as.Date(NA), 
      vector(mode=class(df[[1]]), length=1), 
      stringsAsFactors = FALSE
    )
  names(df_fds) <- c("date", names(df)[1] )
  # cycle through spand from df 
  for ( i in seq_along(df[,1]) ){
    df_tmp <- 
      data.frame(
        full_day_sequence[full_day_sequence %in% expand_spans( df[i,2:3] )], 
        df[i,1]
      )
    names(df_tmp) <- c("date", names(df)[1] )
    df_fds <- rbind(df_fds, df_tmp)
  }
  # return
  
  return( as_data_frame(df_fds)[!is.na(as_data_frame(df_fds)$date), ] )
}
