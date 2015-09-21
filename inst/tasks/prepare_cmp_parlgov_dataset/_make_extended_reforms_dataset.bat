
:: making data sets 
R < Merge_Parlgov_Manifesto.r              > routs/Merge_Parlgov_Manifesto.rout              --vanilla
R < Extend_Parlgov_Manifesto_by_conflict.R > routs/Extend_Parlgov_Manifesto_by_conflict.rout --vanilla
R < Make_Cabinets_Dataset_from_Parties.R   > routs/Make_Cabinets_Dataset_from_Parties.rout   --vanilla
R < Merge_Reforms_with_MP_ParlGov.R        > routs/Merge_Reforms_with_MP_ParlGov.rout        --vanilla

:: end
echo done & pause
        
