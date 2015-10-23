#' transforms a df to html table

df_to_html <- function(df, head=T){
  df[] <- lapply(df, as.character)
  html <- paste( "<tr>  <td>",
                 apply(df, 1, paste, collapse="</td> <td>"),
                 "</td>  </tr>",
                 sep="")
  if( head==T ) {
    cnames   <- paste( "<tr>  <th>",
                       paste(colnames(df), collapse="</td> <th>"),
                       "</th>  </tr>",
                       sep="" )
    
    html <- c(cnames,html)
  }
  paste(html, collapse="\n")
}
