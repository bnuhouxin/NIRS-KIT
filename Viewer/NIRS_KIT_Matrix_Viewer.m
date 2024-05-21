function varargout = NIRS_KIT_Matrix_Viewer(varargin)
% NIRS_KIT_MATRIX_VIEWER MATLAB code for NIRS_KIT_Matrix_Viewer.fig
%      NIRS_KIT_MATRIX_VIEWER, by itself, creates a new NIRS_KIT_MATRIX_VIEWER or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_MATRIX_VIEWER returns the handle to a new NIRS_KIT_MATRIX_VIEWER or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_MATRIX_VIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT_MATRIX_VIEWER.M with the given input arguments.
%
%      NIRS_KIT_MATRIX_VIEWER('Property','Value',...) creates a new NIRS_KIT_MATRIX_VIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_Matrix_Viewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_Matrix_Viewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_Matrix_Viewer

% Last Modified by GUIDE v2.5 24-Nov-2020 13:31:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_Matrix_Viewer_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_Matrix_Viewer_OutputFcn, ...
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


% --- Executes just before NIRS_KIT_Matrix_Viewer is made visible.
function NIRS_KIT_Matrix_Viewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT_Matrix_Viewer (see VARARGIN)

% Choose default command line output for NIRS_KIT_Matrix_Viewer

% default setting for FC_Matrix_Plot---------------------------------------
set(handles.advanced_text,'visible','off');
set(handles.subnet_xls_path,'visible','off');
set(handles.add_subnet_xls,'visible','off');
set(handles.tex_subnet_type,'visible','off');
set(handles.subnet_type,'visible','off');
set(handles.is_node_edge,'visible','off');

set(handles.is_adv_opt,'userdata',0);
% -------------------------------------------------------------------------

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_Matrix_Viewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_Matrix_Viewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inpath_mtx_Callback(hObject, eventdata, handles)
% hObject    handle to inpath_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpath_mtx as text
%        str2double(get(hObject,'String')) returns contents of inpath_mtx as a double


% --- Executes during object creation, after setting all properties.
function inpath_mtx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpath_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in input_mtx.
function input_mtx_Callback(hObject, eventdata, handles)
% hObject    handle to input_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.mat';'*.txt'});
if ischar(filename)
    inpath_mtx = fullfile(pathname,filename);
    set(handles.inpath_mtx,'String',inpath_mtx);
    if strcmp(filename(end-2:end),'mat')
        set(handles.thres_p,'visible','on');
        set(handles.mtx_thres_p,'visible','on');
        set(handles.mtx_thres_p,'string',[]);
        
        load(inpath_mtx);
        set(handles.min_mtx,'string',min(statdata.stat(:)));
        set(handles.max_mtx,'string',max(statdata.stat(:)));
    elseif strcmp(filename(end-2:end),'txt')
        set(handles.mtx_thres_p,'string',[]);
        set(handles.thres_p,'visible','off');
        set(handles.mtx_thres_p,'visible','off');            
        
        mtx_data=load(inpath_mtx);
        set(handles.min_mtx,'string',min(mtx_data(:)));
        set(handles.max_mtx,'string',max(mtx_data(:)));
    end
end



function mtx_thres_p_Callback(hObject, eventdata, handles)
% hObject    handle to mtx_thres_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mtx_thres_p as text
%        str2double(get(hObject,'String')) returns contents of mtx_thres_p as a double


% --- Executes during object creation, after setting all properties.
function mtx_thres_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mtx_thres_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mtx_view.
function mtx_view_Callback(hObject, eventdata, handles)
% hObject    handle to mtx_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.mtx_id,handles.node_edge]=fc_matrix_plot(handles);
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in mtx_save.
function mtx_save_Callback(hObject, eventdata, handles)
% hObject    handle to mtx_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpath=get(handles.inpath_mtx,'string');
[stat_path,stat_name]=fileparts(inpath);

if isfield(handles,'mtx_id')
    if ishandle(handles.mtx_id)
        [fn,fp]= uiputfile({'*.tif';'*.eps';'*.emf'},'Save FC Matrix Figure',fullfile(stat_path,stat_name));
        if ischar(fn)
            out_type=fn(end-2:end);
            if strcmp(out_type,'tif')
                export_fig(handles.mtx_id,fullfile(fp,fn),'-m2.5');
                msgbox('Result Figure has been saved','Success','help');
            elseif strcmp(out_type,'eps')
                print(handles.mtx_id,'-depsc','-painters',fullfile(fp,fn));
                msgbox('Result Figure has been saved','Success','help');
            elseif strcmp(out_type,'emf')
                saveas(handles.hot2d,fullfile(fp,fn));
                msgbox('Result Figure has been saved','Success','help');
            end
        end
    else
        msgbox('The figure handle has been closed','Warning','warn');
    end
end


if get(handles.is_node_edge,'value')
    [fn,fp]= uiputfile({'*'},'Save Node && Edge Files',fullfile(stat_path,stat_name));
    NodeID = fopen(fullfile(fp,[fn,'.node']),'w');
    formatSpec = '%d %d %d %d %d %s\n';
    [nrows,~] = size(handles.node_edge.Node);
    for row = 1:nrows
        fprintf(NodeID,formatSpec,handles.node_edge.Node{row,:});
    end
    fclose(NodeID);
    
    EgdeID=handles.node_edge.Edge;
    save(fullfile(fp,[fn,'.edge']),'EgdeID','-ascii');
    msgbox('Node and edge files have been saved','Success','help');
end


function subnet_xls_path_Callback(hObject, eventdata, handles)
% hObject    handle to subnet_xls_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subnet_xls_path as text
%        str2double(get(hObject,'String')) returns contents of subnet_xls_path as a double


% --- Executes during object creation, after setting all properties.
function subnet_xls_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subnet_xls_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in is_adv_opt.
function is_adv_opt_Callback(hObject, eventdata, handles)
% hObject    handle to is_adv_opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of is_adv_opt
if get(handles.is_adv_opt,'value')
    set(handles.advanced_text,'visible','on');
    set(handles.subnet_xls_path,'visible','on');
    set(handles.add_subnet_xls,'visible','on');
else
    set(handles.subnet_xls_path,'string',[]);
    set(handles.subnet_type,'value',1);
    set(handles.advanced_text,'visible','off');
    set(handles.subnet_xls_path,'visible','off');
    set(handles.add_subnet_xls,'visible','off');
    set(handles.tex_subnet_type,'visible','off');
    set(handles.subnet_type,'visible','off');
    set(handles.is_adv_opt,'userdata',0);
    set(handles.is_node_edge,'value',0);
    set(handles.is_node_edge,'visible','off');
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in add_subnet_xls.
function add_subnet_xls_Callback(hObject, eventdata, handles)
% hObject    handle to add_subnet_xls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(fullfile(pwd,'*.xlsx'));

if ischar(filename)
    hi=waitbar(1,'Please wait ... ...');
    subnet_xls = fullfile(pathname,filename);
    set(handles.subnet_xls_path,'userdata',pathname);
    set(handles.subnet_xls_path,'String',filename);
    [~, ~, mtx_xls] = xlsread(subnet_xls);
    mtx_xls = mtx_xls(2:end,:);
    mtx_xls(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),mtx_xls)) = {''};
    [mm,nn]=size(mtx_xls);
    if nn >= 6
        set(handles.tex_subnet_type,'visible','on');
        set(handles.subnet_type,'visible','on');
        set(handles.is_adv_opt,'userdata',2);
    elseif nn ==1
        set(handles.is_adv_opt,'userdata',1);
        set(handles.subnet_type,'value',1);
        set(handles.tex_subnet_type,'visible','off');
        set(handles.subnet_type,'visible','off');
    end
    if nn == 10
        set(handles.is_node_edge,'visible','on');
    end
    delete(hi);
end


function min_mtx_Callback(hObject, eventdata, handles)
% hObject    handle to min_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_mtx as text
%        str2double(get(hObject,'String')) returns contents of min_mtx as a double


% --- Executes during object creation, after setting all properties.
function min_mtx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_mtx_Callback(hObject, eventdata, handles)
% hObject    handle to max_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_mtx as text
%        str2double(get(hObject,'String')) returns contents of max_mtx as a double


% --- Executes during object creation, after setting all properties.
function max_mtx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_mtx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in is_node_edge.
function is_node_edge_Callback(hObject, eventdata, handles)
% hObject    handle to is_node_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of is_node_edge


% --- Executes on selection change in subnet_type.
function subnet_type_Callback(hObject, eventdata, handles)
% hObject    handle to subnet_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns subnet_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from subnet_type


% --- Executes during object creation, after setting all properties.
function subnet_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subnet_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in is_gridlines.
function is_gridlines_Callback(hObject, eventdata, handles)
% hObject    handle to is_gridlines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of is_gridlines


% --- Executes on selection change in CMap.
function CMap_Callback(hObject, eventdata, handles)
% hObject    handle to CMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CMap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CMap


% --- Executes during object creation, after setting all properties.
function CMap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
