function varargout = NIRS_KIT_SpatialRegistration(varargin)
% NIRS_KIT_SPATIALREGISTRATION MATLAB code for NIRS_KIT_SpatialRegistration.fig
%      NIRS_KIT_SPATIALREGISTRATION, by itself, creates a new NIRS_KIT_SPATIALREGISTRATION or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_SPATIALREGISTRATION returns the handle to a new NIRS_KIT_SPATIALREGISTRATION or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_SPATIALREGISTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT_SPATIALREGISTRATION.M with the given input arguments.
%
%      NIRS_KIT_SPATIALREGISTRATION('Property','Value',...) creates a new NIRS_KIT_SPATIALREGISTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_SpatialRegistration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_SpatialRegistration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_SpatialRegistration

% Last Modified by GUIDE v2.5 29-Jan-2021 21:09:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_SpatialRegistration_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_SpatialRegistration_OutputFcn, ...
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


% --- Executes just before NIRS_KIT_SpatialRegistration is made visible.
function NIRS_KIT_SpatialRegistration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT_SpatialRegistration (see VARARGIN)

set(handles.isReferCheck,'value',1);

% Choose default command line output for NIRS_KIT_SpatialRegistration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_SpatialRegistration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_SpatialRegistration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ref_file_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to ref_file_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_file_listbox as text
%        str2double(get(hObject,'String')) returns contents of ref_file_listbox as a double


% --- Executes during object creation, after setting all properties.
function ref_file_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_file_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_ch_path.
function add_ch_path_Callback(hObject, eventdata, handles)
% hObject    handle to add_ch_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ch_path = uigetdir(pwd);

if ischar(ch_path)
    ch_files = dir(fullfile(ch_path,'*.csv'));
    if ~isempty(ch_files)
        for i = 1:length(ch_files)
            ch_fileList{i} = ch_files(i).name;
        end
        set(handles.ch_file_listbox,'userdata',ch_path);
        set(handles.ch_file_listbox,'string',ch_fileList);
    end            
end


function out_path_Callback(hObject, eventdata, handles)
% hObject    handle to out_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_path as text
%        str2double(get(hObject,'String')) returns contents of out_path as a double


% --- Executes during object creation, after setting all properties.
function out_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in set_outpath.
function set_outpath_Callback(hObject, eventdata, handles)
% hObject    handle to set_outpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir(pwd);

if ischar(outpath)
    set(handles.out_path,'string',outpath);  % set input path name
end

% --- Executes on button press in isReferCheck.
function isReferCheck_Callback(hObject, eventdata, handles)
% hObject    handle to isReferCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isReferCheck


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ref_fileList = get(handles.ref_file_listbox,'string');
ch_fileList = get(handles.ch_file_listbox,'string');

if ~isempty(ref_fileList)
    if length(ref_fileList) == length(ch_fileList)
        NK_3D_Registration(handles);
    else
        msgbox({'The numbers of the files list for Reference and Channel are not equal !!!'; 'Pleach check it !!!'},'Warning','warn');
    end
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in reg_method_box.
function reg_method_box_Callback(hObject, eventdata, handles)
% hObject    handle to reg_method_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns reg_method_box contents as cell array
%        contents{get(hObject,'Value')} returns selected item from reg_method_box
reg_method = get(handles.reg_method_box,'value');
if reg_method == 1
    set(handles.isReferCheck,'enable','on');
    if ~isempty(get(handles.ref_file_listbox,'string'))
        set(handles.ref_file_listbox,'string','');
        set(handles.ref_file_listbox,'userdata','');
    end
    if ~isempty(get(handles.ch_file_listbox,'string'))
        set(handles.ch_file_listbox,'string','');
        set(handles.ch_file_listbox,'userdata','');
    end
        
elseif reg_method == 2
    set(handles.isReferCheck,'enable','off');
    if ~isempty(get(handles.ref_file_listbox,'string'))
        set(handles.ref_file_listbox,'string','');
        set(handles.ref_file_listbox,'userdata','');
    end
    if ~isempty(get(handles.ch_file_listbox,'string'))
        set(handles.ch_file_listbox,'string','');
        set(handles.ch_file_listbox,'userdata','');
    end
end

% --- Executes during object creation, after setting all properties.
function reg_method_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reg_method_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch_file_listbox.
function ch_file_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to ch_file_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ch_file_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch_file_listbox


% --- Executes during object creation, after setting all properties.
function ch_file_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_file_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Add_Ref.
function Add_Ref_Callback(hObject, eventdata, handles)
% hObject    handle to Add_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ref_path = uigetdir(pwd);

if ischar(ref_path)
    ref_files = dir(fullfile(ref_path,'*.csv'));
    if ~isempty(ref_files)
        for i = 1:length(ref_files)
            ref_fileList{i} = ref_files(i).name;
        end
        set(handles.ref_file_listbox,'userdata',ref_path);
        set(handles.ref_file_listbox,'string',ref_fileList);
    end            
end
