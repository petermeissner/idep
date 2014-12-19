# plotting linakges as Rplot and SVG


require(idep)

# loading data
load("Z:/Geschäftsordnungen/CodingData/view_linelinkage_db_version_0.43.Rdata")

ll <- linelinkage[linelinkage$t_country1=="BEL", ]
versions    <- sort(unique(ll$t_t_id1)[!is.na(unique(ll$t_t_id1))])
dates       <- sort(unique(ll$t_date1)[!is.na(unique(ll$t_date1))])
plot_width  <- length(versions)
plot_height <- max(ll$tl_lnr1, na.rm=T)+10

plot( x = c(1,plot_width), 
      y = c(0,plot_height),
      ylab="textline", xlab="version",
      type="n",  xaxt='n')
  axis(side   = 1, 
       at     = seq_along(versions), 
       labels = F)
  text(x = seq_along(versions)-0.3, 
       y = - 0.11*plot_height,
       labels = dates, 
       srt = 45, pos = 1, xpd = TRUE, cex=0.6)

X   <- match(ll$t_t_id1, versions)
Y   <- ll$ll_tl_lnr1
COL <- ccode_to_color(ll$tl_corpus_code1)
segments(X-0.1, Y, X+0.1, col=COL)





