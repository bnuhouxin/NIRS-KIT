function plot4 (Mat, MC, MS, COLOR)
%
% PLOT4 -  Simplified typing of matlab plot3 function.
%
% USAGE.
%   plot4 (Mat, MC, MS, COLOR)
%
% DESCRIPTION.
%   During programming process it is sometimes necessary to visualize
%   partial results, so instead of:
%    plot3(Mat(:,1), Mat(:,2), Mat(:,3), 'c.', 'MarkerSize', 15), hold on
%   is enougth to writet:
%    plot4(Mat, 'c.', 15) 
%   Function works also with multidimensional matrices [n,3,n].
%
% INPUTS.
%   Mat is [n,3] matrix of 3D Cartesian coordinates  e.g. head surface
%   MC defines marker and color  e.g. 'b.' or 'r*'  or 'co'  or 'ms'
%    default is blue dot 'b.'. If you want to define own color 
%    e.g. gray -> [0.8 0.8 0.8], define MC just as marker e.g. '.' or '-'
%   MS defines 'MarkerSize'  e.g. 15; default is 10
%   COLOR - define own (not matlab predefined) color e.g. [0.8 0.8 0.8] or
%    random color [randn(1,3)]
%   
% OUTPUT.
%   Output is plot3.
%
% See also PLOT3.
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 3.march.2006,    VERSION: 1.2
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECK INPUTS
% ...............................................................  ^..^ )~
    if nargin == 1
        MC = 'b.';
        MS = 10;
    end 
    
    if nargin == 2
        MS = 10;
    end
    
    
% PLOTTING
% ...............................................................  ^..^ )~
    % Mat is 3D vector ...........
    if isequal (size(Mat),[1 1 3])
        plot3(Mat(:,:,1), Mat(:,:,2), Mat(:,:,3), ...
                                    MC, 'MarkerSize', MS), hold on
        return;
    end        
    
    
    % MAt is array [n, 3, 3] ...........
    if size(Mat,3) > 1 
        % 3D array
        A = squeeze(Mat(:,1,:));
        B = squeeze(Mat(:,2,:));
        C = squeeze(Mat(:,3,:));
        plot3(A, B, C,  MC, 'MarkerSize', MS), hold on
    else
        % 2D array
        A = Mat(:,1);
        B = Mat(:,2);
        C = Mat(:,3);
        plot3(A, B, C,  MC, 'MarkerSize', MS), hold on
    end    
    
    
    % Define own color ...........
    if nargin == 4
        plot3(Mat(:, 1), Mat(:, 2), Mat(:, 3), ...
                    MC, 'Color', COLOR, 'MarkerSize', MS), hold on  
    end
   
    % Label axis
    xlabel('X'), ylabel('Y'), zlabel('Z')


