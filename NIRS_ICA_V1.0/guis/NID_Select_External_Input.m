function varargout = NID_Select_External_Input(varargin)
% NID_SELECT_EXTERNAL_INPUT MATLAB code for NID_Select_External_Input.fig
%      NID_SELECT_EXTERNAL_INPUT, by itself, creates a new NID_SELECT_EXTERNAL_INPUT or raises the existing
%      singleton*.
%
%      H = NID_SELECT_EXTERNAL_INPUT returns the handle to a new NID_SELECT_EXTERNAL_INPUT or the handle to
%      the existing singleton*.
%
%      NID_SELECT_EXTERNAL_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_SELECT_EXTERNAL_INPUT.M with the given input arguments.
%
%      NID_SELECT_EXTERNAL_INPUT('Property','Value',...) creates a new NID_SELECT_EXTERNAL_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_Select_External_Input_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NID_Select_External_Input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_Select_External_Input

% Last Modified by GUIDE v2.5 28-Jul-2021 15:40:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_Select_External_Input_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_Select_External_Input_OutputFcn, ...
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


% --- Executes just before NID_Select_External_Input is made visible.
function NID_Select_External_Input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_Select_External_Input (see VARARGIN)

% Choose default command line output for NID_Select_External_Input
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_Select_External_Input wait for user response (see UIRESUME)
% uiwait(handles.select_external_input);


% --- Outputs from this function are returned to the command line.
function varargout = NID_Select_External_Input_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Openfile = findobj('Tag','NIRS_ICA_Denoiser');
OpenfileHandles = guihandles(Openfile);
dataSource = get(OpenfileHandles.listbox1,'UserData');
temp = strfind(dataSource,filesep);
dataSource = dataSource(1:temp(end));
if isempty(dataSource)
    [filename,pathname] = uigetfile('*.mat');
else
    [filename,pathname] = uigetfile([dataSource '*.mat']);
end
dataSource = [pathname filename];

if ischar(dataSource)
    inpathList = get(handles.listbox1,'String');
    if ischar(inpathList)
        if isempty(inpathList)
            inpathList={};
        else
            inpathList={inpathList};
        end
    end
    if isempty(inpathList)
        inpathList = {dataSource};
        M = 1;
    else
        N = length(inpathList);
        M = N + 1;
        inpathList{N+1} = dataSource;
        set(handles.listbox1,'value',N+1);
    end
    set(handles.listbox1,'Enable','on','string',inpathList);
    % initialize Preview
    name = get(handles.name,'Userdata');
    thres = get(handles.thres,'Userdata');
    name{M} = ['Ex',num2str(M)];
    thres{M} = 0.9;
    set(handles.name,'Userdata',name,'String',name{M});
    set(handles.thres,'Userdata',thres,'String',num2str(thres{M}));
    % plot
    NID_Select_External_Input_Preview(handles,M,inpathList)
else
    errordlg('Error','Illegal Input...')
end



function thres_Callback(hObject, eventdata, handles)
% hObject    handle to thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thres as text
%        str2double(get(hObject,'String')) returns contents of thres as a double

M = get(handles.listbox1,'Value');
thres = get(handles.thres,'Userdata');
thres_new = get(handles.thres,'String');
thres{M} = str2num(thres_new);
set(handles.thres,'String',thres_new,'Userdata',thres)


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

name = get(handles.name,'Userdata');
thres = get(handles.thres,'Userdata');
dataSource = get(handles.listbox1,'String');

if isempty(name)||isempty(thres)
    errordlg('Illegal Input','Error');
else
    for i = 1:length(thres)
        if thres{i}>1 || thres{i}<0
            errordlg('Illegal Input','Error');
            return
        end
    end
    data.dataSource = dataSource;
    data.name = name;
    data.thres = thres;
    % check if the name of the input is corrected
    if length(name)>1
        for i = 1:length(name)
            name1 = name{i};
            temp = strfind(name(i+1:end),name1);
            for j = 1:length(temp)
                if temp{j}==1
                    errordlg('Two or more input with the same name...','Error');
                    return
                end
            end
        end
    end
    

    Openfile = findobj('Tag','NIRS_ICA_Denoiser');
    OpenfileHandles = guihandles(Openfile);
    set(OpenfileHandles.external,'Value',1,'Userdata',data,'Enable','on')
    delete(handles.select_external_input)
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Openfile = findobj('Tag','NIRS_ICA_Denoiser');
OpenfileHandles = guihandles(Openfile);
set(OpenfileHandles.external,'Value',0,'Userdata','','Enable','on')
delete(handles.select_external_input)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpathList = get(handles.listbox1,'string');
name = get(handles.name,'Userdata');
thres = get(handles.thres,'Userdata');
if isempty(inpathList)
    return;
end
k = get(handles.listbox1,'value');
if ischar(inpathList) || 1==length(inpathList)
    inpathList = {};
    name = {};
    thres = {};
    %
    set(handles.name,'Userdata',name,'String','')
    set(handles.thres,'Userdata',thres,'String','')
    cla(handles.axes1)
else
    inpathList = inpathList([1:k-1 k+1:end]);
    name = name([1:k-1 k+1:end]);
    thres = thres([1:k-1 k+1:end]);
    %
    M = max(k-1,1);
    set(handles.name,'Userdata',name,'String',name{M})
    set(handles.thres,'Userdata',thres,'String',thres{M})
    NID_Select_External_Input_Preview(handles,M,inpathList)
end
set(handles.listbox1,'string',inpathList,'value',max(k-1,1));



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

inpathList = get(handles.listbox1,'string');
M = get(handles.listbox1,'value');

% initialize Preview
name = get(handles.name,'Userdata');
thres = get(handles.thres,'Userdata');
set(handles.name,'String',name{M});
set(handles.thres,'String',num2str(thres{M}));
% plot
NID_Select_External_Input_Preview(handles,M,inpathList)



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



function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double

M = get(handles.listbox1,'Value');
name = get(handles.name,'Userdata');
name_new = get(handles.name,'String');
if length(name_new)>5
    errordlg('The length of "Name" is out of range...');
    if isempty(name)
        name_new = '';
    else
        name_new = name{M};
    end
else
    name{M} = name_new;
end

set(handles.name,'String',name_new,'Userdata',name)


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function select_external_input_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to select_external_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Openfile = findobj('Tag','NIRS_ICA_Denoiser_open_file_and_ICA_config');
% OpenfileHandles = guihandles(Openfile);
% set(OpenfileHandles.external,'Userdata','','Enable','on')
% if isempty(get(OpenfileHandles.external,'Userdata'))
%     set(OpenfileHandles.external,'Value',0)
% end
% close(handles.select_external_input)


% --- Executes when user attempts to close select_external_input.
function select_external_input_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to select_external_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
Openfile = findobj('Tag','NIRS_ICA_Denoiser');
OpenfileHandles = guihandles(Openfile);
set(OpenfileHandles.external,'Value',0,'Userdata','','Enable','on')
delete(handles.select_external_input);
