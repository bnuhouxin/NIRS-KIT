function design_inf = snirf_design_inf_maker(subname,stim,design_inf)

if isempty(design_inf)
    design_inf{1,1} = 'SubID\ConditionName';
    design_inf{2,1} = subname;
    for n_cond = 1:size(stim,2)
        design_inf{1,n_cond+1} = stim(1,n_cond).name;
        design_inf{2,n_cond+1} = stim(1,n_cond).data(:,1:2);
    end
else
    nline = size(design_inf,1);
    design_inf{nline+1,1} = subname;
    
    for n_cond = 1:size(stim,2)
        condind = find(strcmp(stim(1,n_cond).name,design_inf(1,2:end))==1);
        if length(condind) ~= 1
            warndlg(['The desing_inf of the current subject [',subname,'] is not equal to others !!!'],'Warning');
            display(['-----------  The desing_inf of the current subject [',subname,'] is not equal to others !!! -----------']);

        else
            design_inf{nline+1,condind+1} = stim(1,n_cond).data(:,1:2);
        end
    end

end