function varargout = NID_Spikelike_Para_Set(varargin)
% NID_SPIKELIKE_PARA_SET MATLAB code for NID_Spikelike_Para_Set.fig
%      NID_SPIKELIKE_PARA_SET, by itself, creates a new NID_SPIKELIKE_PARA_SET or raises the existing
%      singleton*.
%
%      H = NID_SPIKELIKE_PARA_SET returns the handle to a new NID_SPIKELIKE_PARA_SET or the handle to
%      the existing singleton*.
%
%      NID_SPIKELIKE_PARA_SET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_SPIKELIKE_PARA_SET.M with the given input arguments.
%
%      NID_SPIKELIKE_PARA_SET('Property','Value',...) creates a new NID_SPIKELIKE_PARA_SET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_Spikelike_Para_Set_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NID_Spikelike_Para_Set_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_Spikelike_Para_Set

% Last Modified by GUIDE v2.5 13-May-2015 11:45:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_Spikelike_Para_Set_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_Spikelike_Para_Set_OutputFcn, ...
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


% --- Executes just before NID_Spikelike_Para_Set is made visible.
function NID_Spikelike_Para_Set_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_Spikelike_Para_Set (see VARARGIN)

% Choose default command line output for NID_Spikelike_Para_Set
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_Spikelike_Para_Set wait for user response (see UIRESUME)
% uiwait(handles.NID_Spikelike_ParameterSetting);


% --- Outputs from this function are returned to the command line.
function varargout = NID_Spikelike_Para_Set_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function para_wins_Callback(hObject, eventdata, handles)
% hObject    handle to para_wins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_wins as text
%        str2double(get(hObject,'String')) returns contents of para_wins as a double

str_wins = get(handles.para_wins,'String');

if isempty(str_wins)
    set(handles.para_wins,'String','2');
else
    wins = str2num(str_wins);
    
    if rem(wins,1)~=0
        errordlg('Input data should be a "integer" !','Error')
        set(handles.para_wins,'String','2');
    end
    
    if wins<=0
        errordlg('Invalid Input data !','Error')
        set(handles.para_wins,'String','2');
    end
end



% --- Executes during object creation, after setting all properties.
function para_wins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_wins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function para_thres_Callback(hObject, eventdata, handles)
% hObject    handle to para_thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of para_thres as text
%        str2double(get(hObject,'String')) returns contents of para_thres as a double

str_thres = get(handles.para_thres,'String');

if isempty(str_thres)
    set(handles.para_thres,'String','3');
else
    thres = str2num(str_thres);
    if thres<=0
        errordlg('Invalid Input data !','Error')
        set(handles.para_thres,'String','3');
    end
end



% --- Executes during object creation, after setting all properties.
function para_thres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to para_thres (see GCBO)
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

para_wins = get(handles.para_wins,'String');
para_thres = get(handles.para_thres,'String');
MA_thres = get(handles.ma_thres,'String');

if isempty(para_wins)
    wins = 2;
else
    wins = str2num(para_wins);
end

if isempty(para_thres)
    thres = 3;
else
    thres = str2num(para_thres);
end

if isempty(MA_thres)
    ma_thres = 0.8;
else
    ma_thres = str2num(MA_thres);
end

% OFIChandles = guihandles(NIRS_ICA_open_file_and_config);
spk_obj=findobj('Tag','spikelike');
% OFIChandles = guihandles(NIRS_ICA_v1);
data.wins = wins;
data.thres = thres;
data.ma_thres = ma_thres;
% set(OFIChandles.spikelike,'Userdata',data)
spk_obj.UserData=data;
close(handles.NID_Spikelike_ParameterSetting)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% Openfile = findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
% OpenfileHandles = guihandles(Openfile);
% set(OpenfileHandles.spikelike,'Value',0,'Userdata','','Enable','on')
close(handles.NID_Spikelike_ParameterSetting)



function ma_thres_Callback(hObject, eventdata, handles)
% hObject    handle to ma_thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ma_thres as text
%        str2double(get(hObject,'String')) returns contents of ma_thres as a double

str_thres = get(handles.ma_thres,'String');

if isempty(str_thres)
    set(handles.ma_thres,'String','0.8');
else
    thres = str2num(str_thres);
    if thres<=0||thres>1
        errordlg('Invalid Input data !','Error')
        set(handles.para_thres,'String','0.8');
    end
end


% --- Executes during object creation, after setting all properties.
function ma_thres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ma_thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
