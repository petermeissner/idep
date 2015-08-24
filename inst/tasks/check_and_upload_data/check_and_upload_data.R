# script for checking link data and uploading it to server

if( interactive() & !exists("ctr") ) ctr <- "AUT"

#### setting things up =========================================================
library(idep)
library(dplyr)
library(RMySQL)
'%.%' <- function(a,b) paste0(a,b)


# connection function
get_ready <- function(){
  lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)
  source("~/DBConnections/so_local.r")
  #source("~/DBConnections/so_latin1_local.r")
  #source("~/DBConnections/DBSOconnection.r")
}

# 
setwd("Z:/Gesch\u00e4ftsordnungen/database/rawdata")
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
  message(ctr)  
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
    message("running tests")
    text_texts <- link_files_get_text_only(linkage_env,T) 
    link_texts <- link_files_get_text_only(linkage_env,F) 
    
    # save image
    save.image(file=paste0(ctr,".Rdata"))
}else{
    # laod image
    load(file=paste0(ctr,".Rdata"))
}
    
#### checks ====================================================================

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

#### type 1 || ccode = 999 & rel = 1 ====
#### solution: - relevant <- 0
####           - delete linkage information
tmp          <- t1test(data_linkage, data_lines)
data_linkage <- tmp$data_linkage
data_lines   <- tmp$data_lines



#### type 2 || ccode != 999 & rel = 0 ====
#### solution: - relevant <- 1
####           - linkage1 <- deletion
####           - linkage2 <- insertion
####           - minmaj   <- 0
tmp          <- t2test(data_linkage, data_lines)
data_linkage <- tmp$data_linkage
data_lines   <- tmp$data_lines




#### data upload================================================================

# re-establish connection
message("uploading data")
get_ready()

# Writing results to database
message("data_texts")
system.time(SQL <- genInsertsDKU("data_texts", data_texts))
system.time(dbGetQueries(socon, SQL))

message("data_textlines")
system.time(SQL <- genInsertsDKU("data_textlines", data_lines))
Encoding(SQL) <- "UTF-8"
system.time(dbGetQueries(socon, SQL))

message("data_linkage")
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


# MAKE SURE TO generate new temporary tables in db!
message("regenerate temp tables")
system.time(dbGetQuery(socon, "CALL make_temp_linelinkage_textlines_texts();"))


message("\nOK -- DONE -- OK\n\n")






