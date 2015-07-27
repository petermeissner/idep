
'%.%' <- function(a,b) paste0(a,b)

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

# meta data
fname_data       <- get_meta_from_fname(filelist_full,T)
within_text_data <- link_files_get_date(filelist_full,T)
data_texts  <- cbind(fname_data, within_text_data)
text_meta   <- data_texts
names(data_texts) <- c("t_id", "t_date", "t_dplus", "t_country", "t_daccept", "t_dpromul", "t_denact")


# text data for upload
data_lines      <- link_files_get_text(linkage_env)
matcher                <- match(data_lines$id, corpus_env$coding$id)
data_lines$corpus_code <- corpus_env$coding$code[ matcher ]
data_lines$corpus_memo   <- ifelse( grepl("#§# autocode",corpus_env$coding$memo[ matcher ]), 
                                    "", corpus_env$coding$memo[ matcher ] ) 
names(data_lines) <- c( "tl_id", "tl_text", "tl_lnr", "tl_t_id", "tl_relevant", "tl_wds_raw",           
                        "tl_wds_clean", "tl_corpus_code", "tl_corpus_memo")
data_lines$tl_text <- enc2utf8(data_lines$tl_text)
data_lines$tl_corpus_memo <- enc2utf8(data_lines$tl_corpus_memo)


# linkage data
system.time(data_linkage <- link_files_get_linkage() )
names(data_linkage) <- c("ll_tl_id1", "ll_tl_id2", "ll_sim", "ll_sim_wd", "ll_diff", 
                         "ll_diff_wd", "ll_type", "ll_t_id1", "ll_t_id2", 
                         "ll_tl_lnr1", "ll_tl_lnr2", "ll_minmaj_code", "ll_minmaj_coder",
                         "ll_minmaj_memo", "ll_linkage_coder")
data_linkage$ll_minmaj_memo <- enc2utf8(data_linkage$ll_minmaj_memo)


# text data for testing
text_texts <- link_files_get_text_only(linkage_env,T) 
link_texts <- link_files_get_text_only(linkage_env,F) 

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

# ?????????????????????????????
# tests for linkage
# ?????????????????????????????

# data.frames to tbl_df
data_texts   <- tbl_df(data_texts)
data_lines   <- tbl_df(data_lines)
data_linkage <- tbl_df(data_linkage)



# re-establish connection
get_ready()

# Writing results to database
message("data_texts")
system.time(SQL <- genInsertsDKU("data_texts", data_texts))
system.time(dbGetQueries(socon, SQL))

message("data_textlines")
system.time(SQL <- genInsertsDKU("data_textlines", data_lines))
Encoding(SQL) <- "UTF-8"
#for ( i in seq_along(SQL) ) {
#  SQL[[i]] <- str_replace_all(SQL[[i]], "\u0097", "-")
#  SQL[[i]] <- str_replace_all(SQL[[i]], "\u0084", '"')
#}
system.time(dbGetQueries(socon, SQL))


## DEV ## >>
#pb <- progress_time(); pb$init(length(SQL)); 
#for(i in seqalong(SQL)){
#  dbGetQuery(socon, SQL[i])
#  pb$step()
#}
## DEV ## <<


message("data_linkage")
system.time(SQL <- genInsertsDKU("data_linelinkage", data_linkage))
system.time(dbGetQueries(socon, SQL))


# make new tag for DB versioning
# sqlVersionTag( con=socon, shortdesc="")
get_ready()
sqlVersionTag( con=socon, shortdesc=paste0(country,": texts, textlines, linelinkage data upload by check_link_data() [idep package]"))


# MAKE SURE TO generate new temporary tables in db!
dbGetQuery(socon, "CALL make_temp_linelinkage_textlines_texts();")







