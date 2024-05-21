function varargout = NIRS_KIT_BlockAverage(varargin)
% NIRS_KIT_BLOCKAVERAGE MATLAB code for NIRS_KIT_BlockAverage.fig
%      NIRS_KIT_BLOCKAVERAGE, by itself, creates a new NIRS_KIT_BLOCKAVERAGE or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_BLOCKAVERAGE returns the handle to a new NIRS_KIT_BLOCKAVERAGE or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_BLOCKAVERAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT_BLOCKAVERAGE.M with the given input arguments.
%
%      NIRS_KIT_BLOCKAVERAGE('Property','Value',...) creates a new NIRS_KIT_BLOCKAVERAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_BlockAverage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_BlockAverage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_BlockAverage

% Last Modified by GUIDE v2.5 22-Nov-2023 18:56:49

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NIRS_KIT_BlockAverage_OpeningFcn, ...
    'gui_OutputFcn',  @NIRS_KIT_BlockAverage_OutputFcn, ...
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


% --- Executes just before NIRS_KIT_BlockAverage is made visible.
function NIRS_KIT_BlockAverage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT_BlockAverage (see VARARGIN)

% Choose default command line output for NIRS_KIT_BlockAverage
handles.output = hObject;

global Probe2D;
Probe2D={};

global newaxes;
newaxes={};

global ax2;
ax2=[];

set(handles.add_design_mat,'visible','off');
set(handles.design_mat_path,'visible','off');
set(handles.diffcondbox,'visible','off');

handles.UnitStat=1;
handles.DesTpStat=1;

handles.condi_num=0;
usd=cell(3,1);

set(handles.Task_Opt_Pannel,'userdata',usd);
set(handles.diffcondbox,'userdata',{});
set(handles.DesignType,'userdata',1);

set(handles.step_segment,'value',6);
set(handles.leftseg,'enable','off');
set(handles.rightseg,'enable','off');

set(handles.step_detrend,'value',1);
set(handles.step_motioncorrection,'value',2);
set(handles.step_filter,'value',3);
set(handles.step_custom,'value',6);
set(handles.custom_name_box,'string','','enable','off');
set(handles.add_custom,'enable','off');

set(handles.preprocessed,'enable','off');

set(handles.filt_method,'userdata',{'3';'3'});

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes NIRS_KIT_BlockAverage wait for user response (see UIRESUME)
% uiwait(handles.viewer);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_BlockAverage_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function datasource_Callback(hObject, eventdata, handles)
% hObject    handle to datasource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datasource as text
%        str2double(get(hObject,'String')) returns contents of datasource as a double


% --- Executes during object creation, after setting all properties.
function datasource_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datasource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savedata.
function selectdata_Callback(hObject, eventdata, handles)
% hObject    handle to savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.mat');
dataImformation.source = fullfile(pathname,filename);
if ischar(filename)
    set(handles.viewer,'userdata',dataImformation);
    NR_DataViewer_set(handles);
    BA_drawTimeseries(handles);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function system_Callback(hObject, eventdata, handles)
% hObject    handle to system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of system as text
%        str2double(get(hObject,'String')) returns contents of system as a double


% --- Executes during object creation, after setting all properties.
function system_CreateFcn(hObject, eventdata, handles)
% hObject    handle to system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in downsample.
function downsample_Callback(hObject, eventdata, handles)
% hObject    handle to downsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of downsample


% --- Executes on button press in detrend.
function detrend_Callback(hObject, eventdata, handles)
% hObject    handle to detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detrend


% --- Executes on button press in bandpassfilter.
function bandpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to bandpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bandpassfilter


% --- Executes on button press in segment.
function segment_Callback(hObject, eventdata, handles)
% hObject    handle to segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of segment


% --- Executes on selection change in step_segment.
function step_segment_Callback(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_segment,'value') == 6
    set(handles.leftseg,'enable','off');
    set(handles.rightseg,'enable','off');
else
    set(handles.leftseg,'enable','on');
    set(handles.rightseg,'enable','on');
end

set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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


% --- Executes on selection change in step_detrend.
function step_detrend_Callback(hObject, eventdata, handles)
% hObject    handle to step_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_detrend,'value') == 6
    set(handles.order,'enable','off');
else
    set(handles.order,'enable','on');
end

set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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


% --- Executes on selection change in step_filter.
function step_filter_Callback(hObject, eventdata, handles)
% hObject    handle to step_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.step_filter,'value') == 6
    set(handles.filt_method,'enable','off');
    set(handles.bandlow,'enable','off');
    set(handles.bandhigh,'enable','off');
else
    set(handles.filt_method,'enable','on');
    set(handles.bandlow,'enable','on');
    set(handles.bandhigh,'enable','on');
end

set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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


% --- Executes on selection change in step_downsample.
function step_downsample_Callback(hObject, eventdata, handles)
% hObject    handle to step_downsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
NR_drawPreprocessed(handles);



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to originalT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of originalT as text
%        str2double(get(hObject,'String')) returns contents of originalT as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
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


% --- Executes on button press in runfilter.
function runfilter_Callback(hObject, eventdata, handles)
% hObject    handle to runfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function bandlow_Callback(hObject, eventdata, handles)
% hObject    handle to bandlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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



function order_Callback(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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


% --- Executes on button press in rundetrend.
function rundetrend_Callback(hObject, eventdata, handles)
% hObject    handle to rundetrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function leftseg_Callback(hObject, eventdata, handles)
% hObject    handle to leftseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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


% --- Executes on button press in runseg.
function runseg_Callback(hObject, eventdata, handles)
% hObject    handle to runseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function subject_Callback(hObject, eventdata, handles)
% hObject    handle to subject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subject as text
%        str2double(get(hObject,'String')) returns contents of subject as a double


% --- Executes during object creation, after setting all properties.
function subject_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in oxy.
function oxy_Callback(hObject, eventdata, handles)
if get(handles.multipleMode,'value') == 1 || get(handles.draw_ref,'value') == 1
    set(handles.oxy,'value',1)
    set(handles.dxy,'value',0)
    set(handles.total,'value',0)
end
BA_drawTimeseries(handles);

% --- Executes on button press in dxy.
function dxy_Callback(hObject, eventdata, handles)
if get(handles.multipleMode,'value') == 1 || get(handles.draw_ref,'value') == 1
    set(handles.oxy,'value',0)
    set(handles.dxy,'value',1)
    set(handles.total,'value',0)
end
BA_drawTimeseries(handles);

% --- Executes on button press in total.
function total_Callback(hObject, eventdata, handles)
if get(handles.multipleMode,'value') == 1 || get(handles.draw_ref,'value') == 1
    set(handles.oxy,'value',0)
    set(handles.dxy,'value',0)
    set(handles.total,'value',1)
end
BA_drawTimeseries(handles);


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on selection change in singleMode.
function singleMode_Callback(hObject, eventdata, handles)
% hObject    handle to singleMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns singleMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from singleMode
set(handles.singleMode,'value',1);
set(handles.multipleMode,'value',0);
set(handles.mean,'enable','off');
set(handles.meanOnly,'enable','off');
set(handles.increaseCh,'enable','on');
set(handles.decreaseCh,'enable','on');
set(handles.allChannel,'enable','off');
handles_button = get(handles.channelPanel,'userdata');
N = length(handles_button);
if get(handles.singleMode,'value') == 1
    for i=1:N
        set(handles_button(i), 'BackgroundColor',[0.941,0.941,0.941]);
    end
    set(handles_button(1), 'BackgroundColor',[0.7,0.7,1]);
    set(handles.channel, 'string','1');
end
BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function singleMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singleMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in preprocessed.
function preprocessed_Callback(hObject, eventdata, handles)
% hObject    handle to preprocessed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.multipleMode,'value')==1
    if get(handles.preprocessed,'value')
        set(handles.raw,'value',0);
    end
    if get(handles.raw,'value') == 0 && get(handles.preprocessed,'value') == 0
        set(handles.mean,'value',0);
        set(handles.meanOnly,'value',0);
    end
end
BA_drawTimeseries(handles);



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function probeSet_Callback(hObject, eventdata, handles)
% hObject    handle to probeSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of probeSet as text
%        str2double(get(hObject,'String')) returns contents of probeSet as a double


% --- Executes during object creation, after setting all properties.
function probeSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to probeSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nch_Callback(hObject, eventdata, handles)
% hObject    handle to nch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nch as text
%        str2double(get(hObject,'String')) returns contents of nch as a double


% --- Executes during object creation, after setting all properties.
function nch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function length_Callback(hObject, eventdata, handles)
% hObject    handle to length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length as text
%        str2double(get(hObject,'String')) returns contents of length as a double


% --- Executes during object creation, after setting all properties.
function length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Callback(hObject, eventdata, handles)
% hObject    handle to originalT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of originalT as text
%        str2double(get(hObject,'String')) returns contents of originalT as a double


% --- Executes during object creation, after setting all properties.
function T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to originalT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in modeSelect.
function modeSelect_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in modeSelect
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over single.
function single_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on key press with focus on single and none of its controls.
function single_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to single (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function modeSelect_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to modeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over channel.
function channel_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on channel and none of its controls.
function channel_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over oxy.
function oxy_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to oxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in multiple.
function multiple_Callback(hObject, eventdata, handles)
set(handles.channel,'enable','on');
BA_drawTimeseries(handles);



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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over preprocessed.
function preprocessed_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to preprocessed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in singleCh.
function singleCh_Callback(hObject, eventdata, handles)
% hObject    handle to singleCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_drawTimeseries(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns singleCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from singleCh


% --- Executes during object creation, after setting all properties.
function singleCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singleCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in multipleMode.
function multipleMode_Callback(hObject, eventdata, handles)
% hObject    handle to multipleMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.raw,'value',1);
set(handles.preprocessed,'value',0);
set(handles.singleMode,'value',0);
set(handles.multipleMode,'value',1);
set(handles.oxy,'value',1);
set(handles.dxy,'value',0);
set(handles.total,'value',0);
set(handles.mean,'enable','on');
set(handles.meanOnly,'enable','on');
set(handles.increaseCh,'enable','off');
set(handles.decreaseCh,'enable','off');
set(handles.allChannel,'enable','on');
BA_drawTimeseries(handles);
handles_button = get(handles.channelPanel,'UserData');
set(handles_button(end-1),'enable','on');

% Update handles structure
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of multipleMode


% --- Executes on button press in resetAxes.
function resetAxes_Callback(hObject, eventdata, handles)
% hObject    handle to resetAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
multiviewMode = questdlg('Are you sure to reset?','Reset confirm','Yes','No','No');
inpath=get(handles.addpath,'userdata');
if strcmp(multiviewMode,'Yes') && ischar(inpath)
    set(handles.sublistbox,'value',1);
    set(handles.axestimeseries,'userdata','');
    
    subid=get(handles.sublistbox,'value');
    DesignType=get(handles.DesignType,'value');
    
    if DesignType == 2
        set(handles.diffcondbox,'value',1);
        user_cond=get(handles.diffcondbox,'value');
        design_inf=get(handles.diffcondbox,'userdata');
        usd{1}=user_cond;

        for condn = 1:size(design_inf,2)
           usd{2,1}{condn,1}=design_inf{subid,condn}(:,1)';
           usd{3,1}{condn,1}=design_inf{subid,condn}(:,2)';
        end

        set( handles.Task_Opt_Pannel,'userdata',usd);
    elseif DesignType == 1
        set(handles.cond_listbox,'value',1);
        usd=get(handles.Task_Opt_Pannel,'userdata');
        usd{1,1}=1;
        set(handles.Task_Opt_Pannel,'userdata',usd);          
    end
    
    NR_DataViewer_set(handles);
    BA_drawTimeseries(handles);

end

% --------------------------------------------------------------------
function gridCon_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to gridCon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mean.
function mean_Callback(hObject, eventdata, handles)
% hObject    handle to mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.mean,'value')
    set(handles.meanOnly,'value',0)
end
BA_drawTimeseries(handles);

% --- Executes on button press in meanOnly.
function meanOnly_Callback(hObject, eventdata, handles)
% hObject    handle to meanOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.meanOnly,'value')
    set(handles.mean,'value',0);
end
BA_drawTimeseries(handles);
% Hint: get(hObject,'Value') returns toggle state of meanOnly

function timeLeft_Callback(hObject, eventdata, handles)
% hObject    handle to timeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_drawTimeseries(handles);
% Hints: get(hObject,'String') returns contents of timeLeft as text
%        str2double(get(hObject,'String')) returns contents of timeLeft as a double


% --- Executes during object creation, after setting all properties.
function timeLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in timeMode.
function timeMode_Callback(hObject, eventdata, handles)
% hObject    handle to timeMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.timeMode,'value',1);
set(handles.timeLeft,'enable','on');
set(handles.timeRight,'enable','on');
set(handles.scanMode,'value',0);
set(handles.rangeLeft,'enable','off');
set(handles.rangeRight,'enable','off');
NR_drawTimeseries(handles);
% Hint: get(hObject,'Value') returns toggle state of timeMode


% --- Executes on button press in scanMode.
function scanMode_Callback(hObject, eventdata, handles)
% hObject    handle to scanMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.timeMode,'value',0);
set(handles.timeLeft,'enable','off');
set(handles.timeRight,'enable','off');
set(handles.scanMode,'value',1);
set(handles.rangeLeft,'enable','on');
set(handles.rangeRight,'enable','on');
NR_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of scanMode



function timeRight_Callback(hObject, eventdata, handles)
% hObject    handle to timeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of timeRight as text
%        str2double(get(hObject,'String')) returns contents of timeRight as a double


% --- Executes during object creation, after setting all properties.
function timeRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function viewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function timeOnset_Callback(hObject, eventdata, handles)
% hObject    handle to timeOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeOnset as text
%        str2double(get(hObject,'String')) returns contents of timeOnset as a double


% --- Executes during object creation, after setting all properties.
function timeOnset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timeDuration_Callback(hObject, eventdata, handles)
% hObject    handle to timeDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeDuration as text
%        str2double(get(hObject,'String')) returns contents of timeDuration as a double


% --- Executes during object creation, after setting all properties.
function timeDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in design.
function design_Callback(hObject, eventdata, handles)
% hObject    handle to design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of design



% --- Executes on button press in preprocess.
function preprocess_Callback(hObject, eventdata, handles)
% hObject    handle to preprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

stepA = get(handles.step_segment,'value');
stepB = get(handles.step_detrend,'value');
stepC = get(handles.step_motioncorrection,'value');
stepD = get(handles.step_filter,'value');

if ~isPreprocessStepValid([stepA,stepB,stepC,stepD])
    errordlg('Wrong step setting', 'Error');
else
    set(handles.preprocess,'enable','off');
    set(handles.preprocessed,'enable','on','value',1);
    if 1 == get(handles.multipleMode,'value');
        set(handles.raw,'value',0);
    end
    NR_generate_preprossedData(handles);
    if 1 == get(handles.preprocessed,'value');
        BA_drawTimeseries(handles);
    end
end
% Update handles structure
guidata(hObject, handles);



function utilities_Callback(hObject, eventdata, handles)
% hObject    handle to utilities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in preprocessedOnly.
function preprocessedOnly_Callback(hObject, eventdata, handles)
% hObject    handle to preprocessedOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.preprocessedOnly,'value')
    set(handles.preprocessed,'value',0);
    set(handles.mean,'value',0);
    set(handles.meanOnly,'value',0);
end
BA_drawTimeseries(handles);
% Hint: get(hObject,'Value') returns toggle state of preprocessedOnly



% --------------------------------------------------------------------
function saveData_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to saveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function selectData_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to selectData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentDir = get(handles.selectData,'userdata');
if isempty(currentDir)
    [filename,pathname] = uigetfile('*.mat');
else
    [filename,pathname] = uigetfile(fullfile(currentDir,'*.mat'));
end
dataSource = [pathname filename];
if ischar(filename)
    set(handles.selectData,'userdata',pathname);
    set(handles.viewer,'userdata',dataSource);
    NR_DataViewer_set(handles);
    BA_drawTimeseries(handles);
    set(handles.increaseCh,'enable','on');
    set(handles.decreaseCh,'enable','on');
    set(handles.allChannel,'enable','off');
    if(strcmp(get(handles.axestimeseries,'XGrid'),'on'))
        grid(handles.axestimeseries,'on');
    else
        grid(handles.axestimeseries,'off');
    end
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in raw.
function raw_Callback(hObject, eventdata, handles)
% hObject    handle to raw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.multipleMode,'value')==1
    if get(handles.raw,'value') == 1
        set(handles.preprocessed,'value',0);
    end
    if get(handles.raw,'value') == 0 && get(handles.preprocessed,'value') == 0
        set(handles.mean,'value',0);
        set(handles.meanOnly,'value',0);
    end
end
BA_drawTimeseries(handles);
% Hint: get(hObject,'Value') returns toggle state of raw
% Update handles structure
guidata(hObject, handles);


% --- Executes on mouse press over figure background.
function viewer_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axestimeseries_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axestimeseries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function viewerHelp_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to viewerHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15


% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox16


% --------------------------------------------------------------------
function gridControl_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to gridControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(strcmp(get(handles.axestimeseries,'XGrid'),'on'))
    grid(handles.axestimeseries,'off');
else
    set(handles.axestimeseries,'XGrid','on');
end


% --- Executes on key press with focus on rangeRight and none of its controls.
function rangeRight_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to rangeRight (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over rangeRight.
function rangeRight_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on order and none of its controls.
function order_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');


% --- Executes on key press with focus on rangeLeft and none of its controls.
function rangeLeft_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to rangeLeft (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');


% --- Executes on key press with focus on bandlow and none of its controls.
function bandlow_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to bandlow (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');


% --- Executes on key press with focus on bandhigh and none of its controls.
function bandhigh_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to bandhigh (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.preprocess,'enable','on');


% --------------------------------------------------------------------
function reColor_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to reColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if 1 == get(handles.multipleMode,'value')
    data = get(handles.axestimeseries,'userdata');
    color = data.color;
    n = size(color,1);
    s = randperm(n);
    for i = 1:n
        newcolor(i,:) = color(s(i),:);
    end
    data.color = newcolor;
    set(handles.axestimeseries,'UserData',data);
    NR_drawTimeseries(handles);
end
% Update handles structure
guidata(hObject, handles);



% --- Executes on selection change in step_segment.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_segment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_segment


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close viewer.
function viewer_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global Probe2D;
% Hint: delete(hObject) closes the figure
delete(hObject);


% --------------------------------------------------------------------
function legnedControl_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to legnedControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

legend(handles.axestimeseries,'toggle');

global newaxes;
if ~isempty(newaxes) && get(handles.showDesign,'value')
    legend(newaxes,'toggle');
end



% --- Executes on button press in addpath.
function addpath_Callback(hObject, eventdata, handles)
% hObject    handle to addpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% =========================================================================
inpath=uigetdir;

if ischar(inpath)
    % reset the default setting -------------------------------------------
    set(handles.add_design_mat,'visible','off');
    set(handles.design_mat_path,'visible','off');
    set(handles.diffcondbox,'visible','off');
    set(handles.DesignType,'value',1);
    set(handles.Units,'value',1);
    set(handles.addcondition,'visible','on');
    set(handles.cond_listbox,'visible','on');

    handles.UnitStat=1;
    handles.DesTpStat=1;

    handles.condi_num=0;
    usd=cell(3,1);

    set(handles.Task_Opt_Pannel,'userdata',usd);
    set(handles.diffcondbox,'userdata',{});

    % reset the default setting -------------------------------------------
    
    sublist=dir(fullfile(inpath,'*.mat'));
    for n=1:length(sublist)
        subname{n}=sublist(n).name(1:end-4);
    end
    set(handles.addpath,'userdata',inpath);
    set(handles.sublistbox,'string',subname);
    
    subfile=fullfile(inpath,[subname{1},'.mat']);
    set(handles.viewer,'UserData',subfile);
    set(handles.axestimeseries,'UserData',[]);
        
    NR_DataViewer_set(handles);
end
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sublistbox.
function sublistbox_Callback(hObject, eventdata, handles)
% hObject    handle to sublistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns sublistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sublistbox

% =========================================================================
subid=get(handles.sublistbox,'value');
subname=get(handles.sublistbox,'string');

inpath=get(handles.addpath,'userdata');

if ischar(inpath)
    if subid
        subfile=fullfile(inpath,[subname{subid},'.mat']);

        % -----------------------------------------------------------------
        load(subfile);
        data.raw = nirsdata;
       
        defaultSetDir = which('NIRS_KIT');
        index_dir=fileparts(defaultSetDir);
        defaultSetDir=fullfile(index_dir,'file');
        colortemp = load(fullfile(defaultSetDir,'mycolorTable.mat'));
        data.color = colortemp.mycolorTable;
        set(handles.axestimeseries,'UserData',data);
        if strcmp(get(handles.preprocess,'enable'),'off') && strcmp(get(handles.preprocessed,'enable'),'on')
            NR_generate_preprossedData(handles);
        end
        % -----------------------------------------------------------------
        
        DesignType=get(handles.DesignType,'value');
        user_cond=get(handles.diffcondbox,'value');
        if DesignType == 2
            design_inf=get(handles.diffcondbox,'userdata');
            usd{1}=user_cond;
            
            for condn = 1:size(design_inf,2)
               usd{2,1}{condn,1}=design_inf{subid,condn}(:,1)';
               usd{3,1}{condn,1}=design_inf{subid,condn}(:,2)';
            end
            
            set( handles.Task_Opt_Pannel,'userdata',usd);
        end
        
        
        if isfield(data.raw,'exception_channel')
            handles_buttons = get(handles.channelPanel,'userdata');
            for i=1:length(handles_buttons)
                if data.raw.exception_channel(i) == 1
                    set(handles_buttons(i), 'ForegroundColor',[0.753,0.753,0.753]);
                else
                    set(handles_buttons(i), 'ForegroundColor',[0,0,0]);
                end
            end
        end
        
        BA_drawTimeseries(handles);
    end
end
% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function sublistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sublistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function channelPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in addprobeset.
function addprobeset_Callback(hObject, eventdata, handles)
% hObject    handle to addprobeset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% =========================================================================
defaultSaveDir = which('NIRS_KIT');
index_dir=fileparts(defaultSaveDir);
defaultSetDir=fullfile(index_dir,'Sample_Data','Temp_2D_ProbeSet');
[filename, pathname] = uigetfile(fullfile(defaultSetDir,'*.mat'));

if ischar(filename)
    probepath=fullfile(pathname,filename);
    load(probepath);
    global Probe2D;
    Probe2D=probeSets;
        
    NR_DataViewer_set(handles);
    BA_drawTimeseries(handles);
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in clearprobeset.
function clearprobeset_Callback(hObject, eventdata, handles)
% hObject    handle to clearprobeset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Probe2D;
Probe2D={};

NR_DataViewer_set(handles);
BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes when uipanel25 is resized.
function uipanel25_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function axestimeseries_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axestimeseries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axestimeseries


% --- Executes on button press in addcondition.
function addcondition_Callback(hObject, eventdata, handles)
% hObject    handle to addcondition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpath=get(handles.addpath,'userdata');
sublist=get(handles.sublistbox,'string');
if isempty(sublist)
    msgbox('There is no data!  Please add your data folder', 'Lock of subdata');
elseif ~isempty(sublist)
    
    condi_num=handles.condi_num+1;
    [name,onset,duration]=inputcondinf(condi_num);
    
    if ~isempty(name) && ~isempty(onset) && ~isempty(duration)
        userdata{1,1}=['Condition (',num2str(condi_num),')'];
        userdata{2,1}=['......Name       ',name];
        userdata{3,1}=['......Onset       [',num2str(onset),']'];
        userdata{4,1}=['......Duration    [',num2str(duration),']'];
        
        if strcmp(get(handles.step_segment,'enable'),'on')
            set(handles.step_segment,'enable','off');
            if strcmp(get(handles.leftseg,'enable'),'on')
                set(handles.leftseg,'enable','off');
                set(handles.rightseg,'enable','off'); 
            end
        end
        
        cond_userdata=get(handles.cond_listbox,'userdata');
        if isempty(cond_userdata)
            cond_userdata=userdata;
            usd=get(handles.Task_Opt_Pannel,'userdata');
            usd{1,1}=1;
            usd{2,1}={onset};
            usd{3,1}={duration};
            set( handles.Task_Opt_Pannel,'userdata',usd);
            set(handles.cond_listbox,'value',1);
            set(handles.cond_listbox,'userdata',cond_userdata);
            set(handles.cond_listbox,'string',cond_userdata);
            handles.condi_num=handles.condi_num+1;
            
            BA_drawTimeseries(handles);
        else
            cond_userdata=[cond_userdata;userdata];
            usd=get(handles.Task_Opt_Pannel,'userdata');
            usd{2,1}=[usd{2,1};{onset}];
            usd{3,1}=[usd{3,1};{duration}];
            set( handles.Task_Opt_Pannel,'userdata',usd);
            
            set(handles.cond_listbox,'userdata',cond_userdata);
            set(handles.cond_listbox,'string',cond_userdata);
            handles.condi_num=handles.condi_num+1;
        end
        
    end
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in cond_listbox.
function cond_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to cond_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns cond_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cond_listbox
user_id=get(handles.cond_listbox,'value');

if mod(user_id-1,4)==0
    set(handles.cond_listbox,'UIContextMenu',handles.condition_right);
    usd=get(handles.Task_Opt_Pannel,'userdata');
    usd{1,1}=(user_id-1)/4+1;
    set(handles.Task_Opt_Pannel,'userdata',usd);
    
    BA_drawTimeseries(handles);
else
    set(handles.cond_listbox,'UIContextMenu',[]);
end
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cond_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DesignType.
function DesignType_Callback(hObject, eventdata, handles)
% hObject    handle to DesignType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns DesignType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DesignType
desigtp=get(handles.DesignType,'value');
usd=cell(3,1);
set(handles.Task_Opt_Pannel,'userdata',usd);

if desigtp ~= get(handles.DesignType,'userdata')
    if desigtp==2
        set(handles.addcondition,'visible','off');
        set(handles.cond_listbox,'visible','off');
        set(handles.cond_listbox,'string',[]);

        set(handles.add_design_mat,'visible','on');
        set(handles.design_mat_path,'visible','on');
        set(handles.diffcondbox,'visible','on');
        
        if isfield(handles,'condi_num')
            handles.condi_num = 0;
        end
        
        if ~isempty(get(handles.cond_listbox,'userdata'))
            set(handles.cond_listbox,'userdata',[]);
            set(handles.cond_listbox,'string','');
        end
    else
        set(handles.add_design_mat,'visible','off');
        set(handles.design_mat_path,'visible','off');
        set(handles.diffcondbox,'visible','off');
        set(handles.design_mat_path,'string',[]);
        set(handles.diffcondbox,'string',[]);

        set(handles.addcondition,'visible','on');
        set(handles.cond_listbox,'visible','on');
    end
end

set(handles.DesignType,'userdata',desigtp);


% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function DesignType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DesignType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Units.
function Units_Callback(hObject, eventdata, handles)
% hObject    handle to Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
% Hints: contents = cellstr(get(hObject,'String')) returns Units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Units
global newaxes;
if ~isempty(newaxes)
    legend(newaxes,'off');
end

handles.condi_num =0;

usd=get(handles.Task_Opt_Pannel,'userdata');
usd{1,1}=[];
set(handles.Task_Opt_Pannel,'userdata',usd);

if ischar(get(handles.design_mat_path,'string'))
    set(handles.design_mat_path,'string','');
end

set(handles.diffcondbox,'string','');
set(handles.diffcondbox,'value',[]);
set(handles.diffcondbox,'userdata',[]);
set(handles.cond_listbox,'string','');
set(handles.cond_listbox,'value',[]);
set(handles.cond_listbox,'userdata',[]);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function Units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_design_mat.
function add_design_mat_Callback(hObject, eventdata, handles)
% hObject    handle to add_design_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpath=get(handles.addpath,'userdata');
sublist=get(handles.sublistbox,'string');
if isempty(sublist)
    msgbox('There is no data!  Please add your data folder', 'Lock of subdata');
else
    [fname,fpath] = uigetfile('.mat','Select your Design Inf mat file');
    if ischar(fname)
        design_mat=fullfile(fpath,fname);
        load(design_mat);

        [n_designmat,~]=size(design_inf);
        n_sublist=get(handles.sublistbox,'string');

        des_nm = design_inf(2:end,1);
        is_same = strcmp(des_nm, n_sublist);

        if n_designmat-1==length(n_sublist) && min(is_same) ~= 0
            set(handles.design_mat_path,'string',design_mat);
            conddifstr=design_inf(1,2:end)';
            set(handles.diffcondbox,'value',1);
            set(handles.diffcondbox,'string',conddifstr);
            set(handles.diffcondbox,'userdata',design_inf(2:end,2:end));

            if strcmp(get(handles.step_segment,'enable'),'on')
                set(handles.step_segment,'enable','off');
                if strcmp(get(handles.leftseg,'enable'),'on')
                    set(handles.leftseg,'enable','off');
                    set(handles.rightseg,'enable','off'); 
                end
            end

            subid=get(handles.sublistbox,'value');
            [~,condn]=size(design_inf);
            for jj=1:condn-1
                usd=get(handles.Task_Opt_Pannel,'userdata');
                usd{1,1}=1;
                usd{2,1}{jj,1}=design_inf{subid+1,jj+1}(:,1)';
                usd{3,1}{jj,1}=design_inf{subid+1,jj+1}(:,2)';
                set(handles.Task_Opt_Pannel,'userdata',usd);
            end
            
            BA_drawTimeseries(handles);
            
        else
            set(handles.diffcondbox,'string','');

            msgbox({'The length of your design_inf.mat is unequal to the sub num!!!'; ...
                'Or the sub nemes in the Design Inf.mat are not indentical with subnames in the input folder!!!'; ...
                ''; 'Please check !!!'},'Design inf is wrong!','warn');
        end
    end
end
% Update handles structure
guidata(hObject, handles);


function design_mat_path_Callback(hObject, eventdata, handles)
% hObject    handle to design_mat_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of design_mat_path as text
%        str2double(get(hObject,'String')) returns contents of design_mat_path as a double


% --- Executes during object creation, after setting all properties.
function design_mat_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to design_mat_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function cond_rm_Callback(hObject, eventdata, handles)
% hObject    handle to cond_rm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
userdata=get(handles.cond_listbox,'userdata');
user_id=get(handles.cond_listbox,'value');

userdata=userdata(setdiff(1:length(userdata),user_id:user_id+3));
usd=get(handles.Task_Opt_Pannel,'userdata');
usd{2,1}=usd{2,1}(setdiff(1:handles.condi_num,(user_id-1)./4+1));
usd{3,1}=usd{3,1}(setdiff(1:handles.condi_num,(user_id-1)./4+1));

if ~isempty(userdata)
    for i=1:handles.condi_num-1
        userdata{(i-1)*4+1,1}=['Condition (',num2str(i),')'];
    end
end
handles.condi_num=handles.condi_num-1;


set(handles.cond_listbox,'userdata',userdata);
set(handles.cond_listbox,'value',1);
set(handles.cond_listbox,'string',userdata);


usd{1,1}=1;
set(handles.Task_Opt_Pannel,'userdata',usd);
BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);

% --------------------------------------------------------------------
function condition_right_Callback(hObject, eventdata, handles)
% hObject    handle to condition_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function [name,onset,duration]=inputcondinf(condi_num)

condstr=['Design Inf for Condition',num2str(condi_num)];
condinf=inputdlg({'Condition Name:','Onset:input 5:5:20 or 5 10 15 20','Duration: input a scalar or a vector with the same length of onset'},condstr);
if isempty(condinf)
    name = '';
    onset = '';
    duration = '';
elseif ~isempty(condinf{1}) && ~isempty(condinf{2}) && ~isempty(condinf{3})
    name=condinf{1};
    
    if ~isempty(strfind(condinf{2},']'))
        condinf{2}=condinf{2}(2:end-1);
    end
    if isempty(strfind(condinf{2},':'))
        onset=str2num(condinf{2});
    else
        onset=eval(condinf{2});
    end
    
    if ~isempty(strfind(condinf{3},']'))
        condinf{3}=condinf{3}(2:end-1);
    end
    if isempty(strfind(condinf{3},':'))
        duration=str2num(condinf{3});
        if length(duration)==1
            duration=ones(1,length(onset))*duration;
        end
    else
        duration=eval(condinf{3});
    end
    
    if length(duration)~=length(onset)
        errordlg('The num of onset and duration is unequal !!!    Please re-enter !!!','Design inf is wrong!');
        [name,onset,duration]=inputcondinf(condi_num);
    end
else
    errordlg('Missing input value !!!    Please re-enter !!!','Design inf is wrong!');
    [name,onset,duration]=inputcondinf(condi_num);
end




% --- Executes on selection change in diffcondbox.
function diffcondbox_Callback(hObject, eventdata, handles)
% hObject    handle to diffcondbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns diffcondbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from diffcondbox
usd=get(handles.Task_Opt_Pannel,'userdata');
usd{1,1}=get(handles.diffcondbox,'value');
set(handles.Task_Opt_Pannel,'userdata',usd);

BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function diffcondbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diffcondbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --------------------------------------------------------------------
function zoom_in_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to zoom_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

zoom_stat=get(handles.zoom_in,'stat');
global ax2 newaxes;
if strcmp(zoom_stat,'on')
    if ~isempty(ax2) && ~isempty(newaxes)
        linkaxes([handles.axestimeseries,ax2,newaxes],'x');
    end
    zoom on;
else
    if ~isempty(ax2) && ~isempty(newaxes)
        linkaxes([handles.axestimeseries,ax2,newaxes],'off');
    end
    zoom off;
end


% --------------------------------------------------------------------
function hand_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to hand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hand_stat=get(handles.hand,'stat');
global ax2 newaxes;
if strcmp(hand_stat,'on')
    if ~isempty(ax2) && ~isempty(newaxes)
        linkaxes([handles.axestimeseries,ax2,newaxes],'x');
    end
    pan on;
else
    if ~isempty(ax2) && ~isempty(newaxes)
        linkaxes([handles.axestimeseries,ax2,newaxes],'off');
    end
    pan off;
end



function rangeLeft_Callback(hObject, eventdata, handles)
% hObject    handle to rangeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of rangeLeft as text
%        str2double(get(hObject,'String')) returns contents of rangeLeft as a double


% --- Executes during object creation, after setting all properties.
function rangeLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in rangeType.
function rangeType_Callback(hObject, eventdata, handles)
% hObject    handle to rangeType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% data = get(handles.axestimeseries,'userdata');
% T = data.raw.T;
global rangeType;
if get(handles.rangeType,'value') == 1
    if(rangeType == 1)
        return;
    end
    rangeType=1;
else
    if(rangeType == 2)
        return;
    end
    rangeType=2;
end
BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns rangeType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rangeType


function rangeRight_Callback(hObject, eventdata, handles)
% hObject    handle to rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BA_drawTimeseries(handles);
% Update handles structure
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of rangeRight as text
%        str2double(get(hObject,'String')) returns contents of rangeRight as a double



% --- Executes during object creation, after setting all properties.
function rangeType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function rangeRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
K = str2num(get(handles.channel,'string'));
if 1 == get(handles.singleMode,'value') && length(K) > 1
    errordlg('Cannot draw multiple channels in single mode', 'Error');
else
    handles_button = get(handles.channelPanel,'userdata');
    N = length(handles_button);
    for i=1:N
        set(handles_button(i), 'BackgroundColor',[0.941,0.941,0.941]);
    end
    for i=1:length(K)
        set(handles_button(K(i)), 'BackgroundColor',[0.7,0.7,1]);
    end
    BA_drawTimeseries(handles);
end

% Hints: get(hObject,'String') returns contents of channel as text
%        str2double(get(hObject,'String')) returns contents of channel as a double


% --- Executes during object creation, after setting all properties.
function channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in increaseCh.
function increaseCh_Callback(hObject, eventdata, handles)
% hObject    handle to increaseCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_channelControl_increase(handles);


% --- Executes on button press in decreaseCh.
function decreaseCh_Callback(hObject, eventdata, handles)
% hObject    handle to decreaseCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_channelControl_decrease(handles);


% --- Executes on button press in allChannel.
function allChannel_Callback(hObject, eventdata, handles)
% hObject    handle to allChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NR_channelControl_all(handles);
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in clearChannel.
function clearChannel_Callback(hObject, eventdata, handles)
% hObject    handle to clearChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
usd=get(handles.Task_Opt_Pannel,'userdata');
usercond=usd{1,1};

if ~isempty(usercond)
    usd{1,1}=[];
    set(handles.Task_Opt_Pannel,'userdata',usd);
%     set(handles.cond_listbox,'value',{ });
%     set(handles.diffcondbox,'value',0);
end
NR_channelControl_clear(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in text_mc.
function step_motioncorrection_Callback(hObject, eventdata, handles)
% hObject    handle to text_mc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns text_mc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from text_mc
if get(handles.step_motioncorrection,'value') == 6
    set(handles.method_mc,'enable','off');
else
    set(handles.method_mc,'enable','on');
end

set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');


% --- Executes during object creation, after setting all properties.
function text_mc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_mc (see GCBO)
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
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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

set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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


% --- Executes on selection change in step_custom.
function step_custom_Callback(hObject, eventdata, handles)
% hObject    handle to step_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_custom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_custom

if get(handles.step_custom,'value') == 6
    set(handles.custom_name_box,'string','','enable','off');
    set(handles.add_custom,'enable','off');
else
    set(handles.custom_name_box,'enable','on');
    set(handles.add_custom,'enable','on');
end

set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');
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



function custom_name_box_Callback(hObject, eventdata, handles)
% hObject    handle to custom_name_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of custom_name_box as text
%        str2double(get(hObject,'String')) returns contents of custom_name_box as a double
set(handles.preprocess,'enable','on');
set(handles.preprocessed,'value',0,'enable','off');



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


% --- Executes on button press in draw_ref.
function draw_ref_Callback(hObject, eventdata, handles)
% hObject    handle to draw_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of draw_ref

if get(handles.draw_ref,'value') == 1
    
   if get(handles.oxy,'value') == 1 
      if get(handles.dxy,'value') == 1 || get(handles.total,'value')
          set(handles.dxy,'value',0);
          set(handles.total,'value',0);
      end
   end
   
   if get(handles.dxy,'value') == 1 && get(handles.total,'value') == 1 
       set(handles.total,'value',0);
   end   
   
   set(handles.yr_min,'enable','on');
   set(handles.yr_max,'enable','on');
else
   set(handles.yr_min,'enable','off');
   set(handles.yr_max,'enable','off');
end


BA_drawTimeseries(handles); 



% --- Executes on button press in across_sub.
function across_sub_Callback(hObject, eventdata, handles)
% hObject    handle to across_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of across_sub

if get(handles.across_sub,'value') == 1
    set(handles.sublistbox,'enable','off');
    
    handles_button = get(handles.channelPanel,'UserData');
    N = length(handles_button);
    for hnd=handles_button
        set(hnd, 'ForegroundColor','k');
    end
else
    set(handles.sublistbox,'enable','on');

    data = get(handles.axestimeseries,'UserData');
    if isfield(data.raw,'exception_channel')
        handles_buttons = get(handles.channelPanel,'userdata');
        for i=1:length(handles_buttons)
            if data.raw.exception_channel(i) == 1
                set(handles_buttons(i), 'ForegroundColor',[0.753,0.753,0.753]);
            else
                set(handles_buttons(i), 'ForegroundColor',[0,0,0]);
            end
        end
    end
    
end

BA_drawTimeseries(handles);


% --- Executes on button press in show_fig.
function show_fig_Callback(hObject, eventdata, handles)
% hObject    handle to show_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_fig

global ax2;

handles.view = figure('color','w');
ax_1 = axes;

figch1 = get(handles.axestimeseries,'children');
copyobj(figch1,ax_1);

xLimit = xlim(handles.axestimeseries);
yLimit = ylim(handles.axestimeseries);
axis(ax_1,[xLimit,yLimit]);

figch2 = get(ax2,'children');
if isempty(figch2)
    set(ax_1,'box','on');
else
    ax_2 = axes('position',get(ax_1,'position'),'yaxislocation','right','color','none');
    set(ax_2,'box','on');set(ax_2,'xTick',[]);set(ax_2,'ticklength',[0.005 0.005]);
    
    hold on;
    copyobj(figch2,ax_2);
    
    axis(ax_2,[xLimit,ylim(ax2)]);

end

set(handles.save_fig,'enable','on');
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in save_fig.
function save_fig_Callback(hObject, eventdata, handles)
% hObject    handle to save_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_fig

if ishandle(handles.view)
    [fn,fp]= uiputfile({'*.tif';'*.eps';'*.emf'},'Save Current Figure',fullfile(pwd,'Block Average'));
    if ischar(fn)
        out_type=fn(end-2:end);
        if strcmp(out_type,'tif')
            export_fig(handles.view,fullfile(fp,fn),'-m2.5');
        elseif strcmp(out_type,'eps')
            print(handles.view,'-depsc','-painters',fullfile(fp,fn));
        elseif strcmp(out_type,'emf')
            saveas(handles.view,fullfile(fp,fn));
        end
        msgbox('Result Figure has been saved','Success','help');
    end
else
    msgbox('The figure handle has been closed','Warning','warn');
end


% --- Executes on button press in labels.
function labels_Callback(hObject, eventdata, handles)
% hObject    handle to labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of labels

% if get(handles.labels,'value') == 1
   BA_drawTimeseries(handles); 
% end


% --- Executes on button press in save_data.
function save_data_Callback(hObject, eventdata, handles)
% hObject    handle to save_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

group_ba_data = block_average_save(handles);

[fn,fp]= uiputfile('*.mat','Save Current Figure',fullfile(pwd,'group_ba_data'));
if ischar(fn)
    save(fullfile(fp,fn),'group_ba_data');
end



function yr_min_Callback(hObject, eventdata, handles)
% hObject    handle to yr_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yr_min as text
%        str2double(get(hObject,'String')) returns contents of yr_min as a
%        double\

set(handles.Ylimts_Tag,'value',1);

BA_drawTimeseries(handles);

set(handles.Ylimts_Tag,'value',0);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function yr_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yr_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yr_max_Callback(hObject, eventdata, handles)
% hObject    handle to yr_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yr_max as text
%        str2double(get(hObject,'String')) returns contents of yr_max as a double

set(handles.Ylimts_Tag,'value',1);

BA_drawTimeseries(handles);

set(handles.Ylimts_Tag,'value',0);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function yr_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yr_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
