function nirsdata=NR_regress(nirsdata,cov_path,subid)
    
    regressor_list = dir(fullfile(cov_path,'*.txt'));
    
    regressor = importdata(fullfile(cov_path,regressor_list(subid).name));
    if size(regressor,1) ~= size(nirsdata.oxyData,1)
        warndlg('The lengths of regressor and fNIRS data points are not equal !!!');
        return
    end
    
    for ch_id = 1:nirsdata.nch
        [~,~,res_oxy(:,ch_id),~,~] = regress(nirsdata.oxyData(:,ch_id),regressor);
        [~,~,res_dxy(:,ch_id),~,~] = regress(nirsdata.dxyData(:,ch_id),regressor);
        [~,~,res_total(:,ch_id),~,~] = regress(nirsdata.totalData(:,ch_id),regressor);
    end
    
    nirsdata.oxyData = res_oxy;
    nirsdata.dxyData = res_dxy;
    nirsdata.totalData = res_total;
    
end




