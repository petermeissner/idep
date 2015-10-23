#' This is the PLace to put OnLoad and OnAttach functions.
#' ... these are turned off

  .onLoad   <- function(libname, pkgname){
    #packageStartupMessage("Uh, Package Loaded!")
  }
  .onAttach   <- function(libname, pkgname){
    #packageStartupMessage("Package Kind of Attached - I think.")
    require(plyr, quietly=T, warn.conflicts=F)
    require(dplyr, quietly=T, warn.conflicts=F)
    require(lubridate, quietly=T, warn.conflicts=F)
    require(stringr, quietly=T, warn.conflicts=F)
  }

