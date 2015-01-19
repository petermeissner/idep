 
#link_files_get_linkage <- function(){
  # apply function definition
  worker2 <- function(linkage_env) {
    res  <- eval(as.name(linkage_env))$RESULTS
    meta <- eval(as.name(linkage_env))$meta
    link_data_get_linkage(res, meta) 
  }
  # data extraction  

  for ( i in seq_along(linkage_env) ) {
    ldply(linkage_env[[i]], worker2, .progress="text")
    print(i)
  }

  ldply(linkage_env[[33]], worker2, .progress="text")
  
  
  res  <- eval(as.name(linkage_env[[33]]))$RESULTS
  meta <- eval(as.name(linkage_env[[33]]))$meta

  
  '%.%' <- function(a,b) paste0(a,b)
  
  # subset res to relevant only
  res <- res[res$relevant==1,]
  res$oldline <- ifelse(is.na(res$oldline),"",res$oldline)
  res$newline <- ifelse(is.na(res$newline),"",res$newline)
  
  # set minmaj NA to 0 if relevant==1 and similarity==1
  res$diff <- ifelse( ( is.na(res$diff) & res$similarity==1 & res$relevant==1 ),
                      0,
                      res$diff)
  
  # type 
  type <- linkage_type(res)
