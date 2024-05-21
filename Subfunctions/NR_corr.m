function [R,P] = NR_corr(data,SeedCh)
   
    % calculate RSFC using pearson correlation
    Seed = mean(data(:,SeedCh),2);
    for i=1:size(data,2)
        r = corrcoef(Seed,data(:,i));
        R(i) = r(1,2);
        if abs(R(i)-1)<1e-8 % ===========================================
            R(i)=0;
        end 
    end
end
