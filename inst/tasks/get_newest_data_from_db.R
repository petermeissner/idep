# script for downloading newest data from database and saving it to disk

# set dev options or not 
DEV          = FALSE
UPDATE_TEXTS = FALSE


# setting things up
require(idep)
require(foreign)
require(stringr)
require(magrittr)
library(RMySQL)

get_ready <- function(){
  lapply( dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)
  source("~/DBConnections/so_local.r")
  #source("~/DBConnections/so_latin1_local.r")
  #source("~/DBConnections/DBSOconnection.r")
}

get_ready() # 1 = local utf8
`%.%` <- function(a,b) paste0(a,b)

# set WD
if ( DEV ){
  path = "~/../CodingData"
  dir.create(path, showWarnings = F)
  setwd(path)
}else{
  setwd("Z:/Gesch\u00e4ftsordnungen/CodingData")
}
getwd()

# connection info
socon

# listing tables
dbListTables(socon)
get_table_info(socon)

# version check 
file_version <- 
  str_extract(list.files(), "\\d+\\.\\d+") %>% 
  as.numeric()  %>% 
  max(na.rm=T)
file_version

db_version   <- 
  dbReadTable(socon, "version") %>% 
  select(versionnumber) %>% 
  unlist() %>% 
  as.numeric() %>% 
  max(na.rm=T)
db_version  

files_need_update <- db_version > file_version
files_need_update



### data on changes / linelinkage ###
ll_view <- download_linelinkage_view( socon, saveToFile=files_need_update)  %>% 
  as_data_frame()

### raw data
ll_raw  <- 
  download_linelinkage_raw( socon, saveToFile=files_need_update) %>% 
  as_data_frame()
t_raw   <- 
  download_texts_raw( socon, saveToFile=files_need_update) %>% 
  as_data_frame()
tl_raw  <- download_textlines_raw( socon, saveToFile=files_need_update) %>% 
  as_data_frame()



# wirting texts and linkages into need litle HTML files to be looked upon
if( UPDATE_TEXTS ){
  
### >> producing texts # -------------------------------------------------------
`%.%` <- function(a,b) paste0(a,b)

ids <- 
  tl_raw  %>% 
  distinct(tl_t_id) %>% 
  select(tl_t_id) %>% 
  unlist()

countries <- 
  str_extract(ids, "^[A-Z]{2,10}")

fnames <- 
  "text"  %.% "/"  %.% 
  countries  %.% "/"  %.% 
  ids %.% ".htm"

# create folders for text and for linkage
tmp <- lapply(
  dirname(fnames), 
  dir.create, recursive = TRUE, 
  showWarnings = FALSE
)
tmp <- lapply(
  str_replace(dirname(fnames),"text", "linkage"), 
  dir.create, 
  recursive = TRUE, 
  showWarnings = FALSE
)


# writing texts

for( i in seq_along(ids) ) { 
  id      <- ids[i]
  df <- 
    tl_raw  %>% 
    filter(tl_t_id==id)  %>% 
    mutate(
      tl_lnr=as.numeric(tl_lnr),
      corpus_cat = ccode_corpus_recode(tl_corpus_code)
    ) %>% 
    rename(
      lnr=tl_lnr, 
      text=tl_text, 
      rel = tl_relevant,
      corpus_code = tl_corpus_code, 
      memo = tl_corpus_memo,
      words_clean=tl_wds_clean, 
      words_raw=tl_wds_raw
    ) %>% 
    select(lnr, rel,  text, corpus_code, corpus_cat, words_clean, words_raw)  %>% 
    arrange(lnr)
  
  
  html <- 
    "<h1>" %.%
    ifelse( length(basename(fnames[i-1])) > 0 & identical(countries[i-1], countries[i]), 
            "<a href='" %.% basename(fnames[i-1]) %.% "'>&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;&nbsp;&nbsp;&nbsp;</a>"  ,
            ""
    ) %.% 
    ""  %.% 
    id  %.% 
    ifelse( length(basename(fnames[i+1])) > 0 & identical(countries[i+1], countries[i]), 
            "<a href='" %.% basename(fnames[i+1]) %.% "'>&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;</a>"  ,
            ""
    ) %.% 
    "</h1>"  
  
  htmltable(
    df, 
    file = fnames[i],
    bgcolor = ccode_color_scheme2[df$corpus_cat],
    html = html
  )
}
### << producing texts # -------------------------------------------------------


### >> producing linkage texts # -----------------------------------------------

# sort tl_raw
t_raw <- t_raw  %>% arrange(t_id)

# make combinations of ids
ids <- 
  data_frame(
    id1 = t_raw$t_id[1:length(t_raw$t_id)-1], 
    id2 = t_raw$t_id[2:length(t_raw$t_id)]
  )  %>% 
  filter(str_extract(.$id1,"^.{4}") == str_extract(.$id2,"^.{4}"))  %>% 
  mutate(
    fname = paste0(
      "linkage/", 
      str_extract(.$id1, "^[A-Z]{2,10}"), "/",
      .$id1, " vs ", .$id2, 
      ".htm") 
  )

# function for links to prev or next document
ahref     <- 
  function(x){
    cntr <- str_extract(basename(fname), "^[A-Z]*" )
    if ( length(x)==0 )     return("")
    if ( is.na(x) )         return("")
    if ( !grepl(cntr, basename(x) ) ) return("")
    if ( x < fname ){
      return(
        "<a href='" %.% basename(x) %.% "'>&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;&nbsp;&nbsp;&nbsp;</a>"
      )
    }
    if ( x > fname ){
      return(
        "<a href='" %.% basename(x) %.% "'>&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;</a>"
      )
    }
  }


# filter by those combinations tl_t_id and write files
for(i in seq_along(ids$id1) ){
  
  fname      <- ids$fname[i]
  prev_fname <- ids[i-1, ]$fname
  next_fname <- ids[i+1, ]$fname
  id1   <- ids$id1[i]
  id2   <- ids$id2[i]
  
  # text output
  tl1 <- tl_raw %>% 
    filter( tl_t_id == id1 )  %>% 
    select(tl_id, tl_corpus_code, tl_relevant, tl_lnr, tl_text)  %>% 
    rename(rel=tl_relevant, ccode=tl_corpus_code, text=tl_text)
  names(tl1) <-paste0(names(tl1), 1)
  
  tl2 <- tl_raw %>% 
    filter( tl_t_id == id2 )  %>% 
    select(tl_id, tl_corpus_code, tl_relevant, tl_lnr, tl_text)  %>% 
    rename(rel=tl_relevant, ccode=tl_corpus_code, text=tl_text)
  names(tl2) <-paste0(names(tl2), 2)
  
  ll <- ll_raw  %>% 
    filter( ll_t_id1 == id1 | ll_tl_id2 == id2 ) %>% 
    select(ll_tl_id1, ll_tl_id2, ll_tl_lnr1, ll_tl_lnr2, ll_type,
           ll_sim, ll_sim_wd, ll_diff, ll_diff_wd)  %>% 
    rename(
      tl_id1     = ll_tl_id1,  
      tl_id2     = ll_tl_id2, 
      lnr1       = ll_tl_lnr1, 
      lnr2       = ll_tl_lnr2, 
      type       = ll_type, 
      sim        = ll_sim, 
      sim_words  = ll_sim_wd, 
      diff       = ll_diff, 
      diff_words = ll_diff_wd
    )
  
  linkage <- full_join( ll, tl1) %>% full_join(tl2) 
  linkage$lnr1 <- apply(linkage[,c("lnr1","tl_lnr1")], 1, max, na.rm=T, showWarnings=F)
  linkage$lnr1 <- ifelse(is.infinite(linkage$lnr1), NA, linkage$lnr1)
  linkage$lnr2 <- apply(linkage[,c("lnr2","tl_lnr2")], 1, max, na.rm=T, showWarnings=F)
  linkage$lnr2 <- ifelse(is.infinite(linkage$lnr2), NA, linkage$lnr2)
  linkage <- 
    linkage  %>% 
    select(-tl_lnr1, -tl_lnr2)  %>% 
    mutate(
      lnr1 = ifelse(lnr1==0, NA, lnr1),
      lnr2 = ifelse(lnr2==0, NA, lnr2)
    )
  linkage <- 
    linkage  %>% 
    sort_align_df("lnr1", "lnr2")  %>% 
    select(lnr1, lnr2, text1, rel1, text2, rel2, type, sim, diff, sim_words, diff_words)
  linkage <- as_data_frame(lapply(linkage, function(x) ifelse(is.na(x), "", x)) )
  
  country <- 
    str_extract(tl1$tl_id1[1], "^[A-Z]{3,7}")
  
  versus <- 
    str_extract(tl1$tl_id1[1], ".*\\.\\d")  %.% 
    "&nbsp; &nbsp; &nbsp; &nbsp;  <i>versus</i> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " %.% 
    str_extract(tl2$tl_id2[1], ".*\\.\\d")
  
  info  <-
    "<h1>" %.% 
    ahref(prev_fname) %.% 
    versus  %.% 
    ahref(next_fname)  %.% 
    "</h1><br>"
  
  htmltable(
    file    = ids$fname[i],
    x       = as.data.frame(linkage),
    bgcolor = linkage_type_colors(linkage$type),
    html    = info 
  )
}

### << producing linkage texts # -----------------------------------------------



 
}



message("-- done: getting newest data from DB and updating files --")












































