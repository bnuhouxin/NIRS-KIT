function nfri_anatomlabel( ID, saveFileName, rn )

% NFRI_ANATOMLABEL - Automated anatomical labeling without SPM functions.
%
% USAGE.
%    nfri_anatomlabel( ID, saveFileName, rn )
%
% DESCRIPTION.
%   Function will perform anatomical labeling of spherical region around
%   projected point([x,y,z] - center of sphere). In the default radius is
%   set to 10mm. Function returns list of anatomical label and percentage of
%   overlap. 
%   Example: a result of -44 -22 - 56
%               Postcentral_L    55.00
%           		Precentral_L     31.00
%           		OUTSIDE          10.00
%           		Parietal_Sup_L   5.00
% indicates that:
% 55% of the points in the spherical region is included in the Postcentral_L region
% 31% of the points in the spherical region is included in the Precentral_L region
% 10% of the points in the spherical region is outside the parcellation
% 5% of the points in the spherical region are included in the Parietal_Sup_L region
%
% INPUTS.
%   ID is [n,3] matrix of vectors. ID can be mat file or excel file.
%   saveFileName is string, it's your desire name for exported csv file.
%   rn is value which define radius of spherical region around
%   point which should be labeled.
%     
% OUTPUT.
%   Is named csv file writen to the same folder.
%
% EXAMPLE.
%   load(['sample' filesep 'nfri_anatomlabel.mat']); % load xyz
%   nfri_anatomlabel(xyz, 'justtest', 10);
%
% REFERENCES.
%   AAL files downloaded from http://www.cyceron.fr/freeware/
%   Anatomical Automatic Labeling (AAL).
%   Author: Tzourio-Mazoyer, N. at.all
%   Title: Automated anatomical labeling of activations in SPM using a
%   macroscopic anatomical parcellation of the MNI MRI 	single-subject brain; 
%   Journal: Neuroimage 15 273-289 2002 "http://www.sciencedirect.com/"

%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function, 
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@affrc.go.jp
%   AUTHOR:  Valer Jurcak,    DATE: 12.jan.2006,    VERSION: 1.1
%   REVISED: TSUZUKI Daisuke, DATE: 13.sep.2006,    VERSION: 1.2
%   REVISED: TSUZUKI Daisuke, DATE: 02.jul.2007,    VERSION: 1.3
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

% -------------------
% Load reference data
% -------------------

ThisScriptPath = fileparts(mfilename('fullpath'));
MatFilePath = [ThisScriptPath filesep 'mat' filesep 'nfri_anatomlabel.mat'];
load (MatFilePath); % 'nfri_anatomlabel.mat' is the target.

% CHECKING INPUTS
% ..............................................................  ^..^ )~

% IRadius is not defined
if nargin == 2 
  rn = 10;
end

% Input ID is already loaded variable
if isnumeric (ID)
  MAT = ID;
end

%  Input ID is excel file
if isstr (ID)
  E = [ ID, sprintf('%s', '.xls')]; % check existance
  if exist( E, 'file')
    MAT = xlsread(ID); % excel file was found
    clear E
    MAT = MAT(1:end, 1:3); % dress for excel
  end
end

% Still don't have MAT file, try to search among variables
if ~exist( 'MAT', 'var')
  
  E = [ ID '.mat' ]; % are stored in mat file
  if exist( E, 'file') % checks existence of file 
    load(ID)
    magic_str = [ 'MAT = ' ID ';']; % was saved as "save ID ID"
    eval(magic_str)
    clear E magic_str            
  end
end    

% Input was not analyzed -> return function
if ~exist( 'MAT' ,'var') 
  error('Can not analyze input (points which should be labeled).')
  return
end


% SET SAVING
% ..............................................................  ^..^ )~
Nemo = [ saveFileName '.csv' ]; % save output as csv file
fidSave = fopen( Nemo, 'w' );


% START BATCH PROCESS
% ..............................................................  ^..^ )~
for count = 1 : size(MAT, 1)  
  fprintf('%d/%d\n', count, size(MAT, 1));
  DataRow = MAT(count, :);
  
  % Get all points within radius rn from given point, defauls is 10mm
  [SP, I] = SphPoints ( DataRow, rn, XYZI(:, 1:3));         
  
  data = XYZI(I, 4); % The 4th column of XYZI is the label of AAL.
  udata = unique(data);   
  
  ROIlist = {'OUTSIDE'};
  c = find( data == udata(1) );
  nos = size(c, 1);
  
  for i = 2 : size( udata, 1 )
    c = find( data == udata(i) );
    nos = [ nos size(c, 1) ];
    
    for j = 1 : size( ROI, 2 )
      if ROI(j).ID == udata(i)         
         ROIlist{end+1} = ROI(j).Nom_L; break
      end
    end

  end
  ROIlist = ROIlist';
  clear i j
  
  Perc = nos/sum(nos);
  Perc = Perc';  
  
  % Checking sizes of outputs
  if size(ROIlist, 1) ~= size(Perc, 1)
    error('Failed to getlabels.')
    return
  end
  
  % Write index
  fprintf(fidSave, '%d,,', count);
  
  % Write argument for getlabels
  fprintf(fidSave, '%f,', DataRow(1, 1));
  fprintf(fidSave, '%f,', DataRow(1, 2));
  fprintf(fidSave, '%f,', DataRow(1, 3));
  fprintf(fidSave, '%f,\n', rn); % tsuzuki added for recording SD.
  
  for i = 1 : size(ROIlist, 1)
    ch = ROIlist{i};
    fprintf(fidSave, ',,,,,%s,%f\n', ch, Perc(i));
  end    
  fprintf(fidSave, '\n');
  
end
fclose(fidSave);