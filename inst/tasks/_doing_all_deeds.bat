chcp 1252

REM moving packages to netdrive
robocopy "c:/dropbox/rpackages/idep" Z:/Geschäftsordnungen/Database/package/idep ^
    /MIR /XF .git* .Rbuild* *.Rproj .Rhistory /XD .git .Rproj* .settings devel
robocopy "c:/dropbox/rpackages/diffr" Z:/Geschäftsordnungen/Database/package/diffr ^
    /MIR /XF .git* .Rbuild* *.Rproj .Rhistory /XD .git .Rproj* .settings devel


REM uploading all raw data anew
cd   "C:\Dropbox\RPackages\idep\inst\tasks\check_and_upload_data\"
call "check_and_upload_data.bat"


REM downloading all data anew 
cd   "C:\Dropbox\RPackages\idep\inst\tasks\get_newest_data_from_db\"
call "get_newest_data_from_db_NO_TEXTS.bat"


REM aggregating data 



REM updating html files 
