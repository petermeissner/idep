#' function that checks whether text b of linkage 1 and text a of linkage 2 are identical

link_data_check_textconsistency <- function(link_texts, filelist_full){
  meta <- get_meta_from_fname(filelist_full)
  res  <- data.frame(id1=meta$id1,id2=meta$id2,N_texts_differ=NA)
  
  problems <- list()
  for(i in seq_along(res[,1])) {
    problems[[i]] <- list(name=as.character(res$id2[i]),
                          t1=NA,t2=NA)
  }
  
  for ( i in seq_along(link_texts[-1])) {
    t1 <- link_data_clean_text(link_texts[[i]]$t2)
    t2 <- link_data_clean_text(link_texts[[i+1]]$t1)
    res[i,"N_texts_differ"] <- sum(t1 != t2)
    problems[[i]]$t1 <- null_to_na(t1[t1 != t2])
    problems[[i]]$t2 <- null_to_na(t2[t1 != t2])
  }
  
  df <- data.frame(name=NA,t1=NA,t2=NA)
  for(i in seq_along(problems)){
    tmp <-  data.frame(
                 name = problems[[i]]$name, 
                 t1   = problems[[i]]$t1,
                 t2   = problems[[i]]$t2      )
    df <- rbind(df, tmp)
  }
  problems <- df[!is.na(df$t1) | !is.na(df$t2), ]
  
  return(list(res=res, problems=problems))
}
