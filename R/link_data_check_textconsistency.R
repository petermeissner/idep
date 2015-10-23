#' function that checks whether text b of linkage 1 and text a of linkage 2 are identical

link_data_check_textconsistency <- function(link_texts, filelist_full){
  # helper
  text_not_equal <- function(text1,text2){
    text1 <- str_replace_all(text1, "  ", " ")
    text2 <- str_replace_all(text2, "  ", " ")
    not_equal <- text1 != text2
    not_equal[(text1 == "" | text1 == " ") & text2 == "-- NA --"] <- FALSE
    not_equal[(text2 == "" | text2 == " ") & text1 == "-- NA --"] <- FALSE
    return(not_equal)
  }
  
  ids <- NULL
  for ( i in seq_along(filelist_full[-1]) ) {
    ids[i] <- paste(basename(filelist_full)[(i):(i+1)], collapse=" // ")
  }
  ids   %<>%  
    str_replace_all("[[:alpha:]-]{3,6}","") %>% 
    str_replace_all("^ ","") %>% 
    str_replace_all("\\.","") 
    
  res  <- data.frame(id=ids, N_texts_differ=NA)
  
  problems <- list()
  for(i in seq_along(res[,1]) ) {
    problems[[i]] <- list(name=as.character(res$id[i]),
                          t1=NA,t2=NA)
  }
  
  del <- NULL 
  
  for ( i in seq_along(link_texts[-1])) {
    t1 <- link_data_clean_text(link_texts[[i]]$t2)
    t2 <- link_data_clean_text(link_texts[[i+1]]$t1)
    l1 <- link_texts[[i]]$l2
    l2 <- link_texts[[i+1]]$l1
    
    ldiff2 <- ifelse(length(t1)-length(t2) < 0 , 0 , length(t1)-length(t2))
    ldiff1 <- ifelse(length(t2)-length(t1) < 0 , 0 , length(t2)-length(t1))
    
    tt2 <- c(t2, rep("-- NA --", ldiff2))
    tt1 <- c(t1, rep("-- NA --", ldiff1))
    ll2 <- c(l2, rep(NA, ldiff2))
    ll1 <- c(l1, rep(NA, ldiff1))
    
    res[i,"N_texts_differ"] <- sum(text_not_equal(tt1, tt2))
    problems[[i]]$t1 <- paste("[",
                              unlist(lapply(ll1[text_not_equal(tt1, tt2)], null_to_na)), 
                              "]", ":",
                              unlist(lapply(tt1[text_not_equal(tt1, tt2)], null_to_na)))
    problems[[i]]$t2 <- paste("[",
                              unlist(lapply(ll2[text_not_equal(tt1, tt2)], null_to_na)), 
                              "]", ":",
                              unlist(lapply(tt2[text_not_equal(tt1, tt2)], null_to_na)))
    if( is.null(unlist(lapply(tt2[text_not_equal(tt1, tt2)], null_to_na))) ){
      del <- c(del,i)
    } 
  }
  
  problems[del] <- NULL
  
  return(list(res=res, problems=problems))
}


















