#' checks : check that all text lines ( max(lnr) ) ar included

dtest <- function(text_meta){
  dtest <- sum(is.na(text_meta[, c("daccept","dpromul","denact")])) /
    sum(!is.na(text_meta[, c("daccept","dpromul","denact")]))
  if(sum(dtest)==0){
    message("--- OK all dates extracted ---")
  }else{
    if(!interactive()){
      message("--- NOT all dates extracted")
      #email_error(s=ctr)
      #stop("dtest: failed")
    }
    return(text_meta)
  }
}


#' checks : check that all text lines ( max(lnr) ) are included
ltest <- function(text_texts){
  ltest <- link_data_check_textlength(text_texts)
  if(sum(ltest)==0){
    message("--- OK length test OK ---")
  }else{
    if(!interactive()){
      email_error(s=ctr)
      stop("ltest: failed")
    }
    return(ltest)
  }
}


#' checks : check that the second text of version n 
#'          is equal to the first text of version n+1
#'      ... which should be the case because these are 
#'          supposed to be the same texts
ctest <- function(link_texts, filelist_full){
  res <- link_data_check_textconsistency(link_texts, filelist_full)
  del   <- NULL
  for ( i in seq_along(res$problems) ) {
    if ( is.null(res$problems[[i]]$t1) ) del <- c(del, i)
  }
  res$problems[del] <- NULL
  if( sum(res$res$N_texts_differ)==0 ) {
    message("--- OK text comparison tests OK --- ")
    return(NULL)
  }else{
    if(!interactive()){
      email_error(s=ctr)
      stop("ctest: failed")
    }
    return(res)
  }
}


#' checks for lines relevant=1 and ccode==999 at the same time
#' @seealso \link{check_type_one} \link{check_type_two} \link{solve_type_one} \link{solve_type_two}
check_type_one <- function(data_linkage, data_lines){
  if ( any(class(data_linkage) == "list") ){
    data_lines   <- data_linkage$data_lines
    data_linkage <- data_linkage$data_linkage
  }
  # find problems 
  data_linkage1 <- 
    data_linkage %>% 
    select(ll_tl_id1, ll_tl_id2, ll_type)  %>% 
    mutate(tl_id = ll_tl_id1)
  
  data_linkage2 <- 
    data_linkage %>% 
    select(ll_tl_id1, ll_tl_id2, ll_type)  %>% 
    mutate(tl_id = ll_tl_id2)
  
  type_one <- 
    data_lines  %>% 
    filter( (tl_relevant==1 & tl_corpus_code==999) ) %>% 
    select(tl_id, tl_relevant, tl_corpus_code, tl_text)
  
  type_one_fw <- 
    data_lines  %>% 
    filter( (tl_relevant==1 & tl_corpus_code==999) ) %>% 
    inner_join(data_linkage1, by="tl_id") %>% 
    select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 
  
  type_one_bw <- 
    data_lines  %>% 
    filter( (tl_relevant==1 & tl_corpus_code==999) ) %>% 
    inner_join(data_linkage2, by="tl_id") %>% 
    select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 
  
  type_one_infos <- rbind(type_one_fw, type_one_bw)
  type_one_infos <- type_one_infos[order(type_one_infos$tl_id, type_one_infos$ll_tl_id1),]
  
  # print problems
  if( dim(type_one)[1]==0 ){
return(NULL)
  }else{
    return(named_list( type_one, type_one_infos, data_linkage, data_lines))
  }
}

#' solve where lines relevant=1 and ccode==999 at the same time
#' solution: 
#' - set relevant to 0 because ccoding is wiser
#' - delete linkage information for this line because it is not relevant!
#' @seealso \link{check_type_one} \link{check_type_two} \link{solve_type_one} \link{solve_type_two}
solve_type_one <- function(check_type_one_results){
  data_lines     <- check_type_one_results$data_lines
  data_linkage   <- check_type_one_results$data_linkage
  type_one       <- check_type_one_results$type_one
  type_one_infos <- check_type_one_results$type_one_infos
  # solution
  data_lines[
    data_lines$tl_id %in% type_one$tl_id, 
    ]$tl_relevant <- 0 
  data_linkage <- 
    data_linkage[ !(data_linkage$ll_tl_id1 %in% type_one$tl_id | data_linkage$ll_tl_id2 %in%  type_one$tl_id), ] 
  # return 
  return(named_list(data_linkage, data_lines))
}

#' wrapper for check_type_one() and solve_type_one()
t1test <- function(data_linkage, data_lines){
  tmp <- 
    solve_type_one(
      check_type_one(data_linkage, data_lines)
    )
  if ( is.null(check_type_one(tmp)) ){
    message("--- OK no type one errors (relevant==1 and ccode==999) OK---")
    res <- named_list(data_linkage, data_lines) 
    return(res)
  }else{
    if(!interactive()){
      email_error(s=ctr)
      q(save = "no")
    }else{
      stop("t1test: resolving inconsistencies did not work")
    }
  }      
}



#' function for checking differences between linkage and corpus coding
#' relevant = 0 but ccode != 999
#' @seealso \link{check_type_one} \link{check_type_two} \link{solve_type_one} \link{solve_type_two}
check_type_two <- function(data_linkage, data_lines){
  # corpus code != 999 but relevant = 0
  data_linkage1 <- 
    data_linkage %>% 
    select_("ll_tl_id1", "ll_tl_id2", "ll_type")  %>% 
    mutate(tl_id = ll_tl_id1)
  
  data_linkage2 <- 
    data_linkage %>% 
    select_("ll_tl_id1", "ll_tl_id2", "ll_type")  %>% 
    mutate(tl_id = ll_tl_id2)
  
  type_two <- 
    data_lines  %>% 
    filter( (tl_relevant==0 & tl_corpus_code!=999) ) %>% 
    select(tl_id, tl_relevant, tl_corpus_code, tl_text)
  
  type_two_fw <- 
    data_lines  %>% 
    filter( (tl_relevant==0 & tl_corpus_code!=999) ) %>% 
    inner_join(data_linkage1, by="tl_id") %>% 
    select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 
  
  type_two_bw <- 
    data_lines  %>% 
    filter( (tl_relevant==0 & tl_corpus_code!=999) ) %>% 
    inner_join(data_linkage2, by="tl_id") %>% 
    select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 
  
  type_two_infos <- rbind(type_two_fw, type_two_bw)
  type_two_infos <- type_two_infos[order(type_two_infos$tl_id, type_two_infos$ll_tl_id1),]
  
  if( dim(type_two)[1]==0 ){
    return(NULL)
  }else{
    res <- named_list( type_two, type_two_infos, data_linkage, data_lines)
    return(res)
  }
}

#' function for solving problems where ccode != 999 but rel = 0
#' solution:
#' - relevant <- 1 (ccode is wiser)
#' - linkage1 <- deletion (add forward conservative forward linking)
#' - linkage2 <- insertion (add conservative backward linking)
#' - minmaj   <- 0 (set minmaj conservatively to 0)
#' @seealso \link{check_type_one} \link{check_type_two} \link{solve_type_one} \link{solve_type_two}
solve_type_two <- function(check_type_two_results){
  
  # check necessity of solving anything
  if( is.null(check_type_two_results) ){
    return(NULL)
  }
  
  # expand inputs
  data_linkage   <- check_type_two_results$data_linkage
  data_lines     <- check_type_two_results$data_lines
  type_two       <- check_type_two_results$type_two
  type_two_infos <- check_type_two_results$type_two_infos
  
  # solution
  data_lines[data_lines$tl_id %in%  type_two$tl_id,]$tl_relevant <- 1
  
  suppressMessages(
    missing_deletions <-
      type_two  %>% 
      select(tl_id) %>% rename(ll_tl_id1=tl_id) %>% 
      anti_join(data_linkage) 
  )
  
  tmp_text <- left_join(missing_deletions, data_lines, by=c(ll_tl_id1="tl_id"))$tl_text
  tmp_id2  <- str_c(text_meta$id[match(str_extract(missing_deletions$ll_tl_id1,"\\w*_\\d*-\\d*-\\d*.\\d"), text_meta$id)+1], "_____")
  tmp <- 
    data_frame(
      ll_tl_id1        = missing_deletions$ll_tl_id1,
      ll_tl_id2        = tmp_id2,
      ll_sim           = 0,
      ll_sim_wd        = 0, 
      ll_diff          = 1,
      ll_diff_wd       = linkage_sim(data.frame( Aorigtext = tmp_text, Borigtext = "" ), simtype = "diff_wd" ), 
      ll_type          = "deletion", 
      ll_t_id1         = str_extract(missing_deletions$ll_tl_id1, "\\w*_\\d*-\\d*-\\d*.\\d"),
      ll_t_id2         = str_extract(tmp_id2,"\\w*_\\d*-\\d*-\\d*.\\d"),
      ll_tl_lnr1       = as.numeric(str_extract(missing_deletions$ll_tl_id1, "\\d*$")),
      ll_tl_lnr2       = NA, 
      ll_minmaj_code   = 0, 
      ll_minmaj_coder  = ifelse(str_detect(ctr, "^SWI"), NA, "Peter Auto Correct"),
      ll_minmaj_memo   = ifelse(str_detect(ctr, "^SWI"), "", "Peter Auto Correct"),
      ll_linkage_coder = ifelse(str_detect(ctr, "^SWI"), NA, "Peter Auto Correct")
    )  %>% filter( !is.na(ll_tl_id2) )
  data_linkage <- rbind(data_linkage, tmp)
  
  suppressMessages(
  missing_insertions <- 
    type_two  %>% 
    select(tl_id) %>% rename(ll_tl_id2=tl_id) %>% 
    anti_join(data_linkage) 
  )
  
  
  tmp_text <- left_join(missing_insertions, data_lines, by=c(ll_tl_id2="tl_id"))$tl_text
  tmp_id1  <- str_c(text_meta$id[match(str_extract(missing_insertions$ll_tl_id2,"\\w*_\\d*-\\d*-\\d*.\\d"), text_meta$id)-1], "_____")
  tmp <- 
    data_frame(
      ll_tl_id1        = tmp_id1,
      ll_tl_id2        = missing_insertions$ll_tl_id2,
      ll_sim           = 0,
      ll_sim_wd        = 0, 
      ll_diff          = 1,
      ll_diff_wd       = linkage_sim(data.frame( Aorigtext = "", Borigtext = tmp_text ), simtype = "diff_wd" ), 
      ll_type          = "insertion", 
      ll_t_id1         = str_extract(tmp_id1,"\\w*_\\d*-\\d*-\\d*.\\d"),
      ll_t_id2         = str_extract(missing_insertions$ll_tl_id2, "\\w*_\\d*-\\d*-\\d*.\\d"),
      ll_tl_lnr1       = NA,
      ll_tl_lnr2       = as.numeric(str_extract(missing_insertions$ll_tl_id2, "\\d*$")), 
      ll_minmaj_code   = 0, 
      ll_minmaj_coder  = "Peter Auto Correct",
      ll_minmaj_memo   = "Peter Auto Correct",
      ll_linkage_coder = "Peter Auto Correct"
    )  %>% filter( !is.na(ll_tl_id2) )
  data_linkage <- rbind(data_linkage, tmp)
  
  # return
  res <- named_list(data_linkage, data_lines)
  return(res)
}




#' wrapper for check_type_two() and solve_type_two()
t2test <- function(data_linkage, data_lines){
  tmp <- 
    solve_type_two(
      check_type_two(data_linkage, data_lines)
    )
  chk <- try(check_type_two(tmp$data_linkage, tmp$data_lines), silent=TRUE)
  chk <- ifelse(class(chk)=="try-error", FALSE, is.null(chk))
  if ( is.null(tmp) | chk ){
    message("--- OK no type two errors (relevant==0 and ccode!=999) OK---")
    res <- named_list(data_linkage, data_lines) 
    return(res)
  }else{
    if(!interactive()){
      email_error(s=ctr)
      q(save = "no")
    }else{
      stop("t2test: resolving inconsistencies did not work")
    }
  }      
}
























