function indexdata =  NR_nodeDegree(matrixData,handles)


for i = 1:length(matrixData)
    if 1 == NetType
        [Cprand, ~] = gretna_node_clustcoeff(RandNet);
        [Lprand, ~] = gretna_node_shortestpathlength(RandNet);
    else
        [Cprand, ~] = gretna_node_clustcoeff_weight(RandNet , '2');
        [Lprand, ~] = gretna_node_shortestpathlength_weight(RandNet);
    end
    Cprand(n, 1) = Cprand;
    Lprand(n, 1) = Lprand;
    
end