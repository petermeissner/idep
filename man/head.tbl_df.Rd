% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/head.tbl_df.r
\name{head.tbl_df}
\alias{head.tbl_df}
\title{head method for tabl_df that shows all columns}
\usage{
\method{head}{tbl_df}(x, n = 5)
}
\arguments{
\item{x}{the tbl_df object for which to show head}

\item{n}{the amount of rows to show}
}
\description{
Internally tbl_df is transformed via as.data.frame() and than the usual 
head() function is used.
}
\seealso{
head()
}

