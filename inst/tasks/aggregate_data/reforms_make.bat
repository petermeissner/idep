Rscript -e "library(idep); file.move(grep('Rmd$|bat$|r$', list.files(pattern='.*\\..*'), invert=T, value=T, ignore.case=T),'old')"
REM Rscript -e "library(knitr); knitr::stitch_rhtml('reforms.R', 'reforms.R.out.html')"
Rscript -e "library(knitr); knitr::knit2html('reforms_codebook.Rmd')" 
Rscript -e "files <- grep('codebook', list.files(pattern='pdf$|html$'), value=T)" ^
        -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/aggregats')" ^
        -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/outputs')" 

echo done & pause
        
