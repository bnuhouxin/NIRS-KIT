function varargout = NID_Save_Data_Reserve(varargin)
% NID_SAVE_DATA_RESERVE MATLAB code for NID_Save_Data_Reserve.fig
%      NID_SAVE_DATA_RESERVE, by itself, creates a new NID_SAVE_DATA_RESERVE or raises the existing
%      singleton*.
%
%      H = NID_SAVE_DATA_RESERVE returns the handle to a new NID_SAVE_DATA_RESERVE or the handle to
%      the existing singleton*.
%
%      NID_SAVE_DATA_RESERVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_SAVE_DATA_RESERVE.M with the given input arguments.
%
%      NID_SAVE_DATA_RESERVE('Property','Value',...) creates a new NID_SAVE_DATA_RESERVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_Save_Data_Reserve_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NID_Save_Data_Reserve_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_Save_Data_Reserve

% Last Modified by GUIDE v2.5 16-Dec-2014 11:01:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_Save_Data_Reserve_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_Save_Data_Reserve_OutputFcn, ...
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


% --- Executes just before NID_Save_Data_Reserve is made visible.
function NID_Save_Data_Reserve_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_Save_Data_Reserve (see VARARGIN)

% Choose default command line output for NID_Save_Data_Reserve
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_Save_Data_Reserve wait for user response (see UIRESUME)
% uiwait(handles.NID_Save_Data_Reserve);


% --- Outputs from this function are returned to the command line.
function varargout = NID_Save_Data_Reserve_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% save data path
outpath = get(handles.edit3,'String');
%
icreserve = str2num(get(handles.edit1,'String'));
%
obj = findobj('Tag','NIRS_ICA_Denoiser');
NIDhandles = guihandles(obj);
data = get(NIDhandles.NIRS_ICA_Denoiser,'Userdata');
hbtype = data.hbType;
% raw_nirsdata = data.nirs_data;
raw_icdata = data.IC;
icdata = getfield(raw_icdata,hbtype);
% ic reserved nirsdata
TC = icdata.TC;
SM = icdata.SM;
%
TC_new = TC(:,icreserve);
SM_new = SM(:,icreserve);
% %
% ICA_Method.hbtype = hbtype;
% ICA_Method.A = A;
% ICA_Method.ic_timeSerials = ic;
%
IC_Component.ICA_Method = data;
IC_Component.ic_reserve_timeSerial = TC_new;
IC_Component.ic_reserve_spatialMap = SM_new;
IC_Component.ic_reserve_icnum = icreserve;
IC_Component.ic_reserve_hbtype = hbtype;
% save
ind = find(outpath == filesep,1,'last');
output_folder = outpath(1:ind);

if exist(output_folder,'dir') == 7
    save(outpath,'IC_Component');
else
    errordlg('File Path Error','File Error')
    return
end
%
close(handles.NID_Save_Data_Reserve)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.NID_Save_Data_Reserve)



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

[file,path] = uiputfile('*.mat','Save Workspace As...');
outpath = [path,file];
set(handles.edit3,'String',outpath)
