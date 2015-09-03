REM CLEANING UP

  Rscript -e "library(idep); file.move(grep('Rmd$|bat$|r$|pdf$', list.files(pattern='.*\\..*'), invert=T, value=T, ignore.case=T),'old')"
  Rscript -e "unlink(list.files(pattern='tex2pdf'), recursive=T)"


REM GENERATING HTML AND PDF VERSION

REM Rscript -e "library(knitr); knitr::knit2html('reforms_codebook.Rmd')" 


REM MOVING FILES

  Rscript -e "files <- grep('codebook', list.files(pattern='codebook.*pdf$|codebook.*html$'), value=T)" ^
          -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/aggregats', overwrite=TRUE)" ^
          -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/outputs',   overwrite=TRUE)" ^
          -e "file.copy(files, 'C:/Dropbox/idep/data', overwrite=TRUE)"

echo done & pause
        
