function [ MAT_Cumsum, Curve_Length ] = CurveLength ( Pa, Pb, Mat )
%
% CURVELENGTH - Compute curve length between two inserted starting points.
%
% USAGE.
%   [ MAT_Cumsum, Curve_Length ] = CurveLength ( Pa, Pb, Mat )
%
% DESCRIPTION.
%   Function adds reference points Pa & Pb to matrix Mat wchich is
%   created by vectors forming curve. Then length of curve is
%   computed between starting Pa and ending Pb point. This function
%   was created to compute the distances along the vectorized headsurface.
%   
% INPUTS.
%   Pa is vector in which the curve starts. e.g.[x,y,z]
%   Pb is vector. Ending point of the curve.
%   Mat is [n,3] matrix of sorted points which generate curve.
%   
% OUTPUTS.
%   MAT_Cumsum [n,4] is matrix Mat now starting with point Pa and 
%   ends with Pb. Forth column contains cumulative distances between
%   the points.
%   Curve_Length is final length of curve MAT_Cumsum.  e.g. 345mm
%
% EXAMPLE.
%   Mat = [5 5 5; 10 10 10; 20 20 20; 30 30 10; 35 35 5];
%    plot4(Mat, 'm.', 15), plot4(Mat, 'ro', 10), plot4(Mat, 'c-')
%   % Run function
%   [XX, CL] = CurveLength ( [5 5 2], [35 35 2], Mat );
%    plot4(XX, 'k.', 15), plot4(XX, 'b-')
%
% See also DISTBTW, PLOT4.
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.0
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-



% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
    if nargin > 3
        error('Wrong number of input arguments.');
    end
    
    if nargout > 2
        error('Too many output arguments.');
    end
    
    
% DELETE Mat POINTS WHICH ARE TOO CLOSE TO Pa & Pb (<5mm)
% ..............................................................  ^..^ )~  
    [ SP, Idx ] = SphPoints ( Pa, 5, Mat );
    Mat(Idx,:) = [];
    clear SP Idx
    
    [ SP, Idx ] = SphPoints ( Pb, 5, Mat );
    Mat(Idx,:) = [];
    clear SP Idx
    


% INSERT START POINT & END POINT (Pa, Pb) TO THE MATRIX Mat
% ..............................................................  ^..^ )~  
    One = DistBtw( Pa(1, 1:3), Mat(1, 1:3));
    Two = DistBtw( Pa(1, 1:3), Mat(end, 1:3));

    % Adjust order
    if One < Two
        Mat = [Pa; Mat; Pb];
    else
        Mat = [Pb; Mat; Pa];
        Mat = flipud(Mat); % Mat always starts with "Pa"        
    end  
    


% BUILD RESULT
% ..............................................................  ^..^ )~ 
    [D_List, C_List] = DistBtw ( Mat ); 
    
    % Add to Mat matrix forth column of cumulative distances
    MAT_Cumsum = [Mat, C_List];
    
    % Final curve length
    Curve_Length = C_List(end);
    
    
    
     
