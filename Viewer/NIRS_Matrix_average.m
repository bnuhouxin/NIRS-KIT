function varargout = NIRS_Matrix_average(varargin)
% NIRS_MATRIX_AVERAGE MATLAB code for NIRS_Matrix_average.fig
%      NIRS_MATRIX_AVERAGE, by itself, creates a new NIRS_MATRIX_AVERAGE or raises the existing
%      singleton*.
%
%      H = NIRS_MATRIX_AVERAGE returns the handle to a new NIRS_MATRIX_AVERAGE or the handle to
%      the existing singleton*.
%
%      NIRS_MATRIX_AVERAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_MATRIX_AVERAGE.M with the given input arguments.
%
%      NIRS_MATRIX_AVERAGE('Property','Value',...) creates a new NIRS_MATRIX_AVERAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_Matrix_average_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_Matrix_average_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_Matrix_average

% Last Modified by GUIDE v2.5 13-Nov-2019 21:16:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_Matrix_average_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_Matrix_average_OutputFcn, ...
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


% --- Executes just before NIRS_Matrix_average is made visible.
function NIRS_Matrix_average_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_Matrix_average (see VARARGIN)

% Choose default command line output for NIRS_Matrix_average

set(handles.mask_channels,'visible','off');
set(handles.Tex_ch,'visible','off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes NIRS_Matrix_average wait for user response (see UIRESUME)
% uiwait(handles.NIRS_Matrix_average);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_Matrix_average_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inpath_Callback(hObject, eventdata, handles)
% hObject    handle to inpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpath as text
%        str2double(get(hObject,'String')) returns contents of inpath as a double


% --- Executes during object creation, after setting all properties.
function inpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in input.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpath = uigetdir(pwd); % ~~~~~
if ischar(inpath)
    set(handles.inpath,'string',inpath);  % set input path name
    
    %  ====================== set default outpath =========================
    index_dir = findstr(inpath,filesep);
    subf=regexp(inpath,filesep,'split');                               
    id_ind=find(strcmp(subf,'Individual_Level'));
    if id_ind~=0  
        outpath = fullfile(inpath(1:index_dir(id_ind-1)),'Group_Level');
        set(handles.outpath,'string',outpath);  % set output path name
    end
    %  ====================== set default outpath =========================
end



% --- Executes on button press in output.
function output_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
if ischar(outpath)
    set(handles.outpath,'string',outpath);  % set outpath name
end


function outpath_Callback(hObject, eventdata, handles)
% hObject    handle to outpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outpath as text
%        str2double(get(hObject,'String')) returns contents of outpath as a double


% --- Executes during object creation, after setting all properties.
function outpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in analysis.
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Matrix_average(handles);



function NIRS_Matrix_average_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function currentDir_Callback(hObject, eventdata, handles)
% hObject    handle to currentDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currentDir as text
%        str2double(get(hObject,'String')) returns contents of currentDir as a double


% --- Executes during object creation, after setting all properties.
function currentDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currentDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close NIRS_Matrix_average.
function NIRS_Matrix_average_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function mask_channels_Callback(hObject, eventdata, handles)
% hObject    handle to mask_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mask_channels as text
%        str2double(get(hObject,'String')) returns contents of mask_channels as a double


% --- Executes during object creation, after setting all properties.
function mask_channels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Tex_mask.
function Tex_mask_Callback(hObject, eventdata, handles)
% hObject    handle to Tex_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Tex_mask
if get(handles.Tex_mask,'value')
    set(handles.Tex_ch,'visible','on');
    set(handles.mask_channels,'visible','on');
    set(handles.mask_channels,'string',[]); 
else
    set(handles.Tex_ch,'visible','off');
    set(handles.mask_channels,'visible','off');
end
% Update handles structure
guidata(hObject, handles);
