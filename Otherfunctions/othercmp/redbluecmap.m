function c = redbluecmap(m,varargin)
%REDBLUECMAP creates a red and blue colormap.
%
%   REDBLUECMAP(M) returns an M-by-3 matrix containing a red and blue
%   diverging color palette. M is the number of different colors in the
%   colormap with a minimum of 3 and a maximum of 11. Low values are dark
%   blue, values in the center of the map are white, and high values are
%   dark red. If M is empty, a default value of 11 will be used.
%
%   Example:
% 
%       % Reset the colormap of the current figure, type
%             colormap(redbluecmap)
%
%   See also CLUSTERGRAM, COLORMAP, COLORMAPEDITOR, REDGREENCMAP.

%   Copyright 2007 The MathWorks, Inc.


% Reference: 
% http://colorbrewer.org.

%== Setting default
if nargin < 1 || isempty(m) || ~isnumeric(m)
    m = 11;
end

if ~isscalar(m)
    m = m(:);
end

m = max(abs(fix(m)), 3);
m = min(m, 11);

switch (m)
    case 3
        c = [239	138     98;
             247	247     247;
             103	169     207];
    case 4
        c = [202	0       32;
             244	165     130;
             146	197     222;
             5      113     176];
    case 5
        c = [202	0       32;
             244	165     130;
             247	247     247;
             146	197     222;
             5      113     176];
    case 6
        c = [178	24      43;
             239	138     98;
             253	219     199;
             209	229     240;
             103	169     207;
             33     102     172];
    case 7
        c = [178	24      43;
             239	138     98;
             253	219     199;
            247     247     247;
            209     229     240;
            103     169     207;
            33      102     172];
    case 8
        c = [178	24      43;
             214	96      77;
             244	165     130;
             253	219     199;
             209	229     240;
             146	197     222;
             67     147     195;
             33     102     172];
    case 9
        c = [178	24      43;
             214	96      77;
             244	165     130;
             253	219     199;
             247	247     247;
             209	229     240;
             146	197     222;
             67     147     195;
             33     102     172];
    case 10
        c = [103	0       31;
            178     24      43;
            214     96      77;
            244     165     130;
            253     219     199;
            209     229     240;
            146     197     222;
            67	    147     195;
            33      102     172;
            5       48      97];
    case 11
        c = [103    0       31;
            178     24      43;
            214     96      77;
            244     165     130;
            253     219     199;
            247     247     247;
            209     229     240;
            146     197     222;
            67      147     195;
            33      102     172;
            5       48      97];
end
c = flipud(c/255);
