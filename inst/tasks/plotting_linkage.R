# plotting linakges as Rplot and SVG


require(idep)

# loading data
load("Z:/Geschäftsordnungen/CodingData/view_linelinkage_db_version_0.43.Rdata")

country = "BEL"



ll <- linelinkage[linelinkage$t_country1==country , ]

versions    <- sort(unique(ll$t_t_id1)[!is.na(unique(ll$t_t_id1))])
dates       <- sort(unique(ll$t_date1)[!is.na(unique(ll$t_date1))])
plot_width  <- length(versions)
plot_height <- max(ll$tl_lnr1, na.rm=T)+10

ccode_new <- ccode_corpus_recode(ll$tl_corpus_code1)
lnr_new   <- ll$tl_lnr1

for ( i in seq_along(versions)) {
  iffer <- !is.na(ll$t_t_id1) & ll$t_t_id1 == versions[i]
  lnr_neworder(lnr_new[iffer])
}


plot( x = c(1,plot_width), 
      y = c(0,plot_height),
      ylab="textline", xlab="version",
      type="n",  xaxt='n')
  axis(side   = 1, 
       at     = seq_along(versions), 
       labels = F)
  text(x = seq_along(dates), 
       y = - c(0.09,0.13)*plot_height,
       labels = paste0("'",substring(year(dates),3,4)), 
       srt = 0, pos = c(1), xpd = TRUE, cex=0.7)

X   <- match(ll$t_t_id1, versions)
Y   <- ll$ranklnr
COL <- ccode_to_color(ll$tl_corpus_code1)
segments(X-0.1, Y, X+0.1, 
         col=COL, lwd=0.1)





