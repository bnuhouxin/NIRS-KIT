function R = NR_glm(data,SeedCh)  
    % signal
    Seed = mean(data(:,SeedCh),2);
    for i=1:size(data,2)
        R(i) = regress(data(:,i),Seed);
        if abs(R(i)-1)<1e-8 % ===========================================
            R(i)=0;
        end
    end
end
