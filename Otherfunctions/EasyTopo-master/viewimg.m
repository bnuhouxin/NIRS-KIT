function viewimg(vertices, faces, value, viewangle, upperbond)
% A function to view the interpolated topographical images on brain surface
% Input parameters:
%   vertices/faces: vertices & faces of brain surface mesh
%   value: interpolated topographical image on the brain surface
%   viewangle: 3D vetor that defines the angle to view the 3D brain surface
%           [ 1 0 0] - left
%           [-1 0 0] - right
%           [0  1 0] - frontal
%           [0 -1 0] - occipital
%           [0  0 1] - top
%   upperbond: value to normalize the range of colorbar
%
% Example: viewimg(img.vertices, img.faces, img.HbO2, [0 1 0])
%
% Last modified date: 15-Apr-2016

vertvalue = value;
vertcolor = repmat([1 1 1], length(vertices), 1);
if exist('upperbond') && ~isempty(upperbond)
	vertplot = vertvalue/abs(upperbond);
else
	vertplot = vertvalue/max(abs(vertvalue));
end
    
load cmap_jet;
regIdx = find(isnan(vertplot)==0);
cidx = round(31.5*vertplot(regIdx)+32.5);
cidx(find(cidx>64)) = 64;
cidx(find(cidx<1)) = 1;
vertcolor(regIdx,:) = cmap(cidx,:);
clear vertvalue vertplot regIdx cidx

figure('color','w')
h = plotsurf(vertices, faces, 'edgealpha', 0, 'facecolor', 'interp');
set(h,'FaceVertexCData',vertcolor, 'SpecularStrength',0, 'AmbientStrength',0.4);  daspect([1 1 1]); axis off;
view(3); 
if exist('viewangle')
	view(viewangle); 
else
	view([0 0 1]); 
end
camlight headlight; 
lighting gouraud;
    