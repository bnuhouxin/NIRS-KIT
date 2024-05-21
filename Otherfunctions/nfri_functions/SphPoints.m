function [ SphMat, Indx ] = SphPoints ( x0n, rn, Mat )

% SPHPOINTS - Selects matrix points within the sphere.
%
% USAGE.
%   [ SphMat, Indx ] = SphPoints ( x0n, rn, Mat )
%
% DESCRIPTION.
%   Function selects Mat points which are inside the sphere with
%   radius rn from center x0n.
%
% INPUTS.
%   x0n is sphere center; e.g. vector [ 0 0 0 ];
%   rn is radius; e.g. 90
%   Mat is [n,3] matrix of 3D Cartesian coordinates e.g. head surface.
%   
% OUTPUTS.
%   SphMat is [n,3] matrix of selected points.
%   Indx is [n,1] list of indexed selected points.
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.1
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
    if nargin ~= 3
        error('Wrong number of input arguments.');
    end
    
    if nargout > 2
        error('Too many output arguments.');
    end
    
    % Keep [n,3] size
    Mat = Mat(:,1:3);
    x0n = x0n(:,1:3);


% DISTANCES BETWEEN x0n & MATRIX Mat
% ..............................................................  ^..^ )~
    Disto = repmat( x0n, size(Mat, 1), 1 );
    PreD  = Mat - Disto;
    PreD2 = PreD.^2;
    PreD3 = sum(PreD2, 2);
    
    D_List = PreD3 .^ 0.5; % Now distance are found


% SELECT & INDEX SPHERE POINTS
% ..............................................................  ^..^ )~
    Indx = D_List <= rn;
    SphMat = Mat(Indx, :);
    

% VISUALIZE
% ..............................................................  ^..^ )~
%    plot4(Mat, '.c', 1)
%    plot4(SphMat, '.r', 1)
    

    
    
    
    
    
    
    
    
    
    
     

    