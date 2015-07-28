R < clean_up_before_upload.r > clean_up_before_upload.rout --vanilla 

REM R < check_and_upload_data.R > AUT.rout --vanilla --args ctr='AUT'
REM R < check_and_upload_data.R > BEL.rout --vanilla --args ctr='BEL'
REM R < check_and_upload_data.R > DEN.rout --vanilla --args ctr='DEN'
REM R < check_and_upload_data.R > ESP.rout --vanilla --args ctr='ESP'
REM R < check_and_upload_data.R > FRA.rout --vanilla --args ctr='FRA'
REM R < check_and_upload_data.R > GER.rout --vanilla --args ctr='GER'
REM R < check_and_upload_data.R > IRE.rout --vanilla --args ctr='IRE'
REM R < check_and_upload_data.R > ITA.rout --vanilla --args ctr='ITA'
REM R < check_and_upload_data.R > LUX.rout --vanilla --args ctr='LUX'
REM R < check_and_upload_data.R > NED.rout --vanilla --args ctr='NED' 
REM R < check_and_upload_data.R > NOR.rout --vanilla --args ctr='NOR' 
REM R < check_and_upload_data.R > POR.rout --vanilla --args ctr='POR'
REM R < check_and_upload_data.R > SWE.rout --vanilla --args ctr='SWE'
REM R < check_and_upload_data.R > UK.rout --vanilla --args ctr='UK'
REM R < check_and_upload_data.R > SWIGRN.rout --vanilla --args ctr='SWIGRN'
REM R < check_and_upload_data.R > SWIPARLG.rout --vanilla --args ctr='SWIPARLG'

R < latest_uploads.r > latest_uploads.rout --vanilla 
blat latest_uploads.txt -to retep.meissner@gmail.com -s "IDEP data upload finished" & pause
