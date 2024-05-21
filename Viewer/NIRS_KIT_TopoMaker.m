function varargout = NIRS_KIT_TopoMaker(varargin)
% NIRS_KIT_TOPOMAKER MATLAB code for NIRS_KIT_TopoMaker.fig
%      NIRS_KIT_TOPOMAKER, by itself, creates a new NIRS_KIT_TOPOMAKER or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_TOPOMAKER returns the handle to a new NIRS_KIT_TOPOMAKER or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_TOPOMAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT_TOPOMAKER.M with the given input arguments.
%
%      NIRS_KIT_TOPOMAKER('Property','Value',...) creates a new NIRS_KIT_TOPOMAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_TopoMaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_TopoMaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_TopoMaker

% Last Modified by GUIDE v2.5 14-Dec-2019 19:05:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_TopoMaker_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_TopoMaker_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NIRS_KIT_TopoMaker is made visible.
function NIRS_KIT_TopoMaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT_TopoMaker (see VARARGIN)

% Choose default command line output for NIRS_KIT_TopoMaker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_TopoMaker wait for user response (see UIRESUME)
% uiwait(handles.NR_TopoMaker);
set(handles.save,'userdata',true);

set(handles.channel,'enable','off');
set(handles.source,'enable','off');
set(handles.detector,'enable','off');
set(handles.doneColor,'enable','off');
set(handles.clearColor,'enable','off');

set(handles.autoMethod,'enable','off');
set(handles.autoLabel,'enable','off');
set(handles.autoMethod,'enable','off');

set(handles.removeProbe,'enable','off');
set(handles.preview,'enable','off');
set(handles.edit,'enable','off');
set(handles.probe,'userdata',0);



probeListMenu = uicontextmenu;
set(handles.probeList, 'UIContextMenu',probeListMenu);
uimenu(probeListMenu, 'Label', 'Rename probe','Callback', {@RenameFcn,handles});


function RenameFcn(hObject, eventdata, handles)

newName = cell2mat(inputdlg('Enter new name',''));
if ~isempty(newName)
    oldList = get(handles.probeList,'String');
    k = get(handles.probeList,'value');
    oldList{k} = newName;
    set(handles.probeList,'String',oldList);
end



% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_TopoMaker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function meshN_Callback(hObject, eventdata, handles)
% hObject    handle to meshN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of meshN as text
%        str2double(get(hObject,'String')) returns contents of meshN as a double


% --- Executes during object creation, after setting all properties.
function meshN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meshN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in saveProbe.
function saveProbe_Callback(hObject, eventdata, handles)
% hObject    handle to saveProbe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function meshColumn_Callback(hObject, eventdata, handles)
% hObject    handle to meshColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meshColumn as text
%        str2double(get(hObject,'String')) returns contents of meshColumn as a double


% --- Executes during object creation, after setting all properties.
function meshColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meshColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newProbe.
function newProbe_Callback(hObject, eventdata, handles)
% hObject    handle to newProbe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newSizeN = str2num(get(handles.meshN,'string'));
if newSizeN>25
    errordlg('The max size should not be greater than 25 !','error')
    return;
end

while 1
    probeName = inputdlg('Enter probe name:');
    if isempty(probeName)
        return;
    else
        if isempty(cell2mat(probeName))
            h = errordlg('You must enter a name','Warning');
            waitfor(h);
        else
            allMatrix = get(handles.probeList,'userdata');
            if isempty(allMatrix) 
                set(handles.probe,'userdata',1);
            else
                probeState.channelState = get(handles.channel,'enable');
                probeState.sourceState  = get(handles.source,'enable');
                probeState.detectorState =  get(handles.detector,'enable');
                probeState.clearColorState = get(handles.clearColor,'enable');
                probeState.doneColorState =  get(handles.doneColor,'enable');
                probeState.clearLabelState = get(handles.clearLabel,'enable');
                probeState.autoLabelState =  get(handles.autoLabel,'enable');
                probeState.autoMethodState = get(handles.autoMethod,'enable');
                s = get(handles.probe,'userdata');
                allProbeState = get(handles.NR_TopoMaker,'userdata');
                allProbeState{s} = probeState;
                set(handles.NR_TopoMaker,'userdata',allProbeState);
            end
            break;
        end
    end
end

userdata = get(handles.meshBox,'UserData');
if ~isempty(userdata)
    for buttonHandle = userdata.buttonHandles
        delete(buttonHandle);
    end
end
oldList = get(handles.probeList,'String');
N = str2num(get(handles.meshN,'string'));
if isempty(oldList)
    theList = probeName;
    allMatrix={zeros(N,N)};
    set(handles.probeList,'userdata',allMatrix);
    set(handles.probeList,'value',1);
else
    if ~iscell(oldList)
        theList = [oldList;probeName];
        set(handles.probeList,'value',2);
    else
        n = length(oldList);
        theList = [oldList;probeName];
        set(handles.probeList,'value',n+1);
    end
    allMatrix = get(handles.probeList,'userdata');
    allMatrix{end+1} = zeros(N,N);
    set(handles.probeList,'userdata',allMatrix);
end
set(handles.probeList,'String',theList);
set(handles.removeProbe,'enable','on');
set(handles.preview,'enable','on');
set(handles.edit,'enable','on');
set(handles.channel,'enable','on');
set(handles.source,'enable','on');
set(handles.detector,'enable','on');
set(handles.clearColor,'enable','on');
set(handles.doneColor,'enable','on');

set(handles.autoMethod,'enable','off');
set(handles.autoLabel,'enable','off');
set(handles.autoMethod,'enable','off');

s = get(handles.probeList,'value');
set(handles.probe,'userdata',s);

NR_generateMesh(handles);

% --- Executes on selection change in probeList.
function probeList_Callback(hObject, eventdata, handles)
% hObject    handle to probeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
k = get(handles.probeList,'value');
if k == get(handles.probe,'userdata');
    return;
end
oldList = get(handles.probeList,'String');
if isempty(oldList)
    return;
end
if ~iscell(oldList)
    return;
else
    probeState.channelState = get(handles.channel,'enable');
    probeState.sourceState  = get(handles.source,'enable');
    probeState.detectorState =  get(handles.detector,'enable');
    probeState.clearColorState = get(handles.clearColor,'enable');
    probeState.doneColorState =  get(handles.doneColor,'enable');
    probeState.clearLabelState = get(handles.clearLabel,'enable');
    probeState.autoLabelState =  get(handles.autoLabel,'enable');
    probeState.autoMethodState = get(handles.autoMethod,'enable');
    s = get(handles.probe,'userdata');
    allProbeState = get(handles.NR_TopoMaker,'userdata');
    allProbeState{s} = probeState;
    set(handles.NR_TopoMaker,'userdata',allProbeState);
    %
    k = get(handles.probeList,'value');
    allProbeState = get(handles.NR_TopoMaker,'userdata');
    probeState = allProbeState{k};
    set(handles.channel,'enable',probeState.channelState);
    set(handles.source,'enable',probeState.sourceState);
    set(handles.detector,'enable',probeState.detectorState);
    set(handles.clearColor,'enable',probeState.clearColorState);
    set(handles.doneColor,'enable',probeState.doneColorState);
    set(handles.clearLabel,'enable',probeState.clearLabelState);
    set(handles.autoLabel,'enable',probeState.autoLabelState);
    set(handles.autoMethod,'enable',probeState.autoMethodState);
end

%%%    

userdata = get(handles.meshBox,'UserData');
if ~isempty(userdata)
    for buttonHandle = userdata.buttonHandles
        delete(buttonHandle);
    end
end
k = get(handles.probeList,'value');
set(handles.probe,'userdata',k);
allMatrix = get(handles.probeList,'userdata');
meshN = allMatrix{k};
N = length(meshN);
set(handles.meshN,'string',num2str(N));
NR_generateMesh(handles);
meshBoxData=get(handles.meshBox,'UserData');
buttonHandles = meshBoxData.buttonHandles;
for i = 1:N
    for j = 1:N
        obj = buttonHandles((i-1)*N+j);
        if -1999 <= meshN(i,j) && meshN(i,j)<= -1000
            set(obj,'backgroundcolor','r');
            if meshN(i,j) ~= -1000
                set(obj,'foregroundcolor',[1 1 1]);
                set(obj,'String',num2str(-(meshN(i,j)+1000)));
            end
        end
        if -2999 <= meshN(i,j) && meshN(i,j)<= -2000
            set(obj,'backgroundcolor','b');
            if meshN(i,j) ~= -2000
                set(obj,'foregroundcolor',[1 1 1]);
                set(obj,'String',num2str(-(meshN(i,j)+2000)));
            end
        end
        if  meshN(i,j)>= 1000
            set(obj,'backgroundcolor','g');
            if meshN(i,j) ~= 1000
                set(obj,'foregroundcolor','k');
                set(obj,'String',num2str(meshN(i,j)-1000));
            end
        end
    end
end
meshBoxData.meshN = meshN;
meshBoxData.currentNum =  NR_findCurrentNum(meshN);
set(handles.meshBox,'UserData',meshBoxData);
% Hints: contents = cellstr(get(hObject,'String')) returns probeList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from probeList


% --- Executes during object creation, after setting all properties.
function probeList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to probeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in removeProbe.
function removeProbe_Callback(hObject, eventdata, handles)
% hObject    handle to removeProbe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oldList = get(handles.probeList,'String');
if isempty(oldList)
    return;
end
check = questdlg('Are you sure to remove this probe?','','Yes','No','Yes');
if strcmp(check,'No')
    return;
end
oldList = get(handles.probeList,'String');
if isempty(oldList)
    return;
else
    allMatrix = get(handles.probeList,'userdata');
    if 1 == length(allMatrix)
        currentNum = [0,0,0];
    else
        currentNum = NR_findCurrentNum(allMatrix{end-1});
    end
    meshBoxData.currentNum = currentNum;
    if ~iscell(oldList)
        n=1;
    else
        n = length(oldList);
    end
    k = get(handles.probeList,'value');
    if k<n
        theList = oldList([1:k-1,k+1:end]);
        set(handles.probeList,'value',k);
    end
    if k == n
        theList = oldList(1:k-1);
        if ~isempty(theList)
            set(handles.probeList,'value',k-1);
        end
    end
    allMatrix = get(handles.probeList,'userdata');
    allMatrix = allMatrix([1:k-1,k+1:end]);
    set(handles.probeList,'userdata',allMatrix);
    if 1==n
        userdata = get(handles.meshBox,'UserData');
        if ~isempty(userdata)
            for buttonHandle = userdata.buttonHandles
                delete(buttonHandle);
            end
        end
        set(handles.meshBox,'UserData','');
    end
end
set(handles.probeList,'String',theList);
probeList_Callback(handles.probeList, 0, handles)

% --- Executes on button press in preview.
function preview_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% NR_preview(handles);
NR_preview2(handles);


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
defaultSaveDir = which('NIRS_KIT');
index_dir=fileparts(defaultSaveDir);
defaultSaveDir=fullfile(index_dir,'probe2d');
[filename, pathname] = uiputfile('*.mat', 'Save 2-D probeSet as',defaultSaveDir);
while(1)
    if 0 == pathname
        return;
    else
        load('NIRS_REST_probeSetList.mat');
        valid = 1;
        for i = 1:length(NIRS_REST_probeSetList)
            if strcmp(filename(1:end-4),NIRS_REST_probeSetList{i})
                h = errordlg('Cannot use system configuration!','Warning');
                waitfor(h);
                [filename, pathname] = uiputfile('*.mat', 'Save 2-D probeSet as',defaultSaveDir);
                valid=0;
                break;
            end
        end
        if valid
            break;
        end
    end
end
% this while loop is used to check whether your new probe name conflict with system configuration
% when you need to updata the system configuration, comment this loop, then
% you can save. 
% remember to un-comment after the updata


probeNames = get(handles.probeList,'string');
if isempty(probeNames)
   errordlg('No probe');
   return;
end
if ~iscell(probeNames)
    N=1;
else
    N = length(probeNames);
end
probeSets={};
allMatrix = get(handles.probeList,'userdata');
for i=1:N
    probeSets{i}.name = probeNames(i);
    probeSets{i}.probeSet = allMatrix{i};
end

set(handles.save,'userdata',[pathname filename]);
save([pathname filename], 'probeSets');


% --- Executes during object creation, after setting all properties.
function NR_TopoMaker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NR_TopoMaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in preview.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on probeList and none of its controls.
function probeList_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to probeList (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over probeList.
function probeList_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to probeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RootDirectory = which('NIRS_KIT');
index_dir=fileparts(RootDirectory);
defaultSetDir=fullfile(index_dir,'Sample_Data','Temp_2D_ProbeSet');
[filename, pathname] = uigetfile(fullfile(defaultSetDir,'*.mat'));
if ischar(filename)
    % clear 
    userdata = get(handles.meshBox,'UserData');
    if ~isempty(userdata)
        for buttonHandle = userdata.buttonHandles
            delete(buttonHandle);
        end
    end
    set(handles.meshBox,'userdata',[]);
    set(handles.probeList,'userdata',[]);
    set(handles.probeList,'string','');
    % clear
    load([pathname filename]);
    probeList = [];
    allMatrix = [];
    for i=1:length(probeSets);
        probeList = [probeList probeSets{i}.name];
        allMatrix = [allMatrix {probeSets{i}.probeSet}];
    end
    set(handles.probeList,'string',probeList);
    set(handles.probeList,'userdata',allMatrix);
    % 
    k = 1;
    meshN = allMatrix{k};
    N = length(meshN);
    set(handles.meshN,'string',length(meshN));
    NR_generateMesh(handles);
    meshBoxData=get(handles.meshBox,'UserData');
    buttonHandles = meshBoxData.buttonHandles;
    for i = 1:N
        for j = 1:N
            obj = buttonHandles((i-1)*N+j);
            if -1999 <= meshN(i,j) && meshN(i,j)<= -1000
                set(obj,'backgroundcolor','r');
                if meshN(i,j) ~= -1000
                    set(obj,'foregroundcolor',[1 1 1]);
                    set(obj,'String',num2str(-(meshN(i,j)+1000)));
                end
            end
            if -2999 <= meshN(i,j) && meshN(i,j)<= -2000
                set(obj,'backgroundcolor','b');
                if meshN(i,j) ~= -2000
                    set(obj,'foregroundcolor',[1 1 1]);
                    set(obj,'String',num2str(-(meshN(i,j)+2000)));
                end
            end
            if  meshN(i,j)>= 1000
                set(obj,'backgroundcolor','g');
                if meshN(i,j) ~= 1000
                    set(obj,'foregroundcolor','k');
                    set(obj,'String',num2str(meshN(i,j)-1000));
                end
            end
        end
    end
    meshBoxData.currentNum = NR_findCurrentNum(meshN);
    meshBoxData.meshN = meshN;
    set(handles.meshBox,'UserData',meshBoxData);
    set(handles.save,'userdata',[pathname filename]);
    set(handles.channel,'enable','off');
    set(handles.source,'enable','off');
    set(handles.detector,'enable','off');
    set(handles.doneColor,'enable','off');
    set(handles.clearColor,'enable','off');
    set(handles.removeProbe,'enable','on');
    set(handles.preview,'enable','on');
    set(handles.edit,'enable','on');

    set(handles.probe,'userdata',1);
    set(handles.probeList,'value',1);
    probeState.channelState = get(handles.channel,'enable');
    probeState.sourceState  = get(handles.source,'enable');
    probeState.detectorState =  get(handles.detector,'enable');
    probeState.clearColorState = get(handles.clearColor,'enable');
    probeState.doneColorState =  get(handles.doneColor,'enable');
    probeState.clearLabelState = get(handles.clearLabel,'enable');
    probeState.autoLabelState =  get(handles.autoLabel,'enable');
    probeState.autoMethodState = get(handles.autoMethod,'enable');
    allProbeState = get(handles.NR_TopoMaker,'userdata');
    for i=1:length(probeSets);
        allProbeState{i} = probeState;
    end
	set(handles.NR_TopoMaker,'userdata',allProbeState);

%     set(handles.autoMethod,'enable','on');
%     set(handles.autoLabel,'enable','on');
%     set(handles.clearLabel,'enable','on');
end



% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
isSave = get(handles.save,'userdata');
if ~isSave
    check = questdlg('Do you need to save the change before exit?','','Yes','No','Cancel','Yes');
    if strcmp(check,'Yes')
        NR_DataManager = findobj('Tag','NR_DataManager');
        if ~isempty(NR_DataManager)
            DataManagerHandles = guihandles(NR_DataManager);
            inpath2d = get(handles.save,'userdata');
            set(DataManagerHandles.inpath2d,'string',inpath2d);
            set(DataManagerHandles.isProbe2d,'value',1);
        end
        save_Callback(handles.save,[],handles);
        close(gcf);
    end
    if strcmp(check,'No')
        close(gcf);
    end
else   
    close(gcf);
end

% --- Executes on button press in resizeMesh.
function resizeMesh_Callback(hObject, eventdata, handles)
% hObject    handle to resizeMesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if a new number is entered,
newSizeN = str2num(get(handles.meshN,'string'));
if newSizeN>25
    errordlg('The max size should not be greater than 25 !','error')
    return;
end
% step 1: generate new matrix
meshBoxData=get(handles.meshBox,'UserData');
meshN = meshBoxData.meshN;
currentNum = meshBoxData.currentNum;
if length(meshN) == newSizeN
    return;
end
if newSizeN > length(meshN) 
    meshN(newSizeN,newSizeN) = 0;
end
if newSizeN < length(meshN)
    [an,index]=find(sum(meshN~=0,1)>0);
    if isempty(index)
        newSizeColumn = newSizeN;
    else
        newSizeColumn = index(end);
    end
    [an,index]=find(sum(meshN~=0,2)'>0);
    if isempty(index)
        newSizeRow = newSizeN;
    else
        newSizeRow = index(end);
    end
    if newSizeN < max(newSizeColumn,newSizeRow)
        h = errordlg(['Wrong size,the size should be at least ' num2str(max(newSizeColumn,newSizeRow))]);
        waitfor(h);
        set(handles.meshN,'string',num2str(length(meshN)));
        return;
    end
    meshN=meshN(1:newSizeN,1:newSizeN);
end
% step 2: reLoad in new mesh
% clear 
meshBoxData = get(handles.meshBox,'UserData');
if ~isempty(meshBoxData)
    for buttonHandle = meshBoxData.buttonHandles
        delete(buttonHandle);
    end
end
set(handles.meshBox,'userdata',[]);
% generate new mesh
NR_generateMesh(handles);
meshBoxData=get(handles.meshBox,'UserData');
buttonHandles = meshBoxData.buttonHandles;
for i = 1:newSizeN
    for j = 1:newSizeN
        obj = buttonHandles((i-1)*newSizeN+j);
        if -1999 <= meshN(i,j) && meshN(i,j)<= -1000
            set(obj,'backgroundcolor','r');
            if meshN(i,j) ~= -1000
                set(obj,'foregroundcolor',[1 1 1]);
                set(obj,'String',num2str(-(meshN(i,j)+1000)));
            end
        end
        if -2999 <= meshN(i,j) && meshN(i,j)<= -2000
            set(obj,'backgroundcolor','b');
            if meshN(i,j) ~= -2000
                set(obj,'foregroundcolor',[1 1 1]);
                set(obj,'String',num2str(-(meshN(i,j)+2000)));
            end
        end
        if  meshN(i,j)>= 1000
            set(obj,'backgroundcolor','g');
            if meshN(i,j) ~= 1000
                set(obj,'foregroundcolor','k');
                set(obj,'String',num2str(meshN(i,j)-1000));
            end
        end
    end
end
meshBoxData.meshN = meshN;
meshBoxData.currentNum = currentNum;
set(handles.meshBox,'UserData',meshBoxData);
k = get(handles.probeList,'value');
allMatrix = get(handles.probeList,'userdata');
allMatrix{k}=meshN;
set(handles.probeList,'userdata',allMatrix);


% --- Executes on button press in doneColor.
function doneColor_Callback(hObject, eventdata, handles)
% hObject    handle to doneColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check = questdlg('Painting will not be able to be changed! Continue?','Tips','Yes','No','Yes');
if strcmp(check,'Yes')
    set(handles.channel,'enable','off');
    set(handles.source,'enable','off');
    set(handles.detector,'enable','off');
    set(handles.clearColor,'enable','off');
    set(handles.doneColor,'enable','off');
    
    set(handles.autoMethod,'enable','on');
    set(handles.autoLabel,'enable','on');
    set(handles.autoMethod,'enable','on');
end



% --- Executes on button press in clearColor.
function clearColor_Callback(hObject, eventdata, handles)
% hObject    handle to clearColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check = questdlg('This will clear all probe configuration, continue?','','Yes','No','No');
if strcmp(check,'No')
    return;
end

meshBoxData = get(handles.meshBox,'UserData');
meshN = meshBoxData.meshN;
N = length(meshN);
buttonHandles = meshBoxData.buttonHandles;
for i = 1:N
    for j = 1:N
        obj = buttonHandles((i-1)*N+j);
        set(obj,'backgroundcolor',[1 1 1]);
        meshN(i,j) = 0;
    end
end
meshBoxData.currentNum = [0 0 0];
meshBoxData.meshN = meshN;
set(handles.meshBox,'UserData',meshBoxData);

k = get(handles.probeList,'value');
allMatrix = get(handles.probeList,'userdata');
allMatrix{k} = meshBoxData.meshN;
set(handles.probeList,'userdata',allMatrix);



% --- Executes on button press in edit.
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check = questdlg('This will clear all the labels and start to re-paint the probe, continue?','Warning','Yes','No','Yes');
if strcmp(check,'Yes')
    meshBoxData = get(handles.meshBox,'UserData');
    meshN = meshBoxData.meshN;
    N = length(meshN);
    buttonHandles = meshBoxData.buttonHandles;
    for i = 1:N
        for j = 1:N
            obj = buttonHandles((i-1)*N+j);
            set(obj,'String','');
            if -1999 <= meshN(i,j) && meshN(i,j)< -1000
                meshN(i,j) = -1000;
            end
            if -2999 <= meshN(i,j) && meshN(i,j)< -2000
                meshN(i,j) = -2000;
            end
            if  meshN(i,j)> 1000
                meshN(i,j) = 1000;
            end
        end
    end
    meshBoxData.currentNum = [0 0 0];
    meshBoxData.meshN = meshN;
    set(handles.meshBox,'UserData',meshBoxData);
    set(handles.channel,'enable','on');
    set(handles.source,'enable','on');
    set(handles.detector,'enable','on');
    set(handles.doneColor,'enable','on');
    set(handles.clearColor,'enable','on');
    
    set(handles.autoMethod,'enable','off');
    set(handles.autoLabel,'enable','off');
    set(handles.autoMethod,'enable','off');  
end


% --- Executes on button press in doneColor.
function donePainting_Callback(hObject, eventdata, handles)
% hObject    handle to doneColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in autoMethod.
function autoMethod_Callback(hObject, eventdata, handles)
% hObject    handle to autoMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns autoMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from autoMethod


% --- Executes during object creation, after setting all properties.
function autoMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to autoMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in clearLabel.
function clearLabel_Callback(hObject, eventdata, handles)
% hObject    handle to clearLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
meshBoxData = get(handles.meshBox,'UserData');
meshN = meshBoxData.meshN;
currentNumMesh = NR_findCurrentNum(meshN);
if 0< max(currentNumMesh)
    check = questdlg('This will clear current probe labels, continue?','','Yes','No','No');
    if strcmp(check,'No')
        return;
    end
end
buttonHandles = meshBoxData.buttonHandles;
N = length(meshN);
for i = 1:N
    for j = 1:N
        obj = buttonHandles((i-1)*N+j);
        set(obj,'String','');
        if -1999 <= meshN(i,j) && meshN(i,j)< -1000
            meshN(i,j) = -1000;
        end
        if -2999 <= meshN(i,j) && meshN(i,j)< -2000
            meshN(i,j) = -2000;
        end
        if  meshN(i,j)> 1000
            meshN(i,j) = 1000;
        end
    end
end
    
k = get(handles.probeList,'value');
allMatrix = get(handles.probeList,'userdata');
allMatrix{k} = meshN;
set(handles.probeList,'userdata',allMatrix);

meshBoxData.currentNum = NR_findCurrentNumAll(allMatrix);
meshBoxData.meshN = meshN;
set(handles.meshBox,'UserData',meshBoxData);


% --- Executes on button press in autoLabel.
function autoLabel_Callback(hObject, eventdata, handles)
% hObject    handle to autoLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% clear label
clearLabel_Callback(hObject, 0, handles)
%% auto Label
methodK = get(handles.autoMethod,'value');
meshBoxData = get(handles.meshBox,'UserData');
meshN = meshBoxData.meshN;
buttonHandles = meshBoxData.buttonHandles;
allMatrix = get(handles.probeList,'userdata');
meshN = NR_autoLabelMesh(meshN,methodK,meshBoxData.currentNum);
N = length(meshN);
for i = 1:N
    for j = 1:N
        obj = buttonHandles((i-1)*N+j);
        if -1999 <= meshN(i,j) && meshN(i,j)<= -1000
            set(obj,'backgroundcolor','r');
            if meshN(i,j) ~= -1000
                set(obj,'foregroundcolor',[1 1 1]);
                set(obj,'String',num2str(-(meshN(i,j)+1000)));
            end
        end
        if -2999 <= meshN(i,j) && meshN(i,j)<= -2000
            set(obj,'backgroundcolor','b');
            if meshN(i,j) ~= -2000
                set(obj,'foregroundcolor',[1 1 1]);
                set(obj,'String',num2str(-(meshN(i,j)+2000)));
            end
        end
        if  meshN(i,j)>= 1000
            set(obj,'backgroundcolor','g');
            if meshN(i,j) ~= 1000
                set(obj,'foregroundcolor','k');
                set(obj,'String',num2str(meshN(i,j)-1000));
            end
        end
    end
end
k= get(handles.probeList,'value');
allMatrix = get(handles.probeList,'userdata');
allMatrix{k}=meshN;
set(handles.probeList,'userdata',allMatrix);

meshBoxData.meshN = meshN;
meshBoxData.currentNum = NR_findCurrentNumAll(allMatrix);
set(handles.meshBox,'UserData',meshBoxData);


function NR_TopoMaker_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NR_TopoMaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
