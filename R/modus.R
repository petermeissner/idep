#' function for getting mode source: http://stackoverflow.com/a/8189441/1144966
#' @param x vector for which the mode should be returned
modus <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
