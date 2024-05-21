function varargout = NIRS_Matrix_correlation(varargin)
% NIRS_MATRIX_CORRELATION MATLAB code for NIRS_Matrix_correlation.fig
%      NIRS_MATRIX_CORRELATION, by itself, creates a new NIRS_MATRIX_CORRELATION or raises the existing
%      singleton*.
%
%      H = NIRS_MATRIX_CORRELATION returns the handle to a new NIRS_MATRIX_CORRELATION or the handle to
%      the existing singleton*.
%
%      NIRS_MATRIX_CORRELATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_MATRIX_CORRELATION.M with the given input arguments.
%
%      NIRS_MATRIX_CORRELATION('Property','Value',...) creates a new NIRS_MATRIX_CORRELATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_Matrix_correlation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_Matrix_correlation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_Matrix_correlation

% Last Modified by GUIDE v2.5 20-Nov-2019 09:52:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_Matrix_correlation_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_Matrix_correlation_OutputFcn, ...
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


% --- Executes just before NIRS_Matrix_correlation is made visible.
function NIRS_Matrix_correlation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_Matrix_correlation (see VARARGIN)

% Choose default command line output for NIRS_Matrix_correlation

set(handles.Tex_mask,'visible','off');
set(handles.mask_channels,'visible','off');
set(handles.Tex_ch,'visible','off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = NIRS_Matrix_correlation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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
Matrix_correlation(handles);



function groupNum_Callback(hObject, eventdata, handles)
% hObject    handle to groupNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of groupNum as text
%        str2double(get(hObject,'String')) returns contents of groupNum as a double


% --- Executes during object creation, after setting all properties.
function groupNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to groupNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function covNum_Callback(hObject, eventdata, handles)
% hObject    handle to covNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of covNum as text
%        str2double(get(hObject,'String')) returns contents of covNum as a double


% --- Executes during object creation, after setting all properties.
function covNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to covNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textNum_Callback(hObject, eventdata, handles)
% hObject    handle to textNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textNum as text
%        str2double(get(hObject,'String')) returns contents of textNum as a double


% --- Executes during object creation, after setting all properties.
function textNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function behavNum_Callback(hObject, eventdata, handles)
% hObject    handle to behavNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of behavNum as text
%        str2double(get(hObject,'String')) returns contents of behavNum as a double


% --- Executes during object creation, after setting all properties.
function behavNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to behavNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function NIRS_REST_correlation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_correlation (see GCBO)
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



% --- Executes when user attempts to close NIRS_Matrix_correlation.
function NIRS_REST_correlation_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_correlation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function pValue_Callback(hObject, eventdata, handles)
% hObject    handle to pValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pValue as text
%        str2double(get(hObject,'String')) returns contents of pValue as a double


% --- Executes during object creation, after setting all properties.
function pValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method
corr_meth = get(handles.method,'value');

if corr_meth == 2 || corr_meth == 3
    set(handles.Tex_mask,'visible','on');
    set(handles.Tex_mask,'value',0);
    set(handles.mask_channels,'visible','off');
    set(handles.Tex_ch,'visible','off');
else
    set(handles.Tex_mask,'value',0);
    set(handles.Tex_mask,'visible','off');
    set(handles.mask_channels,'string',[]);
    set(handles.mask_channels,'visible','off');
    set(handles.Tex_ch,'visible','off');
end
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in output.
function output_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
if ischar(outpath)
    set(handles.outpath,'string',outpath);
end


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


function otherCovPath_Callback(hObject, eventdata, handles)
% hObject    handle to otherCovPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of otherCovPath as text
%        str2double(get(hObject,'String')) returns contents of otherCovPath as a double


% --- Executes during object creation, after setting all properties.
function otherCovPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to otherCovPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in othercovinput.
function othercovinput_Callback(hObject, eventdata, handles)
% hObject    handle to othercovinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(fullfile(pwd,'*.txt'));  % ~~~~~
if ischar(filename)
    set(handles.otherCovPath,'string',fullfile(pathname,filename));  % set input path name
end



function listTextBehavdata_Callback(hObject, eventdata, handles)
% hObject    handle to listTextBehavdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of listTextBehavdata as text
%        str2double(get(hObject,'String')) returns contents of listTextBehavdata as a double


% --- Executes during object creation, after setting all properties.
function listTextBehavdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listTextBehavdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addBeha.
function addBeha_Callback(hObject, eventdata, handles)
% hObject    handle to addBeha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(fullfile(pwd,'*.txt'));  % ~~~~~
if ischar(filename)
    set(handles.listTextBehavdata,'string',fullfile(pathname,filename));  % set input path name
end


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
