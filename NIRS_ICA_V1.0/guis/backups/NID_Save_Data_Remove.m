function varargout = NID_Save_Data_Remove(varargin)
% NID_SAVE_DATA_REMOVE MATLAB code for NID_Save_Data_Remove.fig
%      NID_SAVE_DATA_REMOVE, by itself, creates a new NID_SAVE_DATA_REMOVE or raises the existing
%      singleton*.
%
%      H = NID_SAVE_DATA_REMOVE returns the handle to a new NID_SAVE_DATA_REMOVE or the handle to
%      the existing singleton*.
%
%      NID_SAVE_DATA_REMOVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_SAVE_DATA_REMOVE.M with the given input arguments.
%
%      NID_SAVE_DATA_REMOVE('Property','Value',...) creates a new NID_SAVE_DATA_REMOVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_Save_Data_Remove_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NID_Save_Data_Remove_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_Save_Data_Remove

% Last Modified by GUIDE v2.5 16-Dec-2014 10:46:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_Save_Data_Remove_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_Save_Data_Remove_OutputFcn, ...
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


% --- Executes just before NID_Save_Data_Remove is made visible.
function NID_Save_Data_Remove_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_Save_Data_Remove (see VARARGIN)

% Choose default command line output for NID_Save_Data_Remove
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_Save_Data_Remove wait for user response (see UIRESUME)
% uiwait(handles.NID_Save_Data_Remove);


% --- Outputs from this function are returned to the command line.
function varargout = NID_Save_Data_Remove_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% dataSource = get(handles.inpathData,'userdata');
% 
% if isempty(dataSource)
%     [filename,pathname] = uigetfile('*.mat');
% else
%     temp = strfind(dataSource,'\');
%     dataSource = dataSource(1:temp(end));
%     [filename,pathname] = uigetfile([dataSource '*.mat']);
% end
% dataSource = [pathname filename];

[filename,pathname] = uigetfile('*.mat');
dataSource = [pathname filename];
set(handles.edit2,'String',dataSource)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% save data path
outpath = get(handles.edit3,'String');
%
icremove = str2num(get(handles.edit1,'String'));
%
obj = findobj('Tag','NIRS_ICA_Denoiser');

NIDhandles = guihandles(obj);
data = get(NIDhandles.NIRS_ICA_Denoiser,'Userdata');
hbtype = data.hbType;
raw_nirsdata = data.nirs_data;
raw_icdata = data.IC;
icdata = getfield(raw_icdata,hbtype);
% ic removed nirsdata
ic = icdata.TC;
A = icdata.SM;
Anew = A;
Anew(:,icremove) = 0;
nirsData = ic*Anew'+repmat(icdata.m_rawdata,[size(ic,1),1]);

if strcmp(hbtype,'OXY')
    raw_nirsdata.oxyData = nirsData;
elseif strcmp(hbtype,'DXY')
    raw_nirsdata.dxyData = nirsData;
elseif strcmp(hbtype,'TOT')
    raw_nirsdata.totalData = nirsData;
end
%
ICA_Method.hbtype = hbtype;
ICA_Method.A = A;
ICA_Method.ic_timeSerials = ic;
raw_nirsdata.ICA_Method = ICA_Method;

%%print report
obj=findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
NIDC_handles=guihandles(obj);
newtline = [];
i=1;
newtline{i} = '--------------BSS parameters------------';i=i+1;
newtline{i} = ['Hb type:' hbtype];i=i+1;
%if preprocessed 
if isfield(NIDC_handles.advance.UserData,'preprocessSet')
    newtline{i} = '--------preprocessing:';i=i+1;
    for j=1:length(NIDC_handles.advance.UserData.preprocessSet)
        switch NIDC_handles.advance.UserData.preprocessSet{j}{1}
            case 'NID_segment'
                newtline{i} = ['Remove: first:' NIDC_handles.advance.UserData.preprocessSet{j}{2} ',last:' NIDC_handles.advance.UserData.preprocessSet{j}{3}];
            case 'NID_detrend'
                newtline{i} = ['Detrend: ' NIDC_handles.advance.UserData.preprocessSet{j}{2} '-order'];
            case 'NID_bandpassfilter'
                newtline{i} = ['Bandpass filtering: low:' NIDC_handles.advance.UserData.preprocessSet{j}{2} ',high:' NIDC_handles.advance.UserData.preprocessSet{j}{3}];
            case 'NID_resample'
                newtline{i} = ['Resample T: ' NIDC_handles.advance.UserData.preprocessSet{j}{2}];
        end
        i=i+1;
    end
else
    newtline{i} = 'preprocessing: none';i=i+1;
end
%BSS parameters
newtline{i} = ['Algorithm: ' NIDC_handles.advance.UserData.advance_ica_alg];i=i+1;
%if other parameters,like the approximation function in FastICA
newtline{i} = ['Number of Sources: ' num2str(NIDhandles.NIRS_ICA_Denoiser.UserData.IC.OXY.numIC)];i=i+1;
newtline{i} = ['Number of Removed sources: ' num2str(length(icremove))];i=i+1;

%Source evaluation metrics
newtline{i} = '----------Evaluation metrics------------';i=i+1;

if ~isempty(icdata.Sort.Sort_selectRule)
%     for j=1:length(icremove)
        newtline{i} = ['Source number: ' num2str(icremove)];i=i+1;
%     end
    for j=1:length(icdata.Sort.Sort_selectRule)
        newtline{i} = [icdata.Sort.Sort_selectRule{j} ':' num2str(icdata.Sort.Sort_icValue{j}{1}(icremove))];i=i+1;
    end
end

%write new file
outpath_rep=[outpath(1:(find(outpath=='.')-1)) '_report'];
h = fopen(outpath_rep,'w+');
for j=1:1:i-1
    fprintf(h,'%s\n',newtline{j});
end
fclose(h);

% save
nirs_data = raw_nirsdata;
save(outpath,'nirs_data')
%
close(handles.NID_Save_Data_Remove)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.NID_Save_Data_Remove)



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

% save data path
[file,path] = uiputfile('*.mat','Save Workspace As...');
outpath = [path,file];
set(handles.edit3,'String',outpath)
%
