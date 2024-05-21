function varargout = NIRS_stat_ttest2paired(varargin)
% NIRS_STAT_TTEST2PAIRED MATLAB code for NIRS_stat_ttest2paired.fig
%      NIRS_STAT_TTEST2PAIRED, by itself, creates a new NIRS_STAT_TTEST2PAIRED or raises the existing
%      singleton*.
%
%      H = NIRS_STAT_TTEST2PAIRED returns the handle to a new NIRS_STAT_TTEST2PAIRED or the handle to
%      the existing singleton*.
%
%      NIRS_STAT_TTEST2PAIRED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_STAT_TTEST2PAIRED.M with the given input arguments.
%
%      NIRS_STAT_TTEST2PAIRED('Property','Value',...) creates a new NIRS_STAT_TTEST2PAIRED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_stat_ttest2paired_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_stat_ttest2paired_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_stat_ttest2paired

% Last Modified by GUIDE v2.5 13-Nov-2019 18:51:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_stat_ttest2paired_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_stat_ttest2paired_OutputFcn, ...
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


% --- Executes just before NIRS_stat_ttest2paired is made visible.
function NIRS_stat_ttest2paired_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_stat_ttest2paired (see VARARGIN)

% Choose default command line output for NIRS_stat_ttest2paired
set(handles.Tex_mask,'visible','off');
set(handles.mask_channels,'visible','off');
set(handles.Tex_ch,'visible','off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_stat_ttest2paired_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inpath2_Callback(hObject, eventdata, handles)
% hObject    handle to inpath2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpath2 as text
%        str2double(get(hObject,'String')) returns contents of inpath2 as a double


% --- Executes during object creation, after setting all properties.
function inpath2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpath2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inpath1_Callback(hObject, eventdata, handles)
% hObject    handle to inpath1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpath1 as text
%        str2double(get(hObject,'String')) returns contents of inpath1 as a double


% --- Executes during object creation, after setting all properties.
function inpath1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpath1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in input1.
function input1_Callback(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

inpath1 = uigetdir(pwd);% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if ischar(inpath1)
    set(handles.inpath1,'string',inpath1);  % set input path name
    %  ====================== set default outpath =====================
    index_dir = findstr(inpath1,filesep);
    subf=regexp(inpath1,filesep,'split');                               
    id_ind=find(strcmp(subf,'Individual_Level'));
    if id_ind~=0
        outpath = fullfile(inpath1(1:index_dir(id_ind-1)),'Group_Level');
        set(handles.outpath,'string',outpath);  % set output path name
    end
    %  ====================== set default outpath =====================
end



% --- Executes on button press in input2.
function input2_Callback(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpatha=get(handles.inpath1,'string');
inpath = uigetdir(inpatha);
if ischar(inpath)
    set(handles.inpath2,'string',inpath);  % set input path name
end

    

% --- Executes on button press in analysis.
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_ttest2paired(handles);



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

[filename, pathname] = uigetfile(fullfile(pwd,'*.txt'));
if ischar(filename)
    set(handles.otherCovPath,'string',fullfile(pathname,filename));  % set input path name
end



% =========================================================================
% --- Executes during object creation, after setting all properties.
function NIRS_REST_ttest2paired_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_stat_ttest2paired (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% =========================================================================


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

% =========================================================================
% --- Executes when user attempts to close NIRS_stat_ttest2paired.
function NIRS_REST_ttest2paired_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_stat_ttest2paired (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
% =========================================================================


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


% --- Executes on button press in output.
function output_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
if ischar(outpath)
    set(handles.outpath,'string',outpath);  % set outpath name
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
