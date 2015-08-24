  library(idep)
  dir.create("routs", showWarnings = FALSE)
  routs <- list.files(pattern=".*rout$", include.dirs = FALSE)
  file.move(routs, "routs")
  
