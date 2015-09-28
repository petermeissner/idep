prompt $g 

REM ===========================================================================
REM prepare ParlGov and CMP (Comparative Manifesto Project) datasets 
REM ParlGov: Volatility
REM CMP:     Ideological Positions
REM ===========================================================================

R < Merge_Parlgov_Manifesto.R                > routs/Merge_Parlgov_Manifesto.Rout                 --vanilla
R < Extend_Parlgov_Manifesto_by_conflict.R   > routs/Extend_Parlgov_Manifesto_by_conflict.Rout    --vanilla
R < Extend_Parlgov_Manifesto_by_volatility.R > routs/Extend_Parlgov_Manifesto_by_volatility.Rout  --vanilla
R < Make_Cabinets_Dataset_from_Parties.R     > routs/Make_Cabinets_Dataset_from_Parties.Rout      --vanilla


REM ===========================================================================
REM prepare ERD datasets
REM ERD: general information on cabinets
REM ===========================================================================

R < prepare_erd_dataset.R                    > routs/prepare_erd_dataset.Rout                     --vanilla


REM ===========================================================================
REM extend both datasets by ids for later merging / joining
REM ===========================================================================        

R < Extend_ERD_and_Cabinets_by_merge_ids.R   > routs/Extend_ERD_and_Cabinets_by_merge_ids.Rout    --vanilla


echo done & pause