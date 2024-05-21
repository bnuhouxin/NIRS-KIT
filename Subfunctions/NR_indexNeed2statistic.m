function indexNeed2statistic =  NR_indexNeed2statistic(indexType)

% get indeces need to be statistical analysised acorrding to indexType

if strcmp(indexType,'SmallWorld')
    indexNeed2statistic = {'Cpzscore','Lpzscore','Sigma','Lambda','Gamma','aCpzscore','aLpzscore','aSigma','aLambda','aGamma'};
    return;
end

if strcmp(indexType,'Efficiency')
    indexNeed2statistic = {'Eloc','Eglob'};
    return;
end

if strcmp(indexType,'Modularity')
    indexNeed2statistic = {'modularity'};
    return;
end

if strcmp(indexType,'NodeDegree')
    indexNeed2statistic = {'nodalDeg','anodalDeg'};
    return;
end
% 
% if strcmp(indexType,'SmallWorld')
%     indexNeed2statistic = {'aCpzscore','aLpzscore','Cpzscore','Lpzscore',};
%     return;
% end
% 
% if strcmp(indexType,'SmallWorld')
%     indexNeed2statistic = {'aCpzscore','aLpzscore','Cpzscore','Lpzscore',};
%     return;
% end
% 
% if strcmp(indexType,'SmallWorld')
%     indexNeed2statistic = {'aCpzscore','aLpzscore','Cpzscore','Lpzscore',};
%     return;
% end
