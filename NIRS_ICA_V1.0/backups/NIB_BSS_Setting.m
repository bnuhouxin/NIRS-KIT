function varargout = NIB_BSS_Setting(varargin)
% NIB_BSS_SETTING M-file for NIB_BSS_Setting.fig
%      NIB_BSS_SETTING, by itself, creates a new NIB_BSS_SETTING or raises the existing
%      singleton*.
%
%      H = NIB_BSS_SETTING returns the handle to a new NIB_BSS_SETTING or the handle to
%      the existing singleton*.
%
%      NIB_BSS_SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIB_BSS_SETTING.M with the given input arguments.
%
%      NIB_BSS_SETTING('Property','Value',...) creates a new NIB_BSS_SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIB_BSS_Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIB_BSS_Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIB_BSS_Setting

% Last Modified by GUIDE v2.5 02-Jul-2020 11:19:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIB_BSS_Setting_OpeningFcn, ...
                   'gui_OutputFcn',  @NIB_BSS_Setting_OutputFcn, ...
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


% --- Executes just before NIB_BSS_Setting is made visible.
function NIB_BSS_Setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIB_BSS_Setting (see VARARGIN)

% Choose default command line output for NIB_BSS_Setting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIB_BSS_Setting wait for user response (see UIRESUME)
% uiwait(handles.NIB_BSS_Setting);


% --- Outputs from this function are returned to the command line.
function varargout = NIB_BSS_Setting_OutputFcn(hObject, eventdata, handles) 
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
%
set(handles.checkbox1,'Value',1);
set(handles.checkbox2,'Value',0);
% set(handles.advance1,'Value',0);
% set(handles.advance_p1,'Value',2);
% % set(handles.advance_p11,'Enable','off');
% set(handles.advance_p2,'String',10000);
% % set(handles.advance_p21,'Enable','off');
% set(handles.advance_p3,'Value',1);
% % set(handles.advance_p31,'Enable','off');
% set(handles.advance_p4,'String',0.00001);
% set(handles.advance_p41,'Enable','off');


% --- Executes on selection change in advance_p1.
function advance_p1_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns advance_p1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from advance_p1


% --- Executes during object creation, after setting all properties.
function advance_p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in advance_p2.
function advance_p2_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns advance_p2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from advance_p2


% --- Executes during object creation, after setting all properties.
function advance_p2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function advance_p3_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of advance_p2 as text
%        str2double(get(hObject,'String')) returns contents of advance_p2 as a double


% --- Executes during object creation, after setting all properties.
function advance_p3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function advance_p4_Callback(hObject, eventdata, handles)
% hObject    handle to advance_p4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of advance_p4 as text
%        str2double(get(hObject,'String')) returns contents of advance_p4 as a double


% --- Executes during object creation, after setting all properties.
function advance_p4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to advance_p4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in accept.
function accept_Callback(hObject, eventdata, handles)
% hObject    handle to accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% alg1 = get(handles.checkbox1,'Value');
handles_advance=findobj('Tag','advance');

%% preprocessing parameters
is_preprocess=0;
if get(handles.step_segment,'value') ~= 1
    preprocessSet{get(handles.step_segment,'value')-1} = {'NID_segment',get(handles.leftseg,'string'),get(handles.rightseg,'string')};
    is_preprocess=1;
end

if get(handles.step_detrend,'value') ~= 1
    preprocessSet{get(handles.step_detrend,'value')-1} = {'NID_detrend',get(handles.order,'string')};
    is_preprocess=1;
end

if get(handles.step_bandpassfilter,'value') ~= 1
    preprocessSet{get(handles.step_bandpassfilter,'value')-1} = {'NID_bandpassfilter',get(handles.bandlow,'string'),get(handles.bandhigh,'string')};
    is_preprocess=1;
end

if get(handles.step_downsample,'value') ~= 1
    preprocessSet{get(handles.step_downsample,'value')-1} = {'NID_resample',get(handles.newT,'string')};
    is_preprocess=1;
end

if is_preprocess
    handles_advance.UserData.preprocessSet=preprocessSet;
end
%% BSS algorithms and parameters
alg1 = get(handles.radiobutton1,'Value');
% alg2 = get(handles.radiobutton2,'Value');
% alg3 = get(handles.radiobutton3,'Value');
% alg4 = get(handles.radiobutton4,'Value');
alg5 = get(handles.radiobutton5,'Value');


if alg1
    ap0 = 'FastICA';
%     ap1 = get(handles.advance_p1,'Value');
%     % set(handles.advance_p11,'Enable','off');
%     ap2 = get(handles.advance_p2,'String');
%     % set(handles.advance_p21,'Enable','off');
%     ap3 = get(handles.advance_p3,'Value');
%     % set(handles.advance_p31,'Enable','off');
%     ap4 = get(handles.advance_p4,'String');
    % set(handles.advance_p41,'Enable','off');
    advance_p.advance_ica_alg = ap0;
%     advance_p.advance_p1 = ap1;
%     advance_p.advance_p2 = ap2;
%     advance_p.advance_p3 = ap3;
%     advance_p.advance_p4 = ap4;
% elseif alg2
%     ap0 = 'InfomaxICA';
% %     handles_advance=findobj('Tag','advance');
%     advance_p.advance_ica_alg = ap0;
% elseif alg3
%     ap0 = 'ERBM';
% %     handles_advance=findobj('Tag','advance');
%     advance_p.advance_ica_alg = ap0;
% elseif alg4
%     ap0 = 'PCA';
% %     handles_advance=findobj('Tag','advance');
%     advance_p.advance_ica_alg = ap0;
elseif alg5
    ap0 = 'SOBI';
%     handles_advance=findobj('Tag','advance');
    advance_p.advance_ica_alg = ap0;
end
% set(handles_advance,'UserData',advance_p)
handles_advance.UserData.advance_ica_alg=advance_p.advance_ica_alg;
close(handles.NID_OpenFile_ICA_Config_Advance_Setting)
% delete(handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.advance1,'Value',0);
% set(handles.radiobutton1,'Value',1);
% set(handles.checkbox2,'Value',0);
% set(handles.advance_p1,'Value',1);
% % set(handles.advance_p11,'Enable','off');
% set(handles.advance_p2,'String',10000);
% % set(handles.advance_p21,'Enable','off');
% set(handles.advance_p2,'Value',1);
% % set(handles.advance_p31,'Enable','off');
% set(handles.advance_p4,'String',0.00001);
% % set(handles.advance_p41,'Enable','off');
delete(NID_OpenFile_ICA_Config_Advance_Setting)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


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


% --- Executes on selection change in step_bandpassfilter.
function step_bandpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to step_bandpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_bandpassfilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_bandpassfilter


% --- Executes during object creation, after setting all properties.
function step_bandpassfilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_bandpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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


% --- Executes on selection change in step_detrend.
function step_detrend_Callback(hObject, eventdata, handles)
% hObject    handle to step_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on selection change in step_segment.
function step_segment_Callback(hObject, eventdata, handles)
% hObject    handle to step_segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fast_ICA_par(handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton1
