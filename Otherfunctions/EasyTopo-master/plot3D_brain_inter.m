function plot3D_brain_inter(mni,values)

rootp= which('EasyTopo.m');
rootp = fileparts(rootp);

BrainSurface = load(fullfile(rootp,'BrainSurface.mat'));
load(fullfile(rootp,'cmap_jet.mat'));


%topographical images
img.values = topo_surf_rot(mni, values, BrainSurface.vertices);

%3D image on brain surface
vertvalue = img.values;

vertcolor = repmat([1 1 1], length(BrainSurface.vertices), 1);
vertplot = vertvalue/max(abs(vertvalue));
regIdx = find(isnan(vertplot)==0);
cidx = round(31.5*vertplot(regIdx)+32.5);
cidx(find(cidx>64)) = 64;
cidx(find(cidx<1)) = 1;
vertcolor(regIdx,:) = cmap(cidx,:);
clear vertvalue vertplot regIdx cidx

% fid = figure; % ---------------------------------------------------------
set(gcf,'color','w');
h = plotimage(BrainSurface.vertices,BrainSurface.faces, vertcolor, [0 0 1]);    
colormap(cmap); 
% colorbar;

% contextMenuImg(h,vertcolor,handles);
clear vertcolor