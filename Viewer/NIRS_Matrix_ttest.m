function varargout = NIRS_Matrix_ttest(varargin)
% NIRS_MATRIX_TTEST MATLAB code for NIRS_Matrix_ttest.fig
%      NIRS_MATRIX_TTEST, by itself, creates a new NIRS_MATRIX_TTEST or raises the existing
%      singleton*.
%
%      H = NIRS_MATRIX_TTEST returns the handle to a new NIRS_MATRIX_TTEST or the handle to
%      the existing singleton*.
%
%      NIRS_MATRIX_TTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_MATRIX_TTEST.M with the given input arguments.
%
%      NIRS_MATRIX_TTEST('Property','Value',...) creates a new NIRS_MATRIX_TTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_Matrix_ttest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_Matrix_ttest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_Matrix_ttest

% Last Modified by GUIDE v2.5 13-Nov-2019 20:27:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_Matrix_ttest_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_Matrix_ttest_OutputFcn, ...
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


% --- Executes just before NIRS_Matrix_ttest is made visible.
function NIRS_Matrix_ttest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_Matrix_ttest (see VARARGIN)

% Choose default command line output for NIRS_Matrix_ttest

set(handles.Tex_mask,'visible','off');
set(handles.mask_channels,'visible','off');
set(handles.Tex_ch,'visible','off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes NIRS_Matrix_ttest wait for user response (see UIRESUME)
% uiwait(handles.NIRS_Matrix_ttest);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_Matrix_ttest_OutputFcn(hObject, eventdata, handles) 
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




% --- Executes on button press in multicom.
function multicom_Callback(hObject, eventdata, handles)
% hObject    handle to multicom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of multicom



function pvalue_Callback(hObject, eventdata, handles)
% hObject    handle to pvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pvalue as text
%        str2double(get(hObject,'String')) returns contents of pvalue as a double


% --- Executes during object creation, after setting all properties.
function pvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pvalue (see GCBO)
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


% --- Executes on button press in analysis.
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Matrix_ttest(handles);



function NIRS_REST_ttest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_ttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function base_Callback(hObject, eventdata, handles)
% hObject    handle to base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of base as text
%        str2double(get(hObject,'String')) returns contents of base as a double


% --- Executes during object creation, after setting all properties.
function base_CreateFcn(hObject, eventdata, handles)
% hObject    handle to base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes when user attempts to close NIRS_Matrix_ttest.
function NIRS_REST_ttest_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_ttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in output.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes during object deletion, before destroying properties.
function listbox1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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
