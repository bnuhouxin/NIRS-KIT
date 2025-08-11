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

% Last Modified by GUIDE v2.5 06-Aug-2024 06:23:43

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

%set default ICA parameters
% ap.advance_ica_alg = 'FastICA';
% ap.advance_p1 = 'defl';
% ap.advance_p2 = 'tanh';
% ap.advance_p3 = '0.00001';
% ap.advance_p4 = '10000';
% ap.advance_p5 = 'TICA';
ap.advance_ica_alg = 'SOBI';
ap.advance_p1 = 100;
set(handles.advance,'Enable','on','UserData',ap)

set(handles.ic_num_caculate,'Enable','on','Value',1,'Userdata',1); 
set(handles.hbty,'Enable','on','Value',1,'Userdata',1); 

%set default value of source evaluations
spikelike_para.wins=2; % unit "second"
spikelike_para.thres=3;
spikelike_para.ma_thres=0.8;
set(handles.spikelike,'Userdata',spikelike_para); 
set(handles.pushbutton43,'enable','off');


if ~isempty(varargin) 
   if varargin{1} == 1 % for Preprocessing 
       set(handles.uipanel6,'UserData',1);
       set(handles.radiobutton2,'enable','off');
       
       if strcmp(get(handles.radiobutton1,'enable'),'off')
           set(handles.radiobutton1,'enable','on','value',1);
       else
           set(handles.radiobutton1,'value',1);
       end  
   elseif varargin{1} == 2 % for Task Individual Exploration
       set(handles.uipanel6,'UserData',2);
       set(handles.radiobutton1,'enable','off');

       if strcmp(get(handles.radiobutton2,'enable'),'off')
           set(handles.radiobutton2,'enable','on','value',1);
       else
           set(handles.radiobutton2,'value',1);
       end
   elseif varargin{1} == 3 % for Rest Individual Exploration
       set(handles.uipanel6,'UserData',3);
       set(handles.radiobutton1,'enable','off');

       if strcmp(get(handles.radiobutton2,'enable'),'off')
           set(handles.radiobutton2,'enable','on','value',1);
       else
           set(handles.radiobutton2,'value',1);
       end
   end
else
   set(handles.uipanel6,'UserData',[]);
   if strcmp(get(handles.radiobutton1,'enable'),'off')
       set(handles.radiobutton1,'enable','on');
   end
   if strcmp(get(handles.radiobutton2,'enable'),'off')
       set(handles.radiobutton2,'enable','on');
   end  
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_ICA_v1 wait for user response (see UIRESUME)
% uiwait(handles.NIRS_ICA_Denoiser);
disp('----------------------------------------------------------------------------------------------------------');
disp('   Thank you for using NIRS_ICA.');
disp('   NIRS_ICA: A MATLAB toolbox for ICA applied in fNIRS studies');
disp('   Copyright 2021. All Rights Reserved');
disp('   It is only for academic use! Any unauthorized commercial use is prohibited.'); 
disp('   Programers: Yang Zhao, Pei-Pei Sun, Fu-Lun Tan, Xin Hou, Chao-Zhe Zhu.');
disp('   Mail to Initiator: zhaoyang@mail.bnu.edu.cn');
disp('   State Key Laboratory of Cognitive Neuroscience and Learning, Beijing Normal University, Beijing, China');
disp('   ');
disp('   Please cite:');
disp('   Zhao, Y., Sun, P.-P., Tan, F.-L., Hou, X. & Zhu, C.-Z. (2021).');
disp('      NIRS-ICA: A MATLAB Toolboxfor Independent Component Analysis Applied in fNIRS Studies.');
disp('      Frontiers in Neuroinformatics, 15. https://doi.org/10.3389/fninf.2021.683735.');
disp('----------------------------------------------------------------------------------------------------------');


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


% --- Executes on button press in spikelike.
function spikelike_Callback(hObject, eventdata, handles)
% hObject    handle to spikelike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spikelike
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
if get(handles.spikelike,'Value') == 1
    % get hbtype 
    hbtype=get(handles.hbty,'Value');
    switch hbtype
        case 1
            if isfield(dataIn.IC,'OXY')
                sort_info=dataIn.IC.OXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 2
            if isfield(dataIn.IC,'DXY')
                sort_info=dataIn.IC.DXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 3
            if isfield(dataIn.IC,'TOT')
                sort_info=dataIn.IC.TOT.Sort;
            else
                warndlg('Run ICA first')
                return
            end
    end
    
    if ~sum(strcmp(sort_info.Sort_selectRule,'spikelike'))
        %evaluate the source
        NID_Spikelike_Para_Set(handles);
        uiwait(NID_Spikelike_Para_Set);
        dataIn.IC=NID_OpenFileInitial_Sorting(handles,dataIn.IC);
        set(handles.NIRS_ICA_Denoiser,'UserData',dataIn)
    end
    %automatically select ics based on the value of metrics
    [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
    sIC.selectIC = selectIC;    %IC has been selected
    sIC.muti_labelIC = muti_labelIC;    %label
    sIC.labelIC = labelIC;
    set(handles.edit3,'Userdata',sIC);
    if isrow(selectIC)
        set(handles.edit3,'String',num2str(selectIC),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    else
        set(handles.edit3,'String',num2str(selectIC'),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    end
    %plot the ics
    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
else
%     [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
%     sIC.selectIC = selectIC;
%     sIC.muti_labelIC = muti_labelIC;
%     sIC.labelIC = labelIC;
%     set(handles.edit3,'Userdata',sIC);
    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
end

% --- Executes on button press in homo.
function homo_Callback(hObject, eventdata, handles)
% hObject    handle to homo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of homo
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
if get(handles.homo,'Value') == 1
    % get hbtype 
    hbtype=get(handles.hbty,'Value');
    switch hbtype
        case 1
            if isfield(dataIn.IC,'OXY')
                sort_info=dataIn.IC.OXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 2
            if isfield(dataIn.IC,'DXY')
                sort_info=dataIn.IC.DXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 3
            if isfield(dataIn.IC,'TOT')
                sort_info=dataIn.IC.TOT.Sort;
            else
                warndlg('Run ICA first')
                return
            end
    end
    %%not all rules, but one specific homo rule
    if ~sum(strcmp(sort_info.Sort_selectRule,'homo'))
        %evaluate the source
        NID_SpatialHomo_Para_Set(handles);
        uiwait(NID_SpatialHomo_Para_Set);
        dataIn.IC=NID_OpenFileInitial_Sorting(handles,dataIn.IC);
        set(handles.NIRS_ICA_Denoiser,'UserData',dataIn)
    end
    
    [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
    sIC.selectIC = selectIC;
    sIC.muti_labelIC = muti_labelIC;
    sIC.labelIC = labelIC;
    set(handles.edit3,'Userdata',sIC);
    if isrow(selectIC)
        set(handles.edit3,'String',num2str(selectIC),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    else
        set(handles.edit3,'String',num2str(selectIC'),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    end
    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
else

    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
end


% --- Executes on button press in external.
function sort_shortchannel_Callback(hObject, eventdata, handles)
% hObject    handle to external (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of external


% --- Executes on button press in external.
function external_Callback(hObject, eventdata, handles)
% hObject    handle to external (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of external

dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
if get(handles.external,'Value') == 1
    % get hbtype 
    hbtype=get(handles.hbty,'Value');
    switch hbtype
        case 1
            if isfield(dataIn.IC,'OXY')
                sort_info=dataIn.IC.OXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 2
            if isfield(dataIn.IC,'DXY')
                sort_info=dataIn.IC.DXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 3
            if isfield(dataIn.IC,'TOT')
                sort_info=dataIn.IC.TOT.Sort;
            else
                warndlg('Run ICA first')
                return
            end
    end
    %%not all rules, but one specific rule
    if ~sum(strcmp(sort_info.Sort_selectRule,'external'))
        %evaluate the source
        NID_Select_External_Input(handles);
        uiwait(NID_Select_External_Input);
        dataIn.IC=NID_OpenFileInitial_Sorting(handles,dataIn.IC);
        set(handles.NIRS_ICA_Denoiser,'UserData',dataIn)
    end
    
    [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
    sIC.selectIC = selectIC;
    sIC.muti_labelIC = muti_labelIC;
    sIC.labelIC = labelIC;
    set(handles.edit3,'Userdata',sIC);
    if isrow(selectIC)
        set(handles.edit3,'String',num2str(selectIC),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    else
        set(handles.edit3,'String',num2str(selectIC'),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    end
    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
else

    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
end


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


% --- Executes on button press in timetemplate.
function timetemplate_Callback(hObject, eventdata, handles)
% hObject    handle to timetemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of timetemplate

dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
if get(handles.timetemplate,'Value') == 1
    % get hbtype 
    hbtype=get(handles.hbty,'Value');
    switch hbtype
        case 1
            if isfield(dataIn.IC,'OXY')
                sort_info=dataIn.IC.OXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 2
            if isfield(dataIn.IC,'DXY')
                sort_info=dataIn.IC.DXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 3
            if isfield(dataIn.IC,'TOT')
                sort_info=dataIn.IC.TOT.Sort;
            else
                warndlg('Run ICA first')
                return
            end
    end
    %%not all rules, but one specific rule
    if ~sum(strcmp(sort_info.Sort_selectRule,'timetemplate'))
        %evaluate the source
        NID_Input_Design_Info(handles);
        uiwait(NID_Input_Design_Info);
        dataIn.IC=NID_OpenFileInitial_Sorting(handles,dataIn.IC);
        set(handles.NIRS_ICA_Denoiser,'UserData',dataIn)
    end
    
    [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
    sIC.selectIC = selectIC_R;
    sIC.muti_labelIC = muti_labelIC_R;
    sIC.labelIC = labelIC_R;
    set(handles.text7,'Userdata',sIC);
    if isrow(selectIC_R)
        set(handles.text7,'String',num2str(selectIC_R),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    else
        set(handles.text7,'String',num2str(selectIC_R'),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    end
    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
else

    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
end



% --- Executes on button press in spatialtemplate.
function spatialtemplate_Callback(hObject, eventdata, handles)
% hObject    handle to spatialtemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spatialtemplate

dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
if get(handles.spatialtemplate,'Value') == 1
    % get hbtype 
    hbtype=get(handles.hbty,'Value');
    switch hbtype
        case 1
            if isfield(dataIn.IC,'OXY')
                sort_info=dataIn.IC.OXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 2
            if isfield(dataIn.IC,'DXY')
                sort_info=dataIn.IC.DXY.Sort;
            else
                warndlg('Run ICA first')
                return
            end
        case 3
            if isfield(dataIn.IC,'TOT')
                sort_info=dataIn.IC.TOT.Sort;
            else
                warndlg('Run ICA first')
                return
            end
    end
    %%not all rules, but one specific rule
    if ~sum(strcmp(sort_info.Sort_selectRule,'spatialtemplate'))
        %evaluate the source
        NID_Input_SpatialMap(handles);
        uiwait(NID_Input_SpatialMap);
        dataIn.IC=NID_OpenFileInitial_Sorting(handles,dataIn.IC);
        set(handles.NIRS_ICA_Denoiser,'UserData',dataIn)
    end
    
    [selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
    sIC.selectIC = selectIC_R;
    sIC.muti_labelIC = muti_labelIC_R;
    sIC.labelIC = labelIC_R;
    set(handles.text7,'Userdata',sIC);
    if isrow(selectIC_R)
        set(handles.text7,'String',num2str(selectIC_R),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    else
        set(handles.text7,'String',num2str(selectIC_R'),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
    end
    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
else

    NID_PLOT_Clear_Screen(handles)
    NID_PLOT(handles)
end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NID_PLOT_Clear_Screen(handles)

set(handles.Sorting_Rules_of_ICs,'UserData',[])
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.spikelike,'Enable','off','Value',0)
set(handles.homo,'Enable','off','Value',0)
set(handles.external,'Enable','off','Value',0)
set(handles.timetemplate,'Enable','off','Value',0)
set(handles.spatialtemplate,'Enable','off','Value',0)
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
    %
    % NID_Save_Data_Remove
    NID_Save_Noise_Remove(handles)
%     obj1 = findobj('Tag','NID_Save_Data_Remove');
%     Removehandles = guihandles(obj1);
%     if isempty(ic_remove)
%         errordlg('No ICs to be removed!','Error')
%         delete(Removehandles)
%         return
%     else
%         set(Removehandles.edit1,'String',ic_remove)
%     end
elseif val_reserve==1
    %
    NID_Save_IC_Reserve(handles)
%     obj1 = findobj('Tag','NID_Save_Data_Reserve');
%     Reservehandles = guihandles(obj1);
%     if isempty(ic_reserve)
%         errordlg('No ICs to be Save!','Error')
%         delete(Reservehandles)
%         return
%     else
%         set(Reservehandles.edit1,'String',ic_reserve)
%     end
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
    temp = strfind(dataSource,filesep);
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


% --- Executes when uipanel9 is resized.
function uipanel9_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in ic_num_caculate.
function ic_num_caculate_Callback(hObject, eventdata, handles)
% hObject    handle to ic_num_caculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
last_val = get(handles.ic_num_caculate,'Userdata'); % Num IC ibformation
val = get(handles.ic_num_caculate,'Value'); %%Num ICA determination method
string_hb = {'oxy','dxy','total'};
switch val
    % PCA
    case 1
        prompt = {'Enter the Percentage of the Power to be Reserve: '};
        dlg_title = 'Input for PCA Method ...';
        num_lines = 1;
        def = {'0.99'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        if ~isempty(answer)
            Nic_info.method='PCA';
            Nic_info.data=str2num(answer{:});
%             set(handles.icnum,'String',str,'Userdata',Nic_info);
            set(handles.ic_num_caculate,'Userdata',Nic_info);
            set(handles.icnum,'String',answer{:});
        else
            set(handles.ic_num_caculate,'Value',last_val);
        end
    %     
    case 2
        prompt = {'Enter the IC Number: '};
        dlg_title = 'Input for Users Input Method ...';
        num_lines = 1;
        def = {''};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        if ~isempty(answer)
            Nic_info.method='User Input';
            Nic_info.data=str2num(answer{:});
            set(handles.ic_num_caculate,'Userdata',Nic_info);
            set(handles.icnum,'String',answer{:});
        else
            set(handles.ic_num_caculate,'Value',last_val);
            
        end
        
    % AIC    
    case 3
        choice = questdlg('AIC Method will takes you more than 10 min.Would you like to continue?', ...
                'AIC Method', ...
                'Yes','No','No');
        switch choice
            case 'No'
                set(handles.ic_num_caculate,'Value',last_val);
            case 'Yes'
                [icnum_aic,icnum_bic] = NID_get_aicbic(handles);
                %
                icNum = get(handles.icnum,'Userdata');
                if 1 == get(handles.hbty,'Value')
                    icNum.oxy = icnum_aic;
                elseif 2 == get(handles.hbty,'Value')
                    icNum.dxy = icnum_aic;
                elseif 3 == get(handles.hbty,'Value')
                    icNum.total = icnum_aic;
                end
                %
                set(handles.icnum,'String',num2str(icnum_aic),'Userdata',icNum);
                set(handles.ic_num_caculate,'Userdata',val);
        end
        
    % BIC     
    case 4
        choice = questdlg('BIC Method will takes you more than 10 min.Would you like to continue?', ...
                'BIC Method', ...
                'Yes','No','No');
        switch choice
            case 'No'
                set(handles.ic_num_caculate,'Value',last_val);
            case 'Yes'
                [icnum_aic,icnum_bic] = NID_get_aicbic(handles);
                %
                icNum = get(handles.icnum);
                if 1 == get(handles.hbty,'Value')
                    icNum.oxy = icnum_bic;
                elseif 2 == get(handles.hbty,'Value')
                    icNum.dxy = icnum_bic;
                elseif 3 == get(handles.hbty,'Value')
                    icNum.total = icnum_bic;
                end
                %
                set(handles.icnum,'String',num2str(icnum_bic),'Userdata',icNum);
                set(handles.ic_num_caculate,'Userdata',val);
        end
        
        
end
% Hints: contents = cellstr(get(hObject,'String')) returns ic_num_caculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ic_num_caculate


% --- Executes during object creation, after setting all properties.
function ic_num_caculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ic_num_caculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icnum_Callback(hObject, eventdata, handles)
% hObject    handle to icnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icnum as text
%        str2double(get(hObject,'String')) returns contents of icnum as a double


% --- Executes during object creation, after setting all properties.
function icnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in advance.
function advance_Callback(hObject, eventdata, handles)
% hObject    handle to advance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ap = get(handles.advance,'UserData');
NID_ICA_Setting(handles)
% if ~isempty(ap)
%     advance_tag = findobj('Tag','NID_OpenFile_ICA_Config_Advance_Setting');
%     gui_advance = guihandles(advance_tag);
%     %
%     if strcmp(ap.advance_ica_alg, 'FastICA')
%         set(gui_advance.radiobutton1,'Value',1);
%         set(gui_advance.advance_p1,'Value',ap.advance_p1);
%         set(gui_advance.advance_p3,'Value',ap.advance_p3);
%         set(gui_advance.advance_p2,'String',ap.advance_p2);
%         set(gui_advance.advance_p4,'String',ap.advance_p4);
%     elseif strcmp(ap.advance_ica_alg, 'InfomaxICA')
%         set(gui_advance.radiobutton2,'Value',1);
%     elseif strcmp(ap.advance_ica_alg, 'stICA')
%         set(gui_advance.radiobutton3,'Value',1);
%     end
% end

% --- Executes on selection change in hbty.
function hbty_Callback(hObject, eventdata, handles)
% hObject    handle to hbty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hbty contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hbty


% --- Executes during object creation, after setting all properties.
function hbty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hbty (see GCBO)
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


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpath = uigetdir(pwd,'Please select the data folder');
if ischar(inpath)
    files = dir(fullfile(inpath,'*.mat'));
    if ~isempty(files)
        for i = 1:length(files)
            fileList{i} = files(i).name(1:end-4);
        end
        set(handles.listbox1,'string',fileList);
        set(handles.listbox1,'Max',10,'Min',1,'Value', []);
        
        NID_PLOT_Clear_Screen(handles)
    end
    set(handles.edit6,'string',inpath)
else
    
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
%% click for each subject in the listbox
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
%get sub file name
subfiln=get(handles.listbox1,'string');
subid=get(handles.listbox1,'value');

if ~isempty(subid)
    set(handles.pushbutton43,'enable','on');

    %%get ouput path
    subdir_out=get(handles.edit7,'string');
    if strcmp(computer('arch'),'win64')||strcmp(computer('arch'),'win32')
    else
        subdir_out=[filesep subdir_out];
    end
    f_outp=dir([subdir_out filesep '*.mat']);
    
    cond_a=1; %%load exsiting results 1, load new fNIRS data 0
    if ~isempty(f_outp)
        if sum(strcmp({f_outp.name}, [subfiln{subid} '.mat']))
        else
            cond_a=0;
        end
    else
        cond_a=0;
    end
    
    
    if cond_a
        %clear sort information
        %if strcmp(f_outp.name, [subfiln{subid} '.mat'])
        inputStruct = load([subdir_out filesep subfiln{subid} '.mat']);
        %load already exsit ICA process results
        if isfield(inputStruct,'IC')
            %dataIn = inputStruct.IC_Component.ICA_Method;
            %dataIn.ic_reserve_icnum = inputStruct.IC_Component.ic_reserve_icnum;
            %set(handles.NIRS_ICA_open_file_and_ICA_config,'UserData',dataIn);
            
            % NID_open_file_Initial_input_icdata(handles)
            hbtype=get(handles.hbty,'Value');
            if 1 == get(handles.hbty,'Value')
                %         hb = 'Oxy';
                Hb = 'OXY';
            elseif 2 == get(handles.hbty,'Value')
                %         hb = 'Dxy';
                Hb = 'DXY';
            elseif 3 == get(handles.hbty,'Value')
                %         hb = 'Total';
                Hb = 'TOT';
            end
            datain.hbType=Hb;
            datain.nirs_data=inputStruct.nirsdata;
            datain.IC=inputStruct.IC;
            set(handles.NIRS_ICA_Denoiser,'UserData',datain);
            % dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
            % 
            NID_Initial(handles);
        end
    else
        %load raw fNIRS data
        subdir=get(handles.edit6,'string');
        inputStruct = load([subdir filesep subfiln{subid}]);
        %save the directory of current data
        set(handles.listbox1,'UserData',[subdir filesep subfiln{subid}]);
        
        %-----two mode to be chosen-----%
        %fNIRS orICA processed fNIRS
        if isfield(inputStruct,'nirsdata')
            dataIn.nirs_data = inputStruct.nirsdata;
            %to add fs or T field
            if isfield(dataIn.nirs_data,'fs')
                dataIn.nirs_data.T = 1/dataIn.nirs_data.fs;
            else
                dataIn.nirs_data.fs = 1/dataIn.nirs_data.T;
            end
            set(handles.NIRS_ICA_Denoiser,'UserData',dataIn);
            
%             NID_open_file_Initial(handles)
            NID_PLOT_Clear_Screen(handles)
        else
            errordlg('Illegel input data!','Data Error')
        end
    end
end

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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inpath = uigetdir(pwd,'Please select the directory for saving the results');
if ischar(inpath)
    set(handles.edit7,'string',inpath)
end

% --- Executes on button press in Sorting_Rules_of_ICs.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to Sorting_Rules_of_ICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
%% run ICA for one subject
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% datapath = get(handles.inpathData,'String');
% if isempty(datapath)
%     errordlg('You need to input NIRS data first!','File Error')
%     return
% end
alg=get(handles.advance,'UserData');
hw = waitbar(0.65,['Decomposing using ' alg.advance_ica_alg]);
% ICA
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');

% if ~isfield(dataIn,'IC')
% ICA
IC = NID_OpenFileInitial_Do_ICA(handles);
% 
IC = NID_OpenFileInitial_Sorting(handles,IC);
%
% ICA
if 1 == get(handles.hbty,'Value')
    %         hb = 'Oxy';
    Hb = 'OXY';
elseif 2 == get(handles.hbty,'Value')
    %         hb = 'Dxy';
    Hb = 'DXY';
elseif 3 == get(handles.hbty,'Value')
    %         hb = 'Total';
    Hb = 'TOT';
end
%
dataIn.IC = IC;
dataIn.hbType = Hb;
%     dataIn.hb_type = hb;
% else
%edited by ZY
%     if ~isfield(dataIn.IC.OXY, 'Sort')
%         set(handles.timetemplate,'Value',1);
%     end
% end
% 
NIRS_ICA_Denoiser=findobj('Tag','NIRS_ICA_Denoiser');
if ~isempty(NIRS_ICA_Denoiser)
    DenoiserHandles=guihandles(NIRS_ICA_Denoiser);
    set(DenoiserHandles.NIRS_ICA_Denoiser,'UserData',dataIn);
end
% 
NID_Initial(DenoiserHandles);
%
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)
% delete(input_des_h)
% set(handles.NIRS_ICA_open_file_and_ICA_config,'Visible','off')
close(hw)


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
%% run ICA for each subject and save to the results folder
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
subdir=get(handles.edit6,'string');
subfiln=get(handles.listbox1,'string');
subdir_out=get(handles.edit7,'string');
if isempty(subdir_out)
    errordlg('Output path should be set','Error!')
    return
else
    alg=get(handles.advance,'UserData');
%     DenoiserHandles=guihandles(NIRS_ICA_Denoiser);
    val_remove = get(handles.radiobutton1,'Value');
    val_reserve = get(handles.radiobutton2,'Value');
    %do ica for each subject
    for i=1:length(subfiln)
        inputStruct = load([subdir filesep subfiln{i}]);
        set(handles.listbox1,'value',i);
        if isfield(inputStruct,'nirsdata')
            % Input data
            dataIn.nirs_data = inputStruct.nirsdata;
            %to add fs or T field
            if isfield(dataIn.nirs_data,'fs')
                dataIn.nirs_data.T = 1/dataIn.nirs_data.fs;
            else
                dataIn.nirs_data.fs = 1/dataIn.nirs_data.T;
            end
            set(handles.NIRS_ICA_Denoiser,'UserData',dataIn);
            %run ICA
            
            hw = waitbar(0.65,['Decomposing using ' alg.advance_ica_alg ' for ' subfiln{i}]);
            
            IC = NID_OpenFileInitial_Do_ICA(handles);
            % 
            IC = NID_OpenFileInitial_Sorting(handles,IC);
            
            
            if 1 == get(handles.hbty,'Value')
                %         hb = 'Oxy';
                Hb = 'OXY';
            elseif 2 == get(handles.hbty,'Value')
                %         hb = 'Dxy';
                Hb = 'DXY';
            elseif 3 == get(handles.hbty,'Value')
                %         hb = 'Total';
                Hb = 'TOT';
            end
            
            dataIn.IC = IC;
            dataIn.hbType = Hb;
            set(handles.NIRS_ICA_Denoiser,'UserData',dataIn);
            if val_remove==1
                %
                % NID_Save_Data_Remove
                NID_Save_Noise_Remove(handles)
            elseif val_reserve==1
                %
                NID_Save_IC_Reserve(handles)
                
                %             NID_open_file_Initial(handles)
                %             NID_PLOT_Clear_Screen(handles)
            end
            close(hw)
            
        else
            errordlg(['Input data ' subfiln{i} ' has wrong format!'],'Data Error')
        end
    end
%            %save the directory of current data
%         set(handles.listbox1,'UserData',[subdir filesep subfiln{subid}]);
%         
    disp('ICA for all subjects finished!')
end
