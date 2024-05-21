function FL = FillLine ( Mat, n )

% FILLLINE - Generates a linearly spaced vectors between two edge vectors.
%
% USAGE.
%   FL = FillLine ( Mat, n )
%
% DESCRIPTION.
%   Function generates n linearly spaced vectors between two neighbour
%   points of Mat [n,3] matrix.
%   FillLine function use matlab linspace function.
%
% INPUTS.
%   Mat is [n,3] matrix of 3D Cartesian coordinates. e.g. oak
%   n is number of points linearly spaced between two neighbour
%   points of Mat including these two edge points. Default n is 100.
%   
% OUTPUT.
%   FL [n,3] is Mat matrix filled with n linearly spaced vectors.
%
% See also LINSPACE.
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.0
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
    if nargin > 2
        error('Wrong number of input arguments.');
    end
    
    if nargout > 1
        error('Too many output arguments.');
    end
    
    % Set default n value
    if nargin == 1
        n = 100;
    end    

    
% GENERATING POINTS
% ..............................................................  ^..^ )~
    FL = []; % storage
    for j = 1 : size(Mat, 1) - 1
    
        X = linspace(Mat(j+1,1), Mat(j,1), n);
        Y = linspace(Mat(j+1,2), Mat(j,2), n);
        Z = linspace(Mat(j+1,3), Mat(j,3), n);
    
        % Store points
        FL = [X', Y', Z'; FL ];
clear X Y Z
    end


% VISUALIZE
% ..............................................................  ^..^ )~
%    plot4(Mat, 'b.', 5), plot4(Mat, 'g-')
%    plot4(FL, 'y.', 5)

    
    
    