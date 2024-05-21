function varargout = NIRS_KIT_Result_Viewer(varargin)
% NIRS_KIT_RESULT_VIEWER MATLAB code for NIRS_KIT_Result_Viewer.fig
%      NIRS_KIT_RESULT_VIEWER, by itself, creates a new NIRS_KIT_RESULT_VIEWER or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_RESULT_VIEWER returns the handle to a new NIRS_KIT_RESULT_VIEWER or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_RESULT_VIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT_RESULT_VIEWER.M with the given input arguments.
%
%      NIRS_KIT_RESULT_VIEWER('Property','Value',...) creates a new NIRS_KIT_RESULT_VIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_Result_Viewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_Result_Viewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_Result_Viewer

% Last Modified by GUIDE v2.5 30-Jan-2021 20:21:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_Result_Viewer_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_Result_Viewer_OutputFcn, ...
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


% --- Executes just before NIRS_KIT_Result_Viewer is made visible.
function NIRS_KIT_Result_Viewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT_Result_Viewer (see VARARGIN)

% Choose default command line output for NIRS_KIT_Result_Viewer

% default setting for 2D_Hotmap_Plot---------------------------------------
set(handles.isInterpolation,'value',1);

set(handles.tex_size,'visible','off');
set(handles.circle_size,'visible','off');
set(handles.isEdge,'visible','off');
set(handles.tex_bgc,'visible','off');
set(handles.gbc_value,'visible','off');
% -------------------------------------------------------------------------

% default setting for 3D_Hotmap_Plot---------------------------------------

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_Result_Viewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_Result_Viewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in input3d.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to input3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inpath3d_Callback(hObject, eventdata, handles)
% hObject    handle to inpath3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpath3d as text
%        str2double(get(hObject,'String')) returns contents of inpath3d as a double


% --- Executes during object creation, after setting all properties.
function inpath3d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpath3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function path2d_Callback(hObject, eventdata, handles)
% hObject    handle to path2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path2d as text
%        str2double(get(hObject,'String')) returns contents of path2d as a double


% --- Executes during object creation, after setting all properties.
function path2d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isProbe2d.
function isProbe2d_Callback(hObject, eventdata, handles)
% hObject    handle to isProbe2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of isProbe2d
if get(handles.isProbe2d,'value')
    set(handles.addProbe,'enable','on');
    set(handles.path2d,'enable','on');
else
    set(handles.addProbe,'enable','off');
    set(handles.path2d,'enable','off');
end

% --- Executes on button press in addProbe.
function addProbe_Callback(hObject, eventdata, handles)
% hObject    handle to addProbe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RootDirectory = which('NIRS_KIT');
index_dir=fileparts(RootDirectory);
defaultSetDir=fullfile(index_dir,'Sample_Data','Temp_2D_ProbeSet');
[filename, pathname] = uigetfile(fullfile(defaultSetDir,'*.mat'));

if  ischar(filename)
    set(handles.path2d,'userdata',pathname);
    set(handles.path2d,'string',filename);
end

% --- Executes on button press in view2d.
function view2d_Callback(hObject, eventdata, handles)
% hObject    handle to view2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.isProbe2d,'value') && isempty(get(handles.path2d,'string'))
    msgbox({'There is no probeset inf !!!';'Please select ... ...'},'Warning','warn');
else
    handles.hot2d=NR_plot2d(handles);
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in input3d.
function input3d_Callback(hObject, eventdata, handles)
% hObject    handle to input3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(fullfile(pwd,'*.xlsx'));

if ischar(filename)
    inpath_xls = fullfile(pathname,filename);
    
    hi=waitbar(1,'Please wait ... ...');

    set(handles.inpath3d,'String',inpath_xls);
    [~,~,xls_data]=xlsread(inpath_xls);
    xls_data = xls_data(2:end,:);
    xls_data=cell2mat(xls_data);
    set(handles.climt_min_3d,'string',min(xls_data(:,5)));
    set(handles.climt_max_3d,'string',max(xls_data(:,5)));
    
    delete(hi);
end



function inpath2d_Callback(hObject, eventdata, handles)
% hObject    handle to inpath2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpath2d as text
%        str2double(get(hObject,'String')) returns contents of inpath2d as a double


% --- Executes during object creation, after setting all properties.
function inpath2d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpath2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in isInterpolation.
function isInterpolation_Callback(hObject, eventdata, handles)
% hObject    handle to isInterpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of isInterpolation
if get(handles.isInterpolation,'value')
    set(handles.tex_size,'visible','off');
    set(handles.circle_size,'visible','off');
    set(handles.isEdge,'visible','off');
    set(handles.tex_bgc,'visible','off');
    set(handles.gbc_value,'visible','off');
else
    set(handles.tex_size,'visible','on');
    set(handles.circle_size,'visible','on');
    set(handles.isEdge,'visible','on');
    set(handles.tex_bgc,'visible','on');
    set(handles.gbc_value,'visible','on');
    
    set(handles.isEdge,'value',0);
    set(handles.circle_size,'string','1');
    set(handles.gbc_value,'string','255 255 255');
end

% --- Executes on button press in save2d.
function save2d_Callback(hObject, eventdata, handles)
% hObject    handle to save2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpath=get(handles.inpath2d,'string');
[stat_path,stat_name]=fileparts(inpath);

if isfield(handles,'hot2d')
    if ishandle(handles.hot2d)
        [fn,fp]= uiputfile({'*.tif';'*.eps';'*.emf'},'Save 2D Hotmap',fullfile(stat_path,stat_name));
        if ischar(fn)
            out_type=fn(end-2:end);
            if strcmp(out_type,'tif')
                export_fig(handles.hot2d,fullfile(fp,fn),'-m2.5');
                msgbox('Result Figure has been saved','Success','help');
            elseif strcmp(out_type,'eps')
                print(handles.hot2d,'-depsc','-painters',fullfile(fp,fn));
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



function min2d_Callback(hObject, eventdata, handles)
% hObject    handle to min2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min2d as text
%        str2double(get(hObject,'String')) returns contents of min2d as a double


% --- Executes during object creation, after setting all properties.
function min2d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max2d_Callback(hObject, eventdata, handles)
% hObject    handle to max2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max2d as text
%        str2double(get(hObject,'String')) returns contents of max2d as a double


% --- Executes during object creation, after setting all properties.
function max2d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function circle_size_Callback(hObject, eventdata, handles)
% hObject    handle to circle_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of circle_size as text
%        str2double(get(hObject,'String')) returns contents of circle_size as a double


% --- Executes during object creation, after setting all properties.
function circle_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to circle_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isEdge.
function isEdge_Callback(hObject, eventdata, handles)
% hObject    handle to isEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isEdge



function gbc_value_Callback(hObject, eventdata, handles)
% hObject    handle to gbc_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gbc_value as text
%        str2double(get(hObject,'String')) returns contents of gbc_value as a double


% --- Executes during object creation, after setting all properties.
function gbc_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gbc_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in view_3d_gii.
function view_3d_gii_Callback(hObject, eventdata, handles)
% hObject    handle to view_3d_gii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n_type = get(handles.shown_type_3d,'value');

switch n_type   
    case 1
        if ~isempty(get(handles.temp_nii_gii_file,'string'))
            handles.gii3d_id=NR_plot3dgii(handles);
        else
            msgbox({'Brain template has not been selected !!!';'Please select ... ...'},'Warning','warn');
        end
    otherwise {2,4};
        handles.gii3d_id=NR_plot3dgii(handles);
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in save_3d.
function save_3d_Callback(hObject, eventdata, handles)
% hObject    handle to save_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpath3d=get(handles.inpath3d,'string');
[inputfd_3d,inputname_3d]=fileparts(inpath3d);
shown_type = get(handles.shown_type_3d,'value');

if ismember(shown_type, [1, 4]) && isfield(handles,'gii3d_id')
    if ishandle(handles.gii3d_id)
        [fn,fp]= uiputfile({'*.tif';'*.eps';'*emf'},'Save 3D Surfice Figure',fullfile(inputfd_3d,inputname_3d));
        if ischar(fn)
            out_type=fn(end-2:end);
            if strcmp(out_type,'tif')
                export_fig(handles.gii3d_id,fullfile(fp,fn),'-m2.5');
                msgbox('Result Figure has been saved','Success','help');
            elseif strcmp(out_type,'eps')
                saveas(handles.gii3d_id,fullfile(fp,fn),'epsc');
                msgbox('Result Figure has been saved','Success','help');
            elseif strcmp(out_type,'emf')
                saveas(handles.hot2d,fullfile(fp,fn));
                msgbox('Result Figure has been saved','Success','help');
            end
        end
    else
        msgbox('The figure handle has been closed','Warning','warn');
    end
elseif shown_type == 3
    [fn,fp]= uiputfile({'*.nii'},'Save 3D Nifti Figure',fullfile(inputfd_3d,inputname_3d));
    if ischar(fn)
        handles.save_nii_name=fullfile(fp,fn);
        NK_generate_nii(handles);
        msgbox('Result nii file has been saved','Success','help');
    end
end
% Update handles structure
guidata(hObject, handles);

function temp_nii_gii_file_Callback(hObject, eventdata, handles)
% hObject    handle to temp_nii_gii_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_nii_gii_file as text
%        str2double(get(hObject,'String')) returns contents of temp_nii_gii_file as a double


% --- Executes during object creation, after setting all properties.
function temp_nii_gii_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_nii_gii_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_nii_gii.
function add_nii_gii_Callback(hObject, eventdata, handles)
% hObject    handle to add_nii_gii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
root_path=which('NIRS_KIT');
temp_path=fullfile(fileparts(root_path),'BrainTemplate');
if get(handles.shown_type_3d,'value') == 1
    [filename, pathname] = uigetfile(fullfile(temp_path,'*.mat'));
elseif get(handles.shown_type_3d,'value') == 3
    [filename, pathname] = uigetfile(fullfile(temp_path,'*.nii'));
end

if ischar(filename)
    set(handles.temp_nii_gii_file,'String',filename);
    set(handles.temp_nii_gii_file,'userdata',pathname);
end
% Update handles structure
guidata(hObject, handles);



% --- Executes on selection change in shown_type_3d.
function shown_type_3d_Callback(hObject, eventdata, handles)
% hObject    handle to shown_type_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns shown_type_3d contents as cell array
%        contents{get(hObject,'Value')} returns selected item from shown_type_3d

if get(handles.shown_type_3d,'value') == 1 % plot on surface
    set(handles.climt_min_3d,'enable','on');
    set(handles.climt_max_3d,'enable','on');
    
    set(handles.temp_nii_gii_file,'string',[]);
    set(handles.temp_nii_gii_file,'userdata',[]);
    
    if strcmp(get(handles.temp_nii_gii_file,'enable'),'off')
        set(handles.temp_nii_gii_file,'enable','on');
        set(handles.add_nii_gii,'enable','on');
    end
    
    if strcmp(get(handles.circle_size_3d,'enable'),'off')
        set(handles.circle_size_3d,'enable','on');
    end
    
    set(handles.view_3d_gii,'enable','on');
    
    if strcmp(get(handles.save_3d,'enable'),'off')
        set(handles.save_3d,'enable','on');
    end
    
    if strcmp(get(handles.Is_scalp,'enable'),'off')
        set(handles.Is_scalp,'enable','on');  
    end
    set(handles.Is_lighting,'enable','on');

elseif get(handles.shown_type_3d,'value') == 2 % Nfri_mni_plot
    set(handles.temp_nii_gii_file,'string',[]);
    set(handles.temp_nii_gii_file,'userdata',[]);
    set(handles.temp_nii_gii_file,'enable','off');
    set(handles.add_nii_gii,'enable','off');
    
    if strcmp(get(handles.circle_size_3d,'enable'),'off')
        set(handles.circle_size_3d,'enable','on');
    end
    
    if strcmp(get(handles.climt_min_3d,'enable'),'off')
        set(handles.climt_min_3d,'enable','on');
        set(handles.climt_max_3d,'enable','on');
    end
    
    if strcmp(get(handles.save_3d,'enable'),'on')
        set(handles.save_3d,'enable','off');
    end
    
    if strcmp(get(handles.view_3d_gii,'enable'),'off')
       set(handles.view_3d_gii,'enable','on'); 
    end
    
    if strcmp(get(handles.Is_scalp,'enable'),'off')
        set(handles.Is_scalp,'enable','on');      
    end
    set(handles.Is_lighting,'enable','off');

elseif get(handles.shown_type_3d,'value') == 3 % output nii
    
    set(handles.temp_nii_gii_file,'string',[]);
    set(handles.temp_nii_gii_file,'userdata',[]);
    
    set(handles.climt_min_3d,'enable','off');
    set(handles.climt_max_3d,'enable','off');
    
    if strcmp(get(handles.temp_nii_gii_file,'enable'),'off')
        set(handles.temp_nii_gii_file,'enable','on');
        set(handles.add_nii_gii,'enable','on');
    end
    
    if strcmp(get(handles.circle_size_3d,'enable'),'off')
        set(handles.circle_size_3d,'enable','on');
    end
    
    if strcmp(get(handles.save_3d,'enable'),'off')
        set(handles.save_3d,'enable','on');
    end
    
    if strcmp(get(handles.Is_scalp,'enable'),'on')
        set(handles.Is_scalp,'enable','off');
        set(handles.Is_lighting,'enable','off');
    end
        
    set(handles.view_3d_gii,'enable','off');
    
elseif get(handles.shown_type_3d,'value') == 4 % EasyTopo
    set(handles.temp_nii_gii_file,'string',[]);
    set(handles.temp_nii_gii_file,'userdata',[]);
    set(handles.temp_nii_gii_file,'enable','off');
    set(handles.add_nii_gii,'enable','off');
    
    set(handles.circle_size_3d,'enable','off');
    set(handles.climt_min_3d,'enable','off');
    set(handles.climt_max_3d,'enable','off');
    
    if strcmp(get(handles.view_3d_gii,'enable'),'off')
        set(handles.view_3d_gii,'enable','on');
    end
    
    if strcmp(get(handles.save_3d,'enable'),'off')
        set(handles.save_3d,'enable','on');
    end
    
    if strcmp(get(handles.Is_scalp,'enable'),'off')
        set(handles.Is_scalp,'enable','on');
    end
    set(handles.Is_lighting,'enable','on');
end
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function shown_type_3d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shown_type_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function circle_size_3d_Callback(hObject, eventdata, handles)
% hObject    handle to circle_size_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of circle_size_3d as text
%        str2double(get(hObject,'String')) returns contents of circle_size_3d as a double


% --- Executes during object creation, after setting all properties.
function circle_size_3d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to circle_size_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function climt_min_3d_Callback(hObject, eventdata, handles)
% hObject    handle to climt_min_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of climt_min_3d as text
%        str2double(get(hObject,'String')) returns contents of climt_min_3d as a double


% --- Executes during object creation, after setting all properties.
function climt_min_3d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to climt_min_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function climt_max_3d_Callback(hObject, eventdata, handles)
% hObject    handle to climt_max_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of climt_max_3d as text
%        str2double(get(hObject,'String')) returns contents of climt_max_3d as a double


% --- Executes during object creation, after setting all properties.
function climt_max_3d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to climt_max_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in input2d.
function input2d_Callback(hObject, eventdata, handles)
% hObject    handle to input2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(fullfile(pwd,'*.mat'));

if ischar(filename)
    load([pathname filename]);
    statpath = fullfile(pathname,filename);
    set(handles.inpath2d,'String',statpath);
    
    if exist('statdata','var')
        if isempty(statdata.probe2d)
            set(handles.isProbe2d,'value',1);
            set(handles.addProbe,'enable','on');
            set(handles.path2d,'enable','on');
            set(handles.path2d,'string','');
        else
            set(handles.isProbe2d,'value',0);
            set(handles.addProbe,'enable','off');
            set(handles.path2d,'string','');
            set(handles.path2d,'enable','off');
        end
    elseif exist('indexdata','var')
        if isempty(indexdata.probe2d)
            set(handles.isProbe2d,'value',1);
            set(handles.addProbe,'enable','on');
            set(handles.path2d,'enable','on');
            set(handles.path2d,'string','');
        else
            set(handles.isProbe2d,'value',0);
            set(handles.addProbe,'enable','off');
            set(handles.path2d,'string','');
            set(handles.path2d,'enable','off');
        end
    end
    
    if exist('statdata','var') 
        if isfield(statdata,'roiCh1')
            ex_stat=statdata.stat(setdiff(1:end,statdata.roiCh1));

            set(handles.min2d,'string',num2str(min(ex_stat)));
            set(handles.max2d,'string',num2str(max(ex_stat)));

            set(handles.isInterpolation,'value',0);
            set(handles.tex_size,'visible','on');
            set(handles.circle_size,'visible','on');
            set(handles.isEdge,'visible','on');
            set(handles.tex_bgc,'visible','on');
            set(handles.gbc_value,'visible','on');
        else
            set(handles.min2d,'string',num2str(min(statdata.stat)));
            set(handles.max2d,'string',num2str(max(statdata.stat)));
            
            set(handles.isInterpolation,'value',1);
            set(handles.tex_size,'visible','off');
            set(handles.circle_size,'visible','off');
            set(handles.isEdge,'visible','off');
            set(handles.tex_bgc,'visible','off');
            set(handles.gbc_value,'visible','off');
        end          
    elseif exist('indexdata','var') 
        if isfield(indexdata,'roiCh1')
            ex_stat=indexdata.index(setdiff(1:end,indexdata.roiCh1));
            
            set(handles.min2d,'string',num2str(min(ex_stat)));
            set(handles.max2d,'string',num2str(max(ex_stat)));
            
            set(handles.isInterpolation,'value',0);
            set(handles.tex_size,'visible','on');
            set(handles.circle_size,'visible','on');
            set(handles.isEdge,'visible','on');
            set(handles.tex_bgc,'visible','on');
            set(handles.gbc_value,'visible','on');
        else
            set(handles.min2d,'string',num2str(min(indexdata.index)));
            set(handles.max2d,'string',num2str(max(indexdata.index)));
            
            set(handles.isInterpolation,'value',1);
            set(handles.tex_size,'visible','off');
            set(handles.circle_size,'visible','off');
            set(handles.isEdge,'visible','off');
            set(handles.tex_bgc,'visible','off');
            set(handles.gbc_value,'visible','off');            
        end
    end
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Is_scalp.
function Is_scalp_Callback(hObject, eventdata, handles)
% hObject    handle to Is_scalp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Is_scalp

if get(handles.Is_scalp,'value')
    set(handles.scalp_alpha,'enable','on');
else
    set(handles.scalp_alpha,'enable','off');
end



function scalp_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to scalp_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scalp_alpha as text
%        str2double(get(hObject,'String')) returns contents of scalp_alpha as a double


% --- Executes during object creation, after setting all properties.
function scalp_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalp_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Is_lighting.
function Is_lighting_Callback(hObject, eventdata, handles)
% hObject    handle to Is_lighting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Is_lighting


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
