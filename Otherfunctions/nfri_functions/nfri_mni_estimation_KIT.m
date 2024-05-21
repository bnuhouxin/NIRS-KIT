function [ch_label,ch_mni]=nfri_mni_estimation_KIT(Origin, Others,isReferCheck)

% NFRI_MNI_ESTIMATION_KIT - Execute probablistic registration.
% This function is based on 'nfri_mni_estimation'.

% USAGE.
%   nfri_mni_estimation(Origin, Others);
%
% DESCRIPTION.
%   This function converts the points on head in the realworld to the MNI
%   standardized space with spatial errors. Details are described in 
%   "Spatial registration of multichannel multi-subject fNIRS data
%   to MNI space without MRI" (Singh et al., 2005).
%
% INPUTS.
%   Origin is the filename which stores 10-20 points of suject (csv format).
%   Others is the filename which stores probes or channels points of
%   subject (csv format).
%   
% OUTPUTS.
%   ch_mni : [n,3] matrix of vectors

% EXAMPLE.
%   Origin = ['sample' filesep 'nfri_mni_estimation_origin.csv'];
%   Others = ['sample' filesep 'nfri_mni_estimation_others.csv'];
%   [ch_mni,ch_mnisd]=nfri_mni_estimation_KIT(Origin, Others);
   
clear global fullPathList OriginXYZ OthersXYZ PH; % Delete global variables completely;
global fullPathList OriginXYZ OthersXYZ;


% -------------------------------------------------------------------
% This script is derived from Dan & Oishi's AffineEstimation package.
% If you need previous version, please check http://hp/ in our
% labolatory and download '"beautiful" AffineEstimation src'.
% -------------------------------------------------------------------

if(nargin == 3)
  fullPathList.Origin = Origin;
  fullPathList.Others = Others;

else
  % ---------------------------
  % Origin file select dialogue
  % ---------------------------

  [FileNamOrigin, PathNamOrigin]...
    = uigetfile('*.csv','Locate the origin csv file');

  if(PathNamOrigin == 0)
    error('File selection is cancelled.');
  else
    fullPathList.Origin = fullfile(PathNamOrigin, FileNamOrigin);
  end

  % ---------------------------
  % Others file select dialogue
  % ---------------------------

  CWD = pwd;
  cd(PathNamOrigin);
  
  [FileNamOthers, PathNamOthers]...
    = uigetfile('*.csv','Locate the corresponding Others csv file');
  
  cd(CWD);

  if(PathNamOthers == 0)
    error('File selection is cancelled.');
  else
    fullPathList.Others  = fullfile(PathNamOthers, FileNamOthers);
  end
end

% -------------------------------------------------
% Reading the coordinates both of Origin and Others
% -------------------------------------------------

[~,OriginXYZ] = ReadCSV(fullPathList.Origin, 1);
[CH_Label,OthersXYZ] = ReadCSV(fullPathList.Others, 0);

if isReferCheck
    ThisScriptPath = GetMatDir;
    % load MAT/DMNIH;
    MatFile = [ThisScriptPath filesep 'DMNIH'];
    load (MatFile);
    num1020=size(DMNIHAve,1);
    IdX=zeros(1,num1020);
    loadedData.SelIndx = [1,2,3,4,12]; % Origin
    IdX(loadedData.SelIndx)=1;
    Selected=logical(IdX);
    
    loadedData.D   = OriginXYZ(Selected, :);
    loadedData.DD  = DMNIHAve(Selected, :); % XYZ coordinates and SD
    loadedData.DDD = OthersXYZ;

    [affineEstData] =AffineEstimation4(loadedData);
    global chMNIData
    chMNIData=affineEstData.OtherC;
else
    uiSetup(fullPathList, OriginXYZ, OthersXYZ);
end

global chMNIData
ch_mni=chMNIData;
ch_label=CH_Label;



function uiSetup(File, OriginXYZ, OthersXYZ)

figure;

OriginWidth = 230;  % The width of head image
OriginHeight = 260; % The height of head image

CBWidth = 45;  % The width of checkbox
CBHeight = 15; % The height of checkbox
CBPositions = ... % Positions of CheckBoxes
  [
  0.5  0.85; ... % Nz
  0.5  0.08; ... % Iz
  0.9  0.37; ... % AR
  0.1  0.37; ... % AL
  0.4  0.8;  ... % Fp1
  0.6  0.8;  ... % Fp2
  0.5  0.58; ... % Fz
  0.35 0.57; ... % F3
  0.65 0.57; ... % F4
  0.28 0.64; ... % F7
  0.72 0.64; ... % F8
  0.5  0.42; ... % Cz
  0.35 0.41; ... % C3
  0.65 0.41; ... % C4
  0.2  0.4;  ... % T3
  0.8  0.4;  ... % T4
  0.5  0.27; ... % Pz
  0.35 0.28; ... % P3
  0.65 0.28; ... % P4
  0.28 0.21; ... % T5
  0.72 0.21; ... % T6
  0.4  0.13; ... % O1
  0.6  0.13; ... % O2
  ];
Padding = [-0.05 * ones(1, size(CBPositions, 1)); ...
  zeros(1, size(CBPositions, 1))]';
CBPositions = CBPositions + Padding;
CBLabel = ...
  {'Nz', 'Iz', 'AR', 'AL', ...
  'Fp1', 'Fp2', 'Fz', 'F3', 'F4', 'F7', 'F8', 'Cz', 'C3', 'C4', ...
  'T3', 'T4', 'Pz', 'P3', 'P4', 'T5', 'T6', 'O1', 'O2'};

Margin = 5;
LblHeight = 30;
BtnWidth = 50;

ImageFile = [GetFigDir filesep 'head.png'];
% image(imread('head.png'))
image(imread(ImageFile));
set(gca, ...
  'Unit', 'pixels', ...
  'XTickLabel', '', ...
  'YTickLabel', '', ...
  'Position', [0 0 OriginWidth*2 OriginHeight*2])
axis image;

uicontrol('Style', 'text', ...
  'ForegroundColor', 'white', ...
  'BackgroundColor', 'black', ...
  'String', 'Choose the points to proceed spatial estimation', ...
  'Position', ...
  [Margin OriginHeight*2-LblHeight-Margin OriginWidth*2 LblHeight], ...
  'FontName', 'FixedWidth');

Data = OriginXYZ;
for i = 1:size(Data, 1)
  Row = Data(i, :);
  if sum(isnan(Row), 1) > 0
    uicontrol('Style', 'checkbox', ...
      'BackgroundColor', 'white', ...
      'Enable', 'off', ...
      'String', CBLabel{i}, ...
      'Position', [OriginWidth*2*CBPositions(i, 1) ...
      OriginHeight*2*CBPositions(i, 2) ...
      CBWidth CBHeight], ...
      'Visible', 'on');
  else
    uicontrol('Style', 'checkbox', ...
      'BackgroundColor', 'white', ...
      'FontName', 'FixedWidth', ...
      'Enable', 'on', ...
      'String', CBLabel{i}, ...
      'Value', 1, ...
      'Position', [OriginWidth*2*CBPositions(i, 1) ...
      OriginHeight*2*CBPositions(i, 2) ...
      CBWidth CBHeight]);
  end
end
uicontrol('Style', 'PushButton', ...
  'String', 'OK', ...
  'Position', ...
  [OriginWidth*2-BtnWidth-Margin Margin BtnWidth LblHeight], ...
  'FontName', 'FixedWidth', ...
  'Callback', @BtnFcnCheck)

set(gcf, 'MenuBar', 'none', ...
  'Name', 'MNI Estimation', ...
  'NumberTitle', 'off', ...
  'Position', [400 200 OriginWidth*2 OriginHeight*2]);




function BtnFcnCheck(h, eventdata)
global OriginXYZ OthersXYZ

CBH = findobj(gcf, 'Style', 'CheckBox'); % Get handles of CheckBox UI
CBH = sort(CBH); % CBH should be ascending order.
Selected = [];
for i = 1:size(CBH, 1)
  Selected(i) = get(CBH(i), 'Value');
end
Selected = logical(Selected); % Convert double array to logical array

ThisScriptPath = GetMatDir;
% load MAT/DMNIH;
MatFile = [ThisScriptPath filesep 'DMNIH'];
load (MatFile);
loadedData.D   = OriginXYZ(Selected, :);
loadedData.DD  = DMNIHAve(Selected, :); % XYZ coordinates and SD
loadedData.DDD = OthersXYZ;
loadedData.SelIndx = find(Selected); % Pick up the index from 10-20 points.

close(gcf);


[affineEstData] =AffineEstimation4(loadedData);
global chMNIData
chMNIData=affineEstData.OtherC;



function [affineEstData] = AffineEstimation4(loadedData)

%********************************************************************
% AffinEstSurface4
% Last modiied by Dan, 050706
% Modified version of AffinEstSurface3
% This program works as a function for the main batch file
% Now using ProjectionBS_f
%********************************************************************

global PH;

% Just conversions for instant modifications
D     = loadedData.D;   % XYZ coorfinates read from Origin file
DD    = loadedData.DD;  % XYZ coorfinates and SD on averaged MNI head
DDD   = loadedData.DDD; % XYZ coorfinates read from Others file

RIndx = loadedData.SelIndx;

% First, working on the ideal brain on MNI space
ListOri  = [D,ones(size(D,1),1)];
DD(:,4)  = ones(size(DD,1),1);
ListDist = DD;

% Parameter for drawing
MS = 10;  % Marker Size
CT = 0.7; % Color Threshold for mean & SD visualization

%==========================================================
% Transformation to the ideal brain
%==========================================================

%----------------------------------------------------------
% 10-20 standard points of a subject in the real world coordinate system
% stored in ‘Origin'...is affine-transformed to the ideal 10-20 orientation
% on the MNI space
%----------------------------------------------------------
% ListCur is the transformed 10-20 positions
% W is the transformation matrix
%----------------------------------------------------------
W       = ListOri\ListDist;
ListCur = ListOri*W;

FigFile = [GetFigDir filesep 'MeanBrain.fig'];
% MB1 = open('FIG/MeanBrain.fig'); % Obtained from Decent\Standard_Data
MB1 = open(FigFile);
figure(MB1);

set(MB1, ...
  'Name', 'Estimation result', ...
  'NumberTitle', 'off');
axis equal;
hold on
plot3(ListDist(:,1), ListDist(:,2), ListDist(:,3),'.',...
  'MarkerSize', MS * 2, 'Color', [0 0 1]);
plot3(ListCur(:,1), ListCur(:,2), ListCur(:,3),'.',...
  'MarkerSize', MS * 2, 'Color', [1 0 0]);


%==========================================================
% Transformation to reference brains
%==========================================================

%----------------------------------------------------------
% 10-20 standard points of a subject in the real world coordinate system
% stored in ‘Origin'...is affine-transformed to the 10-20 orientation
% on reference brains
%----------------------------------------------------------
% RefBList stores transformed 10-20 points, sum of variances,
% and transformation matrices
%----------------------------------------------------------

RefN     = 17;
RefBList = cell(RefN,2);

ThisScriptPath = GetMatDir;
% load MAT/DMNI;
MatFile = [ThisScriptPath filesep 'DMNI'];
load (MatFile);

for cc=1:RefN

  % Read MNIdata for Sample brain1
  DataName=['DMNI',sprintf('%04d',cc)];%Read an MR slice file
  eval(['DM=' DataName ';']);

  % Now MNI coordinates being read as DM, for a Sample brain
  DM             = DM(RIndx,:); % Only reference points used are selected
  RefDist        = [DM,ones(size(DM,1),1)];
  WW             = ListOri\RefDist;
  RefBListCur    = ListOri*WW;
  RefBList{cc,1} = RefBListCur;
  RefBList{cc,2} = WW;

  ShowProgress(cc, RefN, 'Reading MNI data for NFRI_17');
end


%==========================================================
% Then, transforming given head surface points stored in 'Others’
% to the ideal brain, and each reference brain
%==========================================================

DDDD        = ones(size(DDD,1),4);
DDDD(:,1:3) = DDD;

% Working on each reference brain
OtherRefList=cell(1,RefN);
for cc = 1:RefN
  WR                 = RefBList{cc,2};
  OtherRef           = DDDD*WR;
  OtherRefList{1,cc} = OtherRef;

  figure(MB1);
  plot3(OtherRef(:,1), OtherRef(:,2), OtherRef(:,3), ...
    '.', 'MarkerSize', MS, 'Color', [0.5 0.5 0])
end


%==========================================================
% Restore data across reference brains
%==========================================================

PointN          = size(DDD,1); % Now 12 points
PListOverPoint  = cell(1,PointN);

for c2 = 1:PointN;    % Counting up other points
  PList=ones(RefN,3);

  for c1 = 1:RefN               % Counting up reference brain
    PList(c1,:) = OtherRefList{c1}(c2,1:3);
  end

  PListOverPoint{c2} = PList;

  ShowProgress(c2, PointN, 'Restoring data across reference brains');
end
% Data are restored in PListOverPoint


%----------------------------------------------------------
% Finding the representative point on the head surface
% Now this part has been changed to find average first
% then perform surface transformation
%----------------------------------------------------------

%==========================================================
% Only edge points
%==========================================================
ThisScriptPath = GetMatDir;
% load MAT/HeadSurfEdgeMNI;
MatFile = [ThisScriptPath filesep 'HeadSurfEdgeMNI'];
load(MatFile);

OtherH     = ones(PointN,3);
OtherHMean = ones(PointN,3);
OtherHVar  = ones(PointN,4);
OtherHSD   = ones(PointN,4);

for c3=1:PointN
  AA              = mean(PListOverPoint{c3},1);
  OtherHMean(c3,:)= AA;

  % Surface transformation
  BB              = BackProjectionf(xallHEM, yallHEM, zallHEM, AA);
  OtherH(c3,:)    = BB;

  % Variance calculation
  VV              = VarCalcf(PListOverPoint{c3},BB);
  OtherHVar(c3,:) = VV;
  OtherHSD(c3,:)  = sqrt(VV);
  clear AA BB VV; % 必要？？

  ShowProgress(c3, PointN, 'Performing balloon inflation');
end


%----------------------------------------------------------
% Calculating errors on Cortical surface
% First, projecting given head surface points on each reference brain
% Working on OtherRefList but not on PListOverPoint
%----------------------------------------------------------
OtherRefCList=cell(1,RefN);%!!!!!

for c2=1:RefN
  ProjectionListC = ones(PointN,3);

  % Read cortical surface data for reference brain used.
  DataName = [GetMatDir filesep 'CrtSrfMNISm' sprintf('%04d', c2)];
  load(DataName);
  % Now brain surface data are read as xallM, yallM, zallM

  for cc=1:PointN
    % This is a modified version with stable results
    ProjectionListC(cc,:) = ProjectionBS_f(xallM, yallM, zallM, ...
      OtherRefList{c2}(cc,1:3));
  end

  OtherRefCList{c2} = ProjectionListC;

  ShowProgress(c2, PointN, 'Calculating errors on the cortical surface');
end

% Now all given points are projected, but stored on reference brain basis

figure(MB1);
plot3(ProjectionListC(:,1), ProjectionListC(:,2), ProjectionListC(:,3), ...
  '.', 'MarkerSize', MS, 'Color', [1 1 0])


%==========================================================
% Restore data across reference brains
% Working along PointN,Now 12 points
%==========================================================
CPListOverPoint=cell(1,PointN);%!!!!!

for c2 = 1:PointN; % Counting up other points
  CPList = ones(RefN,3);

  for c1 = 1:RefN % Counting up reference brain
    CPList(c1,:) = OtherRefCList{c1}(c2,:);
  end

  CPListOverPoint{c2} = CPList;
  ShowProgress(c2, PointN, 'Restoring data across reference brains');
end
% Data are restored in CPListOverPoint


%----------------------------------------------------------
% Finding the representative point on the head surface
% Now this part has been changed to find average first
% then perform surface transformation
%----------------------------------------------------------

%==========================================================
% Only edge points
%==========================================================

ThisScriptPath = GetMatDir;
% load MAT/BrainSurfEdgeMNI;
MatFile = [ThisScriptPath filesep 'BrainSurfEdgeMNI'];
load (MatFile);

OtherC      = ones(size(OtherH));   % !!!!! % 意味不明なコメント
% OtherCMean  = ones(PointN,3);       % OtherCMean は参照されません。
OtherCVar   = ones(PointN,4);
OtherCSD    = ones(PointN,4);

for c3=1:PointN;
  AA              = mean(CPListOverPoint{c3},1);
  % OtherCMean(c3,:)= AA;

  % Surface transformation
  BB              = BackProjectionf(xallBEM, yallBEM, zallBEM, AA);
  OtherC(c3,:)    = BB;

  % Variance calculation
  VV              = VarCalcf(CPListOverPoint{c3},BB);
  OtherCVar(c3,:) = VV;
  OtherCSD(c3,:)  = sqrt(VV);

  clear AA BB VV; % 必要？？

  ShowProgress(c3, PointN, 'Finding the representative points');
end
close(PH);

figure(MB1);
plot3(OtherH(:,1), OtherH(:,2), OtherH(:,3),'.', ...
  'MarkerSize', MS * 2, 'Color', [1 0 1])
plot3(OtherC(:,1), OtherC(:,2), OtherC(:,3),'.', ...
  'MarkerSize', MS * 2, 'Color', [1 1 1])
plot3(OtherHMean(:,1), OtherHMean(:,2), OtherHMean(:,3),'.', ...
  'MarkerSize', MS * 2, 'Color', [0 1 0])

% Calculation for SSws
SSwsH   = OtherHVar * (RefN-1);
SSwsC   = OtherCVar * (RefN-1);

% ----------------
% Set Return Value
% ----------------

% given head surface points transformed to the MNI ideal head (within-subject hat)
affineEstData.OtherH   = OtherH;
% given cortical surface points transformed to the MNI ideal brain
% (within-subject hat)
affineEstData.OtherC   = OtherC;
% transformation SD for given head surface points, point manner.
affineEstData.OtherHSD = OtherHSD;
affineEstData.OtherCSD = OtherCSD;
% transformation SD for given cortical surface points, point manner.
affineEstData.SSwsH    = SSwsH;
affineEstData.SSwsC    = SSwsC;
affineEstData.RefN     = RefN;


% ------------------------------------------------------------------------
% Open another figure window and show the summary (each mean point and SD)
% ------------------------------------------------------------------------

% Reading all xall, yall, zall variables just for visualization.

ThisScriptPath = GetMatDir;
% load MAT/Head;
MatFile = [ThisScriptPath filesep 'Head'];
load (MatFile);

Pos = get(MB1, 'Position');
% MB2 = open('FIG/MeanBrain.fig'); % Obtained from Decent\Standard_Data
MB2 = open(FigFile);
set(MB2, ...
  'Name', 'Estimation result (mean points and each SD)', ...
  'NumberTitle', 'off', 'Position', Pos + [50 -50 0 0]);
axis equal; hold on;
drawnow;


% ----------------------------------------------------------
% 1-3rd columns of OtherCSD are SD for each XYZ coordinates.
% 4th column of OtherCSD is total value.
% I use the value of 4th column for visualization.
% ----------------------------------------------------------

BrainEdge = [xall' yall' zall'];
BrainColorMap = flipud(bone(69));
Centroid = mean(BrainEdge, 1);
MeanPointColor = [1 1 1];

for i = 1 : size(OtherC, 1)
  m = OtherC(i, :);
  r = OtherCSD(i, 4);

  % -------------------------------------------------------------------
  % Pick up the points where brain surface covers the SD from MeanPoint
  % -------------------------------------------------------------------

  Dists = GetDist(BrainEdge, m);
  Sel = Dists <= r;
  Area = [BrainEdge(Sel, :) Dists(Sel)];
  % Now variable Area has [x, y, z, Dist from MeanPoint]

  % -------------------------------------------------------
  % Get the distance from centroid of brain and color index
  % -------------------------------------------------------

  Dists = GetDist(Area, Centroid);
  Area = [Area Dists round(Dists)-48];
  % Now variable Area has
  %  [x, y, z, Dist from MeanPoint, Dist from Centroid, BrainColorIndex]

  for j = 1 : size(Area, 1),
    DfM = Area(j, 4); % Distance from MeanPoint
    if DfM < r * CT,
      PlotColor = MeanPointColor;
    else
      MCratio = (r - DfM) / (r - r * CT); % MeanPointColor ratio
      BCratio = 1 - MCratio;              % BrainColor ratio
      PlotColor = MeanPointColor * MCratio + ...
        BrainColorMap(Area(j, 6), :) * BCratio;

      % -----------------------
      % Color vector correction
      % -----------------------

      Sel = PlotColor(:, :) < 0; PlotColor(Sel) = 0;
      Sel = PlotColor(:, :) > 1; PlotColor(Sel) = 1;
    end
    hold on;
    plot3(Area(j,1), Area(j,2), Area(j,3), '.', ...
      'MarkerSize', MS, 'Color', PlotColor);
  end
  axis equal; hold on;

  % -------------------------------------
  % Labeling for each estimated positions
  % -------------------------------------

  TextXYZ = OtherC(i, 1:3) + ...
    OtherC(i, 1:3) / norm(OtherC(i, 1:3)) * 10;
  TH = text(TextXYZ(1), TextXYZ(2), TextXYZ(3), int2str(i), ...
    'BackgroundColor', [.7 .9 .7]);
  NameString = ['Estimation result (mean points and each SD) ', ...
    int2str(i) '/' int2str(size(OtherC, 1))];
  set(MB2, 'Name', NameString);
  drawnow;
end
if ishandle(MB1)
    close(MB1);
end

if ishandle(MB2)
    close(MB2);
end
 
% WriteCSV(loadedData, affineEstData);





% function WriteCSV(loadedData, affineEstData )
% global fullPathList;
% fullPathRep = fullPathList.Rep;
% 
% % given head surface points
% xlswrite(fullPathRep, affineEstData.OtherH,   'WShatH');
% % given cortical surface points
% xlswrite(fullPathRep, affineEstData.OtherC,   'WShatC');
% % transformation SD for given head surface points
% xlswrite(fullPathRep, affineEstData.OtherHSD, 'WS_SDH');
% % transformation SD for given cortical surface points
% xlswrite(fullPathRep, affineEstData.OtherCSD, 'WS_SDC');
% 
% xlswrite(fullPathRep, affineEstData.SSwsH,    'SSwsH');
% xlswrite(fullPathRep, affineEstData.SSwsC,      'SSwsC');
% % xlswrite(fullPathRep, loadedData.TTT,          'OtherPointLabels');
% 
% TextA       = cell(1);
% TextA{1}    = 'Reference brain number';
% xlswrite(fullPathRep, TextA, 'Info', 'A1');
% xlswrite(fullPathRep, affineEstData.RefN, 'Info', 'A2');  % よく失敗する
% 
% TextB       = cell(1);
% TextB{1}    = 'Refference points used';
% xlswrite(fullPathRep, TextB, 'Info', 'A3');
% xlswrite(fullPathRep, loadedData.T, 'Info', 'A4');


% ---------------------------
% Variable information
% ---------------------------

% W:
%  affine-transformation matrix.
%
% OtherH:
%  given head surface points transformed to the MNI(WS hat).
%
% OtherC:
%  given cortical surface points transformed to the MNI(WS hat).
%
% OtherHMean:
%  an average of given head surface points transformed to the MNI ideal head (within-subject mean).
%
% OtherCMean:
%  an average of given cortical surface points transformed to the MNI ideal brain (within-subject mean).
%
% PListOverPoint:
%  given head surface points transformed to the MNI reference heads, point manner.
%
% CPListOverPoint:
%  given cortical porojection points transformed to the MNI reference brains, point manner.

% OtherRefList or OtherRefList{:} to get given head surface points transformed to the MNI reference heads, reference head manner.
% OtherRefCList or OtherRefCList{:} to get given cortical porojection points transformed to the MNI reference brains, reference brain manner.

% OtherHVar to get transformation variances for given head surface points, point manner.
% OtherCVar to get transformation variances for given cortical surface points, point manner.
% In either variance, the first three values indicate x, y, z variances and 4th value, composite variance,r^2.

% OtherHSD to get transformation SD for given head surface points, point manner.
% OtherCSD to get transformation SD for given cortical surface points, point manner.
% In either SDC, the first three values indicate x, y, z SDs and 4th value, composite SD of r.


function ShowProgress(Current, Last, Title)
global PH;

if nargin == 2,
  Title = 'In progress...';
end

if isempty(PH) % Check PiechartHandle
  PH = figure;
  set(PH, ...
    'Units', 'pixels', ...
    'MenuBar', 'none', ...
    'Color', 'Black', ...
    'Name', Title, ...
    'NumberTitle', 'off', ...
    'Position', [400 100 100 100]);
  axis equal;
end

FigTitle = get(PH, 'Name');
if strcmp(FigTitle, Title) == 0
  set(PH, 'Name', Title)
end

figure(PH); % Set the Piechart figure active
pie(Current / Last);
drawnow;


function Output = GetDist(A, B)
Dists = A(:, 1:3) - repmat(B(:, 1:3), size(A(:, 1:3), 1), 1);
Dists = Dists .* Dists;
Dists = sum(Dists, 2);
Output = Dists .^ 0.5;



function Out = BackProjectionf(xall, yall, zall, P)

%%%BackProjectionf%%%
% Last modified by Dan, 041104
% This function simply finds the closest points on the head or brain surface.
% Work only within a small region, and not suitable for large area search.
% Pick up three closest points and find the centroid.

% Input may be head or brain surface EDGE points
% P should be close enough to the surface edge points

% This part obtains a list of distances between P and cortical surfaces
XYZ = [xall', yall', zall'];
PP = ones(size(XYZ));
PP(:,1) = P(1);
PP(:,2) = P(2);
PP(:,3) = P(3);
PreD = XYZ-PP;
PreD2 = PreD.^2;
PreD3 = sum(PreD2,2);
D = PreD3.^0.5; %Now distance is found

[VD,ID]=sort(D); %ID gives indices
Top=3; % This value is only for visual presentation
IDTop=ID(1:Top); % Indices list for top# closest points
XYZTop=XYZ(IDTop,:); % x, y, z coordinate list for top# closest points
Closest=mean(XYZTop,1);
% Closest=XYZ(ID(1), :); % tsuzuki test: This might be correct.

Out = Closest;


function Out = VarCalcf(AA, AV)

%%%VarCalcf%%%
% Last modified by Dan on 11/02/2004
% This function calculates the variance from a given representative point
% to a list of points.
% List of points are fed as n by 3 matrix.
% A given point is fed as 1 by 3 matrix.
% This function returns variances in x, y, z axes and composite distance variance.

N = size(AA,1);

% First, creating a matrix for subtraction
SubMat = ones(size(AA));
for cc = 1:N
  SubMat(cc,:) = AV;
end

DispEach = AA - SubMat;
DispEachSq = DispEach.^2;
XYZSS = sum(DispEachSq);
RSS = sum(XYZSS);

XYZVar = XYZSS/(N-1);
RSSVar = RSS/(N-1);

Out = [XYZVar,RSSVar];


function Out=ProjectionBS_f(xall, yall, zall, P) % Later alive
%!!!This is beta version for ProjectionBS_f
%Stable projection function based on Balloon-inflation algorithm
%Last modified by I. Dan on 050706

%%%ProjectionDM%%%
%Modified version of Projection D
%This program needs the following variates
%FacetListR created by Conv program, a list of coordinates for facets and
%apices of the convex hull
%xall, yall, zall created by BrainImageRead3D program, a list of
%coordinates for brain surface

%P is a given point on the head surface or its outside space

%This is a function version for ProjectionD program
%Based on the balloon-inflation algorithm

% load CrtSrfMNISm0001.mat%%%%%%%
%
% xall=xallM;%%%%%
% yall=yallM;%%%%%
% zall=zallM;%%%%%
% P=[-62    60   -63]%%%%%
% %P=[30 40 100]%%%%%


%This part obtains a list of distances between P and cortical surfaces
XYZ=[xall', yall', zall'];

PP=ones(size(XYZ));
PP(:,1)=P(1);
PP(:,2)=P(2);
PP(:,3)=P(3);
PreD=XYZ-PP;
PreD2=PreD.^2;
PreD3=sum(PreD2,2);
D=PreD3.^0.5; % Now distance is found

[VD,ID]=sort(D);%ID gives indices
%Top=1000;%This value is only for visual presentation
Top=round(size(XYZ,1)*0.05);%Top5% are selected
%!!!This value used to be 1000
% but it sometimes do not cover the deep sulcus
% So now we use a relative number

IDTop=ID(1:Top);%Indices list for top# closest points
XYZTop=XYZ(IDTop,:); %x, y, z coordinate list for top# closest points

% Obtains the colosest point Pnear on the convex hull surfaces from P
% Uses average of several closest points (NClose) to estimate the closest points
NClose=200;
IDClose=ID(1:NClose);
XYZClose=XYZ(IDClose,:);
PNear=mean(XYZClose);
%plot3(PNear(1),PNear(2),PNear(3),'m*');
%plot3(XYZClose(:,1),XYZClose(:,2),XYZClose(:,3),'g.');

%%%Should this be Top instead of Close???

%Draw a line between P and Pnear
NXYZTop=size(XYZTop,1);
%Draw a line between Pnear and P
%First, define a vector
PVec=P-PNear;
A=PVec(1); B=PVec(2); C=PVec(3);
H=ones(size(XYZTop));
%We will get a list of foots H of normal line from brain surface points to the vector
for c=1:NXYZTop;
  xc=XYZTop(c,1); yc=XYZTop(c,2);zc=XYZTop(c,3);
  t=(A*(xc-P(1))+B*(yc-P(2))+C*(zc-P(3)))/(A^2+B^2+C^2);
  H(c,:)=[A*t+P(1) B*t+P(2) C*t+P(3)];
end

%Find diviation between points in XYZClose and H
PreDH=XYZTop-H;
PreDH2=PreDH.^2;
PreDH3=sum(PreDH2,2);
DH=PreDH3.^0.5;%This is a distance list for brain surface points to the vector
%[VDH,IDH]=min(DH)

%Rod Option
%Expand the line P-Pnear to a rod

%%%Rod is now incremented
Det=0;
RodR=0;
while Det==0
  RodR=RodR+1;
  Iless2=find(DH<=RodR);
  Rod=XYZTop(Iless2,:);
  Det=sum(sum(Rod.^2));
end

% Okamoto option
% Find brain surface points on the vicinity of P
PPB=ones(size(Rod));
PPB(:,1)=P(1);
PPB(:,2)=P(2);
PPB(:,3)=P(3);

PreVicD=Rod-PPB;
PreVicD2=PreVicD.^2;
PreVicD3=sum(PreVicD2,2);
VicD=PreVicD3.^0.5;%Distance list

[VVicD,IVicD]=sort(VicD);

NVic=3;%The number of points to be averaged
if size(Rod,1)<=NVic;
  NVic=size(Rod,1);
end;
NIVicD=IVicD(1:NVic);
Vic=Rod(NIVicD,:);%Select top NVic closest points from Pnear within the rod

CP=mean(Vic,1);
Out=CP;


function [Label,XYZ] = ReadCSV(File, LabelRowNum)
XYZ = [];
Label = {};

fid = fopen(File);
while 1
  tline = fgetl(fid);
  if ~isstr(tline), break, end;

  loc = findstr(tline, ',');

  % Eliminate first column (Label)
  if size(loc, 1) ~= 0,
    llabel = tline(1:loc(1)-1);
    tline(1:loc(1)) = [];
  end

  tline(findstr(tline, '"')) = ' '; % Eliminate double quote in case
  tline(findstr(tline, ',')) = ' '; % Eliminate all commas
  lXYZ = sscanf(tline, '%f');
  if ~isempty(lXYZ') && isnumeric(lXYZ') % Thanks Ted.
    XYZ = [XYZ; lXYZ'];
  else
    XYZ = [XYZ; NaN NaN NaN];
  end
  Label = [Label;llabel];
end
fclose(fid);

if LabelRowNum > 0
  XYZ(1:LabelRowNum, :) = []; % Delete first row (Label)
end

%%

function PATH = GetMatDir
PATH = fileparts(mfilename('fullpath'));
PATH = [PATH filesep 'mat' filesep 'nfri_mni_estimation'];

%%

function PATH = GetFigDir
PATH = fileparts(mfilename('fullpath'));
PATH = [PATH filesep 'fig' filesep 'nfri_mni_estimation'];

