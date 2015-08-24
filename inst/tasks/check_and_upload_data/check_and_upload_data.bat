SET SHORTDESC=type1 and type2 errors resolved
R < clean_up_before_upload.r --vanilla 

REM R < check_and_upload_data.R > AUT.rout --vanilla --args ctr='AUT'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > BEL.rout --vanilla --args ctr='BEL'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > DEN.rout --vanilla --args ctr='DEN'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > ESP.rout --vanilla --args ctr='ESP'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > FRA.rout --vanilla --args ctr='FRA'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > GER.rout --vanilla --args ctr='GER'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > IRE.rout --vanilla --args ctr='IRE'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > ITA.rout --vanilla --args ctr='ITA'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > LUX.rout --vanilla --args ctr='LUX'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > NED.rout --vanilla --args ctr='NED'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > NOR.rout --vanilla --args ctr='NOR'           SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > POR.rout --vanilla --args ctr='POR'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > SWE.rout --vanilla --args ctr='SWE'           SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > UK.rout --vanilla --args ctr='UK'             SHORTDESC='\"%SHORTDESC%\"'
REM R < check_and_upload_data.R > SWIGRN.rout --vanilla --args ctr='SWIGRN'     SHORTDESC='\"%SHORTDESC%\"'
R < check_and_upload_data.R > SWIPARLG.rout --vanilla --args ctr='SWIPARLG' SHORTDESC='\"%SHORTDESC%\"' 

R < latest_uploads.r > latest_uploads.rout --vanilla 
blat latest_uploads.txt -to retep.meissner@gmail.com -s "IDEP data upload finished" 
R < clean_up_before_upload.r --vanilla & pause
