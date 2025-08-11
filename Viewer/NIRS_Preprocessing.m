function varargout = NIRS_Preprocessing(varargin)
% NIRS_Preprocessing MATLAB code for NIRS_Preprocessing.fig
%      NIRS_Preprocessing, by itself, creates a new NIRS_Preprocessing or raises the existing
%      singleton*.
%
%      H = NIRS_Preprocessing returns the handle to a new NIRS_Preprocessing or the handle to
%      the existing singleton*.
%
%      NIRS_Preprocessing('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_Preprocessing.M with the given addPath arguments.
%
%      NIRS_Preprocessing('Property','Value',...) creates a new NIRS_Preprocessing or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_Preprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_Preprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_Preprocessing

% Last Modified by GUIDE v2.5 17-Jul-2021 21:04:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_Preprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_Preprocessing_OutputFcn, ...
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


% --- Executes just before NIRS_Preprocessing is made visible.
function NIRS_Preprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_Preprocessing (see VARARGIN)
% Choose default command line output for NIRS_Preprocessing
handles.output = hObject;

% UIWAIT makes NIRS_Preprocessing wait for user response (see UIRESUME)
% uiwait(handles.NIRS_Preprocessing);

set(handles.step_segment,'value',8);
set(handles.step_detrend,'value',1);
set(handles.step_motioncorrection,'value',2);
set(handles.step_filter,'value',3);
set(handles.step_downsample,'value',8);
set(handles.step_regress,'value',8);
set(handles.step_custom,'value',8);


set(handles.leftseg,'string','15');
set(handles.rightseg,'string','15');
set(handles.leftseg,'enable','off');
set(handles.rightseg,'enable','off');

set(handles.order,'string','1');
set(handles.bandlow,'string','0.01');
set(handles.bandhigh,'string','0.08');
set(handles.newT,'string','','enable','off');
set(handles.regressor_path,'string','','enable','off');
set(handles.add_regressor,'enable','off');
set(handles.custom_name_box,'string','','enable','off');
set(handles.add_custom,'enable','off');

set(handles.filt_method,'userdata',{'3';'3'});

set(handles.outpath,'string',pwd);
% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = NIRS_Preprocessing_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in addPath.
function addPath_Callback(hObject, eventdata, handles)
% hObject    handle to addPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpath = uigetdir(pwd);
if ischar(inpath)
    set(handles.inpathList,'string',inpath);
    
    sublist=dir(fullfile(inpath,'*.mat'));
    for n=1:length(sublist)
        subname{n}=sublist(n).name(1:end-4);
    end
    set(handles.fileList,'string',subname);   
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


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stepA = get(handles.step_segment,'value');
stepB = get(handles.step_detrend,'value');
stepC = get(handles.step_motioncorrection,'value');
stepD = get(handles.step_filter,'value');
stepE = get(handles.step_downsample,'value');
stepF = get(handles.step_regress,'value');

if ~isPreprocessStepValid([stepA,stepB,stepC,stepD,stepE,stepF])
    errordlg('Wrong step setting', 'Error');
    return;
end

NR_Preprocessing(handles);


% --- Executes during object creation, after setting all properties.
function NIRS_Preprocessing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Preprocessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in generateReport.
function generateReport_Callback(hObject, eventdata, handles)
% hObject    handle to generateReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of generateReport



% --- Executes on selection change in inpathList.
function inpathList_Callback(hObject, eventdata, handles)
% hObject    handle to inpathList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns inpathList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inpathList


% --- Executes during object creation, after setting all properties.
function inpathList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpathList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fileList.
function fileList_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileList


% --- Executes during object creation, after setting all properties.
function fileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function originalT_Callback(hObject, eventdata, handles)
% hObject    handle to originalT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of originalT as text
%        str2double(get(hObject,'String')) returns contents of originalT as a double


% --- Executes during object creation, after setting all properties.
function originalT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to originalT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function newT_Callback(hObject, eventdata, handles)
% hObject    handle to newT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newT as text
%        str2double(get(hObject,'String')) returns contents of newT as a double


% --- Executes during object creation, after setting all properties.
function newT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_downsample.
function step_downsample_Callback(hObject, eventdata, handles)
% hObject    handle to step_downsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_downsample,'value') == 8
    set(handles.newT,'enable','off');
else
    set(handles.newT,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns step_downsample contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_downsample


% --- Executes during object creation, after setting all properties.
function step_downsample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_downsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bandlow_Callback(hObject, eventdata, handles)
% hObject    handle to bandlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bandlow as text
%        str2double(get(hObject,'String')) returns contents of bandlow as a double


% --- Executes during object creation, after setting all properties.
function bandlow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bandlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bandhigh_Callback(hObject, eventdata, handles)
% hObject    handle to bandhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bandhigh as text
%        str2double(get(hObject,'String')) returns contents of bandhigh as a double


% --- Executes during object creation, after setting all properties.
function bandhigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bandhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_filter.
function step_filter_Callback(hObject, eventdata, handles)
% hObject    handle to step_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_filter,'value') == 8
    set(handles.filt_method,'enable','off');
    set(handles.bandlow,'enable','off');
    set(handles.bandhigh,'enable','off');
else
    set(handles.filt_method,'enable','on');
    set(handles.bandlow,'enable','on');
    set(handles.bandhigh,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns step_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_filter


% --- Executes during object creation, after setting all properties.
function step_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function order_Callback(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of order as text
%        str2double(get(hObject,'String')) returns contents of order as a double


% --- Executes during object creation, after setting all properties.
function order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_detrend.
function step_detrend_Callback(hObject, eventdata, handles)
% hObject    handle to step_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_detrend,'value') == 8
    set(handles.order,'enable','off');
else
    set(handles.order,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns step_detrend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_detrend


% --- Executes during object creation, after setting all properties.
function step_detrend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function leftseg_Callback(hObject, eventdata, handles)
% hObject    handle to leftseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leftseg as text
%        str2double(get(hObject,'String')) returns contents of leftseg as a double


% --- Executes during object creation, after setting all properties.
function leftseg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rightseg_Callback(hObject, eventdata, handles)
% hObject    handle to rightseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rightseg as text
%        str2double(get(hObject,'String')) returns contents of rightseg as a double


% --- Executes during object creation, after setting all properties.
function rightseg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_segment.
function step_segment_Callback(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_segment,'value') == 8
    set(handles.leftseg,'enable','off');
    set(handles.rightseg,'enable','off');
else
    set(handles.leftseg,'enable','on');
    set(handles.rightseg,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns step_segment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_segment


% --- Executes during object creation, after setting all properties.
function step_segment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on step_segment and none of its controls.
function step_segment_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function roichannel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roichannel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to outpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outpath as text
%        str2double(get(hObject,'String')) returns contents of outpath as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in output.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
if ischar(outpath)
    set(handles.outpath,'string',outpath);  % set outpath name
end

% --- Executes on selection change in inpathList.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to inpathList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns inpathList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inpathList


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpathList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileList as text
%        str2double(get(hObject,'String')) returns contents of fileList as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in step_motioncorrection.
function step_motioncorrection_Callback(hObject, eventdata, handles)
% hObject    handle to step_motioncorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_motioncorrection,'value') == 8
    set(handles.method_mc,'enable','off');
else
    set(handles.method_mc,'enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns step_motioncorrection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_motioncorrection


% --- Executes during object creation, after setting all properties.
function step_motioncorrection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_motioncorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method_mc.
function method_mc_Callback(hObject, eventdata, handles)
% hObject    handle to method_mc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method_mc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method_mc


% --- Executes during object creation, after setting all properties.
function method_mc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method_mc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function method_mc_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to method_mc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function regressor_path_Callback(hObject, eventdata, handles)
% hObject    handle to regressor_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of regressor_path as text
%        str2double(get(hObject,'String')) returns contents of regressor_path as a double


% --- Executes during object creation, after setting all properties.
function regressor_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to regressor_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_regress.
function step_regress_Callback(hObject, eventdata, handles)
% hObject    handle to step_regress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_regress contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_regress
if get(handles.step_regress,'value') == 8
    set(handles.regressor_path,'enable','off');
    set(handles.add_regressor,'enable','off');
else
    set(handles.regressor_path,'enable','on');
    set(handles.add_regressor,'enable','on');
end



% --- Executes during object creation, after setting all properties.
function step_regress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_regress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_regressor.
function add_regressor_Callback(hObject, eventdata, handles)
% hObject    handle to add_regressor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
regressor_p = uigetdir(pwd,'select the director including the regressor txt files for all subjects !!!');
if ischar(regressor_p)
    set(handles.regressor_path,'string',regressor_p);  % set outpath name
end



function custom_name_box_Callback(hObject, eventdata, handles)
% hObject    handle to custom_name_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of custom_name_box as text
%        str2double(get(hObject,'String')) returns contents of custom_name_box as a double


% --- Executes during object creation, after setting all properties.
function custom_name_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to custom_name_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_custom.
function step_custom_Callback(hObject, eventdata, handles)
% hObject    handle to step_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_custom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_custom

if get(handles.step_custom,'value') == 8
    set(handles.custom_name_box,'string','','enable','off');
    set(handles.add_custom,'enable','off');
else
    set(handles.custom_name_box,'enable','on');
    set(handles.add_custom,'enable','on');
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function step_custom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_custom.
function add_custom_Callback(hObject, eventdata, handles)
% hObject    handle to add_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
root_p = which('NIRS_KIT');
if ischar(root_p)
    [root_pt, ~, ~] = fileparts(root_p);
    defult_custom_path = fullfile(root_pt,'Customizedfunctions');
else
    defult_custom_path = pwd;
end

[fn,fp] = uigetfile('*.m','select the customized fNIRS singal processing script or function !!!',defult_custom_path);
custom_fun_path = fullfile(fp,fn);
if ischar(custom_fun_path)
    set(handles.custom_name_box,'string',fn(1:end-2)); 
    set(handles.custom_name_box,'userdata',custom_fun_path);
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in filt_method.
function filt_method_Callback(hObject, eventdata, handles)
% hObject    handle to filt_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filt_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filt_method

method_filt = get(handles.filt_method,'value');

if method_filt == 1 % IIR
    Filter_Param = inputdlg({'FilterType: 1 = high pass; 2 = low pass; 3 = band pass','FilterOrder: Defult = 3'},'Filtering parameters',[1 55],{'3','3'});
    celln = cellfun('isempty',Filter_Param);
    
    pause(0.2); 
    while sum(celln) > 0
        Filter_Param = inputdlg({'FilterType: 1 = high pass; 2 = low pass; 3 = band pass','FilterOrder: Defult = 3'},'Filtering parameters',[1 55],{'3','3'});
        celln = cellfun('isempty',Filter_Param);
    end
    
    if str2num(Filter_Param{1}) == 1
        set(handles.bandhigh,'string','','enable','off');
        set(handles.bandlow,'enable','on','string','0.01');
    elseif str2num(Filter_Param{1}) == 2
        set(handles.bandlow,'string','','enable','off');
        set(handles.bandhigh,'enable','on','string','0.08');        
    elseif str2num(Filter_Param{1}) == 3
        set(handles.bandlow,'enable','on','string','0.01');
        set(handles.bandhigh,'enable','on','string','0.08');
    end
    
    set(handles.filt_method,'userdata',Filter_Param);
    
elseif method_filt == 2 % FIR
    Filter_Param = inputdlg({'FilterType: 1 = high pass; 2 = low pass; 3 = band pass','FilterOrder: Defult = 34'},'Filtering parameters',[1 55],{'3','34'});
    celln = cellfun('isempty',Filter_Param);
    
    pause(0.2); 
    while sum(celln) > 0
        Filter_Param = inputdlg({'FilterType: 1 = high pass; 2 = low pass; 3 = band pass','FilterOrder: Defult = 34'},'Filtering parameters',[1 55],{'3','34'});
        celln = cellfun('isempty',Filter_Param);
    end
    
    if str2num(Filter_Param{1}) == 1
        set(handles.bandhigh,'string','','enable','off');
        set(handles.bandlow,'enable','on','string','0.01');
    elseif str2num(Filter_Param{1}) == 2
        set(handles.bandlow,'string','','enable','off');
        set(handles.bandhigh,'enable','on','string','0.08');        
    elseif str2num(Filter_Param{1}) == 3
        set(handles.bandlow,'enable','on','string','0.01');
        set(handles.bandhigh,'enable','on','string','0.08');
    end
    
    set(handles.filt_method,'userdata',Filter_Param);
        
elseif method_filt == 3 % FFT
    Filter_Param = inputdlg({'FilterType: 1 = high pass; 2 = low pass; 3 = band pass'},'Filtering parameters',[1 55],{'3'});
        
    pause(0.2); 
    while isempty(Filter_Param)
        Filter_Param = inputdlg({'FilterType: 1 = high pass; 2 = low pass; 3 = band pass'},'Filtering parameters',[1 55],{'3'});
    end
    
    if str2num(Filter_Param{1}) == 1
        set(handles.bandhigh,'string','','enable','off');
        set(handles.bandlow,'enable','on','string','0.01');
    elseif str2num(Filter_Param{1}) == 2
        set(handles.bandlow,'string','','enable','off');
        set(handles.bandhigh,'enable','on','string','0.08');        
    elseif str2num(Filter_Param{1}) == 3
        set(handles.bandlow,'enable','on','string','0.01');
        set(handles.bandhigh,'enable','on','string','0.08');
    end
    
    set(handles.filt_method,'userdata',{Filter_Param{1};'0'});
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function filt_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filt_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NIRS_ICA_Button.
function NIRS_ICA_Button_Callback(hObject, eventdata, handles)
% hObject    handle to NIRS_ICA_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_ICA_v1;