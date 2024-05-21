function [ PAr, PBr, PCr, InvCoef, RotCoef, TransCoef, MATr ]...
            = Rot3 ( PA, PB, PC, MAT, orientation, cut, putback )
%
% ROT3 - Rotation of 3 vectors around to zero XY plane.
%        
% USEAGE.
%   function [ PAr, PBr, PCr, InvCoef, RotCoef, TransCoef, MATr ]...
%             = Rot3 ( PA, PB, PC, MAT, 'CheckOrientation',...
%             'CutOverhung', 'TransBack' )
%
% DESCRIPTION.
%   This function will rotate three input points PA, PB, PC around Z axis,
%   X axis and Y axis respectively. First step is translation
%   of point PA to origin [0 0 0]. We store translation koeficient
%   as InvCoef. Points PB, PC are also translated. Next step is rotation,
%   rotation koeficient RotCoef is stored. Points coordiantes now are:
%   PAr=[0 0 0], PBr=[n 0 0], PCr=[n n 0]. If input is also matrix MAT, 
%   matrix is rotated with same procedure.
%
% INPUTS.
%   PA, PC, PC are three input reference points. Points are vectors
%   e.g. PA = [ x, y, z ]; PA should by point from the left side of head or
%   brain e.g.AL, PB should by point from the right side e.g. AR, 
%   PC can by nasion Nz or Cz.
%
%   MAT is [n,3] matrix of 3D Cartesian coordinates. e.g. These points
%   create head surface.
%
%   if orientation is string 'CheckOrientation' - after translation PA to
%   [0 0 0] will be checked z-value of point PC. If z-value is lower than 0
%   all points & MAT will be fliped around X axis so point PC has biggest
%   z-value.    e.g. inputs are digitized points: ear points AL,AR; Nz is
%   nasion, in MAT are stored optodes positions. Data form 3d digitizer can
%   be up side down. After rotation we can perform fitting to MRI data.
%   
%   if cut is string 'CutOverhung' - after rotation all points from MAT 
%   matrix with negative y-value will be deleted. See scheme:
%          +y
%           |               °PCr[nn0]
%           |
%           °PAr[000]------------------------°PBr[n00]---- +x
%           |      °  °°° deleted points   °°°
%
%
%   if putback is string 'TransBack' - PAr is tranlsate back to PA, acco-
%   rding this translation also PBr, PCr and matrix points MATr. 
%   TransCoef is saved.
%   
% OUTPUT.
%   PAr, PBr, PCr are rotated points with same z-value. e.g. PAr = [0 0 0]
%   MATr is rotated matrix [n,4]. Forth column is fill with ones.
%   InvCoef is 4x4 translation matrix with info of tanslation PA to [0 0 0]
%   RotCoef is 4x4 rotation matrix with info of rotation around Z,Y,X axis
%   TransCoef is 4x4 translation matrix with info of tanslation PAr to PA

%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.0
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECKING OUTPUTS
% ..............................................................  ^..^ )~
    if nargout ~= 7 
        error('Seven Output Arguments Required.')
    end

    
% Activation trigger for strings: CheckOrientation, CutOverhung, TransBack
% If activation value is 1;  e.g. [1 1 1] will perform everything
    ACTIVATE = [0 0 0]; % default
    
    
    
% CHECKING INPUTS 
% ..............................................................  ^..^ )~
% We want to rotate only three PA, PB, PC points
    if nargin == 3 
         MAT = [0 0 0];
    end    
    
 % 4 INPUTS
 % Analyzing forth inputs ......................
    if nargin == 4 
        ss=size(MAT);
        
         % forth input is MAT, do nothing
        
         % forth input is CheckOrientation or CutOverhung or TransBack
         if ss(2)~= 3 % create MAT
             MAT = [0 0 0];
                  
         % analyzing strings according length

            if ss(2)== 16
                ACTIVATE(1) = 1; % activate CheckOrientation
            end
            
            if ss(2)== 11
                ACTIVATE(2) = 1; % activate CutOverhung
            end
            
            if ss(2)== 9
                ACTIVATE(3) = 1; % activate TransBack            
            end
         end 
       end
clear ss   
    

% 5 INPUTS
% Analyzing two of five inputs ......................
    if nargin == 5 
        ss=size(MAT);
        cc=size(orientation);        
        % !!! don't have MAT
         if ss(2)~= 3 
             MAT = [0 0 0]; % create MAT
             
             % continue analyzing strings according length
            if ss(2)== 16 | cc(2)== 16
                ACTIVATE(1) = 1; % activate CheckOrientation 
            end
            
            if ss(2)== 11 | cc(2)== 11
                ACTIVATE(2) = 1; % activate CutOverhung
            end
                
            if ss(2)== 9 | cc(2)== 9
                ACTIVATE(3) = 1; % activate TransBack
            end
             

         end
         
         % !!! we have MAT
         if ss(2)== 3            
             % we have MAT, checking strings
                if cc(2)== 16
                    ACTIVATE(1) = 1; % activate CheckOrientation 
                end
                
                if cc(2)== 11
                    ACTIVATE(2) = 1; % activate CutOverhung
                end
                
                if cc(2)== 9
                    ACTIVATE(3) = 1; % activate TransBack   
                end
         end
    end 
clear ss cc
        
        
        
% 6 INPUTS
% Analyzing three of six inputs ......................
    if nargin == 6 
        ss=size(MAT);
        cc=size(orientation);
        ff=size(cut);
    
         % !!! don't have MAT
         if ss(2)~= 3
            MAT = [0 0 0]; % create MAT

            if ss(2)== 16 | cc(2)== 16 | ff(2)== 16
                ACTIVATE(1) = 1; % activate CheckOrientation
            end
             
            if ss(2)== 11 | cc(2)== 11 | ff(2)== 11
                ACTIVATE(2) = 1; % activate CutOverhung
            end
             
            if ss(2)== 9 | cc(2)== 9 | ff(2)== 9
                ACTIVATE(3) = 1; % activate TransBack            
            end
         end
            
            
         % !!! we have MAT
         if ss(2)== 3
                
            if cc(2)== 16 | ff(2)== 16
                ACTIVATE(1) = 1; % activate CheckOrientation
            end
            
            if  cc(2)== 11 | ff(2)== 11
                ACTIVATE(2) = 1; % activate CutOverhung
            end
            
            if cc(2)== 9 | ff(2)== 9
                ACTIVATE(3) = 1; % activate TransBack            
            end            
         end
    end
clear ss cc ff


% 7 INPUTS
% Run all strings ......................
    if nargin == 7
       ACTIVATE = [1 1 1] ;
    end


    

% ALGORITHM
% ..............................................................  ^..^ )~
        
% We add forth column of ones
    PA(1, 4)=1;  PB(1, 4)=1; PC(1, 4)=1; MAT(:, 4) = 1;
    

%  TRANSLATION
% ..............................................................  ^..^ )~
% inverse transform = translation of point to origin
% [ 1 0 0 -??; 0 1 0 -??; 0 0 1 -??; 0 0 0 1 ]';    
    Inv_PA = PA * [ 1 0 0 -PA(1); 0 1 0 -PA(2); 0 0 1 -PA(3); 0 0 0 1 ]';
    % plot4(Inv_PA, 'r.', 15)
    
    Inv_PB = PB * [ 1 0 0 -PA(1); 0 1 0 -PA(2); 0 0 1 -PA(3); 0 0 0 1 ]';
    % plot4(Inv_PB, 'r.', 15)

    Inv_PC = PC * [ 1 0 0 -PA(1); 0 1 0 -PA(2); 0 0 1 -PA(3); 0 0 0 1 ]';
    % plot4(Inv_PC, 'r.', 15)

    Inv_MAT = MAT * [ 1 0 0 -PA(1); 0 1 0 -PA(2); 0 0 1 -PA(3); 0 0 0 1 ]';
    % plot4(MAT, 'c.', 1)



% CHECKING ORIENTATION
% ..............................................................  ^..^ )~
% If data are upside-down ->  PC(3) < PA(3) | PB(3) e.g. we have digitized
% data PC=Nz (nasion); PA=AR right ear, PB=AL left ear, we fliped them

    %if exist('orientation', 'var') & orientation == 'CheckOrientation'; 
    if ACTIVATE(1) == 1 
                
        if Inv_PC(3) < Inv_PA(3) | Inv_PC(3) < Inv_PB(3)
        
            Inv_PB(:, 4)=[]; Inv_PC(:, 4)=[]; Inv_MAT(:, 4)=[];
        
            % flip dataset around x axis
            Inv_PB = Rx(Inv_PB, 180, 'degrees'); % call function
            Inv_PC = Rx(Inv_PC, 180, 'degrees');
            Inv_MAT = Rx(Inv_MAT, 180, 'degrees');
        
            Inv_PB(1, 4)=1; Inv_PC(1, 4)=1; Inv_MAT(:, 4)=1;    
            % plot4( [Inv_PA; Inv_PB; Inv_PC ], 'c.', 15)
            % plot4(Inv_MAT, 'k.', 1), grid on
        end
    end
      
      

      
% ROTATION AROUND Z AXIS
% ..............................................................  ^..^ )~
%   After rotation y-value of Inv_PB will be zero

% Compute angle of rotation, clockwise rotation 
    ANGLE_ZZ = sqrt( Inv_PB(1)^2 / (Inv_PB(1)^2 + Inv_PB(2)^2) );
    ANGLE_ZZ = acos(ANGLE_ZZ); % Inverse cosine, value is in radian
    % rad2deg(ANGLE_ZZ)
    
% Optimize direction of rotation depends on quadrant position of "Inv_PB"
    if Inv_PB(1)> 0 & Inv_PB(2)== 0 % points has already x-value == 0 
             MATrZZ = Inv_MAT;
             PBrZZ = Inv_PB;
             PCrZZ = Inv_PC;
             RzT = 1;              
             
    else
        %                   y
        %      4.           |            1.
        %                   |
        %       [-x, +y]    |   [+x, +y]
        %                   |
        %   ---------------------------------x
        %                   |
        %       [-x, -y]    |   [+x, -y]
        %                   |
        %      3.           |            2.
        
        
            if Inv_PB(1)<0 & Inv_PB(2)==0  % we want positive x-value
                ANGLE_ZZ = pi;
            end
        
            if Inv_PB(1)>0 & Inv_PB(2)>0  % quadrant ONE
                ANGLE_ZZ = ANGLE_ZZ;
            end
            
            if Inv_PB(1)>=0 & Inv_PB(2)<0  % quadrant TWO
                ANGLE_ZZ = - ANGLE_ZZ;
            end
            
            if Inv_PB(1)<0 & Inv_PB(2)<0 % quadrant THREE
                ANGLE_ZZ = ANGLE_ZZ + pi;
            end
            
            if Inv_PB(1)<=0 & Inv_PB(2)>0 % quadrant FOUR
                ANGLE_ZZ = -ANGLE_ZZ - pi;
            end

    % Rotation around origin
    % Rz = [ cos(g) -sin(g) 0 0;  sin(g) cos(g) 0 0;  0 0 1 0; 0 0 0 1 ]; 
    RzT = [ cos(ANGLE_ZZ) -sin(ANGLE_ZZ) 0 0;  sin(ANGLE_ZZ) cos(ANGLE_ZZ) 0 0;  0 0 1 0; 0 0 0 1 ];

    PBrZZ = Inv_PB * RzT;
    % plot4(PBrZZ, 'g.', 15)
         
    PCrZZ = Inv_PC * RzT;
    % plot4(PCrZZ, 'g.', 15)
     
    MATrZZ = Inv_MAT * RzT;
    % plot4(MATrZZ, 'm.', 1)
    end

    
    

% ROTATION AROUND Y AXIS
% ..............................................................  ^..^ )~
%   After rotation z-value of Inv_PB will be zero

% Compute angle of rotation      
    ANGLE_YY = sqrt( PBrZZ(3)^2 / (PBrZZ(1)^2 + PBrZZ(3)^2) );
    ANGLE_YY = acos(ANGLE_YY); % Inverse cosine, value is in radian
    % rad2deg(ANGLE_YY)

% Optimize direction of rotation depends on +- PBrZZ(3)
    if PBrZZ(3)== 0 % points has already z-value == 0 
             MAT_rYY = MATrZZ;
             PBrYY = PBrZZ;
             PCrYY = PCrZZ;
             RyT = 1;
             
    else                 
                 
            if PBrZZ(3)>0
                ANGLE_YY = -(pi/2 - ANGLE_YY);
            else
               ANGLE_YY = pi/2 - ANGLE_YY;
            end
            
            
        % rotation around origin     Ry = [ cos(g) 0 sin(g) 0;  0 1 0 0;  -sin(g) 0 cos(g) 0;  0 0 0 1 ];
        RyT = [ cos(ANGLE_YY) 0 sin(ANGLE_YY) 0;  0 1 0 0;  -sin(ANGLE_YY) 0 cos(ANGLE_YY) 0;  0 0 0 1 ];

        PBrYY = PBrZZ * RyT;
        % plot4(PBrYY, 'r.', 15)
         
        PCrYY = PCrZZ * RyT;
        % plot4(PCrYY, 'r.', 15)
                    
        MAT_rYY = MATrZZ * RyT;
        % plot4(MAT_rYY, 'g.', 1)
    end
    
    


% ROTATION AROUND X AXIS
% ..............................................................  ^..^ )~
%   After rotation z-value of Inv_PC will be zero

% Compute angle of rotation  
    ANGLE_XX = sqrt( PCrYY(2)^2 / (PCrYY(2)^2 + PCrYY(3)^2) );
    ANGLE_XX = acos(ANGLE_XX); % Inverse cosine, value is in radian
    % rad2deg(ANGLE_XX)

% Optimize direction of rotation depends on z-value OF "PBrYY" -> can be negative or positive    
    if PCrYY(3) == 0  % points has already z-value == 0 
             MAT_rXX = MAT_rYY;
             PBrXX = PBrYY;
             PCrXX = PCrYY;
             RxT = 1;
    else

            if PCrYY(2)>=0 & PCrYY(3)>0 % [ +x +y +z ]
                ANGLE_XX = ANGLE_XX;
            end
            
            if PCrYY(2)>=0 & PCrYY(3)<0 % [ +x +y -z ]
                ANGLE_XX = -ANGLE_XX;
            end
            
            if PCrYY(2)<=0 & PCrYY(3)>0 % [ +x -y +z ]
                ANGLE_XX = pi - ANGLE_XX;
            end

            if PCrYY(2)<=0 & PCrYY(3)<0 % [ +x -y -z ]
                ANGLE_XX = pi + ANGLE_XX;
            end
            
            
        % rotation around origin     Rz = [ 1 0 0 0; 0  cos(g) -sin(g) 0;  0 sin(g) cos(g) 0;  0 0 0 1 ]; 
        RxT = [ 1 0 0 0; 0  cos(ANGLE_XX) -sin(ANGLE_XX) 0;  0 sin(ANGLE_XX) cos(ANGLE_XX) 0;  0 0 0 1 ]; 
                              
        PCrXX = PCrYY * RxT;
        % plot4(PCrXX, 'm.', 15)
        
        PBrXX = PBrYY * RxT;
        % plot4(PBrXX, 'm.', 15)
        
        MAT_rXX = MAT_rYY * RxT;
        % plot4(MAT_rXX, 'y.', 1)
   end


    

% CUTTING OVERHUNG POINTS
% ..............................................................  ^..^ )~
% All MAT points in second quadrant [+x, -y] are deleted 
    if ACTIVATE(2) == 1 
        
        Sel = MAT_rXX(:, 2)>0;
        MAT_rXX = MAT_rXX(Sel, :);
        % plot4(MAT_rXX, 'b.', 1)
    end




% TRANSLATE ORIGIN TO STARTING POINT 
% ..............................................................  ^..^ )~
    % if exist('putback', 'var'), putback = 'TransBack';
    if ACTIVATE(3) == 1 
    
      MATr = MAT_rXX * [ 1 0 0 PA(1); 0 1 0 PA(2); 0 0 1 PA(3); 0 0 0 1 ]';  
      % plot4(MATr, 'm.', 1)
     
      PAr = PA;
      % plot4(PAr, r.', 15)
    
      PBr = PBrXX * [ 1 0 0 PA(1); 0 1 0 PA(2); 0 0 1 PA(3); 0 0 0 1 ]';
      % plot4(PBr, r.', 15)
     
      PCr = PCrXX * [ 1 0 0 PA(1); 0 1 0 PA(2); 0 0 1 PA(3); 0 0 0 1 ]';
      % plot4(PCr, r.', 15)

    
    else
        
    % DON'T WANT TO TRANSLATE ORIGIN TO STARTING POINT
        MATr = MAT_rXX;
        PAr = Inv_PA;
        PBr = PBrXX;
        PCr = PCrXX;
        
    end
    
    
    
    
% MAKING KOEFICIENTS
% ..............................................................  ^..^ )~

% Inverse translation koeficient "InvCoef"
% - translation of point PA to [0 0 0]
    InvCoef = [ 1 0 0 -PA(1); 0 1 0 -PA(2); 0 0 1 -PA(3); 0 0 0 1 ]';
     
% Rotation koeficient "RotCoef" - rotation around Z, X and Y axis
    RotCoef = RzT * RyT * RxT;    
    
% TRANSLATION KOEFICIENT "TransCoef" - of origin to point
    TransCoef = [ 1 0 0 PA(1); 0 1 0 PA(2); 0 0 1 PA(3); 0 0 0 1 ]';
    
    
 
    
% CHECKING OUTPUTS
% ..............................................................  ^..^ )~
% !!!! We have at least this MAT = [0 0 0 1];

% Inputs were only three points, make MAT empty
    if nargin == 3
         MATr = [];
    end
    
    
% We had four inputs
    if nargin == 4 
         if  sum(sum(MAT)) == 1; % checking MAT size, if input was [0 0 0]
             MATr = [];
         end             
    end
clear ss

    
% We had five inputs
    if nargin == 5    
       if sum(sum(MAT)) == 1;
             MATr = []; % checking MAT size, if input was [0 0 0]
       end
    end
clear ss cc
     
             
%We had six inputs
    if nargin == 6
       if sum(sum(MAT)) == 1; % checking MAT size, if input was [0 0 0]
             MATr = []; 
       end
    end
clear ss cc ff
  

% DELETE FORTH COLUMN OF ONES & THIRD COLUMN SET AS ZERO
% ..............................................................  ^..^ )~
    PAr = PAr(:, 1:3);  PAr(1, 3) = 0; 
    PBr = PBr(:, 1:3);  PBr(1, 3) = 0; % after rotation can be 0.003842
    PCr = PCr(:, 1:3);  PCr(1, 3) = 0; 
        
    if size(MATr,2) == 4
        MATr = MATr(:, 1:3);
    end
