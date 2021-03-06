This is work. Its progressing, so its work in progress. Its not supposed to look nice. Its work. Its supposed to work.   

## Order of scripts

## 1) Gathering data and uploading it to Database

**files relevant**

- `inst/tasks/check_and_upload_data/clean_up_before_upload.r`
- `inst/tasks/check_and_upload_data/_check_and_upload_data.bat`
- `inst/tasks/check_and_upload_data/check_and_upload_data.R`
- `inst/tasks/check_and_upload_data/check_and_upload_data_regen_temp_tables.R`

**batch file**

```batch 

:: set up description
SET SHORTDESC=

:: clean up
R < clean_up_before_upload.r --vanilla 

:: execute uploads
R < check_and_upload_data.R > AUT.rout --vanilla --args ctr='AUT'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > BEL.rout --vanilla --args ctr='BEL'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > DEN.rout --vanilla --args ctr='DEN'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > ESP.rout --vanilla --args ctr='ESP'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > FRA.rout --vanilla --args ctr='FRA'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > GER.rout --vanilla --args ctr='GER'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > IRE.rout --vanilla --args ctr='IRE'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > ITA.rout --vanilla --args ctr='ITA'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > LUX.rout --vanilla --args ctr='LUX'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > NED.rout --vanilla --args ctr='NED'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > NOR.rout --vanilla --args ctr='NOR'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > POR.rout --vanilla --args ctr='POR'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > SWE.rout --vanilla --args ctr='SWE'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > UK.rout --vanilla --args ctr='UK'             SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > SWIGRN.rout --vanilla --args ctr='SWIGRN'     SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > SWIPARLG.rout --vanilla --args ctr='SWIPARLG' SHORTDESC='\"%SHORTDESC%\"' 

:: regenerate temporary database tables
R < check_and_upload_data_regen_temp_tables.R --vanilla

:: send email notification
R < latest_uploads.r > latest_uploads.rout --vanilla 
blat latest_uploads.txt -to retep.meissner@gmail.com -s "IDEP data upload finished" 

:: clean up 
R < clean_up_before_upload.r --vanilla & pause

```



## 2) get data from data base 

**files relevant**

- `inst/tasks/get_newest_data_from_db/_get_newest_data_from_db_NO_TEXTS.bat`
- `inst/tasks/get_newest_data_from_db/_get_newest_data_from_db_WITH_TEXTS.bat`
- `inst/tasks/get_newest_data_from_db/get_newest_data_from_db.R`

**batch file**

```batch 

R < get_newest_data_from_db.R > get_newest_data_from_db.Rout  --vanilla --args UPDATE_TEXTS=TRUE

```



## 3) prepare external data sets 

**files relevant**

- `inst/tasks/prepare_external_dataset/repare_external_datasets.bat`
- `inst/tasks/prepare_external_dataset/Extend_ERD_and_Cabinets_by_merge_ids.R`
- `inst/tasks/prepare_external_dataset/Extend_Parlgov_Manifesto_by_conflict.do`
- `inst/tasks/prepare_external_dataset/Extend_Parlgov_Manifesto_by_conflict.R`
- `inst/tasks/prepare_external_dataset/Extend_Parlgov_Manifesto_by_volatility.R`
- `inst/tasks/prepare_external_dataset/Make_Cabinets_Dataset_from_Parties.R`
- `inst/tasks/prepare_external_dataset/Merge_Parlgov_Manifesto.R`
- `inst/tasks/prepare_external_dataset/Merge_Reforms_with_MP_ParlGov.R`
- `inst/tasks/prepare_external_dataset/prepare_erd_dataset.do`
- `inst/tasks/prepare_external_dataset/prepare_erd_dataset.R`

**batch file**

```batch 

prompt $g 

call rm routs/*.*

REM ===========================================================================
REM prepare ParlGov and CMP (Comparative Manifesto Project) datasets 
REM ParlGov: Volatility
REM CMP:     Ideological Positions
REM ===========================================================================

call R < Merge_Parlgov_Manifesto.R                > routs/Merge_Parlgov_Manifesto.Rout                 --vanilla
call R < Extend_Parlgov_Manifesto_by_conflict.R   > routs/Extend_Parlgov_Manifesto_by_conflict.Rout    --vanilla
call R < Extend_Parlgov_Manifesto_by_volatility.R > routs/Extend_Parlgov_Manifesto_by_volatility.Rout  --vanilla
call R < Make_Cabinets_Dataset_from_Parties.R     > routs/Make_Cabinets_Dataset_from_Parties.Rout      --vanilla


REM ===========================================================================
REM prepare ERD datasets
REM ERD: general information on cabinets
REM ===========================================================================

call R < prepare_erd_dataset.R                    > routs/prepare_erd_dataset.Rout                     --vanilla


REM ===========================================================================
REM extend both datasets by ids for later merging / joining
REM ===========================================================================        

call R < Extend_ERD_and_Cabinets_by_merge_ids.R   > routs/Extend_ERD_and_Cabinets_by_merge_ids.Rout    --vanilla


echo done & pause

```



## 4) aggregate data into data sets ready for analysis

**files relevant**

- `inst/tasks/aggregate_data/variable_description_isor.r`
- `inst/tasks/aggregate_data/^Isor_isom_make.bat`
- `inst/tasks/aggregate_data/isom.R`
- `inst/tasks/aggregate_data/isom_codebook.R`
- `inst/tasks/aggregate_data/isom_codebook.Rmd`
- `inst/tasks/aggregate_data/isom_helper_aggregate_chg.R`
- `inst/tasks/aggregate_data/isom_helper_aggregate_so.R`
- `inst/tasks/aggregate_data/isor.R`
- `inst/tasks/aggregate_data/isor_codebook.R`
- `inst/tasks/aggregate_data/isor_codebook.Rmd`
- `inst/tasks/aggregate_data/isor_codebook_manuals.R`
- `inst/tasks/aggregate_data/isor_codebook_manuals.Rmd`
- `inst/tasks/aggregate_data/isor_ext_erd_cabinet_ids.R`
- `inst/tasks/aggregate_data/isor_ext_pro_minmaj.R`
- `inst/tasks/aggregate_data/isor_ext_tsebelis.R`
- `inst/tasks/aggregate_data/var_desc_isor.Rdata`
- `inst/tasks/aggregate_data/variable_description_isom.r`

**batch file**

```batch 

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


REM ========================================================  
REM GENERATING isom data set
REM ========================================================

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
        


```
