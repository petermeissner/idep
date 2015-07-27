#' function to determine colors based on linkage type
#' @param type character vector with one of the following: 
#' c("no-change", "insertion", "change", "deletion")
linkage_type_colors <- function(type){
  ifelse(        type=="no-change", "#FFFFF0",
                 ifelse(      type=="insertion", "#A3FFA3",
                              ifelse(    type=="change"   , "#FFEA98",
                                         ifelse(  type=="deletion" , "#C2E0FF",
                                                  "#EBEBEB"
                                         )
                              )
                 )
  )
}

