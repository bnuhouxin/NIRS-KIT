function varargout = NIRS_ICA_open_file_and_config(varargin)
% NIRS_ICA_OPEN_FILE_AND_CONFIG M-file for NIRS_ICA_open_file_and_config.fig
%      NIRS_ICA_OPEN_FILE_AND_CONFIG, by itself, creates a new NIRS_ICA_OPEN_FILE_AND_CONFIG or raises the existing
%      singleton*.
%
%      H = NIRS_ICA_OPEN_FILE_AND_CONFIG returns the handle to a new NIRS_ICA_OPEN_FILE_AND_CONFIG or the handle to
%      the existing singleton*.
%
%      NIRS_ICA_OPEN_FILE_AND_CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_ICA_OPEN_FILE_AND_CONFIG.M with the given input arguments.
%
%      NIRS_ICA_OPEN_FILE_AND_CONFIG('Property','Value',...) creates a new NIRS_ICA_OPEN_FILE_AND_CONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_ICA_open_file_and_config_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_ICA_open_file_and_config_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_ICA_open_file_and_config

% Last Modified by GUIDE v2.5 28-Jun-2021 15:32:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_ICA_open_file_and_config_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_ICA_open_file_and_config_OutputFcn, ...
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


% --- Executes just before NIRS_ICA_open_file_and_config is made visible.
function NIRS_ICA_open_file_and_config_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_ICA_open_file_and_config (see VARARGIN)

% Choose default command line output for NIRS_ICA_open_file_and_config
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_ICA_open_file_and_config wait for user response (see UIRESUME)
% uiwait(handles.NIRS_ICA_open_file_and_config);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_ICA_open_file_and_config_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inpathData_Callback(hObject, eventdata, handles)
% hObject    handle to inpathData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpathData as text
%        str2double(get(hObject,'String')) returns contents of inpathData as a double


% --- Executes during object creation, after setting all properties.
function inpathData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpathData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press of inputData directory.
function inputData_Callback(hObject, eventdata, handles)
% hObject    handle to inputData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.inpathData,'Enable','on');
dataSource = get(handles.inpathData,'userdata');
%
if isempty(dataSource)
    [filename,pathname] = uigetfile('*.mat');
else
    temp = strfind(dataSource,filesep);
    dataSource = dataSource(1:temp(end));
    [filename,pathname] = uigetfile([dataSource '*.mat']);
end
dataSource = [pathname filename];

if ischar(dataSource)
    set(handles.inpathData,'string',dataSource);  % set input path name
    set(handles.inpathData,'userdata',dataSource);
else
    return
end

inputStruct = load(dataSource);

%-----two mode to be chosen-----%
%fNIRS orICA processed fNIRS
if isfield(inputStruct,'nirs_data')
    dataIn.nirs_data = inputStruct.nirs_data;
    %to add fs or T field
    if isfield(dataIn.nirs_data,'fs')
        dataIn.nirs_data.T = 1/dataIn.nirs_data.fs;
    else
        dataIn.nirs_data.fs = 1/dataIn.nirs_data.T;
    end
    set(handles.NIRS_ICA_open_file_and_ICA_config,'UserData',dataIn);
    NID_open_file_Initial(handles)
    
elseif isfield(inputStruct,'IC_Component')
    dataIn = inputStruct.IC_Component.ICA_Method;
    %
    dataIn.ic_reserve_icnum = inputStruct.IC_Component.ic_reserve_icnum;
    %
    set(handles.NIRS_ICA_open_file_and_ICA_config,'UserData',dataIn);
    
    NID_open_file_Initial_input_icdata(handles)
else
    errordlg('Illegel input data!','Data Error')
end

%
if isfield(dataIn.nirs_data,'design')
    nfields = fieldnames(dataIn.nirs_data.design);         %
    set(handles.timetemplate,'Value',1);
    NID_Input_Design_Info
    
    obj = findobj('Tag','NID_Input_Design_Info');
    TThandles = guihandles(obj);
    
    table_info.row = 0; %   
    table_info.select = 0;  %   
    set(TThandles.uitable1,'Userdata',table_info)
    for i = 1:length(nfields)
        cur_task = dataIn.nirs_data.design.(nfields{i});
        input_name{1} = nfields{i};
        input_name{2} = 0.8;
        datain_type = class(cur_task);
        
        if  strcmp(datain_type,'cell')
            input_name{3} = cell2mat(cur_task.onset_time)';
            input_name{4} = cell2mat(cur_task.durs)';
        else
            input_name{3} = cur_task.onset_time;
            input_name{4} = cur_task.duration;
        end
        
        % 
        NID_Input_Design_Info_Add(TThandles,input_name)
    end
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in advance1.
function advance1_Callback(hObject, eventdata, handles)
% hObject    handle to advance1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of advance1
if 1 == get(handles.advance1,'Value')
    set(handles.advance_p11,'Enable','on');
    set(handles.advance_p21,'Enable','on');
    set(handles.advance_p31,'Enable','on');
    set(handles.advance_p41,'Enable','on');
else
    set(handles.advance_p11,'Enable','off');
    set(handles.advance_p21,'Enable','off');
    set(handles.advance_p31,'Enable','off');
    set(handles.advance_p41,'Enable','off');
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in spikelike_kk.
function spikelike_kk_Callback(hObject, eventdata, handles)
% hObject    handle to spikelike_kk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spikelike_kk

val = get(handles.spikelike_kk,'Value');

if val
    datapath = get(handles.inpathData,'String');
    if isempty(datapath)
        errordlg('You need to input NIRS data first!','File Error')
        set(handles.spikelike_kk,'Value',0);
        return
    end
    % GUIDE:
    NID_Spikelike_Para_Set
else
    set(handles.spikelike_kk,'UserData','')
end


% --- Executes on button press in homo_kk.
function homo_kk_Callback(hObject, eventdata, handles)
% hObject    handle to homo_kk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of homo_kk

val = get(handles.homo_kk,'Value');

if val
    datapath = get(handles.inpathData,'String');
    if isempty(datapath)
        errordlg('You need to input NIRS data first!','File Error')
        set(handles.homo_kk,'Value',0);
        return
    end
    % GUIDE 
    NID_SpatialHomo_Para_Set
else
    set(handles.homo_kk,'UserData','')
end

% --- Executes on button press in external_kk.
function external_kk_Callback(hObject, eventdata, handles)
% hObject    handle to external_kk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of external_kk

val = get(handles.external_kk,'Value');
if val == 1
    datapath = get(handles.inpathData,'String');
    if isempty(datapath)
        errordlg('You need to input NIRS data first!','File Error')
        set(handles.external_kk,'Value',0);
        return
    end
    % GUIDE
    NID_Select_External_Input
else
    set(handles.external_kk,'Userdata','');
end


% dataSource = get(handles.inpathData,'userdata');
% if isempty(dataSource)
%     [filename,pathname] = uigetfile('*.mat');
% else
%     [filename,pathname] = uigetfile([dataSource '\*.mat']);
% end
% dataSource = [pathname filename];
% 
% if ischar(dataSource)
%     set(handles.external_kk,'userdata',dataSource);
% end




% --- Executes on button press in external_kk.
function shortchannel_Callback(hObject, eventdata, handles)
% hObject    handle to external_kk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of external_kk


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in oxy.
function oxy_Callback(hObject, eventdata, handles)
% hObject    handle to oxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oxyval = get(handles.oxy,'Value');
dxyval = get(handles.dxy,'Value');
totval = get(handles.total,'Value');
if 0 == oxyval
    if 0 == dxyval && 0 == totval
        set(handles.oxy,'Value',1);
    end
end
%
icNum = get(handles.icnum,'Userdata');
str = [];
if 1 == get(handles.oxy,'Value')
    temp = [num2str(icNum.oxy),'(oxy),'];
    str = [str,temp];
end
if 1 == get(handles.dxy,'Value')
    temp = [num2str(icNum.dxy),'(dxy),'];
    str = [str,temp];
end
if 1 == get(handles.total,'Value')
    temp = [num2str(icNum.total),'(total),'];
    str = [str,temp];
end
set(handles.icnum,'String',str,'Enable','off');
% Hint: get(hObject,'Value') returns toggle state of oxy


% --- Executes on button press in dxy.
function dxy_Callback(hObject, eventdata, handles)
% hObject    handle to dxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dxy
oxyval = get(handles.oxy,'Value');
dxyval = get(handles.dxy,'Value');
totval = get(handles.total,'Value');
if 0 == dxyval
    if 0 == oxyval && 0 == totval
        set(handles.dxy,'Value',1);
    end
end
%
icNum = get(handles.icnum,'Userdata');
str = [];
if 1 == get(handles.oxy,'Value')
    temp = [num2str(icNum.oxy),'(oxy),'];
    str = [str,temp];
end
if 1 == get(handles.dxy,'Value')
    temp = [num2str(icNum.dxy),'(dxy),'];
    str = [str,temp];
end
if 1 == get(handles.total,'Value')
    temp = [num2str(icNum.total),'(total),'];
    str = [str,temp];
end
set(handles.icnum,'String',str,'Enable','off');

% --- Executes on button press in total.
function total_Callback(hObject, eventdata, handles)
% hObject    handle to total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of total
oxyval = get(handles.oxy,'Value');
dxyval = get(handles.dxy,'Value');
totval = get(handles.total,'Value');
if 0 == totval
    if 0 == oxyval && 0 == dxyval
        set(handles.total,'Value',1);
    end
end
%
icNum = get(handles.icnum,'Userdata');
str = [];
if 1 == get(handles.oxy,'Value')
    temp = [num2str(icNum.oxy),'(oxy),'];
    str = [str,temp];
end
if 1 == get(handles.dxy,'Value')
    temp = [num2str(icNum.dxy),'(dxy),'];
    str = [str,temp];
end
if 1 == get(handles.total,'Value')
    temp = [num2str(icNum.total),'(total),'];
    str = [str,temp];
end
set(handles.icnum,'String',str,'Enable','off');

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

datapath = get(handles.inpathData,'String');
if isempty(datapath)
    errordlg('You need to input NIRS data first!','File Error')
    return
end

hw = waitbar(0.65,'ICA Decomposing...');
% ICA
dataIn = get(handles.NIRS_ICA_open_file_and_ICA_config,'UserData');
    
if ~isfield(dataIn,'IC')
    % ICA
    IC = NID_OpenFileInitial_Do_ICA(handles);
    % 
    IC = NID_OpenFileInitial_Sorting(handles,IC);
    %
    % ICA
    if 1 == get(handles.hbty,'Value')
%         hb = 'Oxy';
        Hb = 'OXY';
    elseif 2 == get(handles.hbty,'Value')
%         hb = 'Dxy';
        Hb = 'DXY';
    elseif 3 == get(handles.hbty,'Value')
%         hb = 'Total';
        Hb = 'TOT';
    end
    %
    dataIn.IC = IC;
    dataIn.hbType = Hb;
%     dataIn.hb_type = hb;
else
    %edited by ZY
    if ~isempty(dataIn.IC.OXY.Sort.Sort_selectRule)
        set(handles.timetemplate,'Value',1);
    end
end

% 
NIRS_ICA_Denoiser=findobj('Tag','NIRS_ICA_Denoiser');
if ~isempty(NIRS_ICA_Denoiser)
    DenoiserHandles=guihandles(NIRS_ICA_Denoiser);
    set(DenoiserHandles.NIRS_ICA_Denoiser,'UserData',dataIn);
 end
% 
NID_Initial(DenoiserHandles);
% 
set(handles.NIRS_ICA_open_file_and_ICA_config,'Visible','off')
close(hw)

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Rules of Extracting Intrested ICs Automaticly
set(handles.spikelike_kk,'Value',1);
set(handles.homo_kk,'Value',1);
set(handles.external_kk,'Value',0);
%
set(handles.timetemplate,'Value',0);
set(handles.spatialtemplate,'Value',0);


function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% FastICA Parameter Default Setting
set(handles.advance1,'Value',0);
set(handles.advance_p11,'Value',1);
set(handles.advance_p11,'Enable','off');
set(handles.advance_p21,'String',1000);
set(handles.advance_p21,'Enable','off');
set(handles.advance_p31,'Value',1);
set(handles.advance_p31,'Enable','off');
set(handles.advance_p41,'String',0.0001);
set(handles.advance_p41,'Enable','off');

% --- Executes on selection change in advance_p11.
function advance_p11_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns advance_p11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from advance_p11


% --- Executes during object creation, after setting all properties.
function advance_p11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in advance_p31.
function advance_p31_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns advance_p31 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from advance_p31


% --- Executes during object creation, after setting all properties.
function advance_p31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function advance_p21_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of advance_p21 as text
%        str2double(get(hObject,'String')) returns contents of advance_p21 as a double


% --- Executes during object creation, after setting all properties.
function advance_p21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function advance_p41_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of advance_p41 as text
%        str2double(get(hObject,'String')) returns contents of advance_p41 as a double


% --- Executes during object creation, after setting all properties.
function advance_p41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in numofch.
function numofch_Callback(hObject, eventdata, handles)
% hObject    handle to numofch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of numofch
if 1 == get(handles.numofch,'Value')
    set(handles.users_input,'Value',0);
    set(handles.edit3,'Enable','off');
    set(handles.ica_method,'Value',0);
    %
    dataIn = get(handles.NIRS_ICA_open_file_and_ICA_config,'UserData');
    [sp,ch] = size(dataIn.nirs_data.oxyData);
    set(handles.edit3,'String',ch);
else
    if ~isempty(get(handles.edit3,'String'))
        set(handles.edit3,'String',[]);
    end
end



% --- Executes on button press in users_input.
function users_input_Callback(hObject, eventdata, handles)
% hObject    handle to users_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of users_input
if 1 == get(handles.users_input,'Value')
    set(handles.numofch,'Value',0);
    set(handles.ica_method,'Value',0);
    %
    set(handles.edit3,'Enable','on')
else
    set(handles.edit3,'Enable','off')
end

% --- Executes on button press in ica_method.
function ica_method_Callback(hObject, eventdata, handles)
% hObject    handle to ica_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ica_method


% --- Executes on button press in timetemplate.
function timetemplate_Callback(hObject, eventdata, handles)
% hObject    handle to timetemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of timetemplate

val = get(handles.timetemplate,'Value');
if val == 1
    datapath = get(handles.inpathData,'String');
    if isempty(datapath)
        errordlg('You need to input NIRS data first!','File Error')
        set(handles.timetemplate,'Value',0);
        return
    end
    % GUIDE:
    NID_Input_Design_Info
    
    obj = findobj('Tag','NID_Input_Design_Info');
    TThandles = guihandles(obj);

    table_info.row = 0; %   
    table_info.select = 0;  %   
    set(TThandles.uitable1,'Userdata',table_info)
else
    set(handles.timetemplate,'Userdata','');
end

% --- Executes on button press in spatialtemplate.
function spatialtemplate_Callback(hObject, eventdata, handles)
% hObject    handle to spatialtemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spatialtemplate

val = get(handles.spatialtemplate,'Value');
if val == 1
    datapath = get(handles.inpathData,'String');
    if isempty(datapath)
        errordlg('You need to input NIRS data first!','File Error')
        set(handles.spatialtemplate,'Value',0);
        return
    end
    % GUIDE:
    NID_Input_SpatialMap
    obj = findobj('Tag','NID_Input_SpatialMap');
    SMhandles = guihandles(obj);

    table_info.row = 0; %   
    table_info.select = 0;  %   
    set(SMhandles.uitable1,'Userdata',table_info)
else
    set(handles.spatialtemplate,'Userdata','');
end


% --- Executes on button press in mask3.
function mask3_Callback(hObject, eventdata, handles)
% hObject    handle to mask3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mask3


% --- Executes on selection change in ic_num_caculate.
function ic_num_caculate_Callback(hObject, eventdata, handles)
% hObject    handle to ic_num_caculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ic_num_caculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ic_num_caculate

datapath = get(handles.inpathData,'String');
if isempty(datapath)
    errordlg('You need to input NIRS data first!','File Error')
    set(handles.spatialtemplate,'Value',0);
    return
end

last_val = get(handles.ic_num_caculate,'Userdata');
val = get(handles.ic_num_caculate,'Value');
string_hb = {'oxy','dxy','total'};
switch val
    % PCA
    case 1
        prompt = {'Enter the Percentage of the Power to be Reserve: '};
        dlg_title = 'Input for PCA Method ...';
        num_lines = 1;
        def = {'0.99'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        if ~isempty(answer)
            icNum = NID_ic_NO_caculate(handles,str2num(answer{:}));
            %
            str = [];
            if 1 == get(handles.hbty,'Value')
                str = num2str(icNum.oxy);
            elseif 2 == get(handles.hbty,'Value')
                str = num2str(icNum.dxy);
            elseif 3 == get(handles.hbty,'Value')
                str = num2str(icNum.total);
            end
            set(handles.icnum,'String',str,'Userdata',icNum);
            set(handles.ic_num_caculate,'Userdata',val);
        else
            set(handles.ic_num_caculate,'Value',last_val);
        end
    %     
    case 2
        prompt = {'Enter the IC Number: '};
        dlg_title = 'Input for Users Input Method ...';
        num_lines = 1;
        def = {''};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        if ~isempty(answer)
            icNum = NID_ic_NO_caculate(handles,str2num(answer{:}));
            if ~isempty(icNum)
                set(handles.icnum,'String',num2str(icNum.oxy),'Userdata',icNum);
                set(handles.ic_num_caculate,'Userdata',val);
            else
                set(handles.ic_num_caculate,'Value',last_val);
            end
        else
            set(handles.ic_num_caculate,'Value',last_val);
        end
        
    % AIC    
    case 3
        choice = questdlg('AIC Method will takes you more than 10 min.Would you like to continue?', ...
                'AIC Method', ...
                'Yes','No','No');
        switch choice
            case 'No'
                set(handles.ic_num_caculate,'Value',last_val);
            case 'Yes'
                [icnum_aic,icnum_bic] = NID_get_aicbic(handles);
                %
                icNum = get(handles.icnum,'Userdata');
                if 1 == get(handles.hbty,'Value')
                    icNum.oxy = icnum_aic;
                elseif 2 == get(handles.hbty,'Value')
                    icNum.dxy = icnum_aic;
                elseif 3 == get(handles.hbty,'Value')
                    icNum.total = icnum_aic;
                end
                %
                set(handles.icnum,'String',num2str(icnum_aic),'Userdata',icNum);
                set(handles.ic_num_caculate,'Userdata',val);
        end
        
    % BIC     
    case 4
        choice = questdlg('BIC Method will takes you more than 10 min.Would you like to continue?', ...
                'BIC Method', ...
                'Yes','No','No');
        switch choice
            case 'No'
                set(handles.ic_num_caculate,'Value',last_val);
            case 'Yes'
                [icnum_aic,icnum_bic] = NID_get_aicbic(handles);
                %
                icNum = get(handles.icnum);
                if 1 == get(handles.hbty,'Value')
                    icNum.oxy = icnum_bic;
                elseif 2 == get(handles.hbty,'Value')
                    icNum.dxy = icnum_bic;
                elseif 3 == get(handles.hbty,'Value')
                    icNum.total = icnum_bic;
                end
                %
                set(handles.icnum,'String',num2str(icnum_bic),'Userdata',icNum);
                set(handles.ic_num_caculate,'Userdata',val);
        end
        
        
end


% --- Executes during object creation, after setting all properties.
function ic_num_caculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_num_caculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1



function icnum_Callback(hObject, eventdata, handles)
% hObject    handle to icnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icnum as text
%        str2double(get(hObject,'String')) returns contents of icnum as a double


% --- Executes during object creation, after setting all properties.
function icnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in advance.
function advance_Callback(hObject, eventdata, handles)
% hObject    handle to advance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

datapath = get(handles.inpathData,'String');
if isempty(datapath)
    errordlg('You need to input NIRS data first!','File Error')
    set(handles.advance,'Value',0);
    return
end
% GUIDE  fast-ICA,Infomax-ICA,st-ICA
% advance
ap = get(handles.advance,'UserData');
NID_ICA_Setting(handles)
if ~isempty(ap)
    advance_tag = findobj('Tag','NID_OpenFile_ICA_Config_Advance_Setting');
    gui_advance = guihandles(advance_tag);
    %
    if strcmp(ap.advance_ica_alg, 'FastICA')
        set(gui_advance.radiobutton1,'Value',1);
        set(gui_advance.advance_p1,'Value',ap.advance_p1);
        set(gui_advance.advance_p3,'Value',ap.advance_p3);
        set(gui_advance.advance_p2,'String',ap.advance_p2);
        set(gui_advance.advance_p4,'String',ap.advance_p4);
    elseif strcmp(ap.advance_ica_alg, 'InfomaxICA')
        set(gui_advance.radiobutton2,'Value',1);
    elseif strcmp(ap.advance_ica_alg, 'stICA')
        set(gui_advance.radiobutton3,'Value',1);
    end
end


% --- Executes on selection change in hbty.
function hbty_Callback(hObject, eventdata, handles)
% hObject    handle to hbty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hbty contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hbty

datapath = get(handles.inpathData,'String');
if isempty(datapath)
    errordlg('You need to input NIRS data first!','File Error')
    set(handles.spatialtemplate,'Value',0);
    return
end

val = get(handles.hbty,'Value');
%
icNum = get(handles.icnum,'Userdata');
str = [];
if 1 == val
    str = num2str(icNum.oxy);
elseif 2 == val
    str = num2str(icNum.dxy);
elseif 3 == val
    str = num2str(icNum.total);
end
set(handles.icnum,'String',str,'Enable','off');


% --- Executes during object creation, after setting all properties.
function hbty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hbty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
