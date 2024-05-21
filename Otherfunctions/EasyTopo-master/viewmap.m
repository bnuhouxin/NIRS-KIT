function viewimg(theta, phi, map, upperbond)
% A function to view the interpolated brain maps in [theta phi] space
% Input parameters:
%   theta: theta-axis in the spherical coordinate system
%   phi: phi-axis in the spherical coordinate system
%   map: interpolated 2D brain maps in [theta phi] space
%   upperbond: value to normalize the range of colorbar
%
% Example: viewmap(map.theta, map.phi, map.HbO2)
%
% Last modified date: 15-Apr-2016

load cmap_jet;  
load BrainField;
    
figure('color','w')
if exist('upperbond') && ~isempty(upperbond)
	h = imagesc(phi(1,:),theta(:,1),map,[-upperbond upperbond]); set(gca,'Ydir','normal');
else
	h = imagesc(phi(1,:),theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
end    
hold on; contour(phi,theta,BrainField,5,'k-','linewidth',1);
xlabel('\phi (degree)'); ylabel('\theta (degree)');
colormap(cmap); colorbar;