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
  x[is.na(x)] <- 0
  x
}

#' function that transforms NAs to empty string
na_to_empty <- function(x){
  x[is.na(x)] <- 0
  x
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
    if( file.copy(from, to) ){
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












