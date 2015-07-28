 routs <- list.files(pattern=".*rout")
 message <- character(0)
 for ( i in seq_along(routs) ) 
 {
    text <- readLines(routs[i])
    text <-  grep("^\\s*\\|", text, invert=T, value=T)
    message <- 
      c(
        message, 
        paste0("\n\n\n*",routs[i],"*\n\n"),
        head(text, 50), 
        tail(text, 50)
      )
 }
 writeLines(message, "latest_uploads.txt")
 