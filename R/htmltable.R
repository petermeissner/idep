#' function for making html table
#' @param x data.frame or matrix to be transformed 
#' @param file whether or not to write resulting HTML to file
#' @param standalone should HTML head and foot be added to make HTML standalone
#' @param names might be TRUE, FALSE or a character vector giving the names of the columns
#' @param head should user defined HTML head be used (everything before the table)
#' @param foot should user defined HTML foot be used (everything after the table)

htmltable <- function(x, file="", standalone=T, names=T, head="", foot="" ){
  # input check
  if ( !( class(x) %in% c("matrix", "data.frame") ) ){
    stop(paste("df_to_htmltable: I do not know how to transform x =",
               class(x), "into HTML.") )
  }
  # table
  table <-  paste(
              paste(  "  <tr>  <td>",
                apply(cbind(seq_along(x[,1]), x), 1, paste, collapse=" </td> <td> "), 
                "</td>  </tr>"), 
              collapse="\n" 
            )
  if ( any(names != F) ) {
    if ( all(names == T) ){
      names <- names(x)
    }
    names <- c("#", names)
    table <- paste(
                paste( "<tr class= firstline><th>", 
                    paste(names, collapse=" </th> <th> "), 
                    "</th></tr>"), 
                table
              , collapse="\n")
  }
  table <- paste("<table border=0 class=innerTable>", 
                 paste(table, collapse="\n"), 
                 "</table>")
  # standalone
  if ( standalone == T ){
    if ( head=="" ){
      head <- '
<html>
<head>
<title></title>
<link rel=stylesheet href="http://mbtnr.net/js/R2HTML.css" type=text/css>
</head>
<body bgcolor= FFFFFF >
'
    }
    if ( foot=="" ){
      foot <- '
<script src="http://mbtnr.net/js/R2HTML.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://www.pmeissner.com/js/stickyTableHeaders.js"></script>
</body></html>
'
    }
  }else{
    head <- ""
    foot <- ""
  }
  # putting it together
  html <- c(head, table, foot)
  # write to file
  if ( file!="" ){
    writeLines(html, file)
    message(paste("Writing output to file:", file))
  } else {
    file <- tempfile(fileext=".html")
    writeLines(html, file)
    browseURL(file)
  }
  # return
  invisible(html)
}

