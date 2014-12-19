#' function producing text / html versions of standing order texts

ll_view_write_texts <- function(df){
  d_ply(df, .variables="tl_t_id", .fun=ll_view_write_text, .progress = "text")
}


ll_view_write_text <- function(df){
  id    <- df$tl_t_id[1]
  '%.%' <- function(a,b) paste0(a,b)
  iffer    <- id==df$tl_t_id & !duplicated(df$tl_id)
  ordering <- order( df[ iffer, "tl_lnr"])
  text     <- df[ iffer, "tl_text"][ordering]
  lnr      <- df[ iffer, "tl_lnr"][ordering]
  relevant <- df[ iffer, "tl_relevant"][ordering]
  tllu     <- max(df[ iffer, "int_dupdate_textlines"])
  dblu     <- df[ iffer, "db_lastupdate"][1]
  fname_txt       <- paste0("texts_txt/"      , id, ".txt")
  fname_txt_rel   <- paste0("texts_txt_rel/"  , id, "_rel.txt")
  fname_html      <- paste0("texts_html/"     , id, ".html")
  fname_html_info <- paste0("texts_html_info/", id, "_info.html")
  # put it in different folders 
  dir.create("texts_txt"      , showWarnings = F)
  dir.create("texts_txt_rel"  , showWarnings = F)
  dir.create("texts_html"     , showWarnings = F)
  dir.create("texts_html_info", showWarnings = F)
  # html foot and body
  html <- character()
  html_head <-  "<!DOCTYPE HTML>"  %.% 
    "<html><head>\n<title>" %.% 
    id %.% 
    "\n</title>\n</head>\n<body>"  %.% 
    "<h1>" %.% id %.% "</h1>" %.% 
    "text last update:"      %.% tllu %.%  "<br>" %.% 
    "database last update:"  %.% dblu %.%  "<br>" %.% 
    "<table><th></th>"
  html_foot <- "\n"  %.% "</table></body></html>"
  html_body          <- df[iffer, ]
  html_body          <- html_body[order(as.numeric(html_body$tl_lnr)), ]
  # write html
  html_body1         <- html_body[, c("tl_lnr","tl_text") ]
  names(html_body1)   <- c("line","text")
  html_body1          <- df_to_html(html_body1)
  html               <- c(html_head, html_body1, html_foot)
  writeLines(html, fname_html)
  # write html with info
  html_body2        <- html_body[, c("tl_lnr",
                                     "tl_relevant",
                                     "tl_text",
                                     "tl_corpus_code", 
                                     "tl_wds_clean") ]
  names(html_body2)   <- c("line","rel","text", "corpus code", "words clean")
  html_body2          <- df_to_html(html_body2)
  html               <- c(html_head, html_body2, html_foot)
  writeLines(html, fname_html_info)
  # write with #§#
  text_rel           <- paste(ifelse(relevant==0,"#§# ",""), text, collapse="  \n")
  writeLines(text_rel, fname_txt_rel)
  # write txt
  writeLines(text, fname_txt)
}



