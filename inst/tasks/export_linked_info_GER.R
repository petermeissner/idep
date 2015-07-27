# script for exporting info on linkage 


# retep.meissn@gmail.com
# ------------------------------------------------------------------------------------------

# packages
require(stringr)

# get functions
source("D:/Users/Peter/DBConnections/DBSOconnection.r")
source("http://mbtnr.net/rsource/showLinkage.r")
source("http://mbtnr.net/rsource/sqlFunctions.r")
source("http://mbtnr.net/rsource/idep/sqlFunctionsExtended.r")

# upload function
source("D:/Users/Peter/info.ftp")


# ------------------------------------------------------------------------------------------
### options
# ------------------------------------------------------------------------------------------

overwrite <- T # overwrite already existing files on server ? 
restrict_to_country <- F # either FALSE or the country which should be updated, e.g. restrict_to_country <- "GER"



# ------------------------------------------------------------------------------------------
### get list of files
# ------------------------------------------------------------------------------------------

# detect possible relevant files
filelist <- list.files("z:/Geschäftsordnungen/CodingChanges", 
                       pattern="Rdata", 
                       recursive=T)
filelist <- filelist[!str_detect(filelist,ignore.case("change.Rdata"))]
filelist <- filelist[str_detect(filelist,ignore.case("^\\w{2,3}/"))]
filelist <- filelist[!str_detect(filelist,ignore.case("[[:digit:]]x987"))]
filelist <- filelist[!str_detect(filelist,ignore.case("old"))]
filelist <- filelist[!str_detect(filelist,ignore.case("tmp"))]
filelist <- filelist[!str_detect(filelist,ignore.case("trash"))]
filelist <- filelist[!str_detect(filelist,ignore.case("backup"))]
filelist <- filelist[!str_detect(filelist,ignore.case("ResultsOnlySAVE"))]
filelist <- filelist[!str_detect(filelist,ignore.case("save"))]
filelist <- filelist[!str_detect(filelist,ignore.case("temp"))]
filelist <- filelist[!str_detect(filelist,ignore.case("test"))]
filelist <- filelist[!str_detect(filelist,ignore.case("BeforeSimReComputed"))]

# some information gathering
countries <- str_extract(filelist,"^\\w*")
uqcountries <- unique(countries)
standingo <- str_extract(basename(filelist),"^.*?[[:digit:]]")

# complete full path to files
filelist <- paste("z:/Geschäftsordnungen/CodingChanges/",filelist,sep="")

# seperate coded from non coded files
codedfiles      <- filelist[ str_detect(basename(filelist),"coded")]
uncodedfiles    <- filelist[!str_detect(basename(filelist),"coded")]

# substitute uncoded for coded if available
name.codedfiles       <- basename(codedfiles)
name.codedfiles       <- str_replace(name.codedfiles,"coded ","")
name.codedfiles       <- str_replace_all(name.codedfiles,"-cons-sauber-ofn","")
name.codedfiles       <- str_replace_all(name.codedfiles,"_ohneGES","")
name.codedfiles       <- str_replace_all(name.codedfiles,"  "," ")
name.codedfiles       <- str_replace_all(name.codedfiles,"- "," ")
name.codedfiles       <- str_replace_all(name.codedfiles,"\\(a\\)","_A")
name.codedfiles       <- str_replace_all(name.codedfiles,"\\(b\\)","_B")
name.codedfiles       <- str_replace_all(name.codedfiles,"_a","_A")
name.codedfiles       <- str_replace_all(name.codedfiles,"_b","_B")
name.uncodedfiles     <- basename(uncodedfiles)
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"-cons-sauber-ofn","")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"_ohneGES","")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"  "," ")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"- "," ")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"\\(a\\)","_A")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"\\(b\\)","_B")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"_a","_A")
name.uncodedfiles     <- str_replace_all(name.uncodedfiles,"_b","_B")
matcher               <- match( name.codedfiles , name.uncodedfiles )

files <- uncodedfiles
files[matcher] <- codedfiles

if ( restrict_to_country != F ) {
  files <- grep(restrict_to_country, files, value=T)
} 


# ------------------------------------------------------------------------------------------
### read in codings, transform into html representations, upload to idep
# ------------------------------------------------------------------------------------------

# meta data
countries <- str_extract(files,"z:/Geschäftsordnungen/CodingChanges/.*?/")
countries <- str_replace(str_extract(countries,"\\w*?/$"),"/","")
u.countries <- unique(countries)

years       <- as.numeric(unlist(str_extract_all(files,"([[:digit:]]{4})")))
years       <- matrix(data = years, nrow = length(years)/2, ncol = 2, byrow = T)
months      <- as.numeric(unlist(str_extract_all(files,"([[:digit:]]{2})")))
days        <- matrix(data = months, nrow = length(months)/8, ncol = 8, byrow = T)[,c(4,8)]
months      <- matrix(data = months, nrow = length(months)/8, ncol = 8, byrow = T)[,c(3,7)]
dateextra   <- str_extract_all(files,"[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}_?[[:alpha:]]?")
dateextra   <- match(tolower(str_extract_all(unlist(dateextra),"[[:alpha:]]")) , letters )
dateextra   <- matrix(data = dateextra, nrow = length(dateextra)/2, ncol = 2, byrow = T)
dateextra[is.na(dateextra)] <- 0 
ts1 <- as.POSIXct(  paste0(years[,1], "-", months[,1], "-", days[,1]," ", dateextra[,1], ":00:00")  )
ts2 <- as.POSIXct(  paste0(years[,2], "-", months[,2], "-", days[,2]," ", dateextra[,2], ":00:00")  )
fnamedetail <- str_replace_all(
  paste0(  countries, "_",
           str_replace(as.character(ts1),":00:00",""), "_",
           str_replace(as.character(ts1),":00:00",""),".html"  )," ","-")
promin  <- rep(NA,length(fnamedetail))
promaj  <- rep(NA,length(fnamedetail))
pronone <- rep(NA,length(fnamedetail))

# html... head, body, foot for overview page
htmlhead <- '<html><head>
</head> <body id="dangs">'
htmlfoot <- '
<script>
// show stuff script
function showStuff(id) {
if(document.getElementById(id).style.display == "none"){
document.getElementById(id).style.display = "block" ;
}else{
document.getElementById(id).style.display = "none" ;
}
}
</script></body></html>'
htmlbody <- '   '


# set WD
dir.create("d:/tmp", FALSE)
setwd("d:/tmp")





# write change files
for(i in seq_along(fnamedetail) ){
  message(paste(i, fnamedetail[i]))
  load(files[i])
  promin[i]  <- sum(RESULTS$diff==2,na.rm=T)
  promaj[i]  <- sum(RESULTS$diff==1,na.rm=T)
  pronone[i] <- sum(RESULTS$diff==0,na.rm=T)
  if(     overwrite==T | !file.exists(fnamedetail[i])         ){
    showLinkage(RESULTS,fnamedetail[i])
    upload(fnamedetail[i],"idep/changes/")
  }
}


# write and upload overviev HTML
fnamedetailOVLink <- paste0("changes/",fnamedetail)
for(k in seq_along(u.countries)){
  country  <- u.countries[k]
  htmlbody <- c(htmlbody,paste0("<h1>",u.countries[k],"</h1>"))
  htmlbody <- c(htmlbody,paste0("<table>"))
  htmlbody <- c(htmlbody, paste0("<th>#</th>      <th>country</th>    <th>year1</th>      <th>year2</th>  
                                 <th>promin</th> <th>promaj</th>     <th>pronone</th>   
                                 <th>ts1</th>        <th>ts2</th>  
                                 <th>Link</th>"                                          ))
  cfiles <- seq_along(countries)[countries==country]
  for(i in seq_along(cfiles)){
    fname       <- files[cfiles[i]]
    id          <- cfiles[i]
    htmlbody <- c(htmlbody,paste0("<tr>"))
    htmlbody <- c(htmlbody,paste0("<td>", id,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", countries[id] ,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", years[id,1]   ,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", years[id,2]   ,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", promin[id]        ,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", promaj[id]        ,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", pronone[id]       ,"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", str_replace(as.character(ts1[id]),":00:00",""),"</td>"))
    htmlbody <- c(htmlbody,paste0("<td>", str_replace(as.character(ts2[id]),":00:00",""),"</td>"))
    htmlbody <- c(htmlbody,paste0("<td><a href='", fnamedetailOVLink[id],"'>Link</a></td>"))
    htmlbody <- c(htmlbody,paste0("</tr>"))
  }
  htmlbody <- c(htmlbody,paste0("</table>"))
}


#  make overviev document
if ( restrict_to_country != F ) {
  html<-c(htmlhead,htmlbody,htmlfoot)
  writeLines(html,"overview.html")
} 

# browse and upload overview document
if ( restrict_to_country != F ) {
  browseURL("overview.html")
  upload("overview.html","idep/")
} 

































