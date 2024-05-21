function varargout = NID_SpatialHomo_Para_Set(varargin)
% NID_SPATIALHOMO_PARA_SET MATLAB code for NID_SpatialHomo_Para_Set.fig
%      NID_SPATIALHOMO_PARA_SET, by itself, creates a new NID_SPATIALHOMO_PARA_SET or raises the existing
%      singleton*.
%
%      H = NID_SPATIALHOMO_PARA_SET returns the handle to a new NID_SPATIALHOMO_PARA_SET or the handle to
%      the existing singleton*.
%
%      NID_SPATIALHOMO_PARA_SET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_SPATIALHOMO_PARA_SET.M with the given input arguments.
%
%      NID_SPATIALHOMO_PARA_SET('Property','Value',...) creates a new NID_SPATIALHOMO_PARA_SET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_SpatialHomo_Para_Set_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NID_SpatialHomo_Para_Set_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_SpatialHomo_Para_Set

% Last Modified by GUIDE v2.5 06-May-2015 16:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_SpatialHomo_Para_Set_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_SpatialHomo_Para_Set_OutputFcn, ...
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


% --- Executes just before NID_SpatialHomo_Para_Set is made visible.
function NID_SpatialHomo_Para_Set_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_SpatialHomo_Para_Set (see VARARGIN)

% Choose default command line output for NID_SpatialHomo_Para_Set
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_SpatialHomo_Para_Set wait for user response (see UIRESUME)
% uiwait(handles.NID_SptialHomo_ParameterSetting);


% --- Outputs from this function are returned to the command line.
function varargout = NID_SpatialHomo_Para_Set_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Openfile = findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
OpenfileHandles = guihandles(Openfile);
set(OpenfileHandles.homo,'Value',0,'Userdata','','Enable','on')
close(handles.NID_SptialHomo_ParameterSetting)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

para_thres = get(handles.thres,'String');

if isempty(para_thres)
    thres = 0.5;
else
    thres = str2num(para_thres);
end

homo_obj=findobj('Tag','homo');

% OFIChandles = guihandles(NIRS_ICA_v1);
data.thres = thres;
% set(homo_obj.homo,'Userdata',data)
homo_obj.UserData=data;
close(handles.NID_SptialHomo_ParameterSetting)



function thres_Callback(hObject, eventdata, handles)
% hObject    handle to thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thres as text
%        str2double(get(hObject,'String')) returns contents of thres as a double

str_thres = get(handles.thres,'String');

if isempty(str_thres)
    set(handles.thres,'String','0.5');
else
    wins = str2num(str_thres);
    
%     if wins>1
%         errordlg('Value is between 0&1 !','Error')
%         set(handles.thres,'String','0.5');
%     end
%     
    if wins<=0
        errordlg('Invalid Input data !','Error')
        set(handles.thres,'String','0.5');
    else
        set(handles.thres,'String',str_thres);
    end
end


% --- Executes during object creation, after setting all properties.
function thres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
