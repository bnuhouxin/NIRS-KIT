function [ PP1010, Namaes ] = nfri_auto1010 ( RefP, Mat, arf, crf, zparc, Slice, SeePlot )
% 
% NFRI_AUTO1010 - Virtual 10-10 measurement on the vectorized head surface.
%
% USAGE.
%   [ PP1010, Namaes ] = nfri_auto1010 ( RefP, Mat, arf, crf, zparc, Slice, SeePlot )
%
% DESCRIPTION.
%   Function finds 10-10 position according to the distances between
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
%   zparc is string. zparc means -> zero percent axial reference curve
%    if zparc is 'yes' function will also compute points on the 0% axial
%    reference curve.
%   Slice is number expressive thickness of cross-section plane thus Mat
%     points are extracted from so defined cutting slice. Defaul is 0.5mm 
%     so final thickness is 1mm. e.g. cutting zero XY plane +- 0.5mm
%   SeePlot if it is string 'PrintPlot', plot is displayed.
%
% OUTPUT.
%   PP1010 [n,3] matrix of 10-10 positions.
%   Namaes [n,1] matrix return name for each 10-10 point.
%
% EXAMPLE.
%   load sample/samplehead.mat;
%   load sample/sampleinputs.mat;
%   [P, N] = nfri_auto1010(sampleinputs(1:4,:), samplehead, 'hemispheric', 'balanced', [], 0.5, 'PrintPlot');
%
% REFERENCES.
%   1.) Virtual 10-20 measurement on MR images for inter-modal linking of
%       transcranial and tomographic neuroimaging methods. NeuroImage
%   2.) 10/20, 10/10 and 10/5 systems revisited: their validity as relative
%       head-surface-based positioning systems. NeuroImage
%
% See also DISTBTW, ROT3, SPHPOINTS, FIXPOINTS, HALFWAYPOINT, PLOT4.
   
%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.1
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-



% VISUALIZE SITUATION
% ..............................................................  ^..^ )~
%     plot4(Mat, 'c.', 1);
%     plot4(RefP, 'r.', 15);


% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
    if nargin < 4 
        error('Minimum four inputs required.');
    end

    if nargin > 7
        error('Wrong number of input arguments.');
    end
    
    if nargout > 2
        error('Too many output arguments.');
    end
    
    % Four inputs      
    if nargin <= 4
        zparc = [];
        Slice = 0.5;
        SeePlot = [];
    end
    
    % Five inputs      
    if nargin <= 5
        Slice = 0.5;
        SeePlot = [];
    end
    
    % Six inputs      
    if nargin <= 6
        SeePlot = [];
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
    Mid = mean([Nz;Iz;AR;AL]); % plot4(Mid, 'r*', 5);
    
    % Take Mid X and Y value and select points within this square
    % on the top of the head
    Sel = Mat(:,1) < Mid(:,1)+10  &  Mat(:,1) > Mid(:,1)-10 & ...
          Mat(:,2) < Mid(:,2)+10  &  Mat(:,2) > Mid(:,2)-10;
      
    Sq = Mat(Sel,:);
    % plot4(Sq, 'm.', 1);
        
    % Make mean of square
    MidSq = mean(Sq);
    
    % Finally select upside part of the head
    MatTop = SphPoints ( MidSq, 70, Mat );
    % plot4(MatTop, 'm.', 1);
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
    % plot4( Cz_First, 'b.', 15 );
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
    % plot4(Curve, 'm.', 5), plot4(Curve, 'r-');
    
    % In the middle of this reference sagittal curve which is running 
    % along the head surface we set Cz_Second
    Cz_Second = FixPoints (0.5, Curve, Mat); 
    % plot4 (Cz_Second, '.b', 15);
    clear Curve

    
% #### Cz_Third ### - Using a plane defined by points AL, Cz_Second
    % and AR, a reference coronal curve is determined. Cz_Third is set
    % in the middle of the reference curve along the head surface.

    Curve = Prepense1 (AL, AR, Cz_Second, Mat, Slice);
    % plot4(Curve, 'm.', 5), plot4(Curve, 'r-');

    % In the middle of the coronal reference curve which is runnig 
    % along the head surface we set Cz_Third
    Cz_Third = FixPoints (0.5, Curve, Mat); 
%    plot4 (Cz_Third, '.r', 15);
clear Curve 


% #### Cz_Meet ### - is average of Cz_Second & Cz_Third projected to the
    % head surface

    % Coordinates for "Cz_Meet"
    % Cz_Meet = [ Cz_Second(1), Cz_First(2), Cz_First(3) ]; % older version
    Cz_Meet = mean([ Cz_Second; Cz_Third ]);
    % plot4 (Cz_Meet, 'g.', 15);

    % We'll transfer Cz_Meet to the head surface
    Disto = DistBtw( Cz_Meet, Mat ); 
    [D,I] = min(Disto);
    clear Cz_Meet
    Cz_Meet = Mat(I,:); % nearest point on the head surface
    clear Disto D I
    % plot4(Cz_Meet, '.m', 15);
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

    % 10-10 Points on the sagittal Curve
    PP = FixPoints ( [0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9], Curve, Mat);
     plot4(PP, 'b.', 20);
     
    % Entitle points
    [Fpz, AFz, Fz, FCz, CPz, Pz, POz, Oz] = TitleP(PP);
    clear Curve PP
    



% POINTS ON THE CORONAL CURVE AL - Cz - AR
% ..............................................................  ^..^ )~
    Curve = Prepense1 (AL, AR, Cz, Mat, Slice);
     plot4(Curve, 'm-');
     
    % 10-10 Points on the coronal Curve
    PP = FixPoints ( [0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9], Curve, Mat);
     plot4(PP, 'b.', 20);

    % Entitle points
    [T7, C5, C3, C1, C2, C4, C6, T8] = TitleP(PP);
    clear Curve PP


    

% 10-10 POINTS ON THE 10% AXIAL REFERENCE CURVE (arf)
% ..............................................................  ^..^ )~
% ### WORKING ON ANTERIOR AND POSTERIOR HALVES ###
if isequal( arf, 'anteriorposterior' )
    
  % 10% ANTERIOR REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (T7, T8, Fpz, Mat, Slice);    
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Fpz, Curve, [0.2 0.4 0.6 0.8 ], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [Fp1, AF7, F7, FT7] = TitleP(PPA);
    [Fp2, AF8, F8, FT8] = TitleP(PPB);
    clear Curve PPA PPB    
    
 % 10% POSTERIOR REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>    
    Curve = Prepense1 (T7, T8, Oz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');

    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Oz, Curve, [0.2 0.4 0.6 0.8 ], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [O1, PO7, P7, TP7] = TitleP(PPA);
    [O2, PO8, P8, TP8] = TitleP(PPB);
    clear Curve PPA PPB 
end
    
    

% ### WORKING ON EACH HEMISPHERE ###
if isequal( arf, 'hemispheric' )
    
  % 10% LEFT REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (Fpz, Oz, T7, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (T7, Curve, [0.2 0.4 0.6 0.8 ], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [FT7, F7, AF7, Fp1] = TitleP(PPA);
    [TP7, P7, PO7, O1] = TitleP(PPB);
    clear Curve PPA PPB    


 % 10% RIGHT REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>    
    Curve = Prepense1 (Fpz, Oz, T8, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');

    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (T8, Curve, [0.2 0.4 0.6 0.8 ], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20);
    
    % Entitle points
    [FT8, F8, AF8, Fp2] = TitleP(PPA);
    [TP8, P8, PO8, O2] = TitleP(PPB);
    clear Curve PPA PPB 
end




% CORONAL REFERENCE CURVES (crf)
% ..............................................................  ^..^ )~
% ### WORKING ALONG PLANES - balanced manner ###
if isequal( crf, 'balanced' )
    
  % AF7-AFz-AF8 <~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (AF7, AF8, AFz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (AFz, Curve, 0.5, Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20)     ;
    
    % Entitle points
    [AF3] = TitleP(PPA);
    [AF4] = TitleP(PPB);
    clear Curve PPA PPB
    
    
  % F7-Fz-F8 <~><~><~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (F7, F8, Fz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Fz, Curve, [0.25, 0.5, 0.75], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20)     ;
    
    % Entitle points
    [F1, F3, F5] = TitleP(PPA);
    [F2, F4, F6] = TitleP(PPB);
    clear Curve PPA PPB
    
    
  % FT7-FCz-FT8 <~><~><~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (FT7, FT8, FCz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (FCz, Curve, [0.25, 0.5, 0.75], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20)     ;
    
    % Entitle points
    [FC1, FC3, FC5] = TitleP(PPA);
    [FC2, FC4, FC6] = TitleP(PPB);
    clear Curve PPA PPB
    
    
  % TP7-CPz-TP8 <~><~><~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (TP7, TP8, CPz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (CPz, Curve, [0.25, 0.5, 0.75], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20)     ;
    
    % Entitle points
    [CP1, CP3, CP5] = TitleP(PPA);
    [CP2, CP4, CP6] = TitleP(PPB);
    clear Curve PPA PPB
    
    
  % P7-Pz-P8 <~><~><~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (P7, P8, Pz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (Pz, Curve, [0.25, 0.5, 0.75], Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20)     ;
    
    % Entitle points
    [P1, P3, P5] = TitleP(PPA);
    [P2, P4, P6] = TitleP(PPB);
    clear Curve PPA PPB


  % PO7-POz-PO8 <~><~><~><~><~><~><~><~><~><~><~><~>
    Curve = Prepense1 (PO7, PO8, POz, Mat, Slice);
    Curve(:,4) = []; % remove cumulative distances
     plot4(Curve, 'm-');
     
    % 10-10 points on the each qaurter
    [ PPA, PPB ] = Prepense2 (POz, Curve, 0.5, Mat);
     plot4(PPA, 'b.', 20); plot4(PPB, 'b.', 20)     ;
    
    % Entitle points
    [PO3] = TitleP(PPA);
    [PO4] = TitleP(PPB);
    clear Curve PPA PPB
end
    

    
% ### SHORTEST DISTANCE CURVE - short manner ###
if isequal( crf, 'shortest' )
    
  % AF3
    [tP, tD, tM] = HalfwayPoint ( AF7, AFz, Mat );
     plot4(tM, 'm-')    ;
    AF3 = FixPoints ( 0.5, tM, Mat);
     plot4(AF3, 'b.', 20);
    clear tP tD tM
     
  % AF4
    [tP, tD, tM] = HalfwayPoint ( AF8, AFz, Mat );
     plot4(tM, 'm-')    ;
    AF4 = FixPoints ( 0.5, tM, Mat);
     plot4(AF4, 'b.', 20);
    clear tP tD tM

  % PO3
    [tP, tD, tM] = HalfwayPoint ( PO7, POz, Mat );
     plot4(tM, 'm-')    ;
    PO3 = FixPoints ( 0.5, tM, Mat);
     plot4(PO3, 'b.', 20);
    clear tP tD tM
     
  % PO4
    [tP, tD, tM] = HalfwayPoint ( PO8, POz, Mat );
     plot4(tM, 'm-')    ;
    PO4 = FixPoints ( 0.5, tM, Mat);
     plot4(PO4, 'b.', 20);
    clear tP tD tM
    
    
    
  % F1, F3, F5
    [tP, tD, tM] = HalfwayPoint ( F7, Fz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM    
    % Entitle points
    [F1, F3, F5] = TitleP(PP);
    clear PP
    
  % F2, F4, F6
    [tP, tD, tM] = HalfwayPoint ( F8, Fz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM    
    % Entitle points
    [F2, F4, F6] = TitleP(PP);
    clear PP
    
    
    
  % FC1, FC3, FC5
    [tP, tD, tM] = HalfwayPoint ( FT7, FCz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM    
    % Entitle points
    [FC1, FC3, FC5] = TitleP(PP);
    clear PP
    
  % FC2, FC4, FC6
    [tP, tD, tM] = HalfwayPoint ( FT8, FCz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM    
    % Entitle points
    [FC2, FC4, FC6] = TitleP(PP);
    clear PP
    
    
    
  % CP1, CP3, CP5
    [tP, tD, tM] = HalfwayPoint ( TP7, CPz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [CP1, CP3, CP5] = TitleP(PP);
    clear PP
    
  % CP2, CP4, CP6
    [tP, tD, tM] = HalfwayPoint ( TP8, CPz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [CP2, CP4, CP6] = TitleP(PP);
    clear PP
    
    
    
  % P1, P3, P5
    [tP, tD, tM] = HalfwayPoint ( P7, Pz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [P1, P3, P5] = TitleP(PP);
    clear PP
    
  % P2, P4, P6
    [tP, tD, tM] = HalfwayPoint ( P8, Pz, Mat );
     plot4(tM, 'm-')    ;
    PP = FixPoints ( [0.25 0.5 0.75], tM, Mat);
     plot4(PP, 'b.', 20);
    clear tP tD tM
    % Entitle points
    [P2, P4, P6] = TitleP(PP);
    clear PP    
end




% 10-10 POINTS ON THE 0% AXIAL REFERENCE CURVE (zparc)
% ..............................................................  ^..^ )~
% ### WORKING ON ANTERIOR AND POSTERIOR HALVES ###
if isequal( zparc, 'yes' )
    % Working on anterior & posterior halves
    if isequal( arf, 'anteriorposterior' )
    
        % 0% ANTERIOR REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>
        Curve = Prepense1 (AL, AR, Nz, Mat, Slice);    
        Curve(:,4) = []; % remove cumulative distances
         plot4(Curve, 'm-');
     
        % 10-10 points on the each qaurter
        [ PPA, PPB ] = Prepense2 (Nz, Curve, [ 0.2 : 0.2 : 0.8 ]);
         plot4(PPA, 'b.', 20), plot4(PPB, 'b.', 20);
    
        % Entitle points
        [N1, AF9,  F9,  FT9] = TitleP(PPA);
        [N2, AF10, F10, FT10] = TitleP(PPB);
        clear Curve PPA PPB   
    
    
        % 0% POSTERIOR REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>    
        Curve = Prepense1 (AL, AR, Iz, Mat, Slice);
        Curve(:,4) = []; % remove cumulative distances
         plot4(Curve, 'm-');

        % 10-05 points on the each qaurter
        [ PPA, PPB ] = Prepense2 (Iz, Curve, [ 0.2 : 0.2 : 0.8 ]);
         plot4(PPA, 'b.', 20), plot4(PPB, 'b.', 20);
    
        % Entitle points
        [I1, PO9, P9, TP9] = TitleP(PPA);
        [I2, PO10, P10, TP10] = TitleP(PPB);
        clear Curve PPA PPB
    end
    
    % Working on hemispheric left & right halves
    if isequal( arf, 'hemispheric' )
        % 0% LEFT REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>
        Curve = Prepense1 (Nz, Iz, AL, Mat, Slice);
        Curve(:,4) = []; % remove cumulative distances
         plot4(Curve, 'm-');
     
        % 10-05 points on the each qaurter
        [ PPA, PPB ] = Prepense2 (AL, Curve, [ 0.2 : 0.2 : 0.8 ]);
         plot4(PPA, 'b.', 20), plot4(PPB, 'b.', 20);

        % Entitle points
        [FT9, F9,  AF9, N1] = TitleP(PPA);
        [TP9, P9, PO9, I1] = TitleP(PPB);
        clear Curve PPA PPB    


        % 0% RIGHT REFERENCE CURVE <~><~><~><~><~><~><~><~><~><~><~><~>    
        Curve = Prepense1 (Nz, Iz, AR, Mat, Slice);
        Curve(:,4) = []; % remove cumulative distances
         plot4(Curve, 'm-');

        % 10-05 points on the each qaurter
        [ PPA, PPB ] = Prepense2 (AR, Curve, [ 0.2 : 0.2 : 0.8 ]);
         plot4(PPA, 'b.', 20), plot4(PPB, 'b.', 20);
    
        % Entitle points
        [FT10 F10, AF10, N2] = TitleP(PPA);
        [TP10, P10, PO10, I2] = TitleP(PPB);
        clear Curve PPA PPB 
    end
end
    




% FOLD 10-10 MATRIX
% ...............................................................  ^..^ )~
    if isequal( zparc, 'yes' )
        
    PP1010 = [  Nz; Iz; AR; AL; ... % primary reference points
                C3; C4; Cz; F3; F4; F7; F8; Fpz; Fp1; Fp2; Fz;...%11 %10-20
                O1; O2; P3; P4; Pz; T7; T8; P7; P8; Oz; ... %21 %10-20
                AF7; AF3; AFz; AF4; AF8; ... %5
                F5; F1; F2; F6; ... % 4
                FT7; FC5; FC3; FC1; FCz; FC2; FC4; FC6; FT8; ... %9
                C5; C1; C2; C6; ... %4
                TP7; CP5; CP3; CP1; CPz; CP2; CP4; CP6; TP8; ... %9
                P5; P1; P2; P6; ... %4
                PO7; PO3; POz; PO4; PO8; ... %5 
                F9; F10; FT9; FT10; TP9; TP10; P9; P10; ... % 8 % Klem
                N1; N2; AF9; AF10; PO9; PO10; I1; I2 ]; % 8 
                % 77 points
                
    else
        
    PP1010 = [  Nz; Iz; AR; AL; ... % primary reference points
                C3; C4; Cz; F3; F4; F7; F8; Fpz; Fp1; Fp2; Fz;... % 10-20
                O1; O2; P3; P4; Pz; T7; T8; P7; P8; Oz; ... % 10-20
                AF7; AF3; AFz; AF4; AF8; ... %5
                F5; F1; F2; F6; ... % 4
                FT7; FC5; FC3; FC1; FCz; FC2; FC4; FC6; FT8; ... %9
                C5; C1; C2; C6; ... %4
                TP7; CP5; CP3; CP1; CPz; CP2; CP4; CP6; TP8; ... %9
                P5; P1; P2; P6; ... %4
                PO7; PO3; POz; PO4; PO8 ]; %5 
                % 61 points
    end



% VISUALIZE RESUALT
% ...............................................................  ^..^ )~
    if nargin < 7   |  ~isequal( SeePlot, 'PrintPlot'  ) 
        close all % don't want to see resualt
    end

    
% MAKE SECOND OUTPUT
% ...............................................................  ^..^ )~
% Name each 10-10 point

    if isequal( zparc, 'yes' )
        
    Namaes = { 'Nz'; 'Iz'; 'AR'; 'AL'; ...
            'C3';'C4';'Cz';'F3';'F4';'F7';'F8';'Fpz';'Fp1';'Fp2';'Fz';...
            'O1';'O2';'P3';'P4';'Pz';'T7';'T8';'P7';'P8';'Oz'; ...
            'AF7';'AF3';'AFz';'AF4';'AF8'; ...
            'F5';'F1';'F2';'F6'; ...
            'FT7';'FC5';'FC3';'FC1';'FCz';'FC2';'FC4';'FC6';'FT8'; ...
            'C5';'C1';'C2';'C6'; ...
            'TP7';'CP5';'CP3';'CP1';'CPz';'CP2';'CP4';'CP6';'TP8'; ...
            'P5';'P1';'P2';'P6'; ...
            'PO7';'PO3';'POz';'PO4';'PO8'; ...
            'F9'; 'F10'; 'FT9'; 'FT10'; 'TP9'; 'TP10'; 'P9'; 'P10'; ...
            'N1'; 'N2'; 'AF9'; 'AF10'; 'PO9'; 'PO10'; 'I1'; 'I2' };

    else
        
    Namaes = {'Nz'; 'Iz'; 'AR'; 'AL'; ...
            'C3';'C4';'Cz';'F3';'F4';'F7';'F8';'Fpz';'Fp1';'Fp2';'Fz';...
            'O1';'O2';'P3';'P4';'Pz';'T7';'T8';'P7';'P8';'Oz'; ...
            'AF7';'AF3';'AFz';'AF4';'AF8'; ...
            'F5';'F1';'F2';'F6'; ...
            'FT7';'FC5';'FC3';'FC1';'FCz';'FC2';'FC4';'FC6';'FT8'; ...
            'C5';'C1';'C2';'C6'; ...
            'TP7';'CP5';'CP3';'CP1';'CPz';'CP2';'CP4';'CP6';'TP8'; ...
            'P5';'P1';'P2';'P6'; ...
            'PO7';'PO3';'POz';'PO4';'PO8' };
    end
    
    axis equal vis3d; grid on;


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
    % plot4(Curve, 'y.', 5);
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
    % plot4(Tempy, '.m', 5);
    
    K = convhulln(Tempy(:, 1:2)); % returns indices    
    Curve = Curve(K(:, 1), :); % select apex points
    
    % plot4(Curve, '.b', 10), plot4(Curve, '-m');
    % plot4([AAr; BBr; CCr], 'r.', 15) ;
    clear K Tempy g Rz
    
    % Rotate selected Curve matrix back to initial head
    Curve(:, 4) = 1;   
    Curve = Curve / RotCoef / InvCoef;  
    Curve(:, 4) = [];    
    % plot4(Curve, 'r.', 5), plot4(Curve, 'r-'), plot4(Mat, 'c.', 1);
    clear AAr BBr CCr InvCoef RotCoef TransCoef MMr

    % By connecting Curve points we generate a reference curve running along 
    % the head surface. The reference curve enabled computation
    % of the length over the head surface between the two starting points
    % AA & BB
   [ out1, out2 ] = CurveLength (AA, BB, Curve); 
    % plot4(out1, 'r-');
return;


% _______________________________________________________________________
% Prepense2
% Halve reference curves running along head and determine points inside
% each quarter. e.g. Halve 10% axial referece curve T7-Fpz-T8 so get
% curves T7-Fpz and T8-Fpz. Thus 10-10 reference points FT7, F7, AF7, Fp1
% are set at 20, 40, 60, 80% along the total length of T7-Fpz curve.

function [ PPA, PPB ] = Prepense2 (APEX, CP, Step, Mat)
 % Closest Curve point to APEX
    P = DistBtw ( APEX, CP, 1 ); % closest point
    
    % Replace P with APEX
    [D,I] = ismember(P, CP(:, 1:3), 'rows');
    CP(I,:) = APEX;
    clear P D    
     
    % Devide curve
    CurveA = CP(1:I, :); % plot4(CurveA, 'g-');
    CurveA = flipud(CurveA); % first is peak point -> APEX
    CurveB = CP(I:end,:); % plot4(CurveB, 'k-');
    clear CP I

    if nargin == 4 %
        % Quarter A -> 10-05 Points
        PPA = FixPoints ( Step, CurveA, Mat);
        % plot4(PPA, 'b.', 20);

        % Quarter B -> 10-05 Points
        PPB = FixPoints ( Step, CurveB, Mat);
        % plot4(PPB, 'b.', 20);
     else
        % don't project point from curve to head surface    
        % Quarter A -> 10-05 Points
        PPA = FixPoints ( Step, CurveA);
        % plot4(PPA, 'b.', 20);

        % Quarter B -> 10-05 Points
        PPB = FixPoints ( Step, CurveB);
        % plot4(PPB, 'b.', 20);
     end
return;  

% _______________________________________________________________________
% TitleP
% Subfunction used for naming 10-10 points
function [ varargout ] = TitleP (Box)
    for k = 1 : nargout
        varargout{k} = Box(k,:); % Cell array assignment
    end
return;


% _______________________________________________________________________
% title each point  e.g. ->   C3 = [49.0000   97.0200  199.9200];
% <o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x>
%     for count = 1 : size(Namaes, 1)
%         eval( [char(Namaes(count)) ' = PP1010(count,:);'] );
%     end
% <o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x><o><x>
