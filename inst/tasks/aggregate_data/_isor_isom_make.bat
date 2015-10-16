prompt $g 

REM ===========================================================================
REM CLEANING UP
REM ===========================================================================

  Rscript -e "library(idep); file.move(grep('Rmd$|bat$|r$|pdf$', list.files(pattern='.*\\..*'), invert=T, value=T, ignore.case=T),'old')"
  Rscript -e "unlink(list.files(pattern='tex2pdf'), recursive=T)"

  
REM ===========================================================================  
REM GENERATING isor data set
REM ===========================================================================

R < isor.R                         > routs/isor.rout                         --vanilla 

R < isor_ext_pro_minmaj.R          > routs/isor_ext_pro_minmaj.Rout          --vanilla
R < isor_ext_tsebelis.R            > routs/isor_ext_tsebelis.Rout            --vanilla        
R < isor_ext_erd_cabinet_ids.R     > routs/isor_ext_erd_cabinet_ids.Rout     --vanilla

R < isom.R                         > routs/isom.rout                         --vanilla 

REM ===========================================================================
REM building codebook HTML 
REM ===========================================================================

::Rscript -e "library(knitr); knitr::knit2html('isor_codebook.Rmd')" 
::Rscript -e "library(knitr); knitr::knit2html('isom_codebook.Rmd')" 
Rscript -e "library(rmarkdown); render('isor_codebook.Rmd')" 
Rscript -e "library(rmarkdown); render('isom_codebook.Rmd')" 
Rscript -e "library(rmarkdown); render('isor_codebook_manuals.Rmd')" 

REM ===========================================================================
REM MOVING FILES
REM ===========================================================================

  Rscript -e "files <- grep('codebook', list.files(pattern='codebook.*pdf$|codebook.*html$'), value=T)" ^
          -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/aggregats', overwrite=TRUE)" ^
          -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/outputs',   overwrite=TRUE)" ^
          -e "file.copy(files, 'C:/Dropbox/idep/data', overwrite=TRUE)" ^
          -e "files <- list.files(pattern='.rout')" ^
          -e "library(idep); file.move(files, 'old')" 

REM ===========================================================================
echo done & pause
        
