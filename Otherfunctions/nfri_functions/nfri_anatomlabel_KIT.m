function nfri_anatomlabel_KIT(ch_data, saveFileName, rn, col)

% nfri_anatomlabel_KIT - Automated anatomical labeling without SPM functions.
% This function is based on 'anatomlabel_final'.

% USAGE.
%    nfri_anatomlabel_KIT(ID, saveFileName, rn, col)
%
% DESCRIPTION.
%   Function will perform anatomical labeling of spherical region around
%   projected point([x,y,z] - center of sphere). In the default radius is
%   set to 10mm. Function returns list of anatomical label and percentage
%   of overlap. This function is based on 'nfri_anatomlabel'.
%
% INPUTS.
%   ID is [n,3] matrix of vectors. ID can be mat file or excel file.
%   saveFileName is string, it's your desire name for exported csv file.
%   rn is value which define radius of spherical region around
%   point which should be labeled.
%   rn can be scholar or vector in version 1.5.
%   col can be 4-7 scalar, or if it is omitted, whole 4 labels are assigned.
%    4 ... AAL
%    5 ... Brodmann area (Chris rorden' MRIcro)
%    6 ... LPBA40

%
% OUTPUT.
%   Is named csv file writen to the same folder.
%
% EXAMPLE.
%   load(['sample' filesep 'nfri_anatomlabel.mat']); % load xyz
%   anatomlabel_final(xyz, 'justtest', 10, 4);
%
% REFERENCES.
%   AAL files downloaded from http://www.cyceron.fr/freeware/
%    Anatomical Automatic Labeling (AAL).
%    Author: Tzourio-Mazoyer, N. at.all
%    Title: Automated anatomical labeling of activations in SPM using a
%    macroscopic anatomical parcellation of the MNI MRI 	single-subject brain;
%    Journal: Neuroimage 15 273-289 2002 "http://www.sciencedirect.com/"
%   MRIcro
%   LPBA40


%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function,
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@affrc.go.jp
%   AUTHOR:  Valer Jurcak,    DATE: 12.jan.2006,    VERSION: 1.1
%   REVISED: TSUZUKI Daisuke, DATE: 13.sep.2006,    VERSION: 1.2
%   REVISED: TSUZUKI Daisuke, DATE: 02.jul.2007,    VERSION: 1.3
%   REVISED: TSUZUKI Daisuke, DATE: 13.nov.2008,    VERSION: 1.4
%   REVISED: TSUZUKI Daisuke, DATE: 02.mar.2011,    VERSION: 1.5
%    The third argument 'rn' can be not only scalar but also vector.   
%   REVISED: TSUZUKI Daisuke, DATE: 03.mar.2011,    VERSION: 1.6
%    All 4 labeling is executed if the argument 'col' is omitted.
%   REVISED: TSUZUKI Daisuke, DATE: 09.mar.2011,    VERSION: 1.7
%    Weighted by 3D gauss probabilistic density function is implemented.
%    
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

% -------------------
% Load reference data
% -------------------

ThisScriptPath = fileparts(mfilename('fullpath'));

MatFilePath = [ThisScriptPath filesep 'mat' filesep 'anatomlabel_final' filesep 'XYZABLT.mat']; % XYZABLT
% MatFilePath = [ThisScriptPath filesep 'mat' filesep 'nfri_a.mat']; % XYZI
load (MatFilePath); % 'nfri_anatomlabel.mat' is the target.

% CHECKING INPUTS
% ..............................................................  ^..^ )~

% IRadius is not defined
if nargin == 2
  rn = 10;
end

% Input ID is already loaded variable
ID = ch_data{2};
CH_Label = ch_data{1};
if isnumeric (ID)
  MAT = ID;
end

%  Input ID is excel file
if ischar (ID)
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
  error('Can not analyze input (points which should be labeled).');
end

% All 4 labeling is executed if the argument 'col' is omitted.
if (nargin == 3)
  LabelExt = {'aal', 'brodmann', 'lpba40', 'td'};
  for col = 4:6
    Label = get_Label(col, ThisScriptPath);
    myFileName = [saveFileName, '_',LabelExt{col-3}];
    doAnatomLabel(CH_Label, MAT, myFileName, rn, col, XYZABLT, Label);
  end
  return;
end

% Exec AnatomLabel.
Label = get_Label(col, ThisScriptPath);
doAnatomLabel(CH_Label, MAT, saveFileName, rn, col, XYZABLT, Label);


function Label = get_Label(col, ThisScriptPath)

switch col
  case 4
    MatFilePath = [ThisScriptPath filesep 'mat' filesep 'anatomlabel_final' filesep 'label_a.mat']; % label_a
    load (MatFilePath);
    Label = label_a;
  case 5
    MatFilePath = [ThisScriptPath filesep 'mat' filesep 'anatomlabel_final' filesep 'label_b.mat']; % label_b
    load (MatFilePath);
    Label = label_b;
  case 6
    MatFilePath = [ThisScriptPath filesep 'mat' filesep 'anatomlabel_final' filesep 'label_l.mat']; % label_l
    load (MatFilePath);
    Label = label_l;

end


function doAnatomLabel(CH_Label, MAT, saveFileName, rn, col, XYZABLT, Label)

% SET SAVING
% ..............................................................  ^..^ )~
Nemo = [ saveFileName '.csv' ]; % save output as csv file
ResultString = [];


% START BATCH PROCESS
% ..............................................................  ^..^ )~

if (length(rn) == 1)
  rn = ones(size(MAT, 1)) * rn;
end

for count = 1 : size(MAT, 1)
  fprintf('%d/%d\n', count, size(MAT, 1));
  DataRow = MAT(count, :);

  % Get all points within radius rn from given point, defauls is 10mm
  [SP, I] = SphPoints ( DataRow, rn(count), XYZABLT(:, 1:3));

  data = XYZABLT(I, col); % The 4th column of XYZABLT is the label of AAL.
  udata = unique(data);

  nos = nan(1, size(udata, 1)); % Number of the sphere?
  dos = nos;                    % Densities of the sphere
  ROIlist = {};

  for i = 1 : size( udata, 1 )  
    c = find( data == udata(i) );
    nos(i) = size(c, 1);
    ROIlist{end+1} = Label{udata(i)};
    
    % New factor, get the probability density on those points from 3D gauss
    c_xyz = SP(c, :);
    PD = my_ndim_gauss(c_xyz - repmat(DataRow, size(c_xyz, 1), 1), rn(count));
    dos(i) = sum(PD);
  end

  ROIlist = ROIlist';
  clear i j

  Perc = nos/sum(nos);
  Perc = Perc';

  WPerc = dos/sum(dos);
  WPerc = WPerc';
  
  % Checking sizes of outputs
  if size(ROIlist, 1) ~= size(Perc, 1)
    error('Failed to getlabels.');
  end

  ResultString = sprintf('%s%s,,%.3f,%.3f,%.3f\n', ...
    ResultString, CH_Label{count}, DataRow(1,1), DataRow(1,2), DataRow(1,3));

  [Y, I] = sort(Perc, 1, 'descend'); % Maybe we should refer WPerc no Perc...
  ROIlist = ROIlist(I);
  Perc = Perc(I);
  WPerc = WPerc(I);

  for i = 1 : size(ROIlist, 1)
      ResultString = sprintf('%s,,,,,"%s",%.3f\n', ResultString, ROIlist{i}, Perc(i));
    % I quote ROIlist{i} by "(double quotation) for escape comma character
    % in CSV format.
  end
  

end

fprintf('%s', ResultString);


fidSave = fopen( Nemo, 'w' );
fprintf(fidSave, '%s', ResultString);
fclose(fidSave);