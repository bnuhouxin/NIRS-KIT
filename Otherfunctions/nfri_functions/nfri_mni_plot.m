function nfri_mni_plot(CM, InputData, SimpleFlag)

% NFRI_MNI_PLOT - Cortical activation viewer.
%
% USAGE.
%   % Show 'open file' dialog to read the Excel file. Colormap is 'jet'.
%    e.g.,
%     nfri_mni_plot;
%
%   % Show 'open file' dialog to read the Excel file. Colormap is 'pink'.
%    e.g.,
%     nfri_mni_plot('pink');
%
%   % Define the input file as an argument (not showing 'open file' dialog).
%    e.g.,
%     InputData = 'sample/nfri_mni_plot.xls';
%     nfri_mni_plot('jet', InputData);
%
%   % Define the input file as an argument (not showing 'open file' dialog).
%   % Simple visualization mode will be invoked.
%    e.g.,
%     InputData = 'sample/nfri_mni_plot.xls';
%     nfri_mni_plot('jet', InputData, 'Simple');
%
%   % InputData could be variable.
%    e.g.,
%     InputData.xyzsd = [ ...
%         48.6667   -0.6667   58.3333    6.1826
%         48.6667   25.6667   45.6667    6.6124
%         43.6667   49.6667   27.6667    5.6813];
%     InputData.values = [3.2224, 0.8225, 0.3118]';
%     InputData.max = 6;
%     InputData.min = -1;
%     InputData.title = 'sample';
%     nfri_mni_plot('jet', InputData);
%
% DESCRIPTION.
%   This function will load co-ordinates of points stored in *.xls file.
%   You can plot circle of activations around this points; Radius will
%   be composite SD. It will find all points from xall, yall, zall
%   around these points. It will plot them and color them according to
%   Activation values (Va) which are stored in 5th column in InputData.
%
% INPUTS.
%   CM is the Color Scale pattern. Default is 'jet'.
%   InputData could be the Excel file or variable.

% modified by HouXin 2020,10,25 (houxin195776@mail.bnu.edu.cn)

% -------------------
% Datafile processing
% -------------------

if (nargin <= 1 || isempty(InputData))
  [FileNamOrigin, PathNamOrigin] = ...
    uigetfile('*.xls', 'Select the xls file');

  if(PathNamOrigin == 0),
    disp('File selection is cancelled.');
    return;
  
  else
    InputData = fullfile(PathNamOrigin, FileNamOrigin);
  end
end

% We load excel data
if ischar(InputData)
  Title = InputData;
  LoadedData = xlsread(InputData);
end

% InputData can be a struct,
if isstruct(InputData)
  % InputData.xyzsd
  %          .values
  %          .max
  %          .min
  LoadedData = InputData.xyzsd;
  if size(InputData.values, 1) == 1
    LoadedData = [LoadedData InputData.values'];
  else
    LoadedData = [LoadedData InputData.values];    
  end
  LoadedData = [LoadedData; nan(1, 4) InputData.max];
  LoadedData = [LoadedData; nan(1, 4) InputData.min];
  
  if isfield(InputData, 'title')
    Title = InputData.title;
  else
    Title = 'Title is not defined';
  end
end

% Check statistics value column. If all values are 'Nan', then quit.
if (all(isnan(LoadedData(1:end-2, 5))))
  fprintf('All activation values are NaN, not-a-number. There is nothing to do.\n');
  return;
end


% ---------------------------
% Default ColorMap definition
% ---------------------------

if nargin == 0,
  CM = 'jet';
end

% ------------------
% Load cortical data
% ------------------

MatFile = ...
    [fileparts(mfilename('fullpath')) filesep 'mat/nfri_mni_plot/Brain.mat'];
load (MatFile); % xall, yall, zall ... <1x68657>
DrawBrain([xall' yall' zall'],InputData);%

MP = gcf;
set(MP, ...
    'Name', ['NFRI MNI plot: ', Title],...
    'numbertitle', 'off', ...
    'toolbar', 'none', ...
    'menubar', 'none', ...
    'tag', 'Canvas');

Handles = struct('NaN', [], 'X', []);
% This variable Handles is the object handles,
% will be used as "set(MP, 'UserData', handles);"

% ------------
% -- Define constant value for coloring
% -- I guess I should calculate appropriate value for visualize
% --  dynamically by using Brain coordinate.
% -----


% We'll load values which determin colorrange Va
% We always store these values in excel file
% min value is stored in last row
% max value is stored as last but one

Ans = questdlg('Apply automatic scale? (Ignore the max and min value in the sheet?)', 'Automatic scale?');
DummyScale = 100;

if isequal(Ans, 'Yes')
  MaxVa = round(max(LoadedData(1:end - 2, 5)) * DummyScale);
  MinVa = round(min(LoadedData(1:end - 2, 5)) * DummyScale);

elseif isequal(Ans, 'No')
  MaxVa = round(LoadedData(end - 1, 5) * DummyScale);
  MinVa = round(LoadedData(end, 5) * DummyScale);

  ColorAns = questdlg('Do you plot outlier points(less than minimum value, more than maximum value) with white and black color?', 'Color choice');
  if isequal(ColorAns, 'Yes')
    WBFlag = 1;
  elseif isequal(ColorAns, 'No')
    GrayFlag = 1;
  else
    return;
  end

else
  return;
end

% We'll cut last 2 rows
LL = size(LoadedData, 1);
Data = LoadedData(1:(LL - 2), :);

% We define Va - Activation (color intensity value for every point)
Va = Data(:, 5)';

% We'll make length of range bigger
Va = round(Va * 100);

% We generate equally incremented vector CMR from min to max
CMR = MinVa : MaxVa;

% We get length of the vector
Cnp = length(CMR);
Str = ['Cmp = flipud(' CM '(Cnp));'];
eval(Str);

% Cmp = flipud(jet(Cnp));
% Cmp = flipud(hot(Cnp)); % Define colormap of circles
% This can be jet, hot, cool, autumn, colorcube,
% copper, pink, spring, prism, summer, winter

% Here we wanna find all xall, yall, zall points round our points
% Pcol1 is (x) value of points, Pcol2 is (y) and Pcol2 s (z) value
Pcol1 = Data(:,1);
Pcol2 = Data(:,2);
Pcol3 = Data(:,3);

% Here we start script. Script will run m times, depends how many points
% we have in Data.xls file stored in rows. First it will find all xall,
% yall, zall points round points co-ordinates. We'll get cube. Than
% we'll find all lengths from our point to each point inside cube. Than
% we'll cut all lengths longer than Radius. Now we have circle. We can plot
% them.

Radius = Data(:, 4)'; % load Composite SD from xls file
Diameter = Radius * 2;

% 2008/12/22
NanI = isnan(Va);
if sum(NanI) > 0
  NanFlag = 1;
end

if exist('WBFlag', 'var')
  BlackPointsI = Va > MaxVa;
  WhitePointsI = Va < MinVa;
  Va(BlackPointsI | WhitePointsI) = MaxVa; % Temp value
end

if ~exist('WBFlag', 'var')
  LessThanMinI = Va <= MinVa;
  Va(LessThanMinI) = MinVa;
  MoreThanMaxI = Va >= MaxVa;
  Va(MoreThanMaxI) = MaxVa;
end

CenterColors = nan(length(Va), 3);
CenterColors(~NanI, :) = Cmp((MaxVa - Va(~NanI)) + 1, 1:3);
if exist('WBFlag', 'var')
  CenterColors(BlackPointsI, :) = repmat([0 0 0], sum(BlackPointsI), 1);
  CenterColors(WhitePointsI, :) = repmat([1 1 1], sum(WhitePointsI), 1);
end
if exist('GrayFlag', 'var')
	GrayI = LessThanMinI | MoreThanMaxI;
  CenterColors(GrayI, :) = repmat([0.5 0.5 0.5], length(find(GrayI)), 1);  
end
if exist('NanFlag', 'var')
   CenterColors(NanI, :) = repmat(nan(1, 3), sum(NanI), 1);
end
ChangeFlag = true(length(Pcol1));


if isfield(InputData,'Is_scalp')
    if InputData.Is_scalp == 1
       scalp_path = which('scalp_mz3.mat');
       
       if ~isempty(scalp_path)
           load(scalp_path);
       end
           
       patch('Faces',m.faces,'Vertices',m.vertices,'facecolor',[180/255,180/255,180/255],'LineStyle','none');
%        hold on;
       alpha(InputData.scalp_alpha); 
    end
end
hold off;
axis equal vis3d;

DrawMain(Data, Pcol1, Pcol2, Pcol3, Radius, Diameter, ...
         xall, yall, zall, Va, MaxVa, MinVa, CenterColors, nargin);

set(gca, 'Tag', 'MainAxis');
set(Handles.NaN, 'Visible', 'Off');
set(MP, 'UserData', Handles);

% Set plot properties
view(270, 0)

% Set colorbar
if isequal(MinVa, MaxVa)
  MinVa = MinVa - 1;
  MaxVa = MaxVa + 1;
end
SetColorbar(MP, CM, MinVa, MaxVa, DummyScale);
rotate3d on;

RawData = Data(:, 5)';
args = makeArgs(Data, Pcol1, Pcol2, Pcol3, Radius, Diameter, ...
                xall, yall, zall, Va, MaxVa, MinVa, CenterColors, ...
                nargin, RawData, DummyScale, Cmp);
              
args.UIh = SetPropUI(MP, args);
              
set(MP, ...
  'ResizeFcn', {@ReplacePropUI, args}, ...
  'UserData', args);
ReplacePropUI([], [], args);



%%

function UIh = SetPropUI(MP, args)

UIh.PropCon = uicontrol(MP, ...
    'style', 'text', ...
    'tag', 'PropCon', ...
    'unit', 'normalize', ...
    'position', [0.75, 0, 0.25, 1]);

UIh.max_label = uicontrol(MP, ...
    'style', 'text', ...
    'string', 'Max');

UIh.max_edit = uicontrol(MP, ...
    'tag', 'max_edit', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', args.MaxVa / args.DummyScale));

UIh.min_label = uicontrol(MP, ...
    'style', 'text', ...
    'string', 'Min');

UIh.min_edit = uicontrol(MP, ...
    'tag', 'min_edit', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', args.MinVa / args.DummyScale));

UIh.thres_label = uicontrol(MP, ...
    'style', 'text', ...
    'string', 'Thres');

UIh.thres_edit = uicontrol(MP, ...
    'tag', 'thres_edit', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', args.MinVa / args.DummyScale));

UIh.maxc_label = uicontrol(MP, ...
    'style', 'text', ...
    'string', 'Max RGB');

CM = args.CM;

UIh.maxc_edit_r = uicontrol(MP, ...
    'tag', 'maxc_edit_r', ...
              'style', 'edit', ...
              'string', sprintf('%.2f', CM(1, 1)));

UIh.maxc_edit_g = uicontrol(MP, ...
    'tag', 'maxc_edit_g', ...
              'style', 'edit', ...
              'string', sprintf('%.2f', CM(1, 2)));

UIh.maxc_edit_b = uicontrol(MP, ...
    'tag', 'maxc_edit_b', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', CM(1, 3)));

UIh.minc_label = uicontrol(MP, ...
    'style', 'text', ...
    'string', 'Min RGB');

UIh.minc_edit_r = uicontrol(MP, ...
    'tag', 'minc_edit_r', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', CM(end, 1)));

UIh.minc_edit_g = uicontrol(MP, ...
    'tag', 'minc_edit_g', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', CM(end, 2)));

UIh.minc_edit_b = uicontrol(MP, ...
    'tag', 'minc_edit_b', ...
    'style', 'edit', ...
    'string', sprintf('%.2f', CM(end, 3)));

UIh.apply_btn = uicontrol(MP, ...
    'style', 'pushbutton', ...
    'string', 'Apply', ...
    'CallBack', {@ApplyPropChange, args});

UIh.memo_label = uicontrol(MP, ...
    'style', 'text', ...
    'string', 'Memo');

UIh.memo_edit = uicontrol(MP, ...
    'style', 'edit', ...
    'BackGroundColor', [1 1 1], ...
    'max', 5, ...
    'string', '', ...
    'HorizontalAlignment', 'left');

UIh.toggle_btn = uicontrol(MP, ...
    'Style', 'PushButton', ...
    'String', 'Toggle Label', ...
    'Unit', 'Pixel', ...
    'FontName', 'FixedWidth', ...
    'CallBack', @ToggleLabel); ...

% uicontrol(MP, 'Style', 'PushButton', ...
%   'String', 'Change NaN symbol', ...
%   'Unit', 'Pixel', ...
%   'FontName', 'FixedWidth', ...
%   'CallBack', @ChangeColor, ...
%   'Visible', 'off');

UIh.SaveFig_btn = uicontrol(MP, ...
    'Style', 'PushButton', ...
    'String', 'Save Figure', ...
    'Unit', 'Pixel', ...
    'FontName', 'FixedWidth', ...
    'CallBack', @SaveFig);

UIh.SaveFigForPaper_btn = uicontrol(MP, ...
    'Style', 'PushButton', ...
    'String', 'Save Fig for paper', ...
    'Unit', 'Pixel', ...
    'FontName', 'FixedWidth', ...
    'CallBack', @SaveFigForPaper);

UIh_names = fieldnames(UIh);
for n = 1:length(UIh_names)
  set(getfield(UIh, UIh_names{n}), 'FontName', 'FixedWidth')
end



function ReplacePropUI(h, event, args)

TextHeight = 16;
Margin = 10;
EditWidth = 50;
ButtonWidth = EditWidth * 3 + Margin * 2;
ButtonHeight = 30;

UIh = args.UIh;
set(UIh.PropCon, 'unit', 'pixel');
PropCon_pos = get(UIh.PropCon, 'position');
set(UIh.PropCon, 'unit', 'normalized');

% max_label
pos(1, :) = ...
    [PropCon_pos(1) + Margin, PropCon_pos(4) - Margin * 3, EditWidth, TextHeight];

% max_edit
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;

% min_label
pos(end + 1, :) = pos(end - 1, :);
pos(end, 2) = pos(end, 2) - TextHeight - Margin;

% min_edit
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;

% thres_label
pos(end + 1, :) = pos(end - 1, :);
pos(end, 2) = pos(end, 2) - TextHeight - Margin;

% thres_edit
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;

% maxc_label
pos(end + 1, :) = pos(end - 1, :);
pos(end, 2) = pos(end, 2) - TextHeight - Margin;

% maxc_edit_r
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;
% maxc_edit_g
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;
% maxc_edit_b
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;

% minc_label
pos(end + 1, :) = pos(end - 3, :);
pos(end, 2) = pos(end, 2) - TextHeight - Margin;

% minc_edit_r
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;
% minc_edit_g
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;
% minc_edit_b
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;

% apply_btn
pos(end + 1, :) = pos(end - 2, :);
pos(end, 2) = pos(end, 2) - ButtonHeight - Margin;
pos(end, 3) = ButtonWidth;
pos(end, 4) = ButtonHeight;

% memo_label
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) - EditWidth - Margin;
pos(end, 2) = pos(end, 2) - ButtonHeight - Margin;
pos(end, 3) = EditWidth;
pos(end, 4) = TextHeight;

% memo_edit
pos(end + 1, :) = pos(end, :);
pos(end, 1) = pos(end, 1) + EditWidth + Margin;
pos(end, 2) = pos(end, 2) - ButtonHeight * 2 - Margin;
pos(end, 3) = ButtonWidth;
pos(end, 4) = ButtonHeight * 3;

% toggle_btn
pos(end + 1, :) = pos(end, :);
pos(end, 2) = Margin * 3 + ButtonHeight * 2;
pos(end, 4) = ButtonHeight;

% SaveFig_Btn
pos(end + 1, :) = pos(end, :);
pos(end, 2) = pos(end, 2) - ButtonHeight - Margin;

% SaveFigForPaper_Btn
pos(end + 1, :) = pos(end, :);
pos(end, 2) = pos(end, 2) - ButtonHeight - Margin;

UIh_names = fieldnames(UIh);
for n = 1:size(pos, 1) % UIh_names{1} is PropCon it self
  set(getfield(UIh, UIh_names{n + 1}), 'Position', pos(n, :));
end



%%

function colorbarh = SetColorbar(MP, CM, MinVa, MaxVa, DummyScale)
% 2009/10/07(Wed), 2011/09/02(Fri)
% Stupid trick for stupid color bar

colorbarh = findobj(MP, 'tag', 'Colorbar');

if (isempty(colorbarh))
  colorbarh = colorbar;
end

figure(get(colorbarh, 'Parent'));
colormap(CM);
yminmax = [MinVa MaxVa];
caxis(yminmax./DummyScale);
% --------------- HX ------------------------------------------------------
% set(colorbarh, 'YLim', yminmax);
% set(get(colorbarh, 'children'), 'Ydata', yminmax);

ytick_origin = get(colorbarh, 'YTick');
ytick_origin_num = length(ytick_origin);

newtick = linspace(MinVa, MaxVa, ytick_origin_num);
% set(colorbarh, 'YTick', newtick);
newtick = newtick / DummyScale;

% cstr = cell(1, length(newtick));
% for n = 1:length(newtick)
%   cstr{n} = sprintf('%.2f', newtick(n));
% end
% newtickc = char(cstr);
% 
% % Padding
% 
% for y = 1:size(newtickc, 1)
%   str = newtickc(y, :);
%   SpaceIndex = str == ' ';
%   character = str(~SpaceIndex);
%   space = str(SpaceIndex);
%   newtickc(y, :) = [space, character];
% end
% 
% set(colorbarh, 'YTickLabel', newtickc);
% --------------- HX ------------------------------------------------------


%%

function args = makeArgs(Data, Pcol1, Pcol2, Pcol3, Radius, Diameter, xall, yall, zall, ...
    Va, MaxVa, MinVa, CenterColors, nargin, RawData, DummyScale, CM)

args.Data     = Data;
args.Pcol1    = Pcol1; 
args.Pcol2    = Pcol2;
args.Pcol3    = Pcol3;
args.Radius   = Radius;
args.Diameter = Diameter;
args.xall     = xall;
args.yall     = yall;
args.zall     = zall;
args.Va       = Va;
args.MaxVa    = MaxVa;
args.MinVa    = MinVa;
args.CenterColors = CenterColors;
args.nargin   = nargin;
args.RawData  = RawData;
args.DummyScale = DummyScale;
args.CM = CM;



%%

function ApplyPropChange(h, event, args)

RawData = args.RawData;

fig_h = get(h, 'Parent');
new_max = get(findobj(fig_h, 'tag', 'max_edit'), 'string');
new_min = get(findobj(fig_h, 'tag', 'min_edit'), 'string');
thres = get(findobj(fig_h, 'tag', 'thres_edit'), 'string');
new_maxc_r = str2double(get(findobj(fig_h, 'tag', 'maxc_edit_r'), 'string'));
new_maxc_g = str2double(get(findobj(fig_h, 'tag', 'maxc_edit_g'), 'string'));
new_maxc_b = str2double(get(findobj(fig_h, 'tag', 'maxc_edit_b'), 'string'));
new_minc_r = str2double(get(findobj(fig_h, 'tag', 'minc_edit_r'), 'string'));
new_minc_g = str2double(get(findobj(fig_h, 'tag', 'minc_edit_g'), 'string'));
new_minc_b = str2double(get(findobj(fig_h, 'tag', 'minc_edit_b'), 'string'));

new_max = str2double(new_max);
new_min = str2double(new_min);

defaultColorMapRange = 64;
% args.CM = [
%   linspace(new_minc_r, new_maxc_r, defaultColorMapRange)', ...
%   linspace(new_minc_g, new_maxc_g, defaultColorMapRange)', ...
%   linspace(new_minc_b, new_maxc_b, defaultColorMapRange)'];
colormapeditor;
args.CM = get(gcf, 'ColorMap');
SetColorbar(fig_h, args.CM, new_min * args.DummyScale, new_max * args.DummyScale, args.DummyScale);

thres = str2double(thres);
PropCon_h = findobj(fig_h, 'tag', 'PropCon');
if isempty(thres)
  set(PropConr_h, 'UserData', true(1, length(RawData)));
else
  set(PropCon_h, 'UserData', RawData >= thres);
end
% Show summary in the matlab main window
summary = [[1:length(RawData)]', RawData', get(PropCon_h, 'UserData')']


RawData(RawData > new_max) = new_max;
RawData(RawData < new_min) = new_min;
ColorIndex = ...
    round((RawData - new_min) / (new_max - new_min) * ...
          (defaultColorMapRange - 1)) + 1; % 1 ~ defaultColorMapRange
NanI = isnan(args.Va);
args.CenterColors = nan(length(ColorIndex), 3);
args.CenterColors(~NanI, :) = args.CM(ColorIndex(~NanI), :);
% args.CenterColors = args.CM(ColorIndex, :);

doth = findobj(fig_h, 'tag', 'dot'); delete(doth);
DrawMain(args.Data, args.Pcol1, args.Pcol2, args.Pcol3, ...
         args.Radius, args.Diameter, args.xall, args.yall, args.zall, ...
         args.Va, args.MaxVa, args.MinVa, args.CenterColors, args.nargin);


%%

function DrawMain(Data, Pcol1, Pcol2, Pcol3, Radius, Diameter, ...
                  xall, yall, zall, ...
                  Va, MaxVa, MinVa, CenterColors, nargin_origin)

PropCon_h = findobj(gcf, 'tag', 'PropCon');
if isempty(get(PropCon_h, 'UserData'))
  ShowFlag = true(1, size(Data, 1));
else
  ShowFlag = get(PropCon_h, 'UserData');
end

for m = 1:length(Pcol1)
  if isequal(ShowFlag(m), true)
    
    I= (((Pcol1(m)+Diameter(m)) >= xall & ...
         xall >= (Pcol1(m)-Diameter(m))) & ...
        ((Pcol2(m)+Diameter(m)) >= yall & ...
         yall >= (Pcol2(m)-Diameter(m))) & ...
        ((Pcol3(m)+Diameter(m)) >= zall & ...
         zall >= (Pcol3(m)-Diameter(m))));
    XX = xall(I);
    YY = yall(I);
    ZZ = zall(I);

    R = nan(1, length(XX));
    for n = 1:length(XX)
      R(n) = [sqrt((Data((m),1)-XX(n))^2 + ...
                   (Data((m),2)-YY(n))^2 + ...
                   (Data((m),3)-ZZ(n))^2)];
    end

    Rcut = R <= Radius(m);
    % Rcircle=R(Rcut);

    Pxall=XX(Rcut);
    Pyall=YY(Rcut);
    Pzall=ZZ(Rcut);


    % -------------------------
    % -- Plot color sampling --
    % -------------------------

    % Rcut = (R >= Radius(m) -1 & R <= Radius(m) + 1);
    Samples = [XX(Rcut)' YY(Rcut)' ZZ(Rcut)'];

    if isempty(Samples)
      fprintf('%d: empty.\n', m);
      continue;
    end
    
    BrainColorMap = flipud(bone(69));
    BrainCentroid = mean([xall' yall' zall'], 1);
    % D = round(DistBtw(BrainCentroid, Samples)) - 48;
    % EdgeColor = mean(BrainColorMap(D, :));

    % Clearing
    % clear I  R  XX  YY  ZZ  n  Rcut Rcircle

    % We'll plot circle of points round our points colored according color
    % intensity value (Va) - Activation; colorrange has range MinVa to MaxVa
    % - check last 2 row in excel file

    hold on;

    % -------------------------------------
    % Labeling for each estimated positions
    % -------------------------------------

    NearestCortP = ...
        DistBtw([Pcol1(m), Pcol2(m), Pcol3(m)], [xall' yall' zall'], 1);
    TextXYZ = [NearestCortP(1), NearestCortP(2), NearestCortP(3)] + ...
              [Pcol1(m), Pcol2(m), Pcol3(m)] / ...
              norm([Pcol1(m), Pcol2(m), Pcol3(m)]) * 10;
    TH = text(TextXYZ(1), TextXYZ(2), TextXYZ(3), int2str(m), ...
              'Color', 'black', ...
              'FontName', 'FixedWidth', ...
              'Visible', 'Off', ...
              'BackgroundColor', [.7 .9 .7]);
    
    % If value is Nan just skip drawing,
    if sum(isnan(CenterColors(m, :))) > 0
      continue;
    end
            
    % Here we'll plot points according colorrange
    if (Va(m) <= MaxVa) && (Va(m) >= MinVa)
      Circle = [Pxall' Pyall' Pzall'];

      Center = [Pcol1(m) Pcol2(m) Pcol3(m)];
      CenterColor = CenterColors(m, :);

      MS = 2;
      
      if nargin_origin < 3 % If 'SimpleFlag' is not active: normal drawing

        for j = 1 : size(Circle, 1)
          LocalD = DistBtw(Center, Circle(j, :));

          D = DistBtw(BrainCentroid, Circle(j, :));
          SurfaceColor = BrainColorMap(round(D)-48, :);

          SurfaceColorRatio = LocalD / Radius(m);
          PatchColorRatio = 1 - SurfaceColorRatio;

          KeepRatio = 0.7;

          KeepRatio = 1 - KeepRatio;
          if PatchColorRatio > KeepRatio;
            PlotColor = CenterColor;
          else
            PatchColorRatio = PatchColorRatio .* (1 / KeepRatio);
            SurfaceColorRatio = 1 - PatchColorRatio;
            PlotColor = SurfaceColor .* SurfaceColorRatio + ...
                CenterColor .* PatchColorRatio;
          end

          % ---------------------------------------------
          % Correction of color value.
          % More than 1 will be 1, less than 0 will be 0.
          % ---------------------------------------------

          Sel = PlotColor(:, :) > 1;
          PlotColor(Sel) = 1;

          Sel = PlotColor(:, :) < 0;
          PlotColor(Sel) = 0;


          % --------
          % Plotting
          % --------

          ph = plot3(Circle(j,1), Circle(j,2), Circle(j,3), ...
                     's', 'Color', PlotColor, 'MarkerFaceColor', PlotColor, 'MarkerSize', MS);
          set(ph, 'tag', 'dot');
        end
        clear j;

      else % If 'SimpleFlag' is active: simple drawing

        PlotColor = CenterColor;
        ph = plot3(Circle(:,1), Circle(:,2), Circle(:,3), ...
                   's', 'Color', PlotColor, 'MarkerFaceColor', PlotColor, 'MarkerSize', MS);
        set(ph, 'tag', 'dot');
      end
      
    end
  end
end



%%

function ToggleLabel(h, event)
TXTH = findobj(gcf, 'Type', 'text');
if strcmp(get(TXTH(1), 'Visible'), 'on') == 1
  VisibleFlag = 'off';
else
  VisibleFlag = 'on';
end

set(TXTH, ...
    repmat({'visible'}, 1, length(TXTH)), ...
    repmat({VisibleFlag}, 1, length(TXTH)));


%%

% function ChangeColor(h, eventdata)
% Handles = get(gcf, 'UserData');
% C = uisetcolor('Set color for NaN plot');
% set(Handles.NaN, 'Color', C, 'Visible', 'on');
% set(Handles.X, 'Visible', 'off'); % Delete 'X' symbol


%%

function [D_List, Fruit] = DistBtw ( MA, MB, Num )

% DISTBTW - Computes distance between vectors.
%
% USAGE.
%   [D_List, Fruit] = DistBtw ( MA, MB, Num )
%
% DESCRIPTION.
%   This function computes distances between two vectors or vector and
%   matrix or two matrix with the same size. If the input is only single
%   matrix (e.g. sorted apical points creating arch ) it computes
%   distances & cumulative distances between matrix points.
%   If there are three inputs (first input is vector, second one is matrix,
%   third one is number) it selects number of matrix points
%   closest to the vector.
%
% INPUTS.
%   MA is vector or matrix [n,3], e.g. MA = [ x, y, z ];
%   MB is vector or matrix [n,3]
%   Num is number determining the number for the selection of the closest
%   points from matrix MB to vector MA
%
% OUTPUTS.
%   D_List is [n,1] list of distances or coordinates of the closest points.
%   Fruit is [n,1] list of distances or cumulative distances.

%   Brain Research Group
%   Food Physics Laboratory, Division of Food Function,
%   National Food Research Institute,  Tsukuba,  Japan
%   WEB: http://brain.job.affrc.go.jp,  EMAIL: dan@nfri.affrc.go.jp
%   AUTHOR: Valer Jurcak,   DATE: 12.jan.2006,    VERSION: 1.3
%-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-


% CHECK INPUTS & OUTPUTS
% ..............................................................  ^..^ )~
% Check size
if nargin == 1 & size(MA,1) < 3
  error('For one input minimum size of matrix is [3,3].')
end

if nargin == 2
  sA = size(MA,1); sB = size(MB,1);
  if sA < 2 | sB < 2 | sA==sB
    % OK
  else
    error('Can compute distance between "vector & vector", "vector & matrix" or "matrix & matrix" with the same size.')
  end
end

if nargout > 2
  error('Too many output arguments.');
end


% Keep [n,3] size
if nargin == 1
  MA = MA(:,1:3);
end

% Keep [n,3] size
if nargin == 2 || nargin == 3
  MA = MA(:,1:3);
  MB = MB(:,1:3);
end


% MAKE OUTPUT
% ..............................................................  ^..^ )~
Fruit = [];



% ONE INPUT -> COMPUTES DISTANCES AND CUMULATIVE DISTANCES BETWEEN
% SORTED POINTS e.g. apical points which create arch
% ..............................................................  ^..^ )~
if nargin == 1

  % Distances between points in MA matrix
  for n = 1 : size(MA, 1) - 1
    PreD = MA(n,:) - MA(n+1,:);
    PreD2 = PreD.^2;
    PreD3 = sum(PreD2, 2);
    PreD4(n,1) = PreD3 .^ 0.5;
  end
  D_List = PreD4;
  clear n

  % Cumulative distances
  Fruit = zeros(size(MA,1),1);
  Fruit(2:end) = PreD4;
  Fruit = cumsum(Fruit); % cumulative distances
end



% TWO INPUTS -> COMPUTE DISTANCES BETWEEN (VECTOR or MATRIX) & MATRIX
% ..............................................................  ^..^ )~
if nargin == 2

  % Check size
  if size(MA,1) > size(MB,1);
    DxM = MB;  DxN = MA;
  else
    DxM = MA;  DxN = MB;
  end

  % Distances between matrix & matrix
  if size(DxM,1) == size(DxN,1)
    PreD = DxN - DxM;
    PreD2 = PreD.^2;
    PreD3 = sum(PreD2, 2);
    D_List = PreD3 .^ 0.5; % Now distance is found
  else
    % Distances between vector & matrix
    Echo = repmat(DxM, size(DxN,1), 1);
    PreD  = DxN - Echo;
    PreD2 = PreD.^2;
    PreD3 = sum(PreD2, 2);
    D_List = PreD3 .^ 0.5; % Now distance is found
  end
end



% THREE INPUTS -> SELECT Num OF CLOSEST VECTORS TO MA
% ..............................................................  ^..^ )~
if nargin == 3

  % Distances between vector & matrix
  Echo = repmat( MA, size(MB, 1), 1 );
  PreD  = MB - Echo;
  PreD2 = PreD.^2;
  PreD3 = sum(PreD2, 2);

  PreD4 = PreD3 .^ 0.5; % Now distance is found

  % Sort matrix according to distances
  MatRiX = [MB, PreD4]; % add forth column of distances
  MatRiX = sortrows(MatRiX, 4); % sorting
  D_List = MatRiX(1:Num, 1:3); % number of closest points
  Fruit = MatRiX(1:Num, 4); % actual distances
end


%%

function SaveFig(h, event)

[filename, pathname] = uiputfile('*.fig', 'Save figure as ...');
if isequal(filename,0) || isequal(pathname,0)
  disp('User pressed cancel')
else
  set(gcf, 'toolbar', 'figure', 'menubar', 'figure');
  saveas(gcf, fullfile(pathname, filename), 'fig');
  set(gcf, 'toolbar', 'none', 'menubar', 'none');
end


%%

function SaveFigForPaper(h, event)
% set(gca,'color',[1 1 1]);
% 
% export_fig(gca,'b.tif','-m2.5');

[filename, pathname] = uiputfile('*.png', 'Save figure as PNG ...');
if isequal(filename,0) || isequal(pathname,0)
  disp('User pressed cancel')
else
  f1 = gcf; CM = colormap;
  ch = get(f1, 'children');
  f2 = figure; set(f2, 'NumberTitle', 'off', 'Name', 'tmp', 'Visible', 'off');
  
  str = 'Saving figure. Just a moment please...';
  mbh = msgbox(str, 'Saving figure', 'warn');
  mbch = get(mbh, 'children');
  delete(mbch(end)); % Delete 'OK' button only
  drawnow;
  
  copyobj(ch, f2);

  figure(f2);
  set(f2, 'color', [1 1 1]); % Set background color of figure white.

  mah = findobj(f2, 'Tag', 'MainAxis');
  mah_pos = get(mah, 'Position'); mah_pos(3) = 0.8;
  set(mah, 'color', [1 1 1], ...
           'Xcolor', [0 0 0], 'Ycolor', [0 0 0], 'Zcolor', [0 0 0], ...
           'Position', mah_pos);

  cbh = findobj(f2, 'Tag', 'Colorbar');
  cbh_pos = get(cbh, 'Position'); cbh_pos(1) = 0.9;
  set(cbh, 'color', [0 0 0], ...
           'Xcolor', [0 0 0], 'Ycolor', [0 0 0], 'Zcolor', [0 0 0], ...
           'Position', cbh_pos);
  colormap(CM);
  
  % Delete Property Controller on the right
  pch = findobj(f2, 'Tag', 'PropCon');
  delete(pch);
  
  % Delete all push button on the right
  bh = findobj(f2, 'Style', 'pushbutton');
  delete(bh);
  
  % Delete all text label on the right
  th = findobj(f2, 'Style', 'text');
  delete(th);
  
  saveas(f2, fullfile(pathname, filename), 'png');
  close(f2);
  close(mbh);
end


function DrawBrain(Mat,InputData)

% Init
  
screen_size = get(0, 'ScreenSize');
screen_width = screen_size(3);
screen_height = screen_size(4);

figwidth = 1000;
Margin = 50;

gcfcolor = [1 1 1];
gcacolor = [0 0 0];
gridcolor = [1 1 1];

H = Mat;
scale = 69;
colors = flipud(bone(scale));

center = mean(H, 1);
dist = round(DistBtw(center, H)) - 48;

% Visualization

figure; hold on;
for j = 1:scale
  index = dist == j;
  region = H(index, :);
  plot3(region(:,1), region(:,2), region(:,3), ...
        's', 'MarkerSize', 2, ...
        'Color', colors(j, :), 'MarkerFaceColor', colors(j, :));
end

set(gcf, 'color', gcfcolor);
figpos = get(gcf, 'position');
figpos(1) = Margin;
figpos(2) = screen_height - figpos(4) - Margin;
figpos(3) = figwidth;
set(gcf, 'position', figpos);

set(gca, 'color', gcacolor);
set(gca, 'XColor', gridcolor);
set(gca, 'YColor', gridcolor);
set(gca, 'ZColor', gridcolor);
% Set appropriate margin
set(gca, 'Units', 'Normalized', ...
         'Position', [0.1, 0.1, 0.5, 0.8]);
set(gca, 'Tag', 'MainCanvas');
% grid on;

view(-37.5, 30);
axis off; % ---------------------------------------------------------------
% axis equal vis3d; % -----------------------------------------------------