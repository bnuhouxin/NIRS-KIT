function currentNum = NR_findCurrentNumAll(allMatrix)
    
    % find current channle\source\detector number of all probes
    
    currentNum = [0,0,0];
    for i=1:length(allMatrix)
        meshN = allMatrix{i};
        Num = NR_findCurrentNum(meshN);
        for j=1:length(currentNum)
            if currentNum(j) < Num(j)
                currentNum(j) = Num(j);
            end
        end
    end
    
    
end