  

dir='C:\nfri_functions\Test_KIT'
Origin = [dir filesep '0608_origin.csv'];
Others = [dir filesep '0608_others_ch.csv'];
isReferCheck=1;
ch_mni=nfri_mni_estimation_KIT(Origin, Others,isReferCheck);


nfri_anatomlabel_KIT(ch_mni, 'justtest', 10);