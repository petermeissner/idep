# script for checking link data and uploading it to server

#### setting things up =========================================================
message("\n")
library(idep)
library(dplyr)
library(RMySQL)
'%.%' <- function(a,b) paste0(a,b)
message("\n")

# error handling
if( !interactive() ){
  options(error = quote({email_error("undefined error in check and upload" , s=ctr, anyways=T); q(save = "no")}) )
}

# connection function
get_ready <- function(){
  lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)
  source("~/DBConnections/so_local.r")
  #source("~/DBConnections/so_latin1_local.r")
  #source("~/DBConnections/DBSOconnection.r")
}

# setting working directory
try(setwd("Z:/Gesch\u00e4ftsordnungen/database/rawdata"))
try(setwd("~/z/Database/rawdata"))
countries <- list.dirs(".", FALSE, FALSE)
countries



# commandline argument evaluation
eval_cl_args()
if( !exists("ctr") ){
  stop(
    paste0(
      "no country given choose one of these:\n", 
      paste0(countries, collapse = ", "),
      "\ne.g.: R < file.R > file.rout --args ctr='AUT'"
    )
  )
}else{
  message("### ============================================================== ###")
  message("\n",ctr,"\n")  
}


#### getting data ==============================================================
message("preparing data ... ")

# select linkage files
# link_files_select()
linkage_path <- 
  ifelse( 
    file.exists(ctr %.% "/coded"), 
    ctr %.% "/coded", 
    ctr %.% "/linked"
  )
link_files_select(
  list.files(linkage_path, full.names=T )
)
head(filelist_full,  1)
head(filelist_fname, 1)
head(filelist_path,  1)
country_path
country

# load linkage files
link_files_load(filelist_full)
linkage_env
ls(linkage_env001)


# select corpus file
# corpus_file_select()
corpus_file_select(
  list.files(
    paste0(ctr,"/corpus"),
    full.names=T
  )
)
corpus_file_full
corpus_file_fname
corpus_file_path

# load corpus file
corpus_file_load()
ls(corpus_env)

# preapre data for matching
corpus_data_prepare()

iffer <- max(file.info(filelist_full)$mtime) > file.info(paste0(ctr,".Rdata"))$mtime | is.na(file.info(paste0(ctr,".Rdata"))$mtime)
if ( iffer  ){
    # meta data
    message("preparing meta data")
    fname_data       <- get_meta_from_fname(filelist_full,T)
    within_text_data <- link_files_get_date(filelist_full,T)
    data_texts  <- cbind(fname_data, within_text_data)
    text_meta   <- data_texts
    names(data_texts) <- c("t_id", "t_date", "t_dplus", "t_country", "t_daccept", "t_dpromul", "t_denact")
    
    
    # text data for upload
    message("preparing text data")
    data_lines      <- link_files_get_text(linkage_env)
    matcher                <- match(data_lines$id, corpus_env$coding$id)
    data_lines$corpus_code <- corpus_env$coding$code[ matcher ]
    data_lines$corpus_memo   <- ifelse( grepl("#§# autocode",corpus_env$coding$memo[ matcher ]), 
                                        "", corpus_env$coding$memo[ matcher ] ) 
    names(data_lines) <- c( "tl_id", "tl_text", "tl_lnr", "tl_t_id", "tl_relevant", "tl_wds_raw",           
                            "tl_wds_clean", "tl_corpus_code", "tl_corpus_memo")
    data_lines$tl_text <- enc2utf8(data_lines$tl_text)
    data_lines$tl_corpus_memo <- enc2utf8(data_lines$tl_corpus_memo)
    data_lines$tl_corpus_code[ is.na(data_lines$tl_corpus_code) ] <- 999
    
    
    # linkage data
    message("preparing linkage data")
    for(i in seqalong(linkage_env)){
      tbc <- eval(as.name(linkage_env[i]))$RESULTS
      check_diff(tbc)
    } 
    system.time(data_linkage <- link_files_get_linkage() )
    names(data_linkage) <- c("ll_tl_id1", "ll_tl_id2", "ll_sim", "ll_sim_wd", "ll_diff", 
                             "ll_diff_wd", "ll_type", "ll_t_id1", "ll_t_id2", 
                             "ll_tl_lnr1", "ll_tl_lnr2", "ll_minmaj_code", "ll_minmaj_coder",
                             "ll_minmaj_memo", "ll_linkage_coder")
    data_linkage$ll_minmaj_memo <- enc2utf8(data_linkage$ll_minmaj_memo)
    
    
    # text data for testing
    text_texts <- link_files_get_text_only(linkage_env,T) 
    link_texts <- link_files_get_text_only(linkage_env,F) 
    
    # save image
    save.image(file=paste0(ctr,".Rdata"))
}else{
    # laod image
    load(file=paste0(ctr,".Rdata"))
}
    
#### checks ====================================================================
message("\nrunning tests")

# checks : dates were extracted as expected? 
dtest(text_meta)

# checks : check that all text lines ( max(lnr) ) ar included
ltest(text_texts)

# checks : check that the second text of version n 
#          is equal to the first text of version n+1
#      ... which should be the case because these are 
#          supposed to be the same texts
ctest <- ctest(link_texts, filelist_full)
ctest[[1]]

# data.frames to tbl_df
data_texts   <- tbl_df(data_texts)
data_lines   <- tbl_df(data_lines)
data_linkage <- tbl_df(data_linkage)


#### harmonize between different codings =======================================

# type 1 || ccode = 999 & rel = 1 
# solution: - relevant <- 0
#           - delete linkage information
tmp          <- t1test(data_linkage, data_lines)
data_linkage <- tmp$data_linkage
data_lines   <- tmp$data_lines



# type 2 || ccode != 999 & rel = 0 
# solution: - relevant <- 1
#           - linkage1 <- deletion
#           - linkage2 <- insertion
#           - minmaj   <- 0
tmp          <- t2test(data_linkage, data_lines)
data_linkage <- tmp$data_linkage
data_lines   <- tmp$data_lines





#### resolve missing linkage errors ============================================


# lines that should be in data_linkage
id_seq <- sort(unique(substring(data_lines$tl_id, 1, 16)))
max_id <- max(substring(data_lines$tl_id, 1, 16))
min_id <- min(substring(data_lines$tl_id, 1, 16)) 


# forward linking is missing 
fwd_missing <- 
  data_lines  %>% 
  filter(tl_relevant==1) %>%  
  left_join(data_linkage, by=c(tl_id="ll_tl_id1"))   %>% 
  filter(is.na(ll_sim))   %>% 
  filter(!grepl(max_id, tl_id))

fwd_missing$tl_id

res <- data.frame(Aorigtext=fwd_missing$tl_text, Borigtext=rep("", length(fwd_missing$tl_text)))
if ( dim(res)[1]!=0 ){
  fwd_missing$ll_sim      <- linkage_sim( res, "sim")
  fwd_missing$ll_diff     <- linkage_sim( res, "diff")
  fwd_missing$ll_sim_wd   <- linkage_sim( res, "sim_wd")
  fwd_missing$ll_diff_wd  <- linkage_sim( res, "diff_wd")
  fwd_missing$ll_minmaj_code   <- 0
  fwd_missing$ll_minmaj_coder  <- "peter auto correction"
  fwd_missing$ll_minmaj_memo   <- ""
  fwd_missing$ll_linkage_coder <- "peter auto correction"
  fwd_missing$ll_type          <- "deletion"
  fwd_missing$ll_tl_id1  <- fwd_missing$tl_id
  fwd_missing$ll_t_id1   <- str_extract(fwd_missing$ll_tl_id1, "^\\w.*\\.\\d")
  fwd_missing$ll_tl_lnr1 <- as.numeric(str_extract(fwd_missing$ll_tl_id1, "\\d*$"))
  fwd_missing$ll_t_id2   <- id_seq[ match(fwd_missing$ll_t_id1, id_seq)+1 ]
  fwd_missing$ll_tl_lnr2 <- NA
  fwd_missing$ll_tl_id2  <- paste0(fwd_missing$ll_t_id2,"_____")
  
  tmp <- 
    fwd_missing %>% 
    select(tl_id, tl_text, tl_lnr, tl_t_id, grep("^ll", names(fwd_missing)) ) %>% 
    select( match( names(data_linkage), names(.) ) ) 
  
  data_linkage <- rbind(tmp, data_linkage)
}



# backward linking is missing
bwd_missing <- 
  data_lines  %>% 
  filter(tl_relevant==1) %>%  
  left_join(data_linkage, by=c(tl_id="ll_tl_id2"))   %>% 
  filter(is.na(ll_sim))   %>% 
  filter(!grepl(min_id, tl_id))

bwd_missing$tl_id

res <- data.frame(Aorigtext=bwd_missing$tl_text, Borigtext=rep("", length(bwd_missing$tl_text)))
if ( dim(res)[1]!=0 ){
  bwd_missing$ll_sim      <- linkage_sim( res, "sim")
  bwd_missing$ll_diff     <- linkage_sim( res, "diff")
  bwd_missing$ll_sim_wd   <- linkage_sim( res, "sim_wd")
  bwd_missing$ll_diff_wd  <- linkage_sim( res, "diff_wd")
  bwd_missing$ll_minmaj_code   <- 0
  bwd_missing$ll_minmaj_coder  <- "peter auto correction"
  bwd_missing$ll_minmaj_memo   <- ""
  bwd_missing$ll_linkage_coder <- "peter auto correction"
  bwd_missing$ll_type          <- "insertion"
  bwd_missing$ll_tl_id2  <- bwd_missing$tl_id
  bwd_missing$ll_t_id2   <- str_extract(bwd_missing$ll_tl_id2, "^\\w.*\\.\\d")
  bwd_missing$ll_tl_lnr2 <- as.numeric(str_extract(bwd_missing$ll_tl_id2, "\\d*$"))
  bwd_missing$ll_t_id1   <- id_seq[ match(bwd_missing$ll_t_id2, id_seq)-1 ]
  bwd_missing$ll_tl_lnr1 <- NA
  bwd_missing$ll_tl_id1  <- paste0(bwd_missing$ll_t_id1,"_____")
  
  tmp <- 
    bwd_missing %>% 
    select(tl_id, tl_text, tl_lnr, tl_t_id, grep("^ll", names(bwd_missing)) ) %>% 
    select( match( names(data_linkage), names(.) ) ) 
  
  data_linkage <- rbind(tmp, data_linkage)
}







#### data upload================================================================

# re-establish connection
get_ready()

# Writing results to database
message("\nuploading data: data_texts")
system.time(SQL <- genInsertsDKU("data_texts", data_texts))
system.time(dbGetQueries(socon, SQL))

message("uploading data: data_textlines")
system.time(SQL <- genInsertsDKU("data_textlines", data_lines))
Encoding(SQL) <- "UTF-8"
system.time(dbGetQueries(socon, SQL))

message("uploading data: data_linkage")
system.time(SQL <- genInsertsDKU("data_linelinkage", data_linkage))
system.time(dbGetQueries(socon, SQL))


# make new tag for DB versioning
get_ready()
eval_cl_args()

if_not_exists(SHORTDESC, "texts, textlines, linelinkage data upload by check_link_data() [idep package]")
sqlVersionTag( 
  con       = socon, 
  shortdesc = paste0( country, " : ", SHORTDESC )
)


# done
message("\nOK -- DONE -- OK\n\n")






