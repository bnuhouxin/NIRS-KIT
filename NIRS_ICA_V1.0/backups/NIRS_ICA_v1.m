function varargout = NIRS_ICA_v1(varargin)
% NIRS_ICA_V1 M-file for NIRS_ICA_v1.fig
%      NIRS_ICA_V1, by itself, creates a new NIRS_ICA_V1 or raises the existing
%      singleton*.
%
%      H = NIRS_ICA_V1 returns the handle to a new NIRS_ICA_V1 or the handle to
%      the existing singleton*.
%
%      NIRS_ICA_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_ICA_V1.M with the given input arguments.
%
%      NIRS_ICA_V1('Property','Value',...) creates a new NIRS_ICA_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_ICA_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_ICA_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_ICA_v1

% Last Modified by GUIDE v2.5 17-Jun-2021 08:35:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_ICA_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_ICA_v1_OutputFcn, ...
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


% --- Executes just before NIRS_ICA_v1 is made visible.
function NIRS_ICA_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_ICA_v1 (see VARARGIN)

% Choose default command line output for NIRS_ICA_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_ICA_v1 wait for user response (see UIRESUME)
% uiwait(handles.NIRS_ICA_Denoiser);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_ICA_v1_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

% val = get(handles.popupmenu2,'Value');
% switch val
%     case 1
%         
% end
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)



% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in hbType.
function hbType_Callback(hObject, eventdata, handles)
% hObject    handle to hbType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hbType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hbType
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --- Executes during object creation, after setting all properties.
function hbType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hbType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sort_spikelike.
function sort_spikelike_Callback(hObject, eventdata, handles)
% hObject    handle to sort_spikelike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_spikelike

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --- Executes on button press in sort_homo.
function sort_homo_Callback(hObject, eventdata, handles)
% hObject    handle to sort_homo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_homo

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --- Executes on button press in sort_external.
function sort_shortchannel_Callback(hObject, eventdata, handles)
% hObject    handle to sort_external (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_external


% --- Executes on button press in sort_external.
function sort_external_Callback(hObject, eventdata, handles)
% hObject    handle to sort_external (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_external

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


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


% --- Executes on button press in sort_mask3.
function sort_mask3_Callback(hObject, eventdata, handles)
% hObject    handle to sort_mask3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_mask3


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in resultView.
function resultView_Callback(hObject, eventdata, handles)
% hObject    handle to resultView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

remove_val = get(handles.radiobutton1,'Value');
reserve_val = get(handles.radiobutton2,'Value');
if 0==remove_val&&0==reserve_val
    errordlg('Removing or Reserving a IC? Please choose a mode...','Error!')
    return
end

% 
NID_Preview

NID_P = findobj('Tag','NID_Preview');
if ~isempty(NID_P)
    PHandles=guihandles(NID_P);
    % 
    NID_Preview_initial(handles,PHandles)
end

NID_SR_nirsdata_drawTimeseries(PHandles)
NID_SR_nirsdata_drawFreq(PHandles)


% --- Executes on button press in small.
function small_Callback(hObject, eventdata, handles)
% hObject    handle to small (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mid.
function mid_Callback(hObject, eventdata, handles)
% hObject    handle to mid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in big.
function big_Callback(hObject, eventdata, handles)
% hObject    handle to big (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function pageNo_Callback(hObject, eventdata, handles)
% hObject    handle to pageNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pageNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pageNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in sort_timetemplate.
function sort_timetemplate_Callback(hObject, eventdata, handles)
% hObject    handle to sort_timetemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_timetemplate

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)



% --- Executes on button press in sort_spatialtemplate.
function sort_spatialtemplate_Callback(hObject, eventdata, handles)
% hObject    handle to sort_spatialtemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sort_spatialtemplate

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NID_PLOT_Clear_Screen(handles)

set(handles.Sorting_Rules_of_ICs,'UserData',[])
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.sort_spikelike,'Enable','off','Value',0)
set(handles.sort_homo,'Enable','off','Value',0)
set(handles.sort_external,'Enable','off','Value',0)
set(handles.sort_timetemplate,'Enable','off','Value',0)
set(handles.sort_spatialtemplate,'Enable','off','Value',0)
set(handles.edit3,'String','','FontWeight','bold','FontUnit','normalized','FontSize',0.7);
set(handles.text7,'String','','FontWeight','bold','FontUnit','normalized','FontSize',0.7);
set(handles.resultView,'Value',0)
set(handles.small,'State','off')
set(handles.mid,'State','off')
set(handles.big,'State','off')
set(handles.pageNoL,'Userdata',[])
set(handles.pageNoR,'Userdata',[])

NIRS_ICA_open_file_and_config


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pageNoL_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to pageNoL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pagel = get(handles.pageNoL,'Userdata');
pagenowl = pagel.now;
pagemaxl = pagel.max;
%
pager = get(handles.pageNoR,'Userdata');
pagenowr = pager.now;
pagemaxr = pager.max;
if 1 ~= pagenowl
    pagenowl = pagenowl-1;
    pagel.now = pagenowl;
    pagel.max = pagemaxl;
    set(handles.pageNoL,'Userdata',pagel,...
        'TooltipString',strcat('Page','( ',num2str(pagel.now),'/',num2str(pagel.max),' )'))
    %
    pagenowr = pagenowl;
    pager.now = pagenowr;
    pager.max = pagemaxr;
    set(handles.pageNoR,'Userdata',pager,...
        'TooltipString',strcat('Page','( ',num2str(pager.now),'/',num2str(pager.max),' )'))
end
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --------------------------------------------------------------------
function pageNoR_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to pageNoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pagel = get(handles.pageNoL,'Userdata');
pagenowl = pagel.now;
pagemaxl = pagel.max;
%
pager = get(handles.pageNoR,'Userdata');
pagenowr = pager.now;
pagemaxr = pager.max;
if pagemaxr ~= pagenowr
    pagenowr = pagenowr + 1;
    pager.now = pagenowr;
    pager.max = pagemaxr;
    set(handles.pageNoR,'Userdata',pager,...
        'TooltipString',strcat('Page','( ',num2str(pager.now),'/',num2str(pager.max),' )'))
    %
    pagenowl = pagenowr;
    pagel.now = pagenowl;
    pagel.max = pagemaxl;
    set(handles.pageNoL,'Userdata',pagel,...
        'TooltipString',strcat('Page','( ',num2str(pager.now),'/',num2str(pager.max),' )'))
end
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --------------------------------------------------------------------
function small_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to small (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state_small = get(handles.small,'State');
if strcmp(state_small,'off')
    set(handles.small,'State','on');
    set(handles.mid,'State','off');
    set(handles.big,'State','off');
else
    set(handles.small,'State','on');
    set(handles.mid,'State','off');
    set(handles.big,'State','off');
end
%
Num = NID_Caculate_pageNum(handles);
pageNum.max = Num;
pageNum.now = 1;
set(handles.pageNoL,'Userdata',pageNum,...
    'TooltipString',strcat('Page','( ',num2str(pageNum.now),'/',num2str(pageNum.max),' )'))
set(handles.pageNoR,'Userdata',pageNum,...
    'TooltipString',strcat('Page','( ',num2str(pageNum.now),'/',num2str(pageNum.max),' )'))
%
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --------------------------------------------------------------------
function mid_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to mid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state_mid = get(handles.mid,'State');
if strcmp(state_mid,'off')
    set(handles.small,'State','off');
    set(handles.mid,'State','on');
    set(handles.big,'State','off');
else
    set(handles.small,'State','off');
    set(handles.mid,'State','on');
    set(handles.big,'State','off');
end
%
Num = NID_Caculate_pageNum(handles);
pageNum.max = Num;
pageNum.now = 1;
set(handles.pageNoL,'Userdata',pageNum,...
    'TooltipString',strcat('Page','( ',num2str(pageNum.now),'/',num2str(pageNum.max),' )'))
set(handles.pageNoR,'Userdata',pageNum,...
    'TooltipString',strcat('Page','( ',num2str(pageNum.now),'/',num2str(pageNum.max),' )'))
%
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --------------------------------------------------------------------
function big_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to big (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state_big = get(handles.big,'State');
if strcmp(state_big,'off')
    set(handles.small,'State','off');
    set(handles.mid,'State','off');
    set(handles.big,'State','on');
else
    set(handles.small,'State','off');
    set(handles.mid,'State','off');
    set(handles.big,'State','on');
end
%
Num = NID_Caculate_pageNum(handles);
pageNum.max = Num;
pageNum.now = 1;
set(handles.pageNoL,'Userdata',pageNum,...
    'TooltipString',strcat('Page','( ',num2str(pageNum.now),'/',num2str(pageNum.max),' )'))
set(handles.pageNoR,'Userdata',pageNum,...
    'TooltipString',strcat('Page','( ',num2str(pageNum.now),'/',num2str(pageNum.max),' )'))
%
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
% % switch to NIRS_ICA_Denoiser
% if ~isempty(handles.NIRS_ICA_Denoiser)
%     DenoiserHandles=guihandles(handles);
%     set(handles.NIRS_ICA_Denoiser,'UserData',dataIn);
% end
NID_PLOT_Clear_Screen(handles)
NID_Initial(handles);


% --------------------------------------------------------------------
function uipushtool32_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NID_Show_Results

NID_SR = findobj('Tag','NID_Show_Results');
if ~isempty(NID_SR)
    SRHandles=guihandles(NID_SR);
    NID_ShowResult_initial(handles,SRHandles)
end

NID_SR_nirsdata_drawTimeseries(SRHandles)
NID_SR_nirsdata_drawFreq(SRHandles)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
IC = dataIn.IC;
hbType = dataIn.hbType;
temp_struct = getfield(IC,hbType);
temp_struct = getfield(temp_struct,'Sort');
Sort_selectRule = temp_struct.Sort_selectRule;
[xx,zz] = ismember(Sort_selectRule,temp_struct.Sort_icName);
%
val = get(handles.radiobutton2,'Value');
if val == 1
    if ~isempty(zz)
%         if any(zz>3)
            for i = 1:length(zz)
                if ismember(zz(i),[1,2,3])
                    tag = strcat('sort_',temp_struct.Sort_icName{zz(i)});
                    obj = findobj('Tag',tag);
                    set(obj,'Enable','off','Value',0)
                else
                    tag = strcat('sort_',temp_struct.Sort_icName{zz(i)});
                    obj = findobj('Tag',tag);
                    set(obj,'Enable','on','Value',1)
                end
            end
    end
    set(handles.radiobutton1,'Value',0);
    set(handles.resultView,'Enable','off')
else
    if ~isempty(zz)
%         if any(zz<=3)
            for i = 1:length(zz)
                if ismember(zz(i),[4,5])
                    tag = strcat('sort_',temp_struct.Sort_icName{zz(i)});
                    obj = findobj('Tag',tag);
                    set(obj,'Enable','off','Value',0)
                end
            end
            set(handles.radiobutton1,'Value',1);
    end
end
%%

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
IC = dataIn.IC;
hbType = dataIn.hbType;
temp_struct = getfield(IC,hbType);
temp_struct = getfield(temp_struct,'Sort');
Sort_selectRule = temp_struct.Sort_selectRule;
[xx,zz] = ismember(Sort_selectRule,temp_struct.Sort_icName);
%
val = get(handles.radiobutton1,'Value');
if val == 1
    if ~isempty(zz)
        if any(zz<=3)
            for i = 1:length(zz)
                if ismember(zz(i),[1,2,3])
                    tag = strcat('sort_',temp_struct.Sort_icName{zz(i)});
                    obj = findobj('Tag',tag);
                    set(obj,'Enable','on','Value',1)
                else
                    tag = strcat('sort_',temp_struct.Sort_icName{zz(i)});
                    obj = findobj('Tag',tag);
                    set(obj,'Enable','off','Value',0)
                end
            end
        end
    end
    set(handles.radiobutton2,'Value',0);
    set(handles.resultView,'Enable','on')
else
    if ~isempty(zz)
%         if any(zz>3)
            for i = 1:length(zz)
                if ismember(zz(i),[1,2,3])
                    tag = strcat('sort_',temp_struct.Sort_icName{zz(i)});
                    obj = findobj('Tag',tag);
                    set(obj,'Enable','off','Value',0)
                end
            end
    end
    set(handles.resultView,'Enable','off')
end
%%

NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

val_remove = get(handles.radiobutton1,'Value');
val_reserve = get(handles.radiobutton2,'Value');
ic_remove = get(handles.edit3,'String');
ic_reserve = get(handles.text7,'String');
if val_remove==0&&val_reserve==0
    errordlg('Removing ICs from NIRS data or Saving Neural related ICs? Please make a choice','Error')
    return
elseif val_remove==1
    % 
    NID_Save_Data_Remove
    obj1 = findobj('Tag','NID_Save_Data_Remove');
    Removehandles = guihandles(obj1);
    if isempty(ic_remove)
        errordlg('No ICs to be removed!','Error')
        delete(Removehandles)
        return
    else
        set(Removehandles.edit1,'String',ic_remove)
    end
elseif val_reserve==1
    %
    NID_Save_Data_Reserve
    obj1 = findobj('Tag','NID_Save_Data_Reserve');
    Reservehandles = guihandles(obj1);
    if isempty(ic_reserve)
        errordlg('No ICs to be Save!','Error')
        delete(Reservehandles)
        return
    else
        set(Reservehandles.edit1,'String',ic_reserve)
    end
end


% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function uipushtool44_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%config%%
NIRS_BSS_open_file_and_config
set(NIRS_BSS_open_file_and_config,'Visible','off')

obj1 = findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
confighandles = guihandles(obj1);
dataSource = get(confighandles.inpathData,'userdata');
%
if isempty(dataSource)
    [filename,pathname] = uigetfile('*.mat');
else
    temp = strfind(dataSource,'\');
    dataSource = dataSource(1:temp(end));
    [filename,pathname] = uigetfile([dataSource '*.mat']);
end

dataSource = [pathname filename];

if ischar(dataSource)
    set(confighandles.inpathData,'string',dataSource);  % set input path name
    set(confighandles.inpathData,'userdata',dataSource);
else
    return
end

%load data
dataIn = load(dataSource);
%load design
if ~isempty(dataIn.IC.OXY.Sort.Sort_selectRule)
    set(confighandles.timetemplate,'Value',1);
    dataIn.IC = NID_OpenFileInitial_Sorting(confighandles,dataIn.IC);
end

set(handles.NIRS_ICA_Denoiser,'UserData',dataIn);
% dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
% 
NID_Initial(handles);


% --------------------------------------------------------------------
function uipushtool45_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_BSS_Group_Results_Settings


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
