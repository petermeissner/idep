REM making data sets 

R < Merge_Parlgov_Manifesto.R                > routs/Merge_Parlgov_Manifesto.Rout                 --vanilla
R < Extend_Parlgov_Manifesto_by_conflict.R   > routs/Extend_Parlgov_Manifesto_by_conflict.Rout    --vanilla
R < Extend_Parlgov_Manifesto_by_volatility.R > routs/Extend_Parlgov_Manifesto_by_volatility.Rout  --vanilla
R < Make_Cabinets_Dataset_from_Parties.R     > routs/Make_Cabinets_Dataset_from_Parties.Rout      --vanilla
R < Merge_Reforms_with_MP_ParlGov.R          > routs/Merge_Reforms_with_MP_ParlGov.Rout           --vanilla

REM end
echo done & pause
        
