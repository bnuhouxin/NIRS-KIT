%% |paruly| documentation 
% This function returns a blueish-greenish-orangey-yellowish color map 
% which mimics, but  does not exactly match the default parula color
% map introduced in Matlab R2014b.  
% 
%% Syntax and Description
%
% |map = paruly(n)| returns an n-by-3 matrix containing a parula-like 
% colormap. If |n| is not specified, a value of 64 is used. 
%
%% Example 
 
surf(peaks) 
colorbar
colormap(paruly)
 
%% Author Info
% <http://www.chadagreene.com Chad A. Greene>. The University of Texas at Austin. 