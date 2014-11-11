#' function extracting the texts from link data 

link_data_get_text <- function(RESULTS, both=T){
  # text 1
  l1 <- as.numeric(RESULTS$oldline)
  t1 <- RESULTS$Aorigtext[order(l1)]
  r1 <- RESULTS$relevant[order(l1)]
  l1 <- l1[order(l1)]
  iffer <- !duplicated(l1) & !is.na(l1)
  l1 <- l1[iffer]
  t1 <- t1[iffer]
  r1 <- r1[iffer]
  
  l2 <- as.numeric(RESULTS$newline)
  t2 <- RESULTS$Borigtext[order(l2)]
  r2 <- RESULTS$relevant[order(l2)]
  l2 <- l2[order(l2)]
  iffer <- !duplicated(l2) & !is.na(l2)
  l2 <- l2[iffer]
  t2 <- t2[iffer]
  r2 <- r2[iffer]
  
  return(list(l1=l1, 
              t1=t1, 
              r1=r1, 
              l2=l2, 
              t2=t2, 
              r2=r2 )
         )
}
