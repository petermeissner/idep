#' present linkage information in HTML file

linkage_to_html <- function(linkagedata, out=""){
  if(out=="") out <- tempfile(fileext=".html")
  
  # packages
  require(R2HTML)
  require(stringr)
  
  # data preparation // sorting
  if( all( c("diff","coder2","comments") %in% names(linkagedata) ) ){
    X <- linkagedata[ order(as.numeric(linkagedata$oldline),as.numeric(linkagedata$newline)),
                      c("oldline","oldtext","newline","newtext","relevant","similarity","diff","comments")]
  }
  if( all( c("diff","coder2") %in% names(linkagedata) & !all(c("diff","coder2","comments") %in% names(linkagedata) )) ){
    X <- linkagedata[ order(as.numeric(linkagedata$oldline),as.numeric(linkagedata$newline)),
                      c("oldline","oldtext","newline","newtext","relevant","similarity","diff")]
  }
  if( !any( c("diff","coder2","comments") %in% names(linkagedata) ) ){
    X <- linkagedata[ order(as.numeric(linkagedata$oldline),as.numeric(linkagedata$newline)),
                      c("oldline","oldtext","newline","newtext","relevant","similarity")]
  }
  
  X$oldline <- as.numeric(X$oldline)
  X$newline <- as.numeric(X$newline)
  X$relevant <- as.numeric(X$relevant)
  X$similarity <- ifelse(X$similarity==1 | X$similarity==0,X$similarity,round(as.numeric(X$similarity),2))
  
  # putting newlines in right place
  X <- X[ordertext(X$oldline,X$newline),]
  
  # mark, non relevant, del, ins
  X$oldline[is.na(X$oldline) & is.na(X$relevant)] <- "reset"
  X$newline[is.na(X$newline) & is.na(X$relevant)] <- "reset"
  X$oldline[is.na(X$oldline) & X$relevant==0] <- "not rel."
  X$newline[is.na(X$newline) & X$relevant==0] <- "not rel."
  X$oldline[is.na(X$oldline)] <- "ins."
  X$newline[is.na(X$newline)] <- "del."
  
  # write in HTML
  #fout <- paste0(out,".html")
  fout<-out
  if(out=="NEW")                  fout <- paste0("RESETS",".html")
  if(out=="RESULTS")              fout <- paste0("AS IS",".html")
  if(out=="linkageEnv$RESULTS")   fout <- paste0("AS IS",".html")
  target <- HTMLInitFile( ".",
                          filename=str_replace(fout,".html",""), 
                          Title=str_replace(fout,".html",""), 
                          HTMLframe=F, useLaTeX=F,useGrid=F ,
                          CSSFile="http://mbtnr.net/js/R2HTML.css")
  if(exists("resetsfull")) if(out=="NEW") HTML(resetsfull, file=target, classtable="innerTable", caption = "specified resets")
  if(exists("resets")) if(out=="NEW") HTML(resets, file=target, classtable="innerTable", caption = "resets applyable to data")
  HTML(X, file=target, classtable="innerTable", caption="DATA")
  HTMLEndFile(file=target)
  
  # some cleansing
  tmp <- readLines(fout, warn=F)
  headeradd <- '<script src="http://mbtnr.net/js/R2HTML.js"></script>\n
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>\n
  <script src="http://www.pmeissner.com/js/stickyTableHeaders.js"></script>\n'
  tmp <- c(tmp[1:(length(tmp)-2)],headeradd,tmp[(length(tmp)-1):length(tmp)])
  writeLines(tmp,fout)
  
  invisible(X)
}

# function ordering according to linenumbers so that 
ordertext <- function(x,y){
  order(ifelse(is.na(x),as.numeric(y)+0.5,as.numeric(x)))
}



