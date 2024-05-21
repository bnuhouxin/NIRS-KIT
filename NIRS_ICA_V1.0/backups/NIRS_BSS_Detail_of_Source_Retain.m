function varargout = NIRS_BSS_Detail_of_Source_Retain(varargin)
% NIRS_BSS_DETAIL_OF_SOURCE_RETAIN M-file for NIRS_BSS_Detail_of_Source_Retain.fig
%      NIRS_BSS_DETAIL_OF_SOURCE_RETAIN, by itself, creates a new NIRS_BSS_DETAIL_OF_SOURCE_RETAIN or raises the existing
%      singleton*.
%
%      H = NIRS_BSS_DETAIL_OF_SOURCE_RETAIN returns the handle to a new NIRS_BSS_DETAIL_OF_SOURCE_RETAIN or the handle to
%      the existing singleton*.
%
%      NIRS_BSS_DETAIL_OF_SOURCE_RETAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_BSS_DETAIL_OF_SOURCE_RETAIN.M with the given input arguments.
%
%      NIRS_BSS_DETAIL_OF_SOURCE_RETAIN('Property','Value',...) creates a new NIRS_BSS_DETAIL_OF_SOURCE_RETAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_BSS_Detail_of_Source_Retain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_BSS_Detail_of_Source_Retain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_BSS_Detail_of_Source_Retain

% Last Modified by GUIDE v2.5 02-Jul-2020 08:59:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_BSS_Detail_of_Source_Retain_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_BSS_Detail_of_Source_Retain_OutputFcn, ...
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


% --- Executes just before NIRS_BSS_Detail_of_Source_Retain is made visible.
function NIRS_BSS_Detail_of_Source_Retain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_BSS_Detail_of_Source_Retain (see VARARGIN)

% Choose default command line output for NIRS_BSS_Detail_of_Source_Retain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_BSS_Detail_of_Source_Retain wait for user response (see UIRESUME)
% uiwait(handles.NIRS_BSS_Detail_of_Source_Retain);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_BSS_Detail_of_Source_Retain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ica_parameter.
function ica_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to ica_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function data_path_Callback(hObject, eventdata, handles)
% hObject    handle to data_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_path as text
%        str2double(get(hObject,'String')) returns contents of data_path as a double


% --- Executes during object creation, after setting all properties.
function data_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in open_file.
function open_file_Callback(hObject, eventdata, handles)
% hObject    handle to open_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% %-----edit by tan 20140805-----%
filePath1 = 'D:\Experiment_data\ICA_tried_and_error\NIRS_REST_ICA_Denoiser_data\demo_data';
[FileName1,PathName1] = uigetfile([filePath1,'\*.mat'],'Select the Demo NIRS-DATA-file');
load([PathName1,FileName1]);
dataSource1 = [PathName1,FileName1];
%% %-----edit by tan 20140805-----%
filePath2 = 'D:\Experiment_data\ICA_tried_and_error\NIRS_REST_ICA_Denoiser_data\demo_data';
[FileName2,PathName2] = uigetfile([filePath2,'\*.mat'],'Select the Demo IC-DATA-file');
load([PathName2,FileName2]);
dataSource2 = [PathName2,FileName2];
%
dataSource{1} = dataSource1;
dataSource{2} = dataSource2;
%initialize
    %config raw_data
    set(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'userdata',dataSource);
    set(handles.data_path,'String',PathName1);
    % %---NIRS_Data---% %
    NIRS_ICA_Denoiser_nirsdata_set(handles);
    NIRS_ICA_nirsdata_drawTimeseries(handles);
    NIRS_ICA_nirsdata_drawFreq(handles);
    % %---IC_Data---% %
    NIRS_ICA_Denoiser_ICdata_set(handles);
    NIRS_ICA_icdata_draw(handles);
    
%%

% --- Executes on button press in do_ica.
function do_ica_Callback(hObject, eventdata, handles)
% hObject    handle to do_ica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function IC_remove_Callback(hObject, eventdata, handles)
% hObject    handle to IC_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_remove as text
%        str2double(get(hObject,'String')) returns contents of IC_remove as a double


% --- Executes during object creation, after setting all properties.
function IC_remove_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IC_reserve_Callback(hObject, eventdata, handles)
% hObject    handle to IC_reserve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_reserve as text
%        str2double(get(hObject,'String')) returns contents of IC_reserve as a double


% --- Executes during object creation, after setting all properties.
function IC_reserve_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_reserve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in remove_ic.
function remove_ic_Callback(hObject, eventdata, handles)
% hObject    handle to remove_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reserve_ic.
function reserve_ic_Callback(hObject, eventdata, handles)
% hObject    handle to reserve_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_ic_info.
function save_ic_info_Callback(hObject, eventdata, handles)
% hObject    handle to save_ic_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_nirs_data.
function save_nirs_data_Callback(hObject, eventdata, handles)
% hObject    handle to save_nirs_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nirs_data_singlemode.
function nirs_data_singlemode_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_singlemode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nirs_data_singlemode
set(handles.nirs_data_singlemode,'value',1);
set(handles.nirs_data_multiplemode,'value',0);
set(handles.increaseCh,'enable','on');
set(handles.decreaseCh,'enable','on');
set(handles.allChannel,'enable','off');
handles_button = get(handles.nirs_data_channel_pannel,'userdata');
N = length(handles_button);
if get(handles.nirs_data_singlemode,'value') == 1
    for i=1:N
        set(handles_button(i), 'BackgroundColor',[0.941,0.941,0.941]);
    end
    set(handles_button(1), 'BackgroundColor',[0.7,0.7,1]);
    set(handles.nirs_data_channel, 'string','1');
end
NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)



% --- Executes on button press in nirs_data_multiplemode.
function nirs_data_multiplemode_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_multiplemode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nirs_data_multiplemode
set(handles.show_bl,'value',1);
set(handles.show_bl_remove,'value',0);
set(handles.nirs_data_singlemode,'value',0);
set(handles.nirs_data_multiplemode,'value',1);
set(handles.nirs_data_oxy,'value',1);
set(handles.nirs_data_dxy,'value',0);
set(handles.nirs_data_total,'value',0);
set(handles.increaseCh,'enable','off');
set(handles.decreaseCh,'enable','off');
set(handles.allChannel,'enable','on');
NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)
handles_button = get(handles.nirs_data_channel_pannel,'UserData');
set(handles_button(end-1),'enable','on');


% --- Executes on button press in show_bl.
function show_bl_Callback(hObject, eventdata, handles)
% hObject    handle to show_bl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_bl

if 1 == get(handles.show_bl,'Value')
    set(handles.show_bl_remove,'Enable','on')
else
    set(handles.show_bl_remove,'Enable','off','Value',0)
    set(handles.nirs_data_oxy,'Enable','on')
    set(handles.nirs_data_dxy,'Enable','on')
    set(handles.nirs_data_total,'Enable','on')
end

NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)

% --- Executes on button press in nirs_data_denoised_data.
function nirs_data_denoised_data_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_denoised_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nirs_data_denoised_data


% --- Executes on button press in nirs_data_oxy.
function nirs_data_oxy_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_oxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nirs_data_oxy
if get(handles.nirs_data_multiplemode,'value') == 1
    set(handles.nirs_data_oxy,'value',1)
    set(handles.nirs_data_dxy,'value',0)
    set(handles.nirs_data_total,'value',0)
end
NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)


% --- Executes on button press in nirs_data_dxy.
function nirs_data_dxy_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_dxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nirs_data_dxy
if get(handles.nirs_data_multiplemode,'value') == 1
    set(handles.nirs_data_oxy,'value',0)
    set(handles.nirs_data_dxy,'value',1)
    set(handles.nirs_data_total,'value',0)
end
NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)


% --- Executes on button press in nirs_data_total.
function nirs_data_total_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nirs_data_total
if get(handles.nirs_data_multiplemode,'value') == 1
    set(handles.nirs_data_oxy,'value',0)
    set(handles.nirs_data_dxy,'value',0)
    set(handles.nirs_data_total,'value',1)
end
NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)


% --- Executes on button press in resetAxes.
function resetAxes_Callback(hObject, eventdata, handles)
% hObject    handle to resetAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
multiviewMode = questdlg('Are you sure to reset?','Reset confirm','Yes','No','No');
if strcmp(multiviewMode,'Yes')
    handledata = get(getfield(handles,'NIRS_ICA_Denoiser_Detail_of_IC'),'Userdata');
    NID_Detail_NirsData_Set(handledata.ax_fig,handledata.DetailHandles,handledata.NIDHandles)
    NIRS_ICA_nirsdata_drawTimeseries(handles)
    NIRS_ICA_nirsdata_drawFreq(handles)
else
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ic_data_single.
function ic_data_single_Callback(hObject, eventdata, handles)
% hObject    handle to ic_data_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ic_data_single


% --- Executes on button press in ic_data_multiple.
function ic_data_multiple_Callback(hObject, eventdata, handles)
% hObject    handle to ic_data_multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ic_data_multiple



function ic_data_channel_Callback(hObject, eventdata, handles)
% hObject    handle to ic_data_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ic_data_channel as text
%        str2double(get(hObject,'String')) returns contents of ic_data_channel as a double


% --- Executes during object creation, after setting all properties.
function ic_data_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_data_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function nirs_data_channel_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_data_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nirs_data_channel as text
%        str2double(get(hObject,'String')) returns contents of nirs_data_channel as a double


% --- Executes during object creation, after setting all properties.
function nirs_data_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nirs_data_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in allChannel.
function allChannel_Callback(hObject, eventdata, handles)
% hObject    handle to allChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NID_channelControl_all(handles)


% --- Executes on button press in clearChannel.
function clearChannel_Callback(hObject, eventdata, handles)
% hObject    handle to clearChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NID_channelControl_clear(handles)



% --- Executes on button press in increaseCh.
function increaseCh_Callback(hObject, eventdata, handles)
% hObject    handle to increaseCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NID_channelControl_increase(handles)


% --- Executes on button press in decreaseCh.
function decreaseCh_Callback(hObject, eventdata, handles)
% hObject    handle to decreaseCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NID_channelControl_decrease(handles)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
val = get(handles.popupmenu1,'Value');
if val == 1
        set(handles.panel_ic_data,'Visible','on');
        set(handles.uipanel14,'Visible','off');
        set(handles.uipanel17,'Visible','off');
        set(handles.uipanel20,'Visible','off');
elseif val == 2
        set(handles.panel_ic_data,'Visible','off');
        set(handles.uipanel14,'Visible','on');
        set(handles.uipanel17,'Visible','off');
        set(handles.uipanel20,'Visible','off');
elseif val == 3
        set(handles.panel_ic_data,'Visible','off');
        set(handles.uipanel14,'Visible','off');
        set(handles.uipanel17,'Visible','on');
        set(handles.uipanel20,'Visible','off');
elseif val == 4
        set(handles.panel_ic_data,'Visible','off');
        set(handles.uipanel14,'Visible','off');
        set(handles.uipanel17,'Visible','off');
        set(handles.uipanel20,'Visible','on');
end


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


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in ic_data_hbtype.
function ic_data_hbtype_Callback(hObject, eventdata, handles)
% hObject    handle to ic_data_hbtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ic_data_hbtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ic_data_hbtype


% --- Executes during object creation, after setting all properties.
function ic_data_hbtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_data_hbtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ylimAxesf_Callback(hObject, eventdata, handles)
% hObject    handle to ylimAxesf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ylimAxesf as text
%        str2double(get(hObject,'String')) returns contents of ylimAxesf as a double
NIRS_ICA_nirsdata_drawFreq(handles)


% --- Executes during object creation, after setting all properties.
function ylimAxesf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ylimAxesf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fullLength.
function fullLength_Callback(hObject, eventdata, handles)
% hObject    handle to fullLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.nirs_data_timeserial,'userdata');
nirsdataRaw = data.raw;
T = nirsdataRaw.T;
dataLength = size(nirsdataRaw.oxyData,1);
if get(handles.rangeType,'value') == 1  % time range
    set(handles.rangeLeft,'string',T);
    set(handles.rangeRight,'string',dataLength*T);
    %
    set(handles.ic_rangeType,'value',1)
    set(handles.ic_rangeLeft,'string',T);
    set(handles.ic_rangeRight,'string',dataLength*T);
else  % scan range
    set(handles.rangeLeft,'string',1);
    set(handles.rangeRight,'string',dataLength);
    %
    set(handles.ic_rangeType,'value',2)
    set(handles.ic_rangeLeft,'string',1);
    set(handles.ic_rangeRight,'string',dataLength);
end
NIRS_ICA_nirsdata_drawTimeseries(handles)
NID_Detial_IC_drawTimeseries(handles)


% --- Executes on selection change in rangeType.
function rangeType_Callback(hObject, eventdata, handles)
% hObject    handle to rangeType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rangeType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rangeType
data = get(handles.nirs_data_timeserial,'userdata');
T = data.raw.T;
global rangeType;
if get(handles.rangeType,'value') == 1
    if(rangeType == 1)
        return;
    end
    if ~isempty(get(handles.rangeLeft,'string'))
        set(handles.rangeLeft,'string',num2str(str2num(get(handles.rangeLeft,'string'))*T));
    end
    if ~isempty(get(handles.rangeRight,'string'))
        set(handles.rangeRight,'string',num2str(str2num(get(handles.rangeRight,'string'))*T));
    end
    rangeType=1;
    %
    set(handles.ic_rangeType,'Value',1)
    set(handles.ic_rangeLeft,'string',get(handles.rangeLeft,'string'))
    set(handles.ic_rangeRight,'string',get(handles.rangeRight,'string'))
else
    if(rangeType == 2)
        return;
    end
    if ~isempty(get(handles.rangeLeft,'string'))
        set(handles.rangeLeft,'string',num2str(str2num(get(handles.rangeLeft,'string'))/T));
    end
    if ~isempty(get(handles.rangeRight,'string'))
        set(handles.rangeRight,'string',num2str(str2num(get(handles.rangeRight,'string'))/T));
    end   
    rangeType=2;
    %
    set(handles.ic_rangeType,'Value',2)
    set(handles.ic_rangeLeft,'string',get(handles.rangeLeft,'string'))
    set(handles.ic_rangeRight,'string',get(handles.rangeRight,'string'))
end
NIRS_ICA_nirsdata_drawTimeseries(handles)
NID_Detial_IC_drawTimeseries(handles)


% --- Executes during object creation, after setting all properties.
function rangeType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rangeLeft_Callback(hObject, eventdata, handles)
% hObject    handle to rangeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rangeLeft as text
%        str2double(get(hObject,'String')) returns contents of rangeLeft as a double
nirsleft = get(handles.rangeLeft,'String');
set(handles.ic_rangeLeft,'String',nirsleft);
NIRS_ICA_nirsdata_drawTimeseries(handles)
NID_Detial_IC_drawTimeseries(handles)


% --- Executes during object creation, after setting all properties.
function rangeLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rangeRight_Callback(hObject, eventdata, handles)
% hObject    handle to rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rangeRight as text
%        str2double(get(hObject,'String')) returns contents of rangeRight as a double
nirsright = get(handles.rangeRight,'String');
set(handles.ic_rangeRight,'String',nirsright);
NIRS_ICA_nirsdata_drawTimeseries(handles)
NID_Detial_IC_drawTimeseries(handles)


% --- Executes during object creation, after setting all properties.
function rangeRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton68.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton69.
function pushbutton69_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton70.
function pushbutton70_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton71.
function pushbutton71_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton72.
function pushbutton72_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function ic_ylimAxesf_Callback(hObject, eventdata, handles)
% hObject    handle to ic_ylimAxesf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ic_ylimAxesf as text
%        str2double(get(hObject,'String')) returns contents of ic_ylimAxesf as a double

obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDhandles = guihandles(obj);
NID_Detail_IC_drawFreq_Reserve(handles,NIDhandles)


% --- Executes during object creation, after setting all properties.
function ic_ylimAxesf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_ylimAxesf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ic_fullLength.
function ic_fullLength_Callback(hObject, eventdata, handles)
% hObject    handle to ic_fullLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDhandles = guihandles(obj);
data_all = get(NIDhandles.NIRS_ICA_Denoiser,'userdata');
data = data_all.nirs_data;
T = data.T;
dataLength = size(data.oxyData,1);
if get(handles.ic_rangeType,'value') == 1  % time range
    set(handles.ic_rangeLeft,'string',T);
    set(handles.ic_rangeRight,'string',dataLength*T);
else  % scan range
    set(handles.ic_rangeLeft,'string',1);
    set(handles.ic_rangeRight,'string',dataLength);
end
NID_Detial_IC_drawTimeseries_Reserve(handles,NIDhandles)


% --- Executes on selection change in ic_rangeType.
function ic_rangeType_Callback(hObject, eventdata, handles)
% hObject    handle to ic_rangeType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ic_rangeType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ic_rangeType

obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDhandles = guihandles(obj);
data_all = get(NIDhandles.NIRS_ICA_Denoiser,'userdata');
data = data_all.nirs_data;
T = data.T;
global rangeType;
if get(handles.ic_rangeType,'value') == 1
    if(rangeType == 1)
        return;
    end
    if ~isempty(get(handles.ic_rangeLeft,'string'))
        set(handles.ic_rangeLeft,'string',num2str(str2num(get(handles.ic_rangeLeft,'string'))*T));
    end
    if ~isempty(get(handles.ic_rangeRight,'string'))
        set(handles.ic_rangeRight,'string',num2str(str2num(get(handles.ic_rangeRight,'string'))*T));
    end
    rangeType=1;

else
    if(rangeType == 2)
        return;
    end
    if ~isempty(get(handles.ic_rangeLeft,'string'))
        set(handles.ic_rangeLeft,'string',num2str(str2num(get(handles.ic_rangeLeft,'string'))/T));
    end
    if ~isempty(get(handles.ic_rangeRight,'string'))
        set(handles.ic_rangeRight,'string',num2str(str2num(get(handles.ic_rangeRight,'string'))/T));
    end   
    rangeType=2;

end
NID_Detial_IC_drawTimeseries_Reserve(handles,NIDhandles)


% --- Executes during object creation, after setting all properties.
function ic_rangeType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_rangeType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ic_rangeLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ic_rangeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ic_rangeLeft as text
%        str2double(get(hObject,'String')) returns contents of ic_rangeLeft as a double

obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDhandles = guihandles(obj);
NID_Detial_IC_drawTimeseries_Reserve(handles,NIDhandles)


% --- Executes during object creation, after setting all properties.
function ic_rangeLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_rangeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ic_rangeRight_Callback(hObject, eventdata, handles)
% hObject    handle to ic_rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ic_rangeRight as text
%        str2double(get(hObject,'String')) returns contents of ic_rangeRight as a double

obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDhandles = guihandles(obj);
NID_Detial_IC_drawTimeseries_Reserve(handles,NIDhandles)


% --- Executes during object creation, after setting all properties.
function ic_rangeRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in detail_spikelike.
function detail_spikelike_Callback(hObject, eventdata, handles)
% hObject    handle to detail_spikelike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detail_spikelike


% --- Executes on button press in detail_homo.
function detail_homo_Callback(hObject, eventdata, handles)
% hObject    handle to detail_homo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detail_homo


% --- Executes on button press in detail_external.
function detail_external_Callback(hObject, eventdata, handles)
% hObject    handle to detail_external (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detail_external


% --- Executes on button press in detail_timetemplate.
function detail_timetemplate_Callback(hObject, eventdata, handles)
% hObject    handle to detail_timetemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detail_timetemplate



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton74.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton75.
function pushbutton75_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton76.
function pushbutton76_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to selectic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selectic as text
%        str2double(get(hObject,'String')) returns contents of selectic as a double


% --- Executes during object creation, after setting all properties.
function selectic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when NIRS_BSS_Detail_of_Source_Retain is resized.
function NIRS_ICA_Denoiser_Detail_of_IC_Reserve_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_BSS_Detail_of_Source_Retain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_bl_remove.
function show_bl_remove_Callback(hObject, eventdata, handles)
% hObject    handle to show_bl_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_bl_remove
blrm_val = get(handles.show_bl_remove,'Value');
bl_val = get(handles.show_bl,'Value');
if 0 == bl_val
    set(handles.show_bl_remove,'Value',0,'Enable','off');
    set(handles.nirs_data_oxy,'Enable','on','Value',1)
    set(handles.nirs_data_dxy,'Enable','on','Value',0)
    set(handles.nirs_data_total,'Enable','on','Value',0)
else
    if 1 == blrm_val
        set(handles.nirs_data_multiplemode,'Value',0,'Enable','off')
        
        NIDhandles = findobj('Tag','NIRS_ICA_Denoiser');
        dataIn = get(NIDhandles,'UserData');
        hbType = dataIn.hbType;
        if strcmp(hbType,'OXY')
            set(handles.nirs_data_dxy,'Enable','off','Value',0)
            set(handles.nirs_data_total,'Enable','off','Value',0)
        elseif strcmp(hbType,'DXY')
            set(handles.nirs_data_oxy,'Enable','off','Value',0)
            set(handles.nirs_data_total,'Enable','off','Value',0)
        elseif strcmp(hbType,'TOT')
            set(handles.nirs_data_oxy,'Enable','off','Value',0)
            set(handles.nirs_data_dxy,'Enable','off','Value',0)
        end
    else
        set(handles.nirs_data_multiplemode,'Value',0,'Enable','on')
        set(handles.nirs_data_oxy,'Enable','on','Value',1)
        set(handles.nirs_data_dxy,'Enable','on','Value',0)
        set(handles.nirs_data_total,'Enable','on','Value',0)
    end
end

NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)

% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bl_raw.
function bl_raw_Callback(hObject, eventdata, handles)
% hObject    handle to bl_raw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bl_raw
set(handles.bl_raw,'Value',1)
set(handles.bl_user,'Value',0,'Enable','off')

handlesAll = get(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata');
ax_fig = handlesAll.ax_fig;
NIDhandles = handlesAll.NIDHandles;
NID_Detail_Get_BaseLine_NirsData(ax_fig,NIDhandles,handles)

NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)


% --- Executes on button press in bl_taget_rm.
function bl_taget_rm_Callback(hObject, eventdata, handles)
% hObject    handle to bl_taget_rm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bl_taget_rm
set(handles.bl_raw,'Value',0)
set(handles.bl_taget_rm,'Value',1)
set(handles.bl_user,'Value',0,'Enable','off')

handlesAll = get(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata');
ax_fig = handlesAll.ax_fig;
NIDhandles = handlesAll.NIDHandles;
NID_Detail_Get_BaseLine_NirsData(ax_fig,NIDhandles,handles)

NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)


% --- Executes on button press in bl_user.
function bl_user_Callback(hObject, eventdata, handles)
% hObject    handle to bl_user (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bl_user
set(handles.bl_raw,'Value',0)
set(handles.bl_user,'Value',1)

handlesAll = get(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata');
ax_fig = handlesAll.ax_fig;
NIDhandles = handlesAll.NIDHandles;
NID_Detail_Get_BaseLine_NirsData(ax_fig,NIDhandles,handles)

NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
icremove = str2num(get(handles.edit28,'String'));

icdata = get(handles.ic_data_timeserials,'Userdata');
targetic = icdata.icnum;

NIDhandles = findobj('Tag','NIRS_ICA_Denoiser');
dataIn = get(NIDhandles,'Userdata');
ICdata = dataIn.IC;
hbtype = upper(icdata.hbtype);
temp = getfield(ICdata,hbtype);
numIC = temp.numIC;

if ismember(targetic,icremove)
    warndlg(['Target Source(NO.',num2str(targetic),') can not be remove...'],'Warning');
    icremove(find(icremove==targetic)) = '';
end
if any(icremove>numIC) || any(icremove<1)
    warndlg('IC NO. out of range...','Warning');
    icremove(find(icremove>numIC)) = '';
    icremove(find(icremove<1)) = '';
end


set(handles.edit28,'String',num2str(icremove))
set(handles.bl_user,'Value',0,'Enable','on')


% --- Executes on button press in detail_spatialtemplate.
function detail_spatialtemplate_Callback(hObject, eventdata, handles)
% hObject    handle to detail_spatialtemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detail_spatialtemplate



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ic_hbtype_Callback(hObject, eventdata, handles)
% hObject    handle to ic_hbtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ic_hbtype as text
%        str2double(get(hObject,'String')) returns contents of ic_hbtype as a double


% --- Executes during object creation, after setting all properties.
function ic_hbtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_hbtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ic_data_timeserials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_data_timeserials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate ic_data_timeserials


% --------------------------------------------------------------------
function detail_left_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to detail_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles_all = get(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata');
NIDHandles = handles_all.NIDHandles;
% leftflip data
leftflip_data = get(handles.detail_left,'Userdata');
icNum_now = leftflip_data.icNum;
order = leftflip_data.order;
[xx,zz] = ismember(icNum_now,order);
if zz==1
    return
end
icNum_next = order(zz-1);
leftflip_data.icnum = icNum_next;
set(handles.detail_left,'Userdata',leftflip_data);
%rightflip data
rightflip_data = get(handles.detail_right,'Userdata');
rightflip_data.icNum = icNum_next;
set(handles.detail_right,'Userdata',rightflip_data);
%
NID_Detail_IC_Set_Reserve_icflip(icNum_next,handles,NIDHandles,order)
%
NID_Detial_IC_drawTimeseries_Reserve(handles,NIDHandles)
NID_Detail_IC_drawFreq_Reserve(handles,NIDHandles)
NID_Detial_IC_drawSpacialmap_Reserve(handles,NIDHandles)
NID_Detail_IC_Spacialmap_colorBar_Reserve(handles,NIDHandles)


% --------------------------------------------------------------------
function detail_right_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to detail_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles_all = get(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata');
ax_fig = handles_all.ax_fig;
NIDHandles = handles_all.NIDHandles;
% leftflip data
rightflip_data = get(handles.detail_right,'Userdata');
icNum_now = rightflip_data.icNum;
order = rightflip_data.order;
[xx,zz] = ismember(icNum_now,order);
if zz==length(order)
    return
end
icNum_next = order(zz+1);
rightflip_data.icnum = icNum_next;
set(handles.detail_right,'Userdata',rightflip_data);
%leftflip data
leftflip_data = get(handles.detail_left,'Userdata');
leftflip_data.icNum = icNum_next;
set(handles.detail_left,'Userdata',leftflip_data);
%
NID_Detail_IC_Set_Reserve_icflip(icNum_next,handles,NIDHandles,order)
%
NID_Detial_IC_drawTimeseries_Reserve(handles,NIDHandles)
NID_Detail_IC_drawFreq_Reserve(handles,NIDHandles)
NID_Detial_IC_drawSpacialmap_Reserve(handles,NIDHandles)
NID_Detail_IC_Spacialmap_colorBar_Reserve(handles,NIDHandles)


% --- Executes during object creation, after setting all properties.
function NIRS_ICA_Denoiser_Detail_of_IC_Reserve_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_BSS_Detail_of_Source_Retain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel_bl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_bl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function IC_SignChange_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to IC_SignChange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
is_change = questdlg('Change Sign of IC will lead to close of this window, are you Sure?','Warning','Yes','Cancel','Yes'); 
switch is_change
    case 'Yes'
    %%%%%%%%%%
    %need to debug
    % 
    handles_all = get(handles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata');
    NIDHandles = handles_all.NIDHandles;
    dataIn = get(NIDHandles.NIRS_ICA_Denoiser,'UserData');
    IC = dataIn.IC;
    hbtype = dataIn.hbType;
    icdata = getfield(IC,hbtype);
    % 
    curicnum = get(handles_all.ax_fig,'Userdata');
    % 
    icdata.TC(:,curicnum) = icdata.TC(:,curicnum) * -1;
    icdata.SM(:,curicnum) = icdata.SM(:,curicnum) * -1;
%     icdata.IC_weigthInfo(:,curicnum) = icdata.IC_weigthInfo(:,curicnum) * -1;
    if strcmp(hbtype,'OXY')
        IC.OXY = icdata;
    elseif strcmp(hbtype,'DXY')
        IC.DXY = icdata;
    elseif strcmp(hbtype,'TOT')
        IC.TOT = icdata;
    end
    % 
    NID_fileOpen = findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
    guiNID_fileOpen = guihandles(NID_fileOpen);
    IC = NID_OpenFileInitial_Sorting(guiNID_fileOpen,IC);
    % 
    dataIn.IC = IC;
    set(NIDHandles.NIRS_ICA_Denoiser,'UserData',dataIn);
    % 
    NID_PLOT_Clear_Screen(NIDHandles)
    NID_PLOT(NIDHandles)

    % detail
    detailTag = findobj('Tag','NIRS_ICA_Detail_of_IC_Reserve');
    delete(detailTag)

    case 'Cancel'
        
end


%
% NIRS_BSS_Detail_of_Source_Retain                                  % Detail
% NID_Detail = findobj('Tag','NIRS_BSS_Detail_of_Source_Retain');
% if ~isempty(NID_Detail)
%     DetailHandles=guihandles(NID_Detail);
%     NID_Detail_of_IC_Reserve_initial(ax_fig,handles,DetailHandles,order) % detail
% end
% %
% NID_Detial_IC_drawTimeseries_Reserve(DetailHandles,handles)
% NID_Detail_IC_drawFreq_Reserve(DetailHandles,handles)
% NID_Detial_IC_drawSpacialmap_Reserve(DetailHandles,handles)
% NID_Detail_IC_Spacialmap_colorBar_Reserve(DetailHandles,handles)
%     
%     
% %
% data = get(handles.ic_data_timeserials,'Userdata');
% data.time = -1 * data.time;
% data.weight = -1 * data.weight;
% set(handles.ic_data_timeserials,'Userdata',data);
% %
% handles_all = get(handles.NIRS_BSS_Detail_of_Source_Retain,'Userdata');
% NIDHandles = handles_all.NIDHandles;
% 
% NID_Detial_IC_drawTimeseries_Reserve(handles,NIDHandles)
% NID_Detail_IC_drawFreq_Reserve(handles,NIDHandles)
% NID_Detial_IC_drawSpacialmap_Reserve(handles,NIDHandles)
% NID_Detail_IC_Spacialmap_colorBar_Reserve(handles,NIDHandles)
