function varargout = NIRS_Matrix_anova(varargin)
% NIRS_MATRIX_ANOVA MATLAB code for NIRS_Matrix_anova.fig
%      NIRS_MATRIX_ANOVA, by itself, creates a new NIRS_MATRIX_ANOVA or raises the existing
%      singleton*.
%
%      H = NIRS_MATRIX_ANOVA returns the handle to a new NIRS_MATRIX_ANOVA or the handle to
%      the existing singleton*.
%
%      NIRS_MATRIX_ANOVA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_MATRIX_ANOVA.M with the given input arguments.
%
%      NIRS_MATRIX_ANOVA('Property','Value',...) creates a new NIRS_MATRIX_ANOVA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_Matrix_anova_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_Matrix_anova_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_Matrix_anova

% Last Modified by GUIDE v2.5 23-Nov-2019 14:53:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_Matrix_anova_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_Matrix_anova_OutputFcn, ...
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


% --- Executes just before NIRS_Matrix_anova is made visible.
function NIRS_Matrix_anova_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_Matrix_anova (see VARARGIN)

% Choose default command line output for NIRS_Matrix_anova

set(handles.Tex_mask,'visible','off');
set(handles.mask_channels,'visible','off');
set(handles.Tex_ch,'visible','off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes NIRS_Matrix_anova wait for user response (see UIRESUME)
% uiwait(handles.NIRS_Matrix_anova);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_Matrix_anova_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in addGroupImages.
function addGroupImages_Callback(hObject, eventdata, handles)
% hObject    handle to addGroupImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentDir = get(handles.addGroupImages,'userdata');
if isempty(currentDir)
        currentDir = pwd; % ===============================================
end
if ~isempty(currentDir)
    newDir = uigetdir(currentDir);
    if ischar(newDir)
        oldList = get(handles.listGroupImages,'String');
        if( isempty(oldList) )
            theList = {newDir};
            k=1;
        else
            theList = [oldList;{newDir}];
            k=length(theList);
        end
        set(handles.listGroupImages,'String',theList,'value',k);
        set(handles.addGroupImages,'userdata',newDir); % save for next time select
                
        %  ====================== set default outpath =========================
        index_dir = findstr(newDir,filesep);
        subf=regexp(newDir,filesep,'split');                               
        id_ind=find(strcmp(subf,'Individual_Level'));
        if id_ind~=0
            outpath = fullfile(newDir(1:index_dir(id_ind-1)),'Group_Level');
            set(handles.outpath,'string',outpath);  % set output path name
        end
        %  ====================== set default outpath =========================
    end
end



% --- Executes on button press in addTextCovariates.
function addTextCovariates_Callback(hObject, eventdata, handles)
% hObject    handle to addTextCovariates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentDir = get(handles.addTextCovariates,'userdata');
if isempty(currentDir)
        currentDir = pwd; % ===============================================
end
if ~isempty(currentDir)
    [filename, pathname] = uigetfile(fullfile(currentDir,'*.txt'));
    if ischar(filename)
        oldList = get(handles.listTextCovariates,'String');
        if( isempty(oldList) )
            theList = {fullfile(pathname,filename)};
            k=1;
        else
            theList = [oldList;{fullfile(pathname,filename)}];
            k=length(theList);
        end
        set(handles.listTextCovariates,'String',theList,'value',k);
        set(handles.addTextCovariates,'userdata',pathname);
    end
end

% --- Executes on selection change in listGroupImages.
function listGroupImages_Callback(hObject, eventdata, handles)
% hObject    handle to listGroupImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listGroupImages contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listGroupImages
if ~isempty(get(handles.listGroupImages,'String'))
    set(handles.listGroupImages,'UIContextMenu',handles.rm_group);
else
    set(handles.listGroupImages,'UIContextMenu',[]);
end



% --- Executes during object creation, after setting all properties.
function listGroupImages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listGroupImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in listTextCovariates.
function listTextCovariates_Callback(hObject, eventdata, handles)
% hObject    handle to listTextCovariates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listTextCovariates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listTextCovariates
if ~isempty(get(handles.listTextCovariates,'String'))
    set(handles.listTextCovariates,'UIContextMenu',handles.rm_cov);
else
    set(handles.listTextCovariates,'UIContextMenu',[]);
end

% --- Executes during object creation, after setting all properties.
function listTextCovariates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listTextCovariates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in analysis.
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Matrix_anova(handles);



function groupNum_Callback(hObject, eventdata, handles)
% hObject    handle to groupNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of groupNum as text
%        str2double(get(hObject,'String')) returns contents of groupNum as a double


% --- Executes during object creation, after setting all properties.
function groupNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to groupNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function covNum_Callback(hObject, eventdata, handles)
% hObject    handle to covNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of covNum as text
%        str2double(get(hObject,'String')) returns contents of covNum as a double


% --- Executes during object creation, after setting all properties.
function covNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to covNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textNum_Callback(hObject, eventdata, handles)
% hObject    handle to textNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textNum as text
%        str2double(get(hObject,'String')) returns contents of textNum as a double


% --- Executes during object creation, after setting all properties.
function textNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function currentDir_Callback(hObject, eventdata, handles)
% hObject    handle to currentDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currentDir as text
%        str2double(get(hObject,'String')) returns contents of currentDir as a double


% --- Executes during object creation, after setting all properties.
function currentDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currentDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function NIRS_REST_anova_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_anova (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when user attempts to close NIRS_Matrix_anova.
function NIRS_REST_anova_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to NIRS_Matrix_anova (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function pValue_Callback(hObject, eventdata, handles)
% hObject    handle to pValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pValue as text
%        str2double(get(hObject,'String')) returns contents of pValue as a double


% --- Executes during object creation, after setting all properties.
function pValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method
corr_meth = get(handles.method,'value');

if corr_meth == 2 || corr_meth == 3
    set(handles.Tex_mask,'visible','on');
    set(handles.Tex_mask,'value',0);
    set(handles.mask_channels,'visible','off');
    set(handles.Tex_ch,'visible','off');
else
    set(handles.Tex_mask,'value',0);
    set(handles.Tex_mask,'visible','off');
    set(handles.mask_channels,'string',[]);
    set(handles.mask_channels,'visible','off');
    set(handles.Tex_ch,'visible','off');
end
% Update handles structure
guidata(hObject, handles);



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


% --- Executes on button press in output.
function output_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
if ischar(outpath)
    set(handles.outpath,'string',outpath);
end


% --- Executes on button press in isrepeated.
function isrepeated_Callback(hObject, eventdata, handles)
% hObject    handle to isrepeated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isrepeated



function mask_channels_Callback(hObject, eventdata, handles)
% hObject    handle to mask_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mask_channels as text
%        str2double(get(hObject,'String')) returns contents of mask_channels as a double


% --- Executes during object creation, after setting all properties.
function mask_channels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Tex_mask.
function Tex_mask_Callback(hObject, eventdata, handles)
% hObject    handle to Tex_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Tex_mask
if get(handles.Tex_mask,'value')
    set(handles.Tex_ch,'visible','on');
    set(handles.mask_channels,'visible','on');
    set(handles.mask_channels,'string',[]); 
else
    set(handles.Tex_ch,'visible','off');
    set(handles.mask_channels,'visible','off');
end
% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function rm_covariate_Callback(hObject, eventdata, handles)
% hObject    handle to rm_covariate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cov_id=get(handles.listTextCovariates,'Value');
raw_cov=get(handles.listTextCovariates,'String');
new_cov=raw_cov(setdiff(1:size(raw_cov,1),cov_id));
if ~isempty(new_cov)
    set(handles.listTextCovariates,'String',new_cov,'Value',1);
else
    set(handles.listTextCovariates,'String',[],'Value',0);
end

% Update handles structure
guidata(hObject, handles);



% --------------------------------------------------------------------
function rm_gp_dep_Callback(hObject, eventdata, handles)
% hObject    handle to rm_gp_dep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gr_id=get(handles.listGroupImages,'Value');
raw_gp=get(handles.listGroupImages,'String');
new_gp=raw_gp(setdiff(1:size(raw_gp,1),gr_id));
if ~isempty(new_gp)
    set(handles.listGroupImages,'String',new_gp,'Value',1);
else
    set(handles.listGroupImages,'String',[],'Value',0);
end

% Update handles structure
guidata(hObject, handles);

% --------------------------------------------------------------------
function rm_group_Callback(hObject, eventdata, handles)
% hObject    handle to rm_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rm_cov_Callback(hObject, eventdata, handles)
% hObject    handle to rm_cov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
