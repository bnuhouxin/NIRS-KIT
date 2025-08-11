function varargout = NID_Input_Design_Info(varargin)
% NID_INPUT_DESIGN_INFO MATLAB code for NID_Input_Design_Info.fig
%      NID_INPUT_DESIGN_INFO, by itself, creates a new NID_INPUT_DESIGN_INFO or raises the existing
%      singleton*.
%
%      H = NID_INPUT_DESIGN_INFO returns the handle to a new NID_INPUT_DESIGN_INFO or the handle to
%      the existing singleton*.
%
%      NID_INPUT_DESIGN_INFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_INPUT_DESIGN_INFO.M with the given input arguments.
%
%      NID_INPUT_DESIGN_INFO('Property','Value',...) creates a new NID_INPUT_DESIGN_INFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_Input_Design_Info_OpeningFcn gets called.  An
%      unrecognized property design_name or invalid value makes property application
%      stop.  All inputs are passed to NID_Input_Design_Info_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_Input_Design_Info

% Last Modified by GUIDE v2.5 24-Jan-2024 11:13:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_Input_Design_Info_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_Input_Design_Info_OutputFcn, ...
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


% --- Executes just before NID_Input_Design_Info is made visible.
function NID_Input_Design_Info_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_Input_Design_Info (see VARARGIN)

% Choose default command line output for NID_Input_Design_Info
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_Input_Design_Info wait for user response (see UIRESUME)
% uiwait(handles.NID_Input_Design_Info);


% --- Outputs from this function are returned to the command line.
function varargout = NID_Input_Design_Info_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function thres_Callback(hObject, eventdata, handles)
% hObject    handle to thres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thres as text
%        str2double(get(hObject,'String')) returns contents of thres as a double

% num = get(handles.listbox1,'Value');
% thres_new = str2num(get(handles.thres,'String'));
% thres = get(handles.thres,'Userdata');
% if thres_new>=0&&thres_new<=1
%     thres{num} = thres_new;
%     set(handles.thres,'Userdata',thres)
% else
%     errordlg('Invalid Input... ...');
% end


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



function design_name_Callback(hObject, eventdata, handles)
% hObject    handle to design_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of design_name as text
%        str2double(get(hObject,'String')) returns contents of design_name as a double


% --- Executes during object creation, after setting all properties.
function design_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to design_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hrf.
function hrf_Callback(hObject, eventdata, handles)
% hObject    handle to hrf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hrf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hrf


% --- Executes during object creation, after setting all properties.
function hrf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hrf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function onset_Callback(hObject, eventdata, handles)
% hObject    handle to onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of onset as text
%        str2double(get(hObject,'String')) returns contents of onset as a double


% --- Executes during object creation, after setting all properties.
function onset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function duration_Callback(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration as text
%        str2double(get(hObject,'String')) returns contents of duration as a double


% --- Executes during object creation, after setting all properties.
function duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% manually add design information to create reference curve
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';

input_name = inputdlg({'Enter the name of Design Infomation:',...
    'Threshold for "correlation coefficient":',...
    'Onset','Duration'},'Design Infomation',...
    [1 50;1 50;1 50;1 50],{'','0.8','',''},options);


if ~isempty(input_name)
    if isempty(input_name{1})
        errordlg('Names of "Design" should not be empty!','Error')
        return
    end

    if isempty(str2num(input_name{2}))
        errordlg('Threshold should not be empty!','Error')
        return
    elseif str2num(input_name{2})<0
        errordlg('Invalid Threshold! Please check... ...');
        return;
    elseif str2num(input_name{2})>1
        errordlg('Invalid Threshold! Please check... ...');
        return;
    end

    if isempty(input_name{3})
        errordlg('Onset should not be empty!','Error')
        return
    end

    if isempty(input_name{4})
        errordlg('Duration should not be empty!','Error')
        return
    end
    % 
    NID_Input_Design_Info_Add(handles,input_name);
    % 
    NID_Input_Design_Info_Plot(handles);
end


% --- Executes on button press in edit5.
function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ɾ��ѡ��ģ�尴ť
table_info = get(handles.uitable1,'Userdata');
select = table_info.select; % ��ǰѡ�е�ģ��
row_of_table_old = table_info.row; % ģ������

if select > row_of_table_old
    errordlg('You should select a Template first!','Error')
    return
elseif row_of_table_old == 0
    errordlg('No Template to be removed!','Error')
    return
end

table_data = get(handles.uitable1,'Data');
name = table_data{select,1};
designData = get(handles.preview,'Userdata');
durData = get(handles.duration,'Userdata');
onsetData = get(handles.onset,'Userdata');

% ����ѯ�ʿ�ȷ���Ƿ�Ҫɾ��
options.Interpreter = 'tex';
options.Default = 'No';
qstring = ['You want to remove Dseign "',name,'"  from the list ?'];
choice = questdlg(qstring,'Boundary Condition',...
    'Yes','No',options);
%
switch choice
    case 'Yes'
        ax = handles.axes1;
        cla(ax,'reset')
        set(handles.onset,'String','')
        set(handles.duration,'String','')
        
        row_of_table_new = row_of_table_old - 1;
        k = select;
        table_data = table_data([1:k-1 k+1:end],:);
        designData = designData([1:k-1 k+1:end]);
        durData = durData([1:k-1 k+1:end]);
        onsetData = onsetData([1:k-1 k+1:end]);
        %
        table_info.row = row_of_table_new;
        table_info.select = 0;
        set(handles.preview,'Userdata',designData);
        set(handles.duration,'Userdata',durData);
        set(handles.onset,'Userdata',onsetData);
        set(handles.uitable1,'Data',table_data,'Userdata',table_info);
    case 'No'
        return
    otherwise
        errordlg('Illegal Input!','Error')
        return
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 
table_data = get(handles.uitable1,'Data');
table_info = get(handles.uitable1,'UserData');

% if table_info.row == 0
if ~isfield(table_info,'row')
    name = {};
    thres = {};
    design = {};
else
    name = table_data(1:table_info.row,1);
    thres = table_data(1:table_info.row,2);
    design = get(handles.preview,'UserData');
    %add non-tc information (Onset,dur)
    design_onset=get(handles.onset,'UserData');
    design_dur=get(handles.duration,'UserData');
end

if isempty(name)||isempty(thres)
    errordlg('Illegal Input','Error');
else
    for i = 1:length(thres)
        if thres{i}>1 || thres{i}<0
            errordlg('Illegal Input','Error');
            return
        end
    end
    data.design = design;
    data.name = name;
    data.thres = thres;
    data.onset=design_onset;
    data.dur=design_dur;
    % 
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
    set(OpenfileHandles.timetemplate,'Value',1,'Userdata',data,'Enable','on')
    delete(handles.NID_Input_Design_Info)
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ȡ�����벢�˳�����
Openfile = findobj('Tag','NIRS_ICA_Denoiser');
OpenfileHandles = guihandles(Openfile);
set(OpenfileHandles.timetemplate,'Value',0,'Userdata','','Enable','on')
delete(handles.NID_Input_Design_Info)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

% ѡ�н����е�ģ���б�ʱ����Ӧ����
% ��ȡ������������
if isempty(eventdata.Indices)
    return
end
% row�����ѡ�е��У�mLine = eventdata.Indices(1);
% column�����ѡ�е��У�nColumn = eventdata.Indices(2);
%
table_info = get(handles.uitable1,'Userdata');
tables_data = get(handles.uitable1,'Data');
designData = get(handles.preview,'Userdata');
durData = get(handles.duration,'Userdata');
onsetData = get(handles.onset,'Userdata');

% ѡ�п��У�����ʾ�κ�ģ��
if mLine>table_info.row
    ax = handles.axes1;
    cla(ax,'reset')
    
    table_info.select = mLine;
    set(handles.uitable1,'UserData',table_info)
    set(handles.onset,'String',[]);
    set(handles.duration,'String',[]);
    return
end

table_info.select = mLine;
set(handles.uitable1,'Userdata',table_info);
% preview����ѡ����ģ�壬����û�ͼ��������ģ��NID_Input_Design_Info_Plot(handles)

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object deletion, before destroying properties.
function NID_Input_Design_Info_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to NID_Input_Design_Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% Openfile = findobj('Tag','NIRS_ICA_Denoiser_open_file_and_ICA_config');
% OpenfileHandles = guihandles(Openfile);
% set(OpenfileHandles.timetemplate,'Value',0,'Userdata','','Enable','on')
% delete(handles.NID_Input_Design_Info)


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% this function load design information mat file and converted to hrf
Openfile = findobj('Tag','NIRS_ICA_Denoiser');
guiOpenfile_handles = guihandles(Openfile);
dataSource = get(guiOpenfile_handles.listbox1,'UserData');
temp = strfind(dataSource,filesep);
filepath = dataSource(1:temp(end));

[fname,fpath] = uigetfile([filepath,'*.mat']);

if fpath
    datain = load([fpath,fname]);
    input_name{1} = datain.name;
    input_name{2} = 0.8;
    datain_type = class(datain.onset_time);
    
    if  strcmp(datain_type,'cell')
        input_name{3} = cell2mat(datain.onset_time)';
        input_name{4} = cell2mat(datain.durs)';
    else
        input_name{3} = datain.onset_time;
        input_name{4} = datain.duration;
    end
    
    % add design information (calculation hrf)
    NID_Input_Design_Info_Add(handles,input_name)
    % plot design information
    NID_Input_Design_Info_Plot(handles)
end


% --- Executes when user attempts to close NID_Input_Design_Info.
function NID_Input_Design_Info_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NID_Input_Design_Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% 
Openfile = findobj('Tag','NIRS_ICA_Denoiser');
OpenfileHandles = guihandles(Openfile);
set(OpenfileHandles.timetemplate,'Value',0,'Userdata','','Enable','on')
delete(handles.NID_Input_Design_Info);
