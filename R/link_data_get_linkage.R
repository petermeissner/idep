#' function extracting linkage information

link_data_get_linkage <- function(res, meta){
  # easy paste
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
  
  # putting together data
  id1          <- meta$id1  %.% "_"  %.% str_pad(res$oldline,4,"left","_")
  id2          <- meta$id2  %.% "_"  %.% str_pad(res$newline,4,"left","_")
  sim          <- linkage_sim(res, "sim")
  sim_wd       <- linkage_sim(res, "sim_wd")
  diff         <- linkage_sim(res, "diff")
  diff_wd      <- linkage_sim(res, "diff_wd")
  type         <- type
  lnr1         <- res$oldline
  lnr2         <- res$newline
  textid1      <- meta$id1
  textid2      <- meta$id2
  minmaj_code  <- res$diff
  minmaj_coder <- res$coder2
  minmaj_memo  <- res$comments
  linkage_coder<- res$coder
  tmp          <- data.frame( id1, id2, 
                              sim, sim_wd, 
                              diff, diff_wd, 
                              type, 
                              textid1, textid2, 
                              lnr1, lnr2,
                              minmaj_code, minmaj_coder, 
                              minmaj_memo, linkage_coder)

  # dropping sim_wd==0 & diff_wd==0 --> (wd1 & wd2) == 0
  tmp <- tmp[ !(sim_wd==0 & diff_wd==0) , ]
  
  # correcting for re-calculation of similarities for type "no-change"
  iffer   <- tmp$type=="no-change" & tmp$sim < 1 
  tmp_tmp <- tmp[iffer,]
  tmp[iffer,"sim"]     <- 1
  tmp[iffer,"diff"]    <- 0
  tmp[iffer,"diff_wd"] <- 0
  tmp[iffer,"sim_wd"]  <- tmp_tmp$diff_wd + tmp_tmp$sim_wd
  
  # return
  return(tmp)
}





