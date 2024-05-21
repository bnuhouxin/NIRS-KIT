function NR_plotNetwork(statdata,index2plot,hb2plot)

if strcmp(index2plot,'Cpzscore')
    command = ['data2plot = statdata.indexdata_' hb2plot ';'];
    eval(command);
    group1data = data2plot.group1.Cpzscore;
    group2data = data2plot.group2.Cpzscore;
    figure;
end