# start
require(digest)
require(stringr)
require(foreign)
require(ggplot2)
tmpwd <- getwd()

# developement trigger
devel = F

# working directory
setwd("Z:/Geschäftsordnungen/AggregatedData")

# connection and sql helpers
source("functions/DBconnection.r")
source("http://mbtnr.net/rsource/sqlFunctions.r")
source("http://mbtnr.net/rsource/idep/sqlFunctionsExtended.r")

# data path
setwd("data")    



### ----------------------------------------------------------------------------------------
### read in Change Data and Tsebelis Agenda Control Data and add the latter to the former
### ----------------------------------------------------------------------------------------

# get up to date change data
change <- dbReadTable(socon, "metachange")
change <- change[order(change$ctr,change$ts1),]

# transform timestamps to appropriate format
change$ts1 <- as.POSIXct(change$ts1)
change$ts2 <- as.POSIXct(change$ts2)

# read in tsebelis data
# upload the stuff
if(1==2){
  tsebelis <- read.csv2("d:/peter/dropbox/daten sammlung/Tsebelis agenda Control p105/tsebelis.csv" )
  tsebelis <- tsebelis[,!grepl("X",names(tsebelis))]
  dbWriteTable(socon,"tsebelis",tsebelis)
}
tsebelis <- dbReadTable(socon,"tsebelis")
tsebelis <- tsebelis[ !(tsebelis$cntrshort %in% c("","CH","ICE")), ]
tsebelis[tsebelis$cntrshort=="GBR","cntrshort"] <- "GBRPU"
tsebelis[tsebelis$cntrshort=="GER","cntrshort"] <- "DEU"

# set of countries
countries <- unique(tsebelis$cntrshort)

# developement option
if( devel==T ) change <- change[,c("ts1","ts2","ctr","lengthwd.1","lengthwd.2",
                                   "estlwd1","estlwd2","prominwords","promajwords")]

# add agenda control measures to change data to that version that was in place in 1985
tdate <- as.POSIXct("1985-01-01 00:00:00")
change$agendacontrol <- NA
for(i in seq_along(countries)){
  iffer <- change$ctr==countries[i] & change$ts1 <= tdate & change$ts2 > tdate
  agendacontrol <- as.numeric(tsebelis$agenda_control[tsebelis$cntrshort==countries[i]])
  change[iffer,"agendacontrol"] <- ifelse(length(agendacontrol)==0,NA,agendacontrol)
}
change$tsdata <- as.numeric(!is.na(change$agendacontrol))
change$tsbls1 <- change$agendacontrol
change$tsbls2 <- change$agendacontrol
change$tsbls3 <- change$agendacontrol

# presenting assigned data
change[ !is.na(change$agendacontrol), 
        c( "ts1", "ts2", "ctr", "lengthwd.1", "lengthwd.2","agendacontrol", "tsdata",
           "tsbls1", "tsbls2", "tsbls3")]

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------



### ----------------------------------------------------------------------------------------
### adding further, imaginary version to capture also last data
### ----------------------------------------------------------------------------------------

# some clean up
rownames(change) <- seq_along(change[,1])
change$lengthwd.1 <- change$estlwd1
change$lengthwd.2 <- change$estlwd2

# precautiously delete info when basis is not "coded"-file
if(devel != T){
  iffer <- !grepl("coded",change$file)
  change[ iffer , c("prominwords","promajwords","promin","promaj","pronone","prodontknow") ] <- NA
}

# adding an imaginary reform 
# to have tsebellis measures for each and every time point 
# instead for only each and every change
for(i in seq_along(countries)){
  ts1 <- max(change$ts2[change$ctr==countries[i]])
  ts2 <- as.POSIXct(0,origin="9999-09-09")
  nrows <- dim(change)[1]
  change[nrows+1,c("ctr")]          <- countries[i]
  change[nrows+1,c("ts1","ts2")]    <- c(as.character(ts1),as.character(ts2))
  change[nrows+1,c("tsdata")]       <- 0
}

# fill out variables for temporal pseudo-extension
for( i in seq_along(countries)){
  iffer1 <- change$ts2==as.POSIXlt("9999-09-09 02:00:00 CEST") & change$ctr==countries[i]
  iffer2 <- change$ts2==change$ts1[iffer1] & change$ctr==countries[i]
  change$time.1[iffer1]      <-     change$time.2[iffer2]      
  change$y.1[iffer1]         <-        change$y.2[iffer2] 
  change$m.1[iffer1]         <-        change$m.2[iffer2] 
  change$d.1[iffer1]         <-        change$d.2[iffer2] 
  change$tx.1[iffer1]        <-       change$tx.2[iffer2] 
  change$lengthwd.1[iffer1]  <- change$lengthwd.2[iffer2] 
  change$cntrID[iffer1]      <-     change$cntrID[iffer2] 
  change$estlwd1[iffer1]     <-    change$estlwd2[iffer2] 
}

# sort by country and time
change <- change[order(change$ctr,change$ts1),]
rownames(change) <- seq_along(change[,1])

### ----------------------------------------------------------------------------------------
### assign plausible values for the amount of pro majority/minority words per so version
### ----------------------------------------------------------------------------------------

# assign some plausible values for 1985 version
change$maj0 <- round( change$lengthwd.1 * change$agendacontrol  )
change$maj0 <- ifelse(change$maj0>0,change$maj0,0)
change$min0 <- round(change$maj0 - change$agendacontrol * change$lengthwd.1)

## devel 
#test <- change[change$ctr=="IRE",c("ctr","ts1","ts2","maj0","min0","lengthwd.1","agendacontrol","tsdata","promajwords","prominwords")]
#i<-6
#change <- test
##

# calculate forward and backward values for maj0 and min0
for(i in seq_along(countries)){
  start <- change$ctr==countries[i] & change$tsdata==1
  K <- (1:length(change$ts1))[change$ts1 > tdate & change$ctr == countries[i]]
  for(k in K){
    change$maj0[k] <- change$maj0[k-1] + change$promajwords[k-1]
    change$min0[k] <- change$min0[k-1] + change$prominwords[k-1]
  }
  K <- (1:length(change$ts1))[change$ts2 <= tdate & change$ctr == countries[i]]
  K <- rev(K)
  for(k in K){
    change$maj0[k] <- change$maj0[k+1] - change$promajwords[k]
    change$min0[k] <- change$min0[k+1] - change$prominwords[k]
  }
}

# ensure that there are no negative values per line
for(i in seq_along(countries)){
  iffer  <- change$ctr==countries[i] 
  allmin <- min(change[iffer, c("maj0","min0")],na.rm=T)
  change[iffer, "maj0"] <- change[iffer, "maj0"] - allmin
  change[iffer, "min0"] <- change[iffer, "min0"] - allmin
}

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------


### ----------------------------------------------------------------------------------------
### TSBLS (1) // always divide by length of 1985 version that got tsebelis agenda control value
### ----------------------------------------------------------------------------------------

for(i in seq_along(countries)){
  iffer <- change$ctr==countries[i]
  length1985 <- max(change$lengthwd.1[iffer & change$tsdata==1])
  change$tsbls1[iffer]   <- round( (change$maj0[iffer] - change$min0[iffer]) / length1985  ,3)
}

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------


### ----------------------------------------------------------------------------------------
### TSBLS (2) // always divide difference in maj/min words by length of present version
### ----------------------------------------------------------------------------------------

change$tsbls2   <- round( (change$maj0 - change$min0) / change$lengthwd.1  ,3)

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------



### ----------------------------------------------------------------------------------------
### plotting variables to check if it makes sense
### ----------------------------------------------------------------------------------------

dat <- change[!is.na(change$tsbls1) | !is.na(change$tsbls2) | !is.na(change$tsbls3),]
dat$ctrlabel <- ifelse(!duplicated(dat$ctr),dat$ctr,"")

pdf("../AgendacontrolTSBLS1.pdf")
p <- ggplot( dat   ,  aes(x=ts1, y=tsbls1, label=ctrlabel, group=ctr, colour = ctr) )
p + geom_line() + geom_point()+ theme_bw() + geom_text(hjust=0, vjust=-1) + ylim(-1, 1.4) +
  ggtitle("AgendaControl_t = \n\n(MajWords_t - MinWords_t)\n ---------------------------\n AllWords_1985\n ")
dev.off()

pdf("../AgendacontrolTSBLS2.pdf")
p <- ggplot( dat   ,  aes(x=ts1, y=tsbls2, label=ctrlabel, group=ctr, colour = ctr) )
p + geom_line() + geom_point()+ theme_bw() + geom_text(hjust=0, vjust=-1) + ylim(-1, 1.4) +
  ggtitle("AgendaControl_t = \n\n(MajWords_t - MinWords_t)\n ---------------------------\n AllWords_t\n ")
dev.off()


### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------



### ----------------------------------------------------------------------------------------
### Assignment of TSBLS version 1,2 or 3 to agendacontrol
### ----------------------------------------------------------------------------------------

change$agendacontrol <- change$tsbls1

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------



### ----------------------------------------------------------------------------------------
### Data Upload to DB and Saving as Extended Agendacontrol Dataset
### ----------------------------------------------------------------------------------------

# uplaod data
iffer <- !change$ts2==as.POSIXct("9999-09-09 02:00:00 CEST")
SQL   <- genInsertsDKU("metachange", change[ iffer , c("ts1","ts2","ctr","agendacontrol") ])
dbGetQueries(socon, SQL)

# version update
sqlVersionTag(con=socon,shortdesc="metachange update tsebelis data",hash=metachangeHash(socon))

# save data with temporal pseudo-extension
lastchange <- metachangeLastchange(socon)

rname       <- paste(   "../",
                        str_replace_all(as.character(max(as.POSIXlt(lastchange))),":","_"),
                        " ",
                        "Agendacontrol.Rdata",
                        sep=""  )

stataname   <- paste(   "../",
                        str_replace_all(as.character(max(as.POSIXlt(lastchange))),":","_"),
                        " ",
                        "Agendacontrol.dta",
                        sep=""  )

save(change, file = rname)
write.dta(change, stataname, version = 8)

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------



### ----------------------------------------------------------------------------------------
### checking data now in DB
### ----------------------------------------------------------------------------------------

change <- dbReadTable(socon, "metachange")
change[, c("ts1","ts2","ctr","agendacontrol") ]

### ----------------------------------------------------------------------------------------
### ----------------------------------------------------------------------------------------









