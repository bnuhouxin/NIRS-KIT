function [TF_V,TF_P] = NK_Stat_Regress(dep,regressor,Contrast,TF_Flag)

[~,num_ind] = size(dep);

for ind = 1:num_ind  
    sub_ind = dep(:,ind);
    if numel(find(~isnan(sub_ind))) >= 2
        [TF_V(ind),TF_P(ind)] = NK_Regress(sub_ind,regressor,Contrast,TF_Flag); 
    else
        disp(['---------- There are too few individual indexdata for [channel or index = ',num2str(ind),']. ----------']);
        TF_V(ind) = NaN;
        TF_P(ind) = NaN;
    end
    
end
