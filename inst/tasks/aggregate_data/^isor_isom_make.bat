prompt $g$g 

REM ========================================================
REM CLEANING UP
REM ========================================================

CALL Rscript -e "library(idep); file.move(grep('Rmd$|bat$|r$|pdf$', list.files(pattern='.*\\..*'), invert=T, value=T, ignore.case=T),'old')"
CALL Rscript -e "unlink(list.files(pattern='tex2pdf'), recursive=T)"
rm routs/*.rout
  
REM ========================================================  
REM GENERATING isor data set
REM ========================================================

CALL R < isor.R                         > routs/isor.rout                         --vanilla 
CALL R < isor_ext_pro_minmaj.R          > routs/isor_ext_pro_minmaj.Rout          --vanilla 
CALL R < isor_ext_tsebelis.R            > routs/isor_ext_tsebelis.Rout            --vanilla 
CALL R < isor_ext_erd_cabinet_ids.R     > routs/isor_ext_erd_cabinet_ids.Rout     --vanilla 


REM REM ========================================================  
REM REM GENERATING isom data set
REM REM ========================================================

CALL R < isom.R                         > routs/isom.rout                         --vanilla 

REM ========================================================
REM building codebook PDF 
REM ========================================================
CHCP 65001
CALL R < isor_codebook.R         > routs/isor_codebook.rout --vanilla 

CALL R < isom_codebook.R         > routs/isom_codebook.rout --vanilla 

CALL R < isor_codebook_manuals.R > routs/isor_codebook_manuals.rout --vanilla 


REM ========================================================
REM MOVING FILES
REM ========================================================

  CALL  Rscript -e "files <- grep('codebook', list.files(pattern='codebook.*pdf$|codebook.*html$'), value=T)" ^
          -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/aggregats', overwrite=TRUE)" ^
          -e "file.copy(files, 'Z:/Gesch\u00e4ftsordnungen/Database/outputs',   overwrite=TRUE)" ^
          -e "file.copy(files, 'C:/Dropbox/idep/data', overwrite=TRUE)" ^
          -e "files <- list.files(pattern='.rout')" ^
          -e "library(idep); file.move(files, 'old')" 

REM ========================================================
echo done & pause
        
