function varargout = NID_Input_SpatialMap(varargin)
% NID_INPUT_SPATIALMAP MATLAB code for NID_Input_SpatialMap.fig
%      NID_INPUT_SPATIALMAP, by itself, creates a new NID_INPUT_SPATIALMAP or raises the existing
%      singleton*.
%
%      H = NID_INPUT_SPATIALMAP returns the handle to a new NID_INPUT_SPATIALMAP or the handle to
%      the existing singleton*.
%
%      NID_INPUT_SPATIALMAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NID_INPUT_SPATIALMAP.M with the given input arguments.
%
%      NID_INPUT_SPATIALMAP('Property','Value',...) creates a new NID_INPUT_SPATIALMAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NID_Input_SpatialMap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NID_Input_SpatialMap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NID_Input_SpatialMap

% Last Modified by GUIDE v2.5 28-May-2015 16:30:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NID_Input_SpatialMap_OpeningFcn, ...
                   'gui_OutputFcn',  @NID_Input_SpatialMap_OutputFcn, ...
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


% --- Executes just before NID_Input_SpatialMap is made visible.
function NID_Input_SpatialMap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NID_Input_SpatialMap (see VARARGIN)

% Choose default command line output for NID_Input_SpatialMap
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NID_Input_SpatialMap wait for user response (see UIRESUME)
% uiwait(handles.NID_Input_SpatialMap);


% --- Outputs from this function are returned to the command line.
function varargout = NID_Input_SpatialMap_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function select_channel_list_Callback(hObject, eventdata, handles)
% hObject    handle to select_channel_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of select_channel_list as text
%        str2double(get(hObject,'String')) returns contents of select_channel_list as a double


% --- Executes during object creation, after setting all properties.
function select_channel_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_channel_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% val = get(handles.listbox1,'Value');
% thres_all = get(handles.edit3,'Userdata');
% name_all = get(handles.edit2,'Userdata');
% list_data = get(handles.listbox1,'Userdata');
% 
% set(handles.edit3,'String',num2str(thres_all{val}),'Enable','off');
% set(handles.edit2,'String',name_all{val},'Enable','off');
% set(handles.select_channel_list,'String',num2str(list_data{val}));
% % plot channel pannel
% NID_Input_SpatialMap_ClearChannel(handles)
% NID_Input_SpatialMap_CreateFuntion(handles)
% button_handles = get(handles.channel_pannel,'Userdata');
% 
% data = list_data{val};
% set(handles.select_channel_list,'String',num2str(data));
% for i = 1:length(data)
%     num = data(i);
%     set(button_handles(num),'Value',1,'BackgroundColor',[0.71,0.71,1])
% end
% for i = 1:length(button_handles)
%     set(button_handles(i),'Enable','off')
% end
% 
% set(handles.add,'Enable','off')
% set(handles.remove,'Enable','off')


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


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ������table��������µ�ģ��
% �����ʾ����ģ��
NID_Input_SpatialMap_ClearChannel(handles)

input_name = inputdlg({'Enter the name of Spatial Template:',...
    'Threshold for "Goodness of fit:"'},'User Input',1,{'','0.8'});

if isempty(input_name{1})
    errordlg('File name should not be empty!','Error')
    return
end

if isempty(input_name{2})
    errordlg('Threshold should not be empty!','Error')
    return
end
% ����ʾ�������⼫������
NID_Input_SpatialMap_CreateFuntion(handles)

tableData = get(handles.uitable1,'Data');
spatialMap = get(handles.select_channel_list,'Userdata');

table_info = get(handles.uitable1,'UserData');
% row_of_table_old = table_info.row;

if ~isfield(table_info,'row')
    %
    row_of_table_new = 1;
    tableData{1,1} = input_name{1};
    tableData{1,2} = str2num(input_name{2});
    spatialMap{1} = [];
else
    row_of_table_new = table_info.row + 1;
    tableData{row_of_table_new,1} = input_name{1};
    tableData{row_of_table_new,2} = str2num(input_name{2});
    spatialMap{row_of_table_new} = [];
end

table_info.row = row_of_table_new;
table_info.select = row_of_table_new;
set(handles.uitable1,'Data',tableData,'Userdata',table_info);
set(handles.select_channel_list,'Userdata',spatialMap);
set(handles.text9,'String',tableData{row_of_table_new,1})


% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% �����Ƴ�Table�����е�ģ��
table_info = get(handles.uitable1,'Userdata');
select = table_info.select;
row_of_table_old = table_info.row;

if select > row_of_table_old
    errordlg('You should select a Template first!','Error')
    return
elseif row_of_table_old == 0
    errordlg('No Template to be removed!','Error')
    return
end

table_data = get(handles.uitable1,'Data');
name = table_data{select,1};
spatialMap = get(handles.select_channel_list,'Userdata');

% ����ѯ�ʿ�
options.Interpreter = 'tex';
options.Default = 'No';
qstring = ['You want to remove Template "',name,'"  from the list ?'];
choice = questdlg(qstring,'Boundary Condition',...
    'Yes','No',options);
%
switch choice
    case 'Yes'
        NID_Input_SpatialMap_ClearChannel(handles)
        set(handles.select_channel_list,'String','')
             
        row_of_table_new = row_of_table_old - 1;
        k = select;
        table_data = table_data([1:k-1 k+1:end],:);
        spatialMap = spatialMap([1:k-1 k+1:end]);
        %
        table_info.row = row_of_table_new;
        table_info.select = 0;
        set(handles.select_channel_list,'Userdata',spatialMap);
        set(handles.uitable1,'Data',table_data,'Userdata',table_info);
    case 'No'
        return
    otherwise
        errordlg('Illegal Input!','Error')
        return
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% M = get(handles.listbox1,'Value');
% name = get(handles.edit2,'Userdata');
% name_new = get(handles.edit2,'String');
% if length(name_new)>5
%     errordlg('The length of "Name" is out of range...');
%     if isempty(name)
%         name_new = '';
%     else
%         name_new = name{M};
%     end
% else
%     name{M} = name_new;
% end
% 
% set(handles.edit2,'String',name_new,'Userdata',name)


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get table content
table_data = get(handles.uitable1,'Data');
table_info = get(handles.uitable1,'UserData');

if table_info.row == 0
    name = {};
    thres = {};
    SP = {};
else
    name = table_data(1:table_info.row,1);
    thres = table_data(1:table_info.row,2);
    SP = get(handles.select_channel_list,'UserData');
end

% save
obj = findobj('Tag','NIRS_ICA_Denoiser');
openfileHandles = guihandles(obj);
datapath = get(openfileHandles.listbox1,'UserData');
datain = load(datapath);
nirsdata = datain.nirsdata;
N = length(nirsdata.oxyData(1,:));

% �ж��������Ϣ�Ƿ�Ϸ�
if isempty(name)||isempty(thres)
    errordlg('Illegal Input','Error');
else
    for i = 1:length(thres)
        if thres{i}>1 || thres{i}<0
            errordlg('Illegal Input','Error');
            return
        end
    end

    data.name = name;
    data.thres = thres;
    % ����Ƿ���������ģ��
    if length(name)>1
        for i = 1:length(name)
            name1 = name{i};
            temp = strfind(name(i+1:end),name1);
            for j = 1:length(temp)
                if temp{j}==1
                    errordlg('Names of the Template should be different!','Error');
                    return
                end
            end
        end
    end
    % convert CH NO. to "01"
    % ��ģ������ת��Ϊ01������
    SpatialMap = {};
    for i = 1:length(SP)
        temp = zeros(1,N);
        sp = SP{i};
        temp(sp) = 1;
        SpatialMap{i} = temp;
    end
    data.SP = SpatialMap;
    %
    Openfile = findobj('Tag','NIRS_ICA_Denoiser');
    OpenfileHandles = guihandles(Openfile);
    set(OpenfileHandles.spatialtemplate,'Value',1,'Userdata',data,'Enable','on')
    close(handles.NID_Input_SpatialMap)
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ȡ��ģ�����벢�˳�����
Openfile = findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
OpenfileHandles = guihandles(Openfile);
set(OpenfileHandles.spatialtemplate,'Value',0,'Userdata','','Enable','on')
delete(NID_Input_SpatialMap)


% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function NID_Input_SpatialMap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NID_Input_SpatialMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit2,'String','','Enable','on');
set(handles.edit3,'String','','Enable','on');
set(handles.select_channel_list,'String','');

set(handles.add,'Enable','on')
set(handles.remove,'Enable','on')
NID_Input_SpatialMap_ClearChannel(handles)
NID_Input_SpatialMap_CreateFuntion(handles)


% --- Executes during object deletion, before destroying properties.
function NID_Input_SpatialMap_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to NID_Input_SpatialMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% Openfile = findobj('Tag','NIRS_ICA_Denoiser_open_file_and_ICA_config');
% OpenfileHandles = guihandles(Openfile);
% set(OpenfileHandles.spatialtemplate,'Value',0,'Userdata','','Enable','on')
% close(NID_Input_SpatialMap)


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to loadclc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% �����Ѿ����õĿռ�ģ��
% �����ÿռ�ģ���Ĭ��·��ΪNIRS���ݵ�����·��
Openfile = findobj('Tag','NIRS_ICA_Denoiser');
guiOpenfile_handles = guihandles(Openfile);
dataSource = get(guiOpenfile_handles.listbox1,'UserData');
temp = strfind(dataSource,filesep);
filepath = dataSource(1:temp(end));

[fname,fpath] = uigetfile([filepath,'*.mat']);
datain = load([fpath,fname]);
data = datain.data;
name = data.name;
thres = data.thres;
SP = data.SP;
%
spatialMap = get(handles.select_channel_list,'Userdata');
table_data = get(handles.uitable1,'Data');
table_info = get(handles.uitable1,'UserData');
%
table_row_old = table_info.row;
table_row_new = table_row_old + length(name);
%
table_data( table_row_old+1:table_row_new,1 ) = name;
table_data( table_row_old+1:table_row_new,2 ) = thres;
if isempty(spatialMap)
    spatialMap = SP;
else
    spatialMap( table_row_old+1:table_row_new ) = SP;
end


table_info.row = table_row_new;
table_info.select = table_row_new;
set(handles.select_channel_list,'Userdata',spatialMap);
set(handles.uitable1,'UserData',table_info);
set(handles.uitable1,'Data',table_data);

NID_Input_SpatialMap_ClearChannel(handles)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ���浱ǰ���������Ѿ��еĿռ�ģ��
% ����·��Ĭ��ΪNIRS���ݵ�·��
Openfile = findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
guiOpenfile_handles = guihandles(Openfile);
dataSource = get(guiOpenfile_handles.inpathData,'userdata');
temp = strfind(dataSource,'\');
filepath = dataSource(1:temp(end));

table_data = get(handles.uitable1,'Data');
table_info = get(handles.uitable1,'UserData');
spatialMap = get(handles.select_channel_list,'Userdata');

if table_info.row == 0
    name = {};
    thres = {};
    SP = {};
else
    k = table_info.row;
    name = table_data(1:k,1);
    thres = table_data(1:k,2);
    SP = spatialMap;
end

data.name = name;
data.thres = thres;
data.SP = SP;

uisave('data',[filepath,'SpatialMap_']);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over listbox1.
function listbox1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on listbox1 and none of its controls.
function listbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



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



% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

% ģ���б�ؼ��Ŀ��ƺ���
% ��ȡ�û���Ϊ����
if isempty(eventdata.Indices)
    return
end
% row ѡ�е���
mLine = eventdata.Indices(1);
% column ѡ�е���
nColumn = eventdata.Indices(2);
%
tables_data = get(handles.uitable1,'Data');
table_info = get(handles.uitable1,'UserData');
spatialMap = get(handles.select_channel_list,'Userdata');

% ѡ�п��У�����ʾ�κ�ģ��
if mLine>table_info.row
    NID_Input_SpatialMap_ClearChannel(handles)
    
    table_info.select = mLine;
    set(handles.uitable1,'UserData',table_info)
    return
end

NID_Input_SpatialMap_ClearChannel(handles)
NID_Input_SpatialMap_CreateFuntion(handles)

% ��ģ���Ӧλ�õ�ͨ����ɫ
button_handles = get(handles.channel_pannel,'Userdata');
data = spatialMap{mLine};
set(handles.select_channel_list,'String',num2str(data));
for i = 1:length(data)
    num = data(i);
    set(button_handles(num),'Value',0,'BackgroundColor',[0.71,0.71,1])
end

set(handles.text9,'String',tables_data{mLine,1})

table_info.select = mLine;
set(handles.uitable1,'UserData',table_info)
