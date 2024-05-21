function HuntPoints = FixPoints (Dist, CurveMat, HeadMat)

% FIXPOINTS - Function finds points on the arch.
%
% USAGE.
%   HuntPoints = FixPoints (Dist, CurveMat, HeadMat)
%
% DESCRIPTION.
%   Function finds points on the arch "CurveMat" according distance from
%   starting point. If nargin is 3, hunted point is projected to the head
%   surface "HeadMat".
%
% INPUTS.
%   Dist are [n,1] or [1,n] distances from starting point
%    to HuntPoints along CurveMat. Dist can be in percentage {Dist < 1}
%    e.g. [0.1 0.5 0.9] or is length from starting point {Dist > 1} in
%    millimeter e.g. [15 120 130].
%   CurveMat is sorted [n,3] matrix of vectors forming curve running along
%   the head surface.
%   HeadMat is [n,3] vectorized head surface.
%   
% OUTPUT.
%   HuntPoints [n,3] matrix of vectors.
%
% See also DISTBTW, PLOT4, CURVELENGTH.
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 6.march.2006,    VERSION: 1.0
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-



% CHECKING INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
    if nargin < 2 | nargin > 3
        error('Wrong number of input arguments.');
    end
    
    if nargout > 1
        error('Too many output arguments.');
    end
    
    

% CHECKING SIZE OF CurveMat MATRIX  -> EXISTANCE OF FORTH COLUMN
% WITH CUMULATIVE DISTANCES BETWEEN POINTS
% ..............................................................  ^..^ )~
    if size(CurveMat, 2) ~= 4 
        [Ddist, Dcum ] = DistBtw( CurveMat );
        CurveMat(:, 4) = Dcum;
    end    

    
    
% ANALYZE Dist SIZE
% ..............................................................  ^..^ )~
    % Dist is one value
    if size(Dist,1) == size(Dist,2)
        amount = 1; 
    end

    % Dist is [1,n] matrix
    if size(Dist,1) < size(Dist,2) & size(Dist,1) == 1
        amount = size(Dist,2); 
    end
    
    % Dist is [n,1] matrix
    if size(Dist,1) > size(Dist,2) & size(Dist,2) == 1
        amount = size(Dist,1); 
    end
    
    % amount was not analyzed -> return function
    if ~exist( 'amount' ,'var') 
            error('Dist have to be [1,n] or [n,1] matrix.')
        return
    end
    
    
    
% ANALYZE Dist -> CAN BE IN PERCENT OR IN MILLIMETER
% ..............................................................  ^..^ )~
    % Dist is in percent e.g. 0.1 : 0.1 : 0.9 - > find point in 10% step of
    % total length of CurveMat
    if Dist(:) < 1
        L = Dist * CurveMat(end,4);
    end
    
    % Dist is length from starting CurveMat(1,:) point e.g. 120mm
    if Dist(:) > 1
        L = Dist;
    end

    

% SEARCH HUNT POINTS
% ..............................................................  ^..^ )~
for count = 1 : amount

%     % Select length
%     L = Dist(count) * CurveMat(end,4);
%     L = Dist(count);

    % Find two closest point to HuntPoints
    Q1 = CurveMat(:,4) < L(count);
    Q1 = CurveMat(Q1,:);
    Q1 = Q1(end,:);

    Q2 = CurveMat(:,4) > L(count);
    Q2 = CurveMat(Q2,:);
    Q2 = Q2(1,:);

    % Distance between two closest points
    Q1_Q2_Dist = Q2(4) - Q1(4);
    Q = [Q1; Q2];
 
    % Interpolate HuntPoints
    Xdif = (Q(2,1) - Q(1,1))/Q1_Q2_Dist;
    XI = (((L(count)) - Q1(4)) * Xdif) + Q(1, 1);

    Ydif = (Q(2,2) - Q(1,2))/Q1_Q2_Dist;
    YI = (((L(count)) - Q1(4)) * Ydif) + Q(1, 2);

    Zdif = (Q(2,3) - Q(1,3))/Q1_Q2_Dist;
    ZI = (((L(count)) - Q1(4)) * Zdif) + Q(1, 3);    
    
    HuntPoints(count, :) = [ XI, YI, ZI]; % hunted point on the cruve
    clear Q1 Q2 Q Q1_Q2_Dist Xdif Ydif Zdif XI YI ZI
end
    % plot4 (HuntPoints, 'r.',  10)

    
% PROJECT HuntPoints TO THE HEAD SURFACE
% ..............................................................  ^..^ )~
    if nargin == 3
        for i = 1 : count
            Disto = DistBtw( HuntPoints(i,:), HeadMat ); 
            [D,I] = min(Disto);
            HuntPoints(i,:) = HeadMat(I,:); % closest point
            clear Disto D I
        end
    end


    
    
    