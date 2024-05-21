function NR_map(outpath)

files = dir(fullfile(outpath,'*.mat'));
% mkdir(outpath);
load(fullfile(outpath,files.name));
stats_oxy = statsdata.stats_oxy;
stats_dxy = statsdata.stats_dxy;
stats_total = statsdata.stats_total;
p_oxy = statsdata.p_oxy;
p_dxy = statsdata.p_dxy;
p_total = statsdata.p_total;
switch length(stats_oxy)
    
    case 12  % probe 3x3
    case 22  % probe 3x5
        h = figure;fosa_topomap_plot_3x5(stats_oxy(1:22),[],-10); 
        saveas(gcf,fullfile(outpath,'stats_map'),'bmp');close(h);
    case 24  
        if(probeNum==2)  % probe 3x3x2
        else % probe 4x4
        end
    case 52 % probe 3x11          
    case 44 % Probe 3x5x2
        h = figure('position',[300 100 1500 280]);
        fosa_topomap_plot_3x5x2(stats_oxy(1:22),stats_oxy(23:44),[],-100,-100);
        saveas(h,fullfile(outpath,'stats_map(oxy)'),'bmp');
        fosa_topomap_plot_3x5x2(stats_dxy(1:22),stats_dxy(23:44),[],-100,-100);
        saveas(h,fullfile(outpath,'stats_map(dxy)'),'bmp');
        fosa_topomap_plot_3x5x2(stats_total(1:22),stats_total(23:44),[],-100,-100);
        saveas(h,fullfile(outpath,'stats_map(total)'),'bmp');
        close(h);
    case 48 % Probe 4x4x2
    case 34 % Probe 3x3 + 3x5
    case 36 % Probe 3x3 + 4x4
    case 46 % Probe 3x5 + 4x4 

end    

