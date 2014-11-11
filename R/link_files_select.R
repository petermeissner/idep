#' function for selecting a bunch of link files and computing other vars
#' 

link_files_select <- function() {
  tempwd <- getwd()
  setwd("Z:/Gesch\u00e4ftsordnungen/CodingChanges/")
  filelist_full  <<- choose.files()
    setwd(tempwd)
  filelist_full <<- stringr::str_replace_all(filelist_full,"\\\\","/")
  filelist_fname <<- basename(filelist_full)
  filelist_path  <<- dirname(filelist_full)
  country_path   <<- str_replace(
                      filelist_full[1],
                      "Z:.Gesch\u00e4ftsordnungen.CodingChanges.",
                      "")
  country_path   <<- paste0("Z:/Gesch\u00e4ftsordnungen/CodingChanges/",
                        str_extract(country_path,"^\\w+"))
}
