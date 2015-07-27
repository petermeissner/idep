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
