function MakePlot3D ( Mat, MS, ColorMap, Flp );

% MAKEPLOT3D - Generate nice plot of vectorized head or brain.
%
% USAGE.
%   MakePlot3D ( Mat, MS, ColorMap, Flp );
%
% DESCRIPTION.
%   Function paints Mat matrix. Matrix points are colored
%   according to distance from centroid of the Mat matrix. The aim is to
%   paint vectorized head or brain surface.
%
% INPUTS.
%   Mat is [n,3] matrix of vectorized discrete points. e.g. head surface
%   MS - MarkerSize - is size of plotted Mat points. Default is 10.
%   ColorMap - is string indicating supported Matlab Colormaps.
%   Default is 'bone'.
%   Flp - string 'FlipCM' will flip ColorMap matrix.
%
% OUTPUT.
%   Colored plot.
%
% EXAMPLE.
%   e.g. MakePlot3D ( [n,3], 7, 'hsv', 'FlipCM' );
%
% See also IMAGEREAD3D, DISTBTW.

%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.0
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECK INPUTS
% ..............................................................  ^..^ )~
    if nargin == 1 % if marix is too small
        ss = size(Mat);
        if ss(1) < 4 | ss(2) ~= 3;
            error('Input Mat must be [n,3] matrix, min n is 4');
        end
    end
    

    % Only 1 input
     if nargin == 1
        MS = 10; % default marker size
        ColorMap = 'bone'; % default colormap
        Flp = 'FlipCM'; % flip colormap
        Name = 'SeePlot'; % default name
     end
    

    % Only 2 inputs
     if nargin == 2
         
         % second input is marker size MS ........................
            if sum(size(MS))== 2 
                ColorMap = 'bone'; 
                Flp = 'FlipCM'; 
            end
            
         % second input is color map matrix ColorMap ..............
            if isequal(MS, 'autumn') | isequal(MS, 'bone') |...
                isequal(MS, 'colorcube') | isequal(MS, 'cool') |...
                isequal(MS, 'copper')  | isequal(MS, 'flag') |...
                isequal(MS, 'gray')  | isequal(MS, 'hot') |...
                isequal(MS, 'hsv')  | isequal(MS, 'jet') |...
                isequal(MS, 'lines')  | isequal(MS, 'pink') |...
                isequal(MS, 'prism')  | isequal(MS, 'spring') |...
                isequal(MS, 'summer')  | isequal(MS, 'white') |...
                isequal(MS, 'winter')
            
                 ColorMap = MS; % revers variables
                 MS = 10;          
            end
            
          % second input is flip color map FlipCM ...................
             if isequal(MS, 'FlipCM')
                 Flp = MS; % revers variables
                 MS = 10;
                 ColorMap = 'bone'; 
             end            
     end
     
     
     
    % Only 3 inputs
     if nargin == 3
         
         % MS is missing ...................
             if isequal(MS, 'autumn') | isequal(MS, 'bone') |...
                isequal(MS, 'colorcube') | isequal(MS, 'cool') |...
                isequal(MS, 'copper')  | isequal(MS, 'flag') |...
                isequal(MS, 'gray')  | isequal(MS, 'hot') |...
                isequal(MS, 'hsv')  | isequal(MS, 'jet') |...
                isequal(MS, 'lines')  | isequal(MS, 'pink') |...
                isequal(MS, 'prism')  | isequal(MS, 'spring') |...
                isequal(MS, 'summer')  | isequal(MS, 'white') |...
                isequal(MS, 'winter') ...
                & ...
                isequal(ColorMap, 'FlipCM')
                
                 ColorMap = MS;
                 Flp = ColorMap;
                 MS = 10;
             end
         
         
         % Third input is flipping info  .................
             if isequal(ColorMap, 'FlipCM')
                 ColorMap = 'bone'; 
                 Flp = 'FlipCM';
             end
     end




% ALGORITHM
% ..............................................................  ^..^ )~

    % Check matrix Mat, delete NaN rows if exist
    [i,j] = find(isnan(Mat)); % It can happen after normalization
    Mat(i,:) = [];
    clear i j

    % Centroid 
    Centricius = mean(Mat);
        
    % Distances from Centricius to each Mat point
    R = DistBtw( Centricius, Mat ); % call function
    R = round(R); % don't need exact distance for painting

    % Find min & max value of R
    minR = min(R);
    maxR = max(R);   
    
    % Define rank of painting
    L = maxR/2; % nice predefined rank, change it if you want
    M = maxR*1.2;    
    
    % Range of rank
    DistRank = L : M;
    DistRank = round(DistRank); % round values
    
    % Get length of DistRank
    dr = length(DistRank);
    
    % Define ColorBox
    magic_str = [ 'ColorBox = ' ColorMap,'(dr);'];
    eval(magic_str);
    clear magic_str
    

    % Maybe is nicer to flip colormap
    if ~exist('Flp','var'), Flp = 'DontFlip'; end % don't want to flip

    if isequal(Flp, 'FlipCM') % yes we want to flip colormap
        ColorBox = flipud(ColorBox); % flipud colormap
    end


% DEFINE PLOT STYLE
% ..............................................................  ^..^ )~
    % change it if you want
    % colordef black
    % figure    
    hold on
    grid on
    view(3)
    xlabel('X'), ylabel('Y'), zlabel('Z') 


% PAINTING POINTS ACCORDING DISTANCE FROM CENTRICIUS
% ..............................................................  ^..^ )~
    if ~exist('MS', 'var'), MS = 10; end % MS was not defined

    for n = 1 : dr
        Sel = ( R == DistRank(n)); % select points with same distance
         plot3(Mat(Sel,1), Mat(Sel,2), Mat(Sel,3),... 
                '.', 'Color', ColorBox(n,:), 'MarkerSize', MS)
      clear Sel
    end

    hold off
    rotate3d on   
    
    
% SAVE PLOT
% ..............................................................  ^..^ )~
    % saveas( gcf, 'abc.fig')
    
    
    
    
