function varargout = NIRS_BSS_Group_Results_Settings(varargin)
% NIRS_BSS_GROUP_RESULTS_SETTINGS MATLAB code for NIRS_BSS_Group_Results_Settings.fig
%      NIRS_BSS_GROUP_RESULTS_SETTINGS, by itself, creates a new NIRS_BSS_GROUP_RESULTS_SETTINGS or raises the existing
%      singleton*.
%
%      H = NIRS_BSS_GROUP_RESULTS_SETTINGS returns the handle to a new NIRS_BSS_GROUP_RESULTS_SETTINGS or the handle to
%      the existing singleton*.
%
%      NIRS_BSS_GROUP_RESULTS_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_BSS_GROUP_RESULTS_SETTINGS.M with the given input arguments.
%
%      NIRS_BSS_GROUP_RESULTS_SETTINGS('Property','Value',...) creates a new NIRS_BSS_GROUP_RESULTS_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_BSS_Group_Results_Settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_BSS_Group_Results_Settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_BSS_Group_Results_Settings

% Last Modified by GUIDE v2.5 02-Jul-2020 16:27:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_BSS_Group_Results_Settings_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_BSS_Group_Results_Settings_OutputFcn, ...
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


% --- Executes just before NIRS_BSS_Group_Results_Settings is made visible.
function NIRS_BSS_Group_Results_Settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_BSS_Group_Results_Settings (see VARARGIN)

% Choose default command line output for NIRS_BSS_Group_Results_Settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_BSS_Group_Results_Settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_BSS_Group_Results_Settings_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir('*.mat');

%% input path check
if isfolder(pathname)
    set(handles.inpathData,'string',pathname);  % set input path name
else
    errordlg('Directory is not found!');
    return;
end



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpath=get(handles.inpathData,'string'); 
files=dir([inpath filesep '*.mat']);
%load individual results
% indv_map_zsc=zeros();
indv_tc=cell(length(files),1);
indv_onset=zeros(length(files),1);
indv_offset=zeros(length(files),1);
indv_metric_timetmp=zeros(length(files),1);
for i=1:length(files)
    r=load([inpath filesep files(i).name]);
    %% if task

    %% block average individual tc
    des_tc=r.IC_Component.ICA_Method.IC.OXY.Sort.Sort_icDetail_data{4}{1};
    tmp_ic=r.IC_Component.ic_reserve_timeSerial;
    % z-transform time course
    tmp=(tmp_ic-mean(tmp_ic))./std(tmp_ic);
    [indv_tc{i},indv_onset(i),indv_offset(i)]=NID_bl_average(tmp,des_tc);
    icn=find(r.IC_Component.ICA_Method.IC.OXY.Sort.Sort_icNum{4,1}{1,1}==r.IC_Component.ic_reserve_icnum);
    indv_metric_timetmp(i)=r.IC_Component.ICA_Method.IC.OXY.Sort.Sort_icValue{4, 1}{1, 1}(icn);

    
    % z-transform spatial map
    tmp_sm=r.IC_Component.ic_reserve_spatialMap;
    tmp_sm=tmp_sm.*std(tmp_ic);
    indv_map_zsc(i,:)=tmp_sm;

    %% if resting-state

    
    %% threshold spatial map
    th=0.5;
    
    ret=abs(indv_map_zsc(i,:))>(max(indv_map_zsc(i,:))*th);
    indv_map_zsc(i,:)=indv_map_zsc(i,:).*ret;
    
end

%% calculate group statistics
g_data.g_sp_map=indv_map_zsc;
[g_data.g_tc,g_data.g_onset,g_data.g_offset]=NID_tc_group_average(indv_tc,indv_onset,indv_offset);

% set(handles,'Userdata',5)
handles.Userdata=g_data;

%% calculate evaluataion metrics time course
m_indv_metric_timetmp=mean(indv_metric_timetmp);
sd_indv_metric_timetmp=std(indv_metric_timetmp);



NIRS_ICA_group_task(handles);
