function [ PP1020, Namaes ] = nfri_auto1020( RefP, Mat, arf, crf, Slice, SeePlot )
%
% NFRI_AUTO1020 - Virtual 10-20 measurement on the vectorized head surface.
%
% USAGE.
%   [ PP1020, Namaes ] = nfri_auto1020 ( RefP, Mat, arf, crf, Slice, SeePlot )
%
% DESCRIPTION.
%   Function finds 10-20 position according to the distances between
%   landmarks over the head surface. In a virtual space three landmark
%   positions define a plane. By extracting head surface points which
%   comprised a cross-section between the plane and the head surface
%   reference curve can be dravw. The reference curve enabled computation
%   of the length over the head surface between two starting points. 
%
% INPUTS.
%   RefP is [4,3] matrix of Primary Reference Points in order nasion Nz,
%     inion Iz and two preauricular points, AR on the right side and
%     AL on the left side.
%   Mat [n,3] is vectorized head surface.
%   arf string define drawing of 10% Axial Reference Curve. It can be:
%    'anteriorposterior' if working on anterior and posterior halves or
%    'hemispheric' if working on each hemisphere.
%   crf string define drawing of Coronal Reference Curves. It can be:
%    'balanced' points are found on the coronal reference curve along plane
%     defined by three points e.g. F7 - Fz -F8
%    'shortest' points are found on the shortest distance curve between
%     two corresponding starting points e.g. F7 and Fz
%   Slice is number expressive thickness of cross-section plane thus Mat
%     points are extracted from so defined cutting slice. Defaul is 0.5mm 
%     so final thickness is 1mm. e.g. cutting zero XY plane +- 0.5mm
%   SeePlot if it is string 'PrintPlot', plot is displayed.
%
% OUTPUT.
%   PP1020 [25,3] matrix of 10-20 positions.
%   Namaes [25,1] matrix return name for each 10-20 point.
%
% EXAMPLE.
%   load sample/samplehead.mat;
%   load sample/sampleinputs.mat;
%   [P, N] = nfri_auto1020(sampleinputs(1:4,:), samplehead, 'hemispheric', 'balanced', 0.5, 'PrintPlot');
%
% REFERENCES.
%   1.) Virtual 10-20 measurement on MR images for inter-modal linking of
%       transcranial and tomographic neuroimaging methods. NeuroImage
%   2.) 10/20, 10/10 and 10/5 systems revisited: their validity as relative
%       head-surface-based positioning systems. NeuroImage
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 13.march.2006,    VERSION: 1.2
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

    

% VISUALIZE SITUATION
% ..............................................................  ^..^ )~
%     plot4(Mat, 'c.', 1)
%     plot4(RefP, 'r.', 15)


% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
    if nargin < 4 
        error('Minimum four inputs required ');
    end

    if nargin > 6
        error('Wrong number of input arguments.');
    end
    
    if nargout > 2
        error('Too many output arguments.');
    end
    
    % Four inputs      
    if nargin <= 4
        Slice = 0.5;
        SeePlot = [];
    end
    
    
    % Analyze fift input
    if nargin == 5  &  isnumeric(Slice)
        SeePlot = []; % later don't plot resualt
    end
    
    if nargin == 5  &  isstr(Slice)
        Slice = 0.5; 
        SeePlot = 'PrintPlot'; % later plot resualt
    end


    % Specify Primary Reference Points
    RefP = RefP(1:4,:); % needs first 4 rows
    Nz = RefP(1,1:3);
    Iz = RefP(2,1:3);
    AR = RefP(3,1:3);
    AL = RefP(4,1:3);
    


% DELETE Mat POINTS AROUND PREAURICULAR POINTS AR & AL 
% Minimalize influence of points from ears
% ..............................................................  ^..^ )~
    [ SphMat, Sel ] = SphPoints ( AL, 30, Mat ); % radius set to 20mm
    Mat(Sel,:) = []; % left side deleted 
    clear SphMat Sel
    
    [ SphMat, Sel ] = SphPoints ( AR, 30, Mat );
    Mat(Sel,:) = []; % right side deleted 
    clear SphMat Sel
    
     plot4(Mat, 'c.', 1); plot4(RefP, 'r.', 15);
    


% FIND APPROXIMATE Cz -> Cz_First
% #### Cz_First #### - The Cz_First is set so that the sum of the
    % absolute values of ([Nz,Cz_First] ? [Iz,Cz_First]) and
    % ([AR,Cz_First] ? [AL,Cz_First]) is minimum.
% ..............................................................  ^..^ )~
    
    % Select Mat points which create upside part of the head
    % First make mean Mid of reference points
    Mid = mean([Nz;Iz;AR;AL]); % plot4(Mid, 'r*', 5),
    
    % Take Mid X and Y value and select points within this square
    % on the top of the head
    Sel = Mat(:,1) < Mid(:,1)+10  &  Mat(:,1) > Mid(:,1)-10 & ...
          Mat(:,2) < Mid(:,2)+10  &  Mat(:,2) > Mid(:,2)-10;
      
    Sq = Mat(Sel,:);
    % plot4(Sq, 'm.', 1)
        
    % Make mean of square
    MidSq = mean(Sq);
    
    % Finally select upside part of the head
    MatTop = SphPoints ( MidSq, 70, Mat );
    % plot4(MatTop, 'm.', 1)
    clear Mid Sel Sq MidSq    

    % Distance from each reference point to each MatTop points
    DistoNz = DistBtw( Nz, MatTop ); 
    DistoIz = DistBtw( Iz, MatTop ); 
    DistoAR = DistBtw( AR, MatTop ); 
    DistoAL = DistBtw( AL, MatTop ); 

    % Select optimal point Cz_First
    Dlist = abs(DistoNz - DistoIz) + abs(DistoAR - DistoAL);
    [D,I] = min(Dlist);
    Cz_First = MatTop(I,:);
    % plot4( Cz_First, 'm.', 15 )
    clear DistoNz DistoIz DistoAR DistoAL Dlist D I





% FIND FINAL Cz
% ..............................................................  ^..^ )~
% Repeat searching procedure for 4 times
for count = 1 : 4
    
% #### Cz_Second ### - A plane defined by points Nz, the first Cz and
    % Iz, sliced out head surface points, which were further wrapped up by
    % a convex hull. Thus the generated curve enabled computation of the
    % length over the head surface between Iz and Nz. The Cz_Second 
    % is set in the middle of the reference sagittal curve
    % along the head surface.

    Curve = Prepense1 (Nz, Iz, Cz_First, Mat, Slice);
    % plot4(Curve, 'm.', 5), plot4(Curve, 'r-')
    
    % In the middle of this reference sagittal curve which is running 
    % along the head surface we set Cz_Second
    Cz_Second = FixPoints (0.5, Curve, Mat); 
    % plot4 (Cz_Second, '.b', 15)
    clear Curve

    
% #### Cz_Third ### - Using a plane defined by points AL, Cz_Second
    % and AR, a reference coronal curve is determined. Cz_Third is set
    % in the middle of the reference curve along the head surface.

    Curve = Prepense1 (AL, AR, Cz_Second, Mat, Slice);
    % plot4(Curve, 'm.', 5), plot4(Curve, 'r-')

    % In the middle of the coronal reference curve which is runnig 
    % along the head surface we set Cz_Third
    Cz_Third = FixPoints (0.5, Curve, Mat); 
%    plot4 (Cz_Third, '.r', 15)
clear Curve 


% #### Cz_Meet ### - is average of Cz_Second & Cz_Third projected to the
    % head surface

    % Coordinates for "Cz_Meet"
    % Cz_Meet = [ Cz_Second(1), Cz_First(2), Cz_First(3) ]; % older version
    Cz_Meet = mean([ Cz_Second; Cz_Third ]);
    % plot4 (Cz_Meet, 'g.', 15)

    % We'll transfer Cz_Meet to the head surface
    Disto = DistBtw( Cz_Meet, Mat ); 
    [D,I] = min(Disto);
    clear Cz_Meet
    Cz_Meet = Mat(I,:); % nearest point on the head surface
    clear Disto D I
    % plot4(Cz_Meet, '.m', 15)
    clear Cz_First Cz_Second Cz_Third

    if count == 4 % last count run, we store value as Cz
        Cz = Cz_Meet; % final Cz
    end

    Cz_First = Cz_Meet; 
    clear Cz_Meet
end 
clear Cz_Meet count

    % Plot Cz 
     plot4(Cz, '.r', 20);

     

     
% POINTS ON THE SAGITAL CURVE Nz - Cz - Iz
% ..............................................................  ^..^ )~
    Curve = Prepense1 (Nz, Iz, Cz, Mat, Slice); 
     plot4(Curve, 'm-');

    % 10-20 Points on the sagittal Curve
    PP = FixPoints ( [0.1 0.3 0.7 0.9], Curve, Mat);
     plot4(PP, 'b.', 20);
     
    % Entitle points
    [Fpz, Fz, Pz, Oz] = TitleP(PP);
    clear Curve PP
    



% POINTS ON THE CORONAL CURVE AL - Cz - AR
% ..............................................................  ^..^ )~
    Curve = Prepense1 (AL, AR, Cz, Mat, Slice);
     plot4(Curve, 'm-');
     
    % 10-20 Points on the coronal Curve
    PP = FixPoints ( [0.1 0.3 0.7 0.9], Curve, Mat);
     plot4(PP, 'b.', 20);

    % Entitle points
    [T3, C3, C4, T4] = TitleP(PP);
    clear Curve PP


    

% 10-20 POINTS ON THE 10% AXIAL REFERENCE CURVE (arf)
% ..............................................................  ^..^ )~
% ### WORKING ON ANTERIOR AND POSTERIOR HALVES ###
if isequal( arf, 'anteriorposterior' )    
    
  % 10% ANTERIOR REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (T3, T4, Fpz, Mat, Slice);    
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-20 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Fpz, Curve, [0.2 0.6], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [Fp1, F7] = TitleP(PPA);
    [Fp2, F8] = TitleP(PPB);
    clear Curve PPA PPB    
    
 % 10% POSTERIOR REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>    
    Curve = Prepense1 (T3, T4, Oz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');

    % 10-20 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Oz, Curve, [0.2 0.6], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [O1, T5] = TitleP(PPA);
    [O2, T6] = TitleP(PPB);
    clear Curve PPA PPB 
end
    
    

% ### WORKING ON EACH HEMISPHERE ###
if isequal( arf, 'hemispheric' )
    
  % 10% LEFT REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (Fpz, Oz, T3, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-20 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (T3, Curve, [0.4 0.8], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [F7, Fp1] = TitleP(PPA);
    [T5, O1] = TitleP(PPB);
    clear Curve PPA PPB    


 % 10% RIGHT REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>    
    Curve = Prepense1 (Fpz, Oz, T4, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');

    % 10-20 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (T4, Curve, [0.4 0.8], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [F8, Fp2] = TitleP(PPA);
    [T6, O2] = TitleP(PPB);
    clear Curve PPA PPB 
end




% CORONAL REFERENCE CURVES (crf)
% ..............................................................  ^..^ )~
% ### WORKING ALONG PLANES - balanced manner ###
if isequal( crf, 'balanced' )
   
  % F7-Fz-F8 <~><~><~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (F7, F8, Fz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-20 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Fz, Curve, [0.5], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);     
    
    % Entitle points
    [F3] = TitleP(PPA);
    [F4] = TitleP(PPB);
    clear Curve PPA PPB
    
    
  % T5-Pz-T6 <~><~><~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (T5, T6, Pz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-20 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Pz, Curve, [0.5], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);     
    
    % Entitle points
    [P3] = TitleP(PPA);
    [P4] = TitleP(PPB);
    clear Curve PPA PPB
end
    
    
% ### SHORTEST DISTANCE CURVE - short manner ###
if isequal( crf, 'shortest' )
    
   % F3
    [tP, tD, tM] = HalfwayPoint ( F7, Fz, Mat );
     plot4(tM, 'm-');    
    PP = FixPoints ( [0.5], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM    
    % Entitle points
    [F3] = TitleP(PP);
    clear PP
    
  % F4
    [tP, tD, tM] = HalfwayPoint ( F8, Fz, Mat );
     plot4(tM, 'm-');    
    PP = FixPoints ( [0.5], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [F4] = TitleP(PP);
    clear PP
 
  % P3
    [tP, tD, tM] = HalfwayPoint ( T5, Pz, Mat );
     plot4(tM, 'm-');
    PP = FixPoints ( [0.5], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [P3] = TitleP(PP);
    clear PP
    
  % P4
    [tP, tD, tM] = HalfwayPoint ( T6, Pz, Mat );
     plot4(tM, 'm-');    
    PP = FixPoints ( [0.5], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [P4] = TitleP(PP);
    clear PP    
end
    
    

% FIND POINTS Cb1 & Cb2
% ..............................................................  ^..^ )~
if isequal( crf, 'balanced' )
    
    % Rotation A, B, C to the zero xy plane, also rotate matrix MM
    [ AAr, BBr, CCr, InvCoef, RotCoef, TransCoef, MMr ]... 
                                = Rot3( T5, T6, Pz, Mat ); 
   
    % Define range for z plane & select accurate part & indices
    Sel = MMr(:,3) >= -(Slice) & MMr(:,3) <= (Slice);
    Curve = MMr(Sel,:);
    Curve(:, 3) = 0; % z==0
    % plot4(Curve, 'y.', 5)
    clear Sel
    
    g = 1.5708; % 90 degree rotation around Z axis
    Rz = [ cos(g) -sin(g) 0;  sin(g) cos(g) 0 ;  0 0 1 ]; 
    Tempy = Curve * Rz;
    % plot4(Tempy, '.m', 5)
    
    K = convhulln(Tempy(:, 1:2)); % returns indices    
    Curve = Curve(K(:, 1), :); % select apex points

    % plot4(Curve, '.b', 10), plot4(Curve, '-m')
    % plot4([AAr; BBr; CCr], 'r.', 15) 
    clear K Tempy g Rz
    
    % Rotate selected Curve matrix back to initial head
    Curve(:, 4) = 1;   
    Curve = Curve / RotCoef / InvCoef;  
    Curve(:, 4) = [];    
    % plot4(Curve, 'r.', 5), plot4(Curve, 'r-'), plot4(Mat, 'c.', 1)
    clear AAr BBr CCr InvCoef RotCoef TransCoef MMr
    
    % Fill Curve
    FL = FillLine ( Curve, 10 );
    % plot4(FL, 'b.', 5)
    
    [ CurveA, CurveB ] = Prepense2 (Pz, FL);
    % plot4(CurveA, 'r.', 5)
    % plot4(CurveB, 'g.', 5)
    
% Hunt Cb1
% ..............................................................  ^..^ )~
 % Insert P3 & T5 to CurveA
    % Closest CurveA point to P3
    P = DistBtw ( P3, CurveA, 1 ); % closest point
    
    % Replace P with P3
    [D,I] = ismember(P, CurveA(:, 1:3), 'rows');
    CurveA(I,:) = P3;
    clear P D I
    
     % Closest CurveA point to T5
    P = DistBtw ( T5, CurveA, 1 ); % closest point
    
    % Replace P with T5
    [D,I] = ismember(P, CurveA(:, 1:3), 'rows');
    CurveA(I,:) = T5;
    clear P D I
    
    
    % CurveA start in P3
    [D,I] = ismember(P3, CurveA(:, 1:3), 'rows');
    CurveA = CurveA(I:end,:);
    clear D I
    
    % Find position of T5 & compute distance P3-T5
    [D,I] = ismember(T5, CurveA(:, 1:3), 'rows');
    
    CurveP3T5 = CurveA(1:I,:); % plot4(CurveP3T5, 'b.', 5);
    [dist_P3T5, dist_P3T5] = DistBtw( CurveP3T5 );
    dist_P3T5 = dist_P3T5(end);
    
    % Now CurveA start in T5
    [D,I] = ismember(T5, CurveA(:, 1:3), 'rows');
    CurveA = CurveA(I:end,:); % plot4(CurveA, 'k.', 5)
    plot4(CurveA, 'm-');
    clear D I
    
    % Here is Cb1
    % Cb1 = FixPoints (dist_P3T5, CurveA, Mat);
    % plot4(Cb1, 'b.', 20)
    
% Hunt Cb2
% ..............................................................  ^..^ )~
 % Insert P4 & T6 to CurveB
    % Closest CurveB point to P4
    P = DistBtw ( P4, CurveB, 1 ); % closest point
    
    % Replace P with P4
    [D,I] = ismember(P, CurveB(:, 1:3), 'rows');
    CurveB(I,:) = P4;
    clear P D I
    
     % Closest CurveB point to T6
    P = DistBtw ( T6, CurveB, 1 ); % closest point
    
    % Replace P with T6
    [D,I] = ismember(P, CurveB(:, 1:3), 'rows');
    CurveB(I,:) = T6;
    clear P D I    
    
    % CurveB start in P4
    [D,I] = ismember(P4, CurveB(:, 1:3), 'rows');
    CurveB = CurveB(I:end,:);
    clear D I
    
    % Find position of T6 & compute distance P4-T6
    [D,I] = ismember(T6, CurveB(:, 1:3), 'rows');
    
    CurveP4T6 = CurveB(1:I,:); % plot4(CurveP4T6, 'b.', 5)
    [dist_P4T6, dist_P4T6] = DistBtw( CurveP4T6 );
    dist_P4T6 = dist_P4T6(end);
    
    % Now CurveB start in T6
    [D,I] = ismember(T6, CurveB(:, 1:3), 'rows');
    CurveB = CurveB(I:end,:); % plot4(CurveB, 'k.', 5)
    plot4(CurveB, 'm-');
    clear D I
    
    % Here is Cb2
    % Cb2 = FixPoints (dist_P4T6, CurveB, Mat);
    % plot4(Cb2, 'b.', 20)
end

axis equal vis3d; grid on;


% FOLD 10-20 MATRIX
% ...............................................................  ^..^ )~
    PP1020 = [  Nz; Iz; AR; AL; ... % primary reference points
                C3; C4; Cz; F3; F4; F7; F8; Fpz; Fp1; Fp2; Fz; ... % 10-20
                O1; O2; P3; P4; Pz; T3; T4; T5; T6; Oz]; ... % 10-20
                % Cb1; Cb2  ];



% VISUALIZE RESUALT
% ...............................................................  ^..^ )~
    if nargin < 5   |  ~isequal( SeePlot, 'PrintPlot'  ) 
        close all % don't want to see resualt
    end

    
% MAKE SECOND OUTPUT
% ...............................................................  ^..^ )~
% Name each 10-20 point
    Namaes = { 'Nz'; 'Iz'; 'AR'; 'AL'; ...
        'C3';'C4';'Cz';'F3';'F4';'F7';'F8';'Fpz';'Fp1';'Fp2';'Fz'; ...
        'O1';'O2';'P3';'P4';'Pz';'T3';'T4';'T5';'T6';'Oz'}; ...
        % 'Cb1';'Cb2'};
      



% SUBFUNCTIONS  - often used part of code made as subfunction
% _______________________________________________________________________
% Prepense1
% Contain rotation to zero XY plane, Extract cross-section points, 
% Project these points to zero plane, select apicies which form curve, 
% rotate curve apicies points back to the initial head position, 
% insert two starting points, compute final length of curve.

function [ out1, out2 ] = Prepense1 (AA, BB, CC, MM, Slice)
    % Rotation A, B, C to the zero xy plane, also rotate matrix MM
    [ AAr, BBr, CCr, InvCoef, RotCoef, TransCoef, MMr ]... 
                                = Rot3( AA, BB, CC, MM, 'CutOverhung' ); 
   
    % Define range for z plane & select accurate part & indices
    Sel = MMr(:,3) >= -(Slice) & MMr(:,3) <= (Slice);
    Curve = MMr(Sel,:);
    Curve(:, 3) = 0; % z==0
    % plot4(Curve, 'y.', 5)
    clear Sel
    
    % From intersected points by using Qhull algorithm we select points
    % forming convex hull apices. To get nice sorted apices, starting
    % points must have x value == 0, we rotate Curve matrix 90degree
    % Sceme:
    %          y|
    %           |AAr[0 0 0]
    %    -------*--------------------- x
    %           | * 
    %           |    *
    %           |      *
    %           |      *
    %           |     *
    %           |  *
    %           *BBr[0 n 0]

    g = 1.5708; % 90 degree rotation around Z axis
    Rz = [ cos(g) -sin(g) 0;  sin(g) cos(g) 0 ;  0 0 1 ]; 
    Tempy = Curve * Rz;
    % plot4(Tempy, '.m', 5)
    
    K = convhulln(Tempy(:, 1:2)); % returns indices    
    Curve = Curve(K(:, 1), :); % select apex points

    % plot4(Curve, '.b', 10), plot4(Curve, '-m')
    % plot4([AAr; BBr; CCr], 'r.', 15) 
    clear K Tempy g Rz
    
    % Rotate selected Curve matrix back to initial head
    Curve(:, 4) = 1;   
    Curve = Curve / RotCoef / InvCoef;  
    Curve(:, 4) = [];    
    % plot4(Curve, 'r.', 5), plot4(Curve, 'r-'), plot4(Mat, 'c.', 1)
    clear AAr BBr CCr InvCoef RotCoef TransCoef MMr

    % By connecting Curve points we generate a reference curve running along 
    % the head surface. The reference curve enabled computation
    % of the length over the head surface between the two starting points
    % AA & BB
   [ out1, out2 ] = CurveLength (AA, BB, Curve); 
    % plot4(out1, 'r-')
return;


% _______________________________________________________________________
% Prepense2
% Halve reference curves running along head and determine points inside
% each quarter. e.g. Halve 10% axial referece curve T3-Fpz-T4 so get
% curves T3-Fpz and T4-Fpz. Thus 10-20 reference points FT7, F7, AF7, Fp1
% are set at 20, 40, 60, 80% along the total length of T3-Fpz curve.

function [ PPA, PPB ] = Prepense2 (APEX, CP, Step, Mat)
 % Closest Curve point to APEX
    P = DistBtw ( APEX, CP, 1 ); % closest point
    
    % Replace P with APEX
    [D,I] = ismember(P, CP(:, 1:3), 'rows');
    CP(I,:) = APEX;
    clear P D    
     
    % Devide curve
    CurveA = CP(1:I, :); % plot4(CurveA, 'g-')
    CurveA = flipud(CurveA); % first is peak point -> APEX
    CurveB = CP(I:end,:); % plot4(CurveB, 'k-')
    clear CP I 
    
   % Want just two bisection of CP
    if nargin == 2 
        PPA = CurveA;
        PPB = CurveB;
    end
    
    % Don't project point from curve to head surface    
    if nargin == 3
        % Quarter A -> 10-10 Points
            PPA = FixPoints ( Step, CurveA);
            % plot4(PPA, 'b.', 20)

        % Quarter B -> 10-10 Points
            PPB = FixPoints ( Step, CurveB);
            % plot4(PPB, 'b.', 20)
    end
    
    % Find points on the curves 
    if nargin == 4 
         % Quarter A -> 10-10 Points
            PPA = FixPoints ( Step, CurveA, Mat);
            % plot4(PPA, 'b.', 20)

        % Quarter B -> 10-10 Points
            PPB = FixPoints ( Step, CurveB, Mat);
            % plot4(PPB, 'b.', 20)
    end
return;  

% _______________________________________________________________________
% TitleP
% Subfunction used for naming 10-20 points
function [ varargout ] = TitleP (Box)
    for k = 1 : nargout
        varargout{k} = Box(k,:); % Cell array assignment
    end
return;


% _______________________________________________________________________
% title each point
% <o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x>
%     for count = 1 : size(Namaes, 1)
%         eval( [char(Namaes(count)) ' = PP1020(count,:);'] );
%     end
% <o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x>