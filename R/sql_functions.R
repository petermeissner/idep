#' Some funtions making life easier for handling Databases from within R
#'

sqlEscape <<- function(data){
  iffer <- is.na(data)
  data  <- paste0( "'", dbEscapeStrings(socon, as.character(data)) , "'")
  data[iffer] <- "NULL"
  data
}

genUpdate <- function(tablename, columnnames, values){
  sql <- paste(
    "UPDATE ", tablename ," SET ",
    paste(paste0(columnnames," = ", sqlEscape(values) ),collapse=", ")
    ," ",sep="")
  sql
}



genInsert <- function(tablename, columnnames, values){
  sql <- paste(
    "INSERT INTO ", tablename ,
    " (",        paste0(columnnames       , collapse=", ") ,")",
    " VALUES (", paste0(sqlEscape(values) , collapse=", ") ,") "
    ,sep="")
  sql
}


dbGetQueries <<- function(con, SQL){
  dummyfunc <- function(sql){dbGetQuery(con, sql)}
  res <- unlist(plyr::llply(SQL, dummyfunc, .progress="text"))
  res
}


genInserts <- function(tablename, data){
  # checking for differs in length
  lengths <- NULL
  for(i in seq_along(data)){
    lengths <- c(lengths,length(data[[i]]))
  }
  if(!all(lengths == 1 | lengths == max(lengths))){
    problems <- paste(  names(data)[!(lengths == 1 | lengths == max(lengths))],
                        ", size:",
                        lengths[!(lengths == 1 | lengths == max(lengths))]
    )
    stop(paste( "All supplied data has to be of length 1 or n.",
                "Have a look at ...\n", paste(problems, collapse="\n")))
  }
  # producing the sql statements
  colnames <- paste0("`",names(data),"`")
  sqlstart <- paste(
    "INSERT INTO ", tablename ,
    " (",        paste0(colnames       , collapse=",\n ") ,")")
  SQL <- NULL
  pb <- txtProgressBar(style = 3)
  for(i in 1:max(lengths)){
    SQL[i]  <-  paste(  sqlstart, 
                        " \nVALUES (\n",
                        paste( sapply( as.data.frame( data, stringsAsFactors=F )[i,], sqlEscape ), 
                               collapse=", "),
                        "\n)"
    ) 
    setTxtProgressBar(pb, i/max(lengths) )
  }
  SQL
}

genUpdates <- function(tablename, data){
  # checking for differs in length
  lengths <- NULL
  for(i in seq_along(data)){
    lengths <- c(lengths,length(data[[i]]))
  }
  if(!all(lengths == 1 | lengths == max(lengths))){
    problems <- paste(  names(data)[!(lengths == 1 | lengths == max(lengths))],
                        ", size:",
                        lengths[!(lengths == 1 | lengths == max(lengths))]
    )
    stop(paste( "All supplied data has to be of length 1 or n.",
                "Have a look at ...\n", paste(problems, collapse="\n")))
  }
  # producing the sql statements
  sqlstart <- paste( "UPDATE ", tablename , " SET " )
  dataDF   <- as.data.frame( data, stringsAsFactors=F ) 
  SQL      <- NULL
  for(i in 1:max(lengths) ){
    SQL[i]  <-  sqlstart
    for(k in seq_along(data) ){
      if(k==1) tmpsep = " " else tmpsep = ", "
      keydata <- paste(names(data)[k], "=", sqlEscape(dataDF[i,k]))
      SQL[i]  <- paste(SQL[i], keydata, sep=tmpsep ) 
    }
  }
  SQL
}




genInsertsDKU <- function(tablename, data){
  SQL <- genInserts(tablename, data)
  SQL <- paste(SQL, " ON DUPLICATE KEY UPDATE ")
  dataDF <- as.data.frame( data, stringsAsFactors=F )
  pb <- txtProgressBar(style = 3)
  for(i in seq_along(names(data)) ){
    if(i!=1){ SQL <- paste( SQL, "," ) }
    SQL <- paste(SQL, paste0("`",names(data)[i],"`"), "=", sqlEscape(dataDF[,i]))
    setTxtProgressBar(pb, i/length(data))
  }
  close(pb)
  SQL
}                




###
### some functions making Life easier for handling IDEP Database
###



#### ................ packages  ................ ####
require(stringr)
require(digest)



#### ................ functions ................ ####

#version tag
sqlVersionTag <- function(con, shortdesc="", description="",versionnumber="auto",tabname="version",hash=""){ 
  data <- list()
  data$changedate <- as.character(Sys.time())
  if(shortdesc!="")       data$shortdesc      <- shortdesc
  if(description!="")     data$description    <- description
  if(versionnumber!="" & versionnumber!="auto")   data$versionnumber  <- versionnumber
  if(hash!="")            data$hash  <- hash
  vtab <- dbReadTable(con,tabname)
  vmax <- vtab$versionnumber
  if(length(vmax)==0){ vmax <- 0 }
  vmax <- ifelse(    is.na(vmax), 0, vmax)
  vmax <- max(as.numeric(vmax))
  if(is.function(versionnumber)){
    data$versionnumber <- versionumber(vmax)
  }
  if(versionnumber=="auto"){
    data$versionnumber <-  vmax + 0.01
  }
  if(hash!="" & any(vtab$hash[!is.na(vtab$hash)]!="") ){
    if(hash %in% vtab$hash){ data$versionnumber <- vmax }
  }
  sql <- genInserts(tabname, data)
  dbGetQuery(con, sql)
}

#metachange table hash
metachangeHash <- function(socon){
  hashdata <- dbReadTable(socon,"metachange")
  hashdata <- hashdata[,!(names(hashdata) %in% c("time.1","time.2","intdatupdate","ctr"))]
  hashd    <- digest(hashdata)
  return(hashd)
}

#metachange last change to DB
metachangeLastchange <- function(socon){
  version <- dbReadTable(socon,"version")
  maxDate <- max(version$changedate)
  maxHash <- version$hash[version$changedate==maxDate]
  min(version$changedate[version$hash==maxHash])
}

#version tag
sqlVersionTag <- function(con, shortdesc="", description="",versionnumber="auto",tabname="version",hash=""){ 
  data <- list()
  data$changedate <- as.character(Sys.time())
  if(shortdesc!="")       data$shortdesc      <- shortdesc
  if(description!="")     data$description    <- description
  if(versionnumber!="" & versionnumber!="auto")   data$versionnumber  <- versionnumber
  if(hash!="")            data$hash  <- hash
  vtab <- dbReadTable(con,tabname)
  vmax <- vtab$versionnumber
  if(length(vmax)==0){ vmax <- 0 }
  vmax <- ifelse(    is.na(vmax), 0, vmax)
  vmax <- max(as.numeric(vmax))
  if(is.function(versionnumber)){
    data$versionnumber <- versionumber(vmax)
  }
  if(versionnumber=="auto"){
    data$versionnumber <-  vmax + 0.01
  }
  if(hash!="" & any(vtab$hash[!is.na(vtab$hash)]!="") ){
    if(hash %in% vtab$hash){ data$versionnumber <- vmax }
  }
  sql <- genInserts(tabname, data)
  dbGetQuery(con, sql)
}














