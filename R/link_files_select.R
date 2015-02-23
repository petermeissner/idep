#' function for selecting a bunch of link files and computing other vars
#' 

link_files_select <- function(filelist_full=NULL) {
  if ( is.null(filelist_full) ){
    filelist_full <- choose.files()
  }
  filelist_full  <- stringr::str_replace_all(filelist_full,"\\\\","/")
    assign("filelist_full", filelist_full, envir=globalenv() )
  filelist_fname <- basename(filelist_full)
  filelist_path  <- dirname(filelist_full)
    assign("filelist_fname", filelist_fname, envir=globalenv() )
    assign("filelist_path", filelist_path, envir=globalenv() )
  country_path   <- str_replace(
                      tolower(filelist_full[1]),
                      tolower("Z:.Gesch\u00e4ftsordnungen.CodingChanges."),
                      "")
  country_path   <- paste0("Z:/Gesch\u00e4ftsordnungen/CodingChanges/",
                        str_extract(country_path,"^\\w+"))
    assign("country_path", country_path, envir=globalenv() )
  country        <- toupper(str_extract(country_path,"\\w*$"))
    assign("country", country, envir=globalenv() )
}
