
# function that merges according to time span overlaps
merger_for_time_spans <- function(df1, df2){
  require(dplyr)
  # helper function
  expand_spans <- function(x){ seq( x[1,1], x[1,2], "day") } 
  
  # input check 
  stopifnot( dim(df1)[2] >=3 ) 
  stopifnot( dim(df2)[2] >=3 )
  stopifnot( all(class(df1) =="data.frame") )
  stopifnot( all(class(df2) =="data.frame") )
  stopifnot( lapply(df1[,2:3], class) %in% "Date")
  stopifnot( lapply(df2[,2:3], class) %in% "Date")
  
  # expand span to all dates
  dmax <- max(c(df1[[2]], df1[[3]], df2[[2]], df2[[3]]), na.rm=TRUE)
  dmin <- min(c(df1[[2]], df1[[3]], df2[[2]], df2[[3]]), na.rm=TRUE)
  dates  <- seq(dmin, dmax, "day")
  
  # match expanded dates with df1 spans
  df_dates1 <- 
    data.frame(
      as.Date(NA), 
      vector(mode=class(df1[[1]]), length=1), 
      stringsAsFactors = FALSE
    )
  names(df_dates1) <- c("date", names(df1)[1] )
  
  for ( i in seq_along(df1[,1]) ){
    df_tmp <- 
      data.frame(
        dates[dates %in% expand_spans( df1[i,2:3] )], 
        df1[i,1]
      )
    names(df_tmp) <- c("date", names(df1)[1] )
    df_dates1 <- rbind(df_dates1, df_tmp)
  }
  df_dates1 <- as_data_frame(df_dates1)
  
  # match expanded dates with df2 spans
  df_dates2 <- 
    data.frame(
      as.Date(NA), 
      vector(mode=class(df2[[1]]), length=1), 
      stringsAsFactors = FALSE
    )
  names(df_dates2) <- c("date", names(df2)[1] )
  
  for ( i in seq_along(df2[,1]) ){
    df_tmp <- 
      data.frame(
        dates[dates %in% expand_spans( df2[i,2:3] )], 
        df2[i,1]
      )
    names(df_tmp) <- c("date", names(df2)[1] )
    df_dates2 <- rbind(df_dates2, df_tmp)
  }
  df_dates2 <- as_data_frame(df_dates2)
  
  # merge expanded dates and df1 / df2
  # to get data.frame that has all dates 
  # and for each date matched id1, id2 if availible
  #  id1 &  id2  - covered by both
  #  id1 & !id2  - not covered by id2 but by id1
  # !id1 &  id2  - not covered by id1 but by id2
  # !id1 & !id2  - covered by neither 
  df <- 
    data_frame(date=dates) %>% 
    left_join(df_dates1) %>% 
    left_join(df_dates2) %>% 
    arrange(date) %>% 
    filter(!is.na(date)) 
  
  ## add span_id variable according to changes in df1 id and df2 id 
  
  # getting started
  df <- df[order(df[[1]], df[[2]], df[[3]]),]
  
  # separate data covered spans and those not covered
  iffer <- apply(df[, 2:3], 1, function(x){all(is.na(x))})
  
  # unique combinations of id1 - id2 get unique span_id
  tmp1 <- df[!duplicated(df[, 2:3]) & !iffer, ]
  tmp1$span_id1 <- NA
  tmp1$span_id1 <- seq_along(tmp1$span_id1)
  tmp1 <- tmp1[, c(   2, 3, 4)]
  
  # unbroken sequences of days get unique id
  tmp2 <- df[iffer, ]
  if( dim(tmp2)[1] > 0 ){
    tmp2$span_id2 <- NA
  }else{
    tmp2[1,] <- NA
    tmp2$span_id2 <- NA
  }
  tmp2 <- tmp2[order(tmp2$date),]
  if( dim(tmp2)[1] > 0 ){
    tmp2[1,]$span_id2 <- max(tmp1$span_id1, na.rm=TRUE) + 1
  }
  for( i in seq_dim1(tmp2)[-1] ){
    if( tmp2$date[i] - tmp2$date[i-1] > 1 ) { # broken sequence
      tmp2$span_id2[i] <- max(tmp2$span_id2, na.rm = TRUE)+1 # -> new id
    }else{
      tmp2$span_id2[i] <- tmp2$span_id2[i-1] # -> old id
    }
  }
  tmp2 <- tmp2[!duplicated(tmp2$date), ]  
  tmp2 <- tmp2[,2:4]
  
  df <- 
    df  %>% 
    full_join(tmp1) %>% 
    full_join(tmp2) %>% 
    filter(
      !is.na(.[[2]]) | !is.na(.[[3]])
    )  %>% 
    mutate(
      span_id = ifelse( is.na(span_id1), span_id2, span_id1 )
    )  %>% 
    select(
      -span_id1, -span_id2
    ) %>% 
    group_by(
      span_id
    ) %>% 
    summarize(
      so_id  = first(so_id), 
      cab_id = first(cab_id), 
      span_start = min(date, na.rm=TRUE),
      span_end   = max(date, na.rm=TRUE)
    )
  
  return(df)
}



#' seq_dim1
seq_dim1 <- function(x){
  if( is.vector(x) ){
    return(seq_along(x))
  }
  return(seq_len(dim(x)[1]))
}

#' seq_dim2
seq_dim2 <- function(x){
  if( is.vector(x) ){
    return(NULL)
  }
  return(seq_len(dim(x)[2]))
}


#' wrapper for browseURL()
goto <- function(x=getwd()){
  browseURL(URLencode(x))
}

#' make automatically named list 
#' 
#' ricardo: \link{http://stackoverflow.com/a/21059868/1144966}
named_list <- function(...){
  anonList <- list(...)
  names(anonList) <- as.character(substitute(list(...)))[-1]
  anonList
}

#' function for handling function calls
function_call <- function(){
  res <- list()
  call_info       <- sys.call(sys.parent())
    res$info <- call_info
  call_function   <- call_info[[1]]
    res$func <- as.character(call_function )
  call_par_names  <- names(as.list(call_info)[-1])
    res$par_names <- call_par_names
  call_par_names  <- ifelse(nchar(call_par_names)>0, paste(call_par_names, "=", sep=""), call_par_names)
  call_par_values <- call_info[-1]
    res$par_values <- as.character(call_par_values)
  call_par        <- paste(call_par_names, call_par_values, collapse=", ", sep="")
  full_call       <- paste0(call_function, "(", call_par, ")")
    res$call <- full_call
  return(res)
}


#' email error
#' @param s subject 
#' @param body body of email
#' @param anyways if set to true function will mail also when in non-interactive mode while the default is to no mail 
email_error <- function(..., s="", body="", anyways=F, to="retep.meissner@gmail.com"){
  if ( !interactive() | anyways==T ){
      fc <- function_call()
    blatr::blat( 
      to   = to,
      s    = paste0("[Rerror] : ", fc$func,", ", s),
      body = paste0(Sys.time(), " \n\n", 
                    "[ Rerror        ] : ", fc$call,", ", "\n",
                    "[ getwd()       ] : ", getwd(), "\n",
              paste("[ commandArgs() ] : ", commandArgs(), "\n", collapse = "", sep=""),
                    "\n\n", paste(body, collapse = "\n"), paste(..., collapse = "\n")) 
    )
  }
}

#' function for getting the history
get_history <- function(){
  tmpf <- tempfile()
  savehistory(tmpf)
  rev(readLines(tmpf))
}


#' factors to character

factors_to_character <- function(x){
  if( "list" %in% class(x) ){
    for( i in seq_along(x) ){
      x[[i]] <- factors_to_character(x[[i]])
    }
    return(x)
  }
  if( "tbl_df" %in% class(x) ){
    x <- as.data.frame(x)
    for( i in seq_along(x) ){
      x[[i]] <- factors_to_character(x[[i]])
    }
    return(as_data_frame(x))
  }
  if( "data.frame" %in% class(x) ){
    for( i in seq_along(x) ){
      x[,i] <- factors_to_character(x[,i])
    }
    return(x)
  }
  if( "factor" %in% class(x) ){
    x <- as.character(x)
    return(x)
  }
  return(x)
}

#' get classes
#' @param x list or data frame
#' @return returns list with class attributes of length equal to length(x)
#' 

classes <- function(x){
  lapply(x, class)
}


#' function that transforms NAs to FALSE
na_to_false <- function(x){
  x[is.na(x)] <- FALSE
  x
}

#' function that transforms NAs to TRUE
na_to_true <- function(x){
  x[is.na(x)] <- TRUE
  x
}

#' function that transforms NAs to 0
na_to_zero <- function(x){
  if( any(class(x) %in% "POSIXct") ){ 
    x[is.na(x)] <- as.Date(x, origin = "0000-01-01")
  }else{
    x[is.na(x)] <- 0 
  }
  x
}

#' function that transforms NAs to empty string
na_to_empty <- function(x){
  x[is.na(x)] <- ""
  x
}

#' function that tests value for NA | TRUE
is_true_or_na <- function(x) is.na(x) | x == TRUE

#' function that tests value for NA | FALSE
is_false_or_na <- function(x) is.na(x) | x == FALSE


#' function transforming NULL (non-values) to NA
#' 
null_to_na <-function(x) {
  if( is.null(x) | length(x)==0 ){
    return(NA)
  }
  return(x)
}

#' function transforming NULL (non-values) to FALSE
#' 
null_to_false  <-function(x) {
  if( is.null(x) | length(x)==0 ){
    return(FALSE)
  }
  return(x)
}

#' function transforming NULL (non-values) to TRUE
#' 
null_to_true   <-function(x) {
  if( is.null(x) | length(x)==0 ){
    return(TRUE)
  }
  return(x)
}



#' function transforming NULL and NA (non-values) to TRUE
#' 
empty_to_true <- function(x){ 
  na_to_true(null_to_true(x))
}


#' function transforming NULL and NA (non-values) to FALSE
#' 
empty_to_false <- function(x){ 
  na_to_false(null_to_false(x))
}







#' function that does a more convenient table, always showing NAs
tab  <- function(...){
    table(..., useNA = "always")
}

#' function for tabulating one variable 
tab1 <- function(..., sort=FALSE){
  if( sort==TRUE ){
    a   <- as.matrix(sort(tab(...))) 
  }else{
    a <- as.matrix(tab(...))
  }
  res <- data.frame(cat=rownames(a), N=a, p=a/(sum(a)-as.integer(tail(a,1))), p_na=a/(sum(a))  , row.names=NULL)
  return(res)
}

#' function evaluating command line arguments to R that are in the form of a='value'
eval_cl_args <- function(){
  args <- grep(".+=.+", commandArgs(), value = TRUE)
  eval_globally <- function(x) eval(parse(text=x), envir = globalenv())
  lapply(args, eval_globally)
  return(commandArgs())
}

#' function setting value to object if not existing
if_not_exists <- function(name, value){
  obj_name <- deparse(substitute(name))
  if ( !exists(obj_name, envir = parent.frame()) ) {
    assign(obj_name, value, envir = parent.frame() )
    return(TRUE)
  }else{
    return(FALSE)
  }
}

#' function for moving files via copy / delete (inefficient)
file.move <- function(from, to){
  if(length(from)==0) return(TRUE)
  dummy <- function(from,to){
    if( file.copy(from, to, recursive = TRUE) ){
      file.remove(from)
    }
  }
  mapply(dummy, from, to)
}

#' function that determines if something might be an id (distinct and either integer or character)
is_id <- function(x){
  if( !(length(x) == length(unique(x))) )                  return(FALSE)
  if( !(class(x) %in% "character" | all(x == suppressWarnings(as.integer(x)))) )  return(FALSE)
  return(TRUE)
}


#' country shorthands used throughout the project
country_short <- 
  c( "AUT", "BEL", "DEN", "ESP", "FRA", "GER", "IRE", "ITA", "LUX", 
     "NED", "NOR", "POR", "SWE", "SWIGRN", "SWIPARLG", "UK")

#' country names matching the shorthands
country_long <- 
  c( "Austria", "Belgium", "Denmark", "Spain", "France", "Germany", 
     "Ireland", "Italy", "Luxembourg", "Netherlands", "Norway", 
     "Portugal", "Sweden", "Switzerland", "Switzerland", "United Kingdom")


#' short to country
short_to_coutry <- function(x){
  country_long[match(x, country_short)]
}

#' country to short
country_to_short <- function(x){
  country_short[match(x, country_long)]
}


#' function for keeping only selected objects
keep <- function(...){
  if ( !interactive() ) stop("mgiht only be used interactively")
  fpvs <- function_call()$par_values
  ls_tmp <- ls(envir=globalenv())[!(ls(envir=globalenv()) %in% function_call()$par_values)]
  rm( list = ls_tmp , envir = globalenv())
  return(ls_tmp)
}



#' function plotting the range of a variable 
#' @param x varaible to be plotted

plot_var_overview <- function(x){
  if( (is.numeric(x) | class(x)=="Date") ){
    par("mar" = c(2,0,0,0))
    plot(range(x, na.rm=TRUE), c(0,1), type="n", ylab = "", yaxt="n", xlab="", xaxt="n", ylim=c(-0.2,2.2))
    axis(1, at=summary(x)[c(1,4,6)], cex.axis=1.25)
    if( class(x)=="Date" ) x <- as.numeric(x)
    dx <- density(x, na.rm=TRUE)
    segments(x0=x, x1=x, y0=0, y1=1, col="#00000060")
    lines(dx$x, dx$y * 2 / max(dx$y), col="#EEEEEECC", lwd=10)
    lines(dx$x, dx$y * 2 / max(dx$y), lwd=5, col="#808080AA")
    lines(dx$x, dx$y * 2 / max(dx$y), lwd=2, col="#000000")
  }
}



#' function wrapper for grep(,value=TRUE)
#' @param pattern regular expression to look for
#' @param x text to look through
#' @param ... passed through to grep(pattern, x, value = TRUE, ...)
grepv <- function(pattern, x, ...){grep(pattern, x, value = TRUE, ...)}


#' function to describe variables in data.frame
#' @param df data.frame to be described
#' @param what metric to put out
#' @param cols columns of data.frame for which to put out metrics
#' @param digits shall numbers be rounded to a certain amount of diogits?
desc_df <- function(
  df, 
  what=c("class", "nas","min", "modus", "max"), 
  cols=TRUE,
  digits=2
){
  tmp <- as.data.frame(t(as_data_frame(classes(df))), stringsAsFactors=FALSE)
  tmp <- data.frame(name=rownames(tmp), class=tmp[,1], stringsAsFactors = FALSE)
  
  # calculating statistics
  suppressWarnings({
    tmp$nas   <- unlist( lapply(df, function(x){as.character(sum(is.na(x)))} ))
    tmp$min   <- unlist( lapply(df, function(x){as.character(min(x, na.rm = TRUE))} ))
    tmp$mean  <- unlist( lapply(df, function(x){as.character(mean(x, na.rm = TRUE))} ))
    tmp$modus <- unlist( lapply(df, function(x){as.character(modus(x))} ))
    tmp$median<- unlist( lapply(df, function(x){as.character(median(x, na.rm = TRUE))} ))
    tmp$max   <- unlist( lapply(df, function(x){as.character(max(x, na.rm = TRUE))} ))
  })
  
  # applying round
  if(digits >=1 ){
    for(j in seq_len(dim(tmp)[2])){
      for(i in seq_len(dim(tmp)[1])){  
        tmp[i,j] <- 
          ifelse(
            suppressWarnings(is.na(as.numeric(tmp[i,j]))),
            tmp[i,j],
            round(as.numeric(tmp[i,j]), digits)
         )
      }
    }
  }
  
  # nameing
  tmp <- tmp[cols, c("name", what)]
  # return
  return(tmp)
}


#' method for POSIXct
`/.POSIXt` <- function(x,y) as.POSIXct(as.numeric(x) / as.numeric(y), origin="1970-01-01")

#' method for POSIXct
`+.POSIXt` <- function(x,y) as.POSIXct(as.numeric(x) + as.numeric(y), origin="1970-01-01")


#' function for making rank plots
rankplot <- function(x, label, axislab="", ...){
  label <- label[order(x)]
  x     <- x[order(x)]
  rangex    <- diff(range(x))
  minx      <- min(x)
  maxx      <- max(x)
  nx        <- length(x)
  label_pos <- seq(minx, maxx, rangex / (nx-1))
  
  ggplot() + 
    theme_bw() +
    geom_segment(
      aes(x=0.07, y=mean(x), xend=0.09, yend=mean(x)), 
      colour="#10101080"
    )+
    geom_segment(
      aes(x=0.31, y=mean(x), xend=0.33, yend=mean(x)), 
      colour="#10101080"
    )+
    geom_text(
      aes(x=0.2, y=label_pos,label=label), 
      hjust=0, ...
    ) + 
    geom_point(
      aes(x=0.1, y=x),
      colour="#10101080"
    ) + 
    geom_segment(
      aes(x=0.11, y=x, yend=label_pos, xend=0.19), 
      colour="#10101080"
    ) +
    ggtitle(axislab) + 
    theme(
      axis.text.x  = element_blank(), 
      axis.ticks.x = element_blank(), 
      axis.title.y = element_blank(),
      axis.title.x = element_blank(),
      axis.text.y = element_text(size=5, angle = 60), 
      plot.title = element_text(size=6)
    ) + 
    geom_blank(aes(x=0.30,y=x)) + 
    geom_blank(aes(x=0.075,y=x)) 
}



#' function for restricting size of string
#' @param text vector of text 
maxchar <- function(text, maxchar=5, indicator=" ..."){
  stopifnot(nchar(indicator) <= maxchar)
  ifelse(
    nchar(x)<=maxchar, 
    x, 
    paste0(substring(text, 1, maxchar-4), " ...")
  )
}
































