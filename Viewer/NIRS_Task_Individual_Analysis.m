function varargout = NIRS_Task_Individual_Analysis(varargin)
% NIRS_TASK_INDIVIDUAL_ANALYSIS MATLAB code for NIRS_Task_Individual_Analysis.fig
%      NIRS_TASK_INDIVIDUAL_ANALYSIS, by itself, creates a new NIRS_TASK_INDIVIDUAL_ANALYSIS or raises the existing
%      singleton*.
%
%      H = NIRS_TASK_INDIVIDUAL_ANALYSIS returns the handle to a new NIRS_TASK_INDIVIDUAL_ANALYSIS or the handle to
%      the existing singleton*.
%
%      NIRS_TASK_INDIVIDUAL_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_TASK_INDIVIDUAL_ANALYSIS.M with the given input arguments.
%
%      NIRS_TASK_INDIVIDUAL_ANALYSIS('Property','Value',...) creates a new NIRS_TASK_INDIVIDUAL_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_Task_Individual_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_Task_Individual_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_Task_Individual_Analysis

% Last Modified by GUIDE v2.5 04-Aug-2023 10:38:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NIRS_Task_Individual_Analysis_OpeningFcn, ...
    'gui_OutputFcn',  @NIRS_Task_Individual_Analysis_OutputFcn, ...
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


% --- Executes just before NIRS_Task_Individual_Analysis is made visible.
function NIRS_Task_Individual_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_Task_Individual_Analysis (see VARARGIN)

set(handles.Oxy,'value',1);
set(handles.Dxy,'value',1);

set(handles.design_msg,'visible','off');
set(handles.add_design_mat,'visible','off');
set(handles.design_mat_path,'visible','off');
set(handles.ensure_msg,'visible','off');
set(handles.opensample,'visible','off');
set(handles.design_maker,'visible','off');

handles.condi_num=0;
handles.contr_num=0;
handles.cov_num = 0;

handles.onset={};
handles.dur={};
handles.cond_name={};
handles.cont_name={};
handles.contrs={};
handles.UnitStat=1;
handles.DesTpStat=1;
handles.desplot=0;
handles.inputtype=0;

handles.design_inf={};

% Choose default command line output for gretna_GUI_EdgeInterface
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes NIRS_Task_Individual_Analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_Task_Individual_Analysis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;







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


% --- Executes on button press in output.
function output_Callback(hObject, eventdata, handles)
% hObject    handle to output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
if ischar(outpath)
    set(handles.outpath,'string',outpath);  % set outpath name
end


% --- Executes during object creation, after setting all properties.
function inpathList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpathList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addPath.
function addPath_Callback(hObject, eventdata, handles)
% hObject    handle to addPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.cond_listbox,'value',1);
set(handles.contrast_listbox,'value',1);
inpath = uigetdir(pwd,'Please select the preprocessed data folder');
set(handles.addPath,'userdata',inpath);
set(handles.fileList,'value',1);
userid=get(handles.fileList,'value');
if ischar(inpath)
    files = dir(fullfile(inpath,'*.mat'));
    if ~isempty(files)
        for i = 1:length(files)
            fileList{i} = files(i).name(1:end-4);
        end
        set(handles.fileList,'string',fileList);
        
        if handles.desplot==1
            cla(handles.axes_desmtx,'reset');
            set(handles.axes_desmtx,'box','on');
            set(handles.axes_desmtx,'XTick',[]);
            set(handles.axes_desmtx,'YTick',[]);
            cla(handles.axes_contrs,'reset');
            set(handles.axes_contrs,'box','on');
            set(handles.axes_contrs,'XTick',[]);
            set(handles.axes_contrs,'YTick',[]);
            handles.desplot=0;
            set(handles.cond_listbox,'userdata',{});
            set(handles.cond_listbox,'string',{});
            set(handles.contrast_listbox,'userdata',{});
            set(handles.contrast_listbox,'string',{});
            handles.onset={};
            handles.dur={};
            handles.contrs={};
            handles.condi_num=0;
            handles.contr_num=0;
            handles.cov_num = 0;
        end
        
        load(fullfile(inpath,fileList{userid})); 
        if exist('GLM_data','var') % load GLM data path
            handles.inputtype=2;
            set(handles.GLM_panel,'visible','off');
            [out,~]=fileparts(inpath);
            set(handles.outpath,'string',out);
            
            if isfield(GLM_data,'cov')
                if ~isempty(GLM_data.cov)
                    set(handles.add_cov,'enable','off');
                    set(handles.Add_CovP,'enable','off');
                    set(handles.covp_box,'enable','off');
                end
            end
            
            if isfield(GLM_data,'beta_Oxy')
                set(handles.Oxy,'value',1);
            else
                set(handles.Oxy,'value',0);
            end
            if isfield(GLM_data,'beta_Dxy')
                set(handles.Dxy,'value',1);
            else
                set(handles.Dxy,'value',0);
            end
            if isfield(GLM_data,'beta_Total')
                set(handles.Total,'value',1);
            else
                set(handles.Total,'value',0);
            end
            % -------------------------------------------------------------
            [~,condi_num]=size(GLM_data.desmtx);
            handles.condi_num = condi_num;
            [m,n]=size(GLM_data.predmtx);
            for i=1:condi_num
                con_lable{i}=['con',num2str(i),' '];
            end
            
            if ~isempty(GLM_data.cov)
                [~,cov_num] = size(GLM_data.cov);
                handles.cov_num = cov_num;
                for j=1:cov_num
                        cov_lable{j}=['cov',num2str(j),' '];
                end
            end
                        
            if ~isempty(GLM_data.cov)
                xlable = [con_lable, cov_lable];
            else
                xlabel = con_lable;
            end
            xlable{n}='constant ';
            
            axes(handles.axes_desmtx);
            imagesc(GLM_data.predmtx);
            handles.desplot=1;
            
            my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
            my_gray=repmat(my_gray,1,3);
            colormap(handles.axes_desmtx,my_gray);
            
            xt=get(handles.axes_desmtx,'XTick');
            yt=get(handles.axes_desmtx,'YTick');
            set(handles.axes_desmtx,'YTick',[],'XTick',[]);
            
            tx=text([1:n],ones(1,n)*m,xlable);
            set(tx,'HorizontalAlignment','right','Rotation',90);
            handles.condi_num=condi_num;
            handles.desplot=1;
            % -------------------------------------------------------------
        elseif ~exist('GLM_data','var') && handles.inputtype==2
            handles.inputtype=1;
            set(handles.GLM_panel,'visible','on');
            set(handles.Oxy,'value',1);
            set(handles.Dxy,'value',1);
            set(handles.Total,'value',0);
            set(handles.outpath,'string',[]);
            set(handles.design_mat_path,'string',[]);
        else
            handles.inputtype=1;
            set(handles.add_cov,'enable','on');
        end
        
    else
        msgbox({'Input file path is wrong!!!';'Please re-add !!!'},'Warning','warn');
    end
end
% Update handles structure
guidata(hObject, handles);



function fileList_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of fileList as text
%        str2double(get(hObject,'String')) returns contents of fileList as a double
inpath=get(handles.addPath,'userdata');
sublist=get(handles.fileList,'string');
userid=get(handles.fileList,'value');
des_mat_path=get(handles.design_mat_path,'string');
if handles.inputtype==1 && ~isempty(inpath) && ~isempty(des_mat_path) % input processed data && different design infor
    
    load(fullfile(inpath,sublist{userid}));
    load(des_mat_path);
    num_tp=length(nirsdata.vector_onset);
    T=nirsdata.T;
    
    [~,snum]=size(design_inf);
    condi_num=snum-1;
    des_mtx=zeros(num_tp,condi_num);
    
    
    if get(handles.Units,'value')==2
        for n_cond=1:condi_num
            if round(design_inf{userid+1,n_cond+1}(end,1)./T)+round(design_inf{userid+1,n_cond+1}(end,2)./T) > num_tp
                msgbox({'The length of the design matrix is beyond the dimension of sub timepoint.';'Please re-add !!!'},'Warning!','warn');
                break
            end
            for n_trial=1:size(design_inf{userid+1,n_cond+1},1)
                onset_trail=round(design_inf{userid+1,n_cond+1}(n_trial,1)./T);
                dur_trail=round(design_inf{userid+1,n_cond+1}(n_trial,2)./T);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
        
    else
        for n_cond=1:condi_num
            if design_inf{userid+1,n_cond+1}(end,1)+design_inf{userid+1,n_cond+1}(end,2) > num_tp
                msgbox({'The length of the design matrix is beyond the dimension of sub timepoint.';'Please re-add !!!'},'Warning!','warn'); break
            end
            for n_trial=1:size(design_inf{userid+1,n_cond+1},1)
                onset_trail=design_inf{userid+1,n_cond+1}(n_trial,1);
                dur_trail=design_inf{userid+1,n_cond+1}(n_trial,2);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    end
    
    
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
        cov_path = get(handles.covp_box,'string');
        cov_files = dir(fullfile(cov_path,'*.txt'));
        
        
        cov = importdata(fullfile(cov_path, cov_files(userid).name));
        des_mtx = [des_mtx, cov];
        
        n_cov = size(cov,2);
        handles.cov_num = n_cov;
        
        for n_cov = 1:size(cov,2)
            cov_lable{n_cov} = ['cov', num2str(n_cov),' '];
        end
    end
    
    des_mtx(:,end+1)=1;
    [m,n]=size(des_mtx);
    
    for i=1:n_cond
        con_lable{i}=['con',num2str(i),' '];
    end
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
       xlable = [con_lable, cov_lable];
    else
        xlable = con_lable;
    end
        
    xlable{n}='constant ';
    
    axes(handles.axes_desmtx);
    imagesc(des_mtx);
    handles.desplot=1;
    
    my_gray=interp1([1,32,64],[0.5,0.2,1],1:64,'linear','extrap')';
    my_gray=repmat(my_gray,1,3);
    colormap(handles.axes_desmtx,my_gray);
    
    xt=get(handles.axes_desmtx,'XTick');
    yt=get(handles.axes_desmtx,'YTick');
    set(handles.axes_desmtx,'YTick',[],'XTick',[]);
    
    tx=text([1:n],ones(1,n)*m,xlable);
    set(tx,'HorizontalAlignment','right','Rotation',90);
    handles.condi_num=condi_num;
    handles.desplot=1;
    
elseif handles.inputtype==1 && ~isempty(inpath) && get(handles.DesignType,'value') ==1 && handles.condi_num > 0 % input processed data && same design infor
    load(fullfile(inpath,sublist{userid}));
    num_tp=length(nirsdata.vector_onset);
    T=nirsdata.T;
    
    des_mtx=zeros(num_tp,handles.condi_num);
    if get(handles.Units,'value')==2
        for n_cond=1:handles.condi_num
            if round(handles.onset{n_cond}(end)./T)+round(handles.dur{n_cond}(end)./T) > num_tp;
                errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
                break
            end
            for n_trial=1:length(handles.onset{n_cond})
                onset_trail=round(handles.onset{n_cond}(n_trial)./T);
                dur_trail=round(handles.dur{n_cond}(n_trial)./T);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    else
        for n_cond=1:handles.condi_num
            if handles.onset{n_cond}(end)+handles.dur{n_cond}(end) > num_tp;
                errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
                break
            end
            for n_trial=1:length(handles.onset{n_cond})
                onset_trail=handles.onset{n_cond}(n_trial);
                dur_trail=handles.dur{n_cond}(n_trial);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    end
    
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
        cov_path = get(handles.covp_box,'string');
        cov_files = dir(fullfile(cov_path,'*.txt'));
        n_cov = size(cov_files,1);
        handles.cov_num = n_cov;
        
        cov = importdata(fullfile(cov_path, cov_files(userid).name));
        des_mtx = [des_mtx, cov];
        
        for n_cov = 1:size(cov,2)
            cov_lable{n_cov} = ['cov', num2str(n_cov),' '];
        end
    end
    
    des_mtx(:,end+1)=1;
    
    [m,n]=size(des_mtx);
    for i=1:handles.condi_num
        con_lable{i}=['cond',num2str(i),' '];
    end
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
       xlable = [con_lable, cov_lable];
    else
        xlable = con_lable;
    end
    
    xlable{n}='constant ';
     
    axes(handles.axes_desmtx);
    imagesc(des_mtx);
    handles.desplot=1;
    
    my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
    my_gray=repmat(my_gray,1,3);
    colormap(handles.axes_desmtx,my_gray);
    
    xt=get(handles.axes_desmtx,'XTick');
    yt=get(handles.axes_desmtx,'YTick');
    set(handles.axes_desmtx,'YTick',[],'XTick',[]);
    
    tx=text([1:n],ones(1,n)*m,xlable);
    set(tx,'HorizontalAlignment','right','Rotation',90);
    
elseif handles.inputtype==2 && ~isempty(inpath) % input GLM files =========
    
    load(fullfile(inpath,sublist{userid}));
    [~,condi_num]=size(GLM_data.desmtx);
    
    if ~isempty(GLM_data.cov)
        [~,cov_num] = size(GLM_data.cov);
        for j=1:cov_num
                cov_lable{j}=['cov',num2str(j),' '];
        end
    end
        
    
    hrf_nk = zeros(20,1); hrf_nk(1,1) = 0.5; hrf_nk(2,1) = 0.8; hrf_nk(3,1) = 0.5;
    for nn = 4:12 % *******************************************************
        hrf_nk(nn,1) = hrf_nk(nn-1,1)/2;
    end
 
    [m,n]=size(GLM_data.predmtx);
    
    for i=1:condi_num
        con_lable{i}=['con',num2str(i),' '];
    end
    if ~isempty(GLM_data.cov)
        xlable = [con_lable, cov_lable];
    else
        xlabel = con_lable;
    end
    xlable{n}='constant ';
    
    axes(handles.axes_desmtx);
    imagesc(GLM_data.predmtx);
    handles.desplot=1;
    
    my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
    my_gray=repmat(my_gray,1,3);
    colormap(handles.axes_desmtx,my_gray);
    
    xt=get(handles.axes_desmtx,'XTick');
    yt=get(handles.axes_desmtx,'YTick');
    set(handles.axes_desmtx,'YTick',[],'XTick',[]);
    
    tx=text([1:n],ones(1,n)*m,xlable);
    set(tx,'HorizontalAlignment','right','Rotation',90);
    handles.condi_num=condi_num;
    handles.desplot=1;
end
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.outpath,'string'))
    msgbox('Please select the output folder !!!','Warning','warn');
else
    nirs_firstlevel_analysis(handles);
end


% --- Executes on button press in OpenFolder.
function OpenFolder_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpathAll = get(handles.outpath,'string');

try
    winopen(outpathAll);
catch
    macopen(outpathAll);
end


% --- Executes on button press in Oxy.
function Oxy_Callback(hObject, eventdata, handles)
% hObject    handle to Oxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Oxy


% --- Executes on button press in Dxy.
function Dxy_Callback(hObject, eventdata, handles)
% hObject    handle to Dxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Dxy


% --- Executes on button press in Total.
function Total_Callback(hObject, eventdata, handles)
% hObject    handle to Total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Total


% --- Executes on selection change in HRF_type.
function HRF_type_Callback(hObject, eventdata, handles)
% hObject    handle to HRF_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns HRF_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from HRF_type


% --- Executes during object creation, after setting all properties.
function HRF_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HRF_type (see GCBO)
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
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns Units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Units
units_stat=get(handles.Units,'value');
if units_stat~=handles.UnitStat;
    set(handles.cond_listbox,'value',1);
    set(handles.cond_listbox,'userdata',{});
    set(handles.cond_listbox,'string',[]);
    set(handles.contrast_listbox,'value',1);
    set(handles.contrast_listbox,'userdata',{});
    set(handles.contrast_listbox,'string',[]);
    
    handles.condi_num=0;
    handles.contr_num=0;
    handles.cov_num = 0;
    handles.onset={};
    handles.dur={};
    handles.contrs={};
    handles.UnitStat=units_stat;
    
    cla(handles.axes_desmtx,'reset');
    set(handles.axes_desmtx,'box','on');
    set(handles.axes_desmtx,'XTick',[]);
    set(handles.axes_desmtx,'YTick',[]);
    cla(handles.axes_contrs,'reset');
    set(handles.axes_contrs,'box','on');
    set(handles.axes_contrs,'XTick',[]);
    set(handles.axes_contrs,'YTick',[]);
end
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



% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in addcondition.
function addcondition_Callback(hObject, eventdata, handles)
% hObject    handle to addcondition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
condi_num=handles.condi_num+1;
[name,onset,duration]=inputcondinf(condi_num);

if ~isempty(name) && ~isempty(onset) && ~isempty(duration)
    userdata{1,1}=['Condition (',num2str(condi_num),')'];
    userdata{2,1}=['......Name            ',name];
    userdata{3,1}=['......Onset            [',num2str(onset),']'];
    userdata{4,1}=['......Duration       [',num2str(duration),']'];
    
    cond_userdata=get(handles.cond_listbox,'userdata');
    if isempty(cond_userdata)
        cond_userdata=userdata;
        handles.onset={onset};
        handles.dur={duration};
        handles.cond_name={name};
        set(handles.cond_listbox,'userdata',cond_userdata);
        set(handles.cond_listbox,'string',cond_userdata);
        handles.condi_num=handles.condi_num+1;
    else
        cond_userdata=[cond_userdata;userdata];
        handles.onset=[handles.onset;{onset}];
        handles.dur=[handles.dur;{duration}];
        handles.cond_name=[handles.cond_name,name];
        set(handles.cond_listbox,'userdata',cond_userdata);
        set(handles.cond_listbox,'string',cond_userdata);
        handles.condi_num=handles.condi_num+1;
    end
end

set(handles.cond_listbox,'value',1);
inpath=get(handles.addPath,'userdata');
sublist=get(handles.fileList,'string');

if ~isempty(sublist) && handles.condi_num>0
    set(handles.fileList,'value',1);
    userid=get(handles.fileList,'value');
    load(fullfile(inpath,sublist{userid}));
    num_tp=length(nirsdata.vector_onset);
    T=nirsdata.T;
    
    des_mtx=zeros(num_tp,handles.condi_num);
        
    if get(handles.Units,'value')==2
        for n_cond=1:handles.condi_num
            if round(handles.onset{n_cond}(end)./T)+round(handles.dur{n_cond}(end)./T) > num_tp;
                errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
                break
            end
            for n_trial=1:length(handles.onset{n_cond})
                onset_trail=round(handles.onset{n_cond}(n_trial)./T);
                dur_trail=round(handles.dur{n_cond}(n_trial)./T);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    else
        for n_cond=1:handles.condi_num
            if handles.onset{n_cond}(end)+handles.dur{n_cond}(end) > num_tp;
                errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
                break
            end
            for n_trial=1:length(handles.onset{n_cond})
                onset_trail=handles.onset{n_cond}(n_trial);
                dur_trail=handles.dur{n_cond}(n_trial);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    end
    
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
        cov_path = get(handles.covp_box,'string');
        cov_files = dir(fullfile(cov_path,'*.txt'));
        n_cov = size(cov_files,1);
        handles.cov_num = n_cov;
        
        cov = importdata(fullfile(cov_path, cov_files(userid).name));
        des_mtx = [des_mtx, cov];
        
        for n_cov = 1:size(cov,2)
            cov_lable{n_cov} = ['cov', num2str(n_cov),' '];
        end
    end
    
    des_mtx(:,end+1)=1;
    
    [m,n]=size(des_mtx);
    for i=1:handles.condi_num
        con_lable{i}=['cond',num2str(i),' '];
    end
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
       xlable = [con_lable, cov_lable];
    else
        xlable = con_lable;
    end
        
    xlable{n}='constant ';
     
    axes(handles.axes_desmtx);
    imagesc(des_mtx);
    handles.desplot=1;
    
    my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
    my_gray=repmat(my_gray,1,3);
    colormap(handles.axes_desmtx,my_gray);
    
    xt=get(handles.axes_desmtx,'XTick');
    yt=get(handles.axes_desmtx,'YTick');
    set(handles.axes_desmtx,'YTick',[],'XTick',[]);
    
    tx=text([1:n],ones(1,n)*m,xlable);
    set(tx,'HorizontalAlignment','right','Rotation',90);
elseif isempty(get(handles.cond_listbox,'userdata')) && handles.desplot==1
    cla(handles.axes_desmtx,'reset');
    set(handles.axes_desmtx,'box','on');
    set(handles.axes_desmtx,'XTick',[]);
    set(handles.axes_desmtx,'YTick',[]);
    cla(handles.axes_contrs,'reset');
    set(handles.axes_contrs,'box','on');
    set(handles.axes_contrs,'XTick',[]);
    set(handles.axes_contrs,'YTick',[]);
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
if ~isempty(get(handles.cond_listbox,'String'))
    if mod(user_id-1,4)==0
        set(handles.cond_listbox,'UIContextMenu',handles.condition_right);
    end
else
    set(handles.cond_listbox,'UIContextMenu',[]);
end

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


% --- Executes on button press in add_T.
function add_T_Callback(hObject, eventdata, handles)
% hObject    handle to add_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.condi_num ~= 0
    condi_num=handles.condi_num;
    cov_num = handles.cov_num;
    contr_num=handles.contr_num+1;
    contrast=inputcontrast(contr_num,condi_num,cov_num);
    
    if ~isempty(contrast)
        userdata{1,1}=['Contrast (',num2str(contr_num),')'];
        userdata{2,1}=['......Name                     ',contrast{1}];
        userdata{3,1}=['......Contrast vector     ',contrast{2}];
        
        contr_userdata=get(handles.contrast_listbox,'userdata');
        if isempty(contr_userdata)
            contr_userdata=userdata;
            handles.cont_name=contrast(1);
            handles.contrs=contrast(2);
            set(handles.contrast_listbox,'string',contr_userdata);
            set(handles.contrast_listbox,'userdata',contr_userdata);
            handles.contr_num=handles.contr_num+1;
        else
            contr_userdata=[contr_userdata;userdata];
            handles.cont_name=[handles.cont_name,contrast(1)];
            handles.contrs=[handles.contrs;contrast{2}];
            set(handles.contrast_listbox,'string',contr_userdata);
            set(handles.contrast_listbox,'userdata',contr_userdata);
            handles.contr_num=handles.contr_num+1;
            set(handles.contrast_listbox,'value',(handles.contr_num-1)*3+1);
        end
        
        if handles.contr_num >= 1
            user_id = get(handles.contrast_listbox,'value');
            contrs_mat=eval(handles.contrs{(user_id-1)/3+1});
            [m,n]=size(contrs_mat);
            if n <= handles.condi_num+handles.cov_num+1
                contrs_mat(:,handles.condi_num+1)=0;
                if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string')) && handles.cov_num ~= 0
                    contrs_mat(:,handles.condi_num+handles.cov_num+1)=0;
                end
                
                if handles.inputtype == 2 && handles.cov_num > 0
                   contrs_mat(:,handles.condi_num+handles.cov_num+1)=0; 
                end

                if m==1 && max(contrs_mat)>0 && min(contrs_mat)<0
                    contrs_mat=repmat(contrs_mat,2,1);
                    contrs_mat(1,find(contrs_mat(1,:)<0))=0;
                    contrs_mat(2,find(contrs_mat(2,:)>0))=0;
                    contrs_mat(find(contrs_mat<=0))=(contrs_mat(find(contrs_mat<=0))*-1)-1;
                end
            end

            axes(handles.axes_contrs);
            %imagesc(contrs_mat);
            contrs_mat2=contrs_mat;contrs_mat2(end+1,end+1)=0;
            pcolor(contrs_mat2); axis ij;

            my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
            my_gray=repmat(my_gray,1,3);
            colormap(handles.axes_contrs,my_gray);

            set(handles.axes_contrs,'YTick',[],'XTick',[]);
         
        end
                
    end
    
else
    msgbox('There is no Design Matrxi!!','Warning','warn');
end

% Update handles structure
guidata(hObject, handles);



% --- Executes on selection change in DesignType.
function DesignType_Callback(hObject, eventdata, handles)
% hObject    handle to DesignType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DesignType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DesignType
desigtp=get(handles.DesignType,'value');
if desigtp==2
    set(handles.addcondition,'visible','off');
    set(handles.cond_listbox,'visible','off');
    
    set(handles.design_msg,'visible','on');
    set(handles.add_design_mat,'visible','on');
    set(handles.design_mat_path,'visible','on');
    set(handles.ensure_msg,'visible','on');
    set(handles.opensample,'visible','on');
    set(handles.design_maker,'visible','on');
else
    set(handles.design_msg,'visible','off');
    set(handles.add_design_mat,'visible','off');
    set(handles.design_mat_path,'visible','off');
    set(handles.ensure_msg,'visible','off');
    set(handles.opensample,'visible','off');
    set(handles.design_maker,'visible','off');
    
    set(handles.addcondition,'visible','on');
    set(handles.cond_listbox,'visible','on');
end

if desigtp~=handles.DesTpStat;
    set(handles.cond_listbox,'value',1);
    set(handles.cond_listbox,'userdata',{});
    set(handles.cond_listbox,'string',[]);
    set(handles.contrast_listbox,'value',1);
    set(handles.contrast_listbox,'userdata',{});
    set(handles.contrast_listbox,'string',[]);
    
    set(handles.design_mat_path,'string',[]);
    
    handles.condi_num=0;
    handles.contr_num=0;
    handles.onset={};
    handles.dur={};
    handles.contrs={};
    handles.UnitStat=desigtp;
    
    cla(handles.axes_desmtx,'reset');
    set(handles.axes_desmtx,'box','on');
    set(handles.axes_desmtx,'XTick',[]);
    set(handles.axes_desmtx,'YTick',[]);
    cla(handles.axes_contrs,'reset');
    set(handles.axes_contrs,'box','on');
    set(handles.axes_contrs,'XTick',[]);
    set(handles.axes_contrs,'YTick',[]);
end

handles.DesTpStat=desigtp;
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


% --- Executes on button press in add_design_mat.
function add_design_mat_Callback(hObject, eventdata, handles)
% hObject    handle to add_design_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname,fpath] = uigetfile('.mat','Select your Design Inf mat file');

if ischar(fname)
    design_mat=fullfile(fpath,fname);
    load(design_mat);
    [n_designmat,n_condi]=size(design_inf);
    
    inpath=get(handles.addPath,'userdata');
    sublist=get(handles.fileList,'string');
    
    
    des_nm = design_inf(2:end,1);
    is_same = strcmp(des_nm, sublist);
    
    if n_designmat-1==length(sublist) && min(is_same) ~= 0
        set(handles.design_mat_path,'string',design_mat);
        handles.design_inf=design_inf;
        handles.condi_num=n_condi-1;
        
        if ~isempty(get(handles.fileList,'string'))
            set(handles.fileList,'value',1);
            userid=get(handles.fileList,'value');
            load(fullfile(inpath,sublist{userid}));
            
            num_tp=length(nirsdata.vector_onset);
            T=nirsdata.T;
            
            [~,snum]=size(design_inf);
            condi_num=snum-1;
            des_mtx=zeros(num_tp,condi_num);
            
            if get(handles.Units,'value')==2
                for n_cond=1:condi_num
                    if round(design_inf{userid+1,n_cond+1}(end,1)./T)+round(design_inf{userid+1,n_cond+1}(end,2)./T) > num_tp
                        msgbox({'The length of the design matrix is beyond the dimension of sub timepoint.';'Please re-add !!!'},'Warning!','warn');
                        break
                    end
                    for n_trial=1:size(design_inf{userid+1,n_cond+1},1)
                        onset_trail=round(design_inf{userid+1,n_cond+1}(n_trial,1)./T);
                        dur_trail=round(design_inf{userid+1,n_cond+1}(n_trial,2)./T);
                        des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
                    end
                end
                
            else
                for n_cond=1:condi_num
                    if design_inf{userid+1,n_cond+1}(end,1)+design_inf{userid+1,n_cond+1}(end,2) > num_tp
                        msgbox({'The length of the design matrix is beyond the dimension of sub timepoint.';'Please re-add !!!'},'Warning!','warn');               break
                    end
                    for n_trial=1:size(design_inf{userid+1,n_cond+1},1)
                        onset_trail=design_inf{userid+1,n_cond+1}(n_trial,1);
                        dur_trail=design_inf{userid+1,n_cond+1}(n_trial,2);
                        des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
                    end
                end
            end
            
            if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
                cov_path = get(handles.covp_box,'string');
                cov_files = dir(fullfile(cov_path,'*.txt'));
                n_cov = size(cov_files,2);
                handles.cov_num = n_cov;
                cov = importdata(fullfile(cov_path, cov_files(userid).name));
                des_mtx = [des_mtx, cov];

                for n_cov = 1:size(cov,2)
                    cov_lable{n_cov} = ['cov', num2str(n_cov),' '];
                end
            end
            des_mtx(:,end+1)=1;
            [m,n] = size(des_mtx);
            for i=1:condi_num
                con_lable{i}=['con',num2str(i),' '];
            end
            
            if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
               xlable = [con_lable, cov_lable];
            else
                xlable = con_lable;
            end
            xlable{end+1}='constant ';
            
            axes(handles.axes_desmtx);
            imagesc(des_mtx);
            handles.desplot=1;
            
            my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
            my_gray=repmat(my_gray,1,3);
            colormap(handles.axes_desmtx,my_gray);
            
            xt=get(handles.axes_desmtx,'XTick');
            yt=get(handles.axes_desmtx,'YTick');
            set(handles.axes_desmtx,'YTick',[],'XTick',[]);
            
            tx=text([1:n],ones(1,n)*m,xlable);
            set(tx,'HorizontalAlignment','right','Rotation',90);
            handles.condi_num=condi_num;
            handles.desplot=1;
        end
    else
        set(handles.design_mat_path,'string','');
        
        msgbox({'The length of your design_inf.mat is unequal to the sub num!!!'; ...
            'Or the sub nemes in the Design Inf.mat are not indentical with subnames in the input folder!!!'; ...
            ''; 'Please check !!!'},'Design inf is wrong!','warn');
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


% --- Executes on button press in opensample.
function opensample_Callback(hObject, eventdata, handles)
% hObject    handle to opensample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
defaultpath=which('NIRS_KIT');
design_sam_path=fullfile(fileparts(defaultpath),'Sample_Data');

try
    winopen(design_sam_path);
catch
    macopen(design_sam_path);
end


% --------------------------------------------------------------------
function cond_delete_Callback(hObject, eventdata, handles)
% hObject    handle to cond_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

userdata=get(handles.cond_listbox,'userdata');
user_id=get(handles.cond_listbox,'value');

userdata=userdata(setdiff(1:length(userdata),user_id:user_id+3));
handles.onset=handles.onset(setdiff(1:handles.condi_num,(user_id-1)./4+1));
handles.dur=handles.dur(setdiff(1:handles.condi_num,(user_id-1)./4+1));
if ~isempty(userdata)
    for i=1:handles.condi_num-1
        userdata{(i-1)*4+1,1}=['Condition (',num2str(i),')'];
    end
end
handles.condi_num=handles.condi_num-1;

set(handles.cond_listbox,'userdata',userdata);
set(handles.cond_listbox,'value',1);
set(handles.cond_listbox,'string',userdata);

inpath=get(handles.addPath,'userdata');
sublist=get(handles.fileList,'string');

if ~isempty(sublist) && handles.condi_num>0
    userid=get(handles.fileList,'value');
    load(fullfile(inpath,sublist{userid}));
    num_tp=length(nirsdata.vector_onset);
    T=nirsdata.T;
    
    des_mtx=zeros(num_tp,handles.condi_num);
        
    if get(handles.Units,'value')==2
        for n_cond=1:handles.condi_num
            if round(handles.onset{n_cond}(end)./T)+round(handles.dur{n_cond}(end)./T) > num_tp;
                errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
                break
            end
            for n_trial=1:length(handles.onset{n_cond})
                onset_trail=round(handles.onset{n_cond}(n_trial)./T);
                dur_trail=round(handles.dur{n_cond}(n_trial)./T);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    else
        for n_cond=1:handles.condi_num
            if handles.onset{n_cond}(end)+handles.dur{n_cond}(end) > num_tp;
                errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
                break
            end
            for n_trial=1:length(handles.onset{n_cond})
                onset_trail=handles.onset{n_cond}(n_trial);
                dur_trail=handles.dur{n_cond}(n_trial);
                des_mtx(onset_trail:(onset_trail+dur_trail),n_cond)=1;
            end
        end
    end
    
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
        cov_path = get(handles.covp_box,'string');
        cov_files = dir(fullfile(cov_path,'*.txt'));
        n_cov = size(cov_files,1);
        handles.cov_num = n_cov;
        
        cov = importdata(fullfile(cov_path, cov_files(userid).name));
        des_mtx = [des_mtx, cov];
        
        for n_cov = 1:size(cov,2)
            cov_lable{n_cov} = ['cov', num2str(n_cov),' '];
        end
    end
    
    des_mtx(:,end+1)=1;
    
    [m,n]=size(des_mtx);
    for i=1:handles.condi_num
        con_lable{i}=['cond',num2str(i),' '];
    end
    
    if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string'))
       xlable = [con_lable, cov_lable];
    else
        xlable = con_lable;
    end
    
    xlable{n}='constant ';
    
    axes(handles.axes_desmtx);
    imagesc(des_mtx);
    handles.desplot=1;
    
    my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
    my_gray=repmat(my_gray,1,3);
    colormap(handles.axes_desmtx,my_gray);
    
    xt=get(handles.axes_desmtx,'XTick');
    yt=get(handles.axes_desmtx,'YTick');
    set(handles.axes_desmtx,'YTick',[],'XTick',[]);
    
    tx=text([1:n],ones(1,n)*m,xlable);
    set(tx,'HorizontalAlignment','right','Rotation',90);
elseif isempty(get(handles.cond_listbox,'userdata')) && handles.desplot==1
    cla(handles.axes_desmtx,'reset');
    set(handles.axes_desmtx,'box','on');
    set(handles.axes_desmtx,'XTick',[]);
    set(handles.axes_desmtx,'YTick',[]);
    cla(handles.axes_contrs,'reset');
    set(handles.axes_contrs,'box','on');
    set(handles.axes_contrs,'XTick',[]);
    set(handles.axes_contrs,'YTick',[]);
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function condition_right_Callback(hObject, eventdata, handles)
% hObject    handle to condition_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function contrast_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to contrast_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of contrast_listbox as text
%        str2double(get(hObject,'String')) returns contents of contrast_listbox as a double

user_id=get(handles.contrast_listbox,'value');

if ~isempty(get(handles.contrast_listbox,'String'))
    if mod(user_id-1,3)==0
        set(handles.contrast_listbox,'UIContextMenu',handles.contrs_right);
        if handles.condi_num>0
            contrs_mat=eval(handles.contrs{(user_id-1)/3+1});
            [m,n]=size(contrs_mat);
            if n <= handles.condi_num+handles.cov_num+1
                contrs_mat(:,handles.condi_num+1)=0;
                if handles.inputtype == 1 && get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string')) && handles.cov_num ~= 0
                    contrs_mat(:,handles.condi_num+handles.cov_num+1)=0;
                end
                
                if handles.inputtype == 2
                   contrs_mat(:,handles.condi_num+handles.cov_num+1)=0; 
                end
                
                if m==1 && max(contrs_mat)>0 && min(contrs_mat)<0
                    contrs_mat=repmat(contrs_mat,2,1);
                    contrs_mat(1,find(contrs_mat(1,:)<0))=0;
                    contrs_mat(2,find(contrs_mat(2,:)>0))=0;
                    contrs_mat(find(contrs_mat<=0))=(contrs_mat(find(contrs_mat<=0))*-1)-1;
                end
            end
            
            axes(handles.axes_contrs);
            %imagesc(contrs_mat);
            contrs_mat2=contrs_mat;contrs_mat2(end+1,end+1)=0;
            pcolor(contrs_mat2); axis ij;
            
            my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
            my_gray=repmat(my_gray,1,3);
            colormap(handles.axes_contrs,my_gray);
            
            set(handles.axes_contrs,'YTick',[],'XTick',[]);
        end
    end
else
    set(handles.contrast_listbox,'UIContextMenu',[]);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function contrast_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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


function contrast=inputcontrast(contr_num,condi_num,cov_num)
contrstr=['Add New Contrast',num2str(contr_num)];
contrs_nm='Contrast Name:';
vect_str='Please Enter Constrast Vector, eg: 1 0 0 or [1 0 -1]   ';
contrinf=inputdlg({contrs_nm,vect_str},contrstr);
if isempty(contrinf)
    contrast = '';
elseif ~isempty(contrinf{1}) && ~isempty(contrinf{2})
    contrast=contrinf;
    if isempty(strfind(contrast{2},']'))
        contrast{2}=['[',contrast{2},']'];
        contr_value=str2num(contrast{2});
        if length(contr_value)> condi_num+cov_num+1
            ha = questdlg('The length of contrast vector is beyond !!! Do you want to re-enter ?','Options','Yes','NO','NO');
            if strcmp(ha,'Yes')
                contrast=inputcontrast(contr_num,condi_num);
            else
                contrast = '';
            end
        elseif length(contr_value) == condi_num+cov_num+1 && contr_value(end) ~= 0
            hb = questdlg('The corresponding constrast value of the constant must be 0 !!! Do you want to re-enter ?','Options','Yes','NO','NO');
            if strcmp(hb,'Yes')
                contrast=inputcontrast(contr_num,condi_num);
            else
                contrast = '';
            end
        end
    end
else
    errordlg('Missing input value !!!    Please re-enter !!!','Design inf is wrong!');
    contrast=inputcontrast(contr_num,condi_num);
end


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function run_CreateFcn(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function contrs_delete_Callback(hObject, eventdata, handles)
% hObject    handle to contrs_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
userdata=get(handles.contrast_listbox,'userdata');
user_id=get(handles.contrast_listbox,'value');

cla(handles.axes_contrs,'reset');
set(handles.axes_contrs,'box','on');
set(handles.axes_contrs,'XTick',[]);
set(handles.axes_contrs,'YTick',[]);

userdata=userdata(setdiff(1:length(userdata),user_id:user_id+2));
if ~isempty(userdata)
    for i=1:handles.contr_num-1
        new_str=userdata{(i-1)*3+1,1};
        userdata{(i-1)*3+1,1}=[new_str(1:10),num2str(i),')'];
    end
end

handles.cont_name=handles.cont_name(setdiff(1:handles.contr_num,(user_id-1)./3+1));
handles.contrs=handles.contrs(setdiff(1:handles.contr_num,(user_id-1)./3+1));
handles.contr_num=handles.contr_num-1;

set(handles.contrast_listbox,'userdata',userdata);
set(handles.contrast_listbox,'value',1);
set(handles.contrast_listbox,'string',userdata);

if handles.contr_num > 0
    user_id = get(handles.contrast_listbox,'value');
    contrs_mat=eval(handles.contrs{(user_id-1)/3+1});
    [m,n]=size(contrs_mat);
    if n <= handles.condi_num+handles.cov_num+1
        contrs_mat(:,handles.condi_num+1)=0;
        if get(handles.add_cov,'value') == 1 && ~isempty(get(handles.covp_box,'string')) && handles.cov_num ~= 0
            contrs_mat(:,handles.condi_num+handles.cov_num+1)=0;
        end
        
        if handles.inputtype == 2 && handles.cov_num > 0
           contrs_mat(:,handles.condi_num+handles.cov_num+1)=0; 
        end

        if m==1 && max(contrs_mat)>0 && min(contrs_mat)<0
            contrs_mat=repmat(contrs_mat,2,1);
            contrs_mat(1,find(contrs_mat(1,:)<0))=0;
            contrs_mat(2,find(contrs_mat(2,:)>0))=0;
            contrs_mat(find(contrs_mat<=0))=(contrs_mat(find(contrs_mat<=0))*-1)-1;
        end
    end
    
    axes(handles.axes_contrs);
    %imagesc(contrs_mat);
    contrs_mat2=contrs_mat;contrs_mat2(end+1,end+1)=0;
    pcolor(contrs_mat2); axis ij;

    my_gray=interp1([1,32,64],[0.5,0,1],1:64,'linear','extrap')';
    my_gray=repmat(my_gray,1,3);
    colormap(handles.axes_contrs,my_gray);

    set(handles.axes_contrs,'YTick',[],'XTick',[]);

end
guidata(hObject, handles);


% --------------------------------------------------------------------
function contrs_right_Callback(hObject, eventdata, handles)
% hObject    handle to contrs_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in add_cov.
function add_cov_Callback(hObject, eventdata, handles)
% hObject    handle to add_cov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of add_cov
iscov = get(handles.add_cov,'value');
if iscov == 1
    set(handles.Add_CovP,'enable','on');
    set(handles.covp_box,'enable','on');
    set(handles.covp_box,'string','');
    handles.cov_num = 0;
    
    if handles.desplot == 1
        cla(handles.axes_desmtx,'reset');
        set(handles.axes_desmtx,'box','on');
        set(handles.axes_desmtx,'XTick',[]);
        set(handles.axes_desmtx,'YTick',[]);
        cla(handles.axes_contrs,'reset');
        set(handles.axes_contrs,'box','on');
        set(handles.axes_contrs,'XTick',[]);
        set(handles.axes_contrs,'YTick',[]);
    end
else
    set(handles.Add_CovP,'enable','off');
    set(handles.covp_box,'enable','off');
    set(handles.covp_box,'string','');
    handles.cov_num = 0;
    
    if handles.desplot == 1
        cla(handles.axes_desmtx,'reset');
        set(handles.axes_desmtx,'box','on');
        set(handles.axes_desmtx,'XTick',[]);
        set(handles.axes_desmtx,'YTick',[]);
        cla(handles.axes_contrs,'reset');
        set(handles.axes_contrs,'box','on');
        set(handles.axes_contrs,'XTick',[]);
        set(handles.axes_contrs,'YTick',[]);
    end
end
guidata(hObject, handles);




function covp_box_Callback(hObject, eventdata, handles)
% hObject    handle to covp_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of covp_box as text
%        str2double(get(hObject,'String')) returns contents of covp_box as a double


% --- Executes during object creation, after setting all properties.
function covp_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to covp_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Add_CovP.
function Add_CovP_Callback(hObject, eventdata, handles)
% hObject    handle to Add_CovP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Cov_Path = uigetdir(pwd,'Select the folder containing covariate txt files.');
if ischar(Cov_Path)
    set(handles.covp_box,'string',Cov_Path);  % set outpath name
end


% --- Executes on button press in design_maker.
function design_maker_Callback(hObject, eventdata, handles)
% hObject    handle to design_maker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NK_design_inf_maker;
