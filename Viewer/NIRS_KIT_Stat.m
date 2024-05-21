function varargout = NIRS_KIT_Stat(varargin)
% NIRS_KIT_STAT MATLAB code for NIRS_KIT_Stat.fig
%      NIRS_KIT_STAT, by itself, creates a new NIRS_KIT_STAT or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_STAT returns the handle to a new NIRS_KIT_STAT or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_STAT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT_STAT.M with the given input arguments.
%
%      NIRS_KIT_STAT('Property','Value',...) creates a new NIRS_KIT_STAT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_Stat_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_Stat_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_Stat

% Last Modified by GUIDE v2.5 27-Sep-2020 19:44:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_Stat_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_Stat_OutputFcn, ...
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


% --- Executes just before NIRS_KIT_Stat is made visible.
function NIRS_KIT_Stat_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT_Stat (see VARARGIN)

% Choose default command line output for NIRS_KIT_Stat

if ~isempty(varargin) 
    if varargin{1} ==1
        set(handles.is_matrix,'Visible','off');
    end
end

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_Stat wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_Stat_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in onesample_t.
function onesample_t_Callback(hObject, eventdata, handles)
% hObject    handle to onesample_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.is_matrix,'value')
    NIRS_Matrix_ttest;
else
    NIRS_stat_ttest;
end



% --- Executes on button press in twosample_t.
function twosample_t_Callback(hObject, eventdata, handles)
% hObject    handle to twosample_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.is_matrix,'value')
    NIRS_Matrix_ttest2;
else
    NIRS_stat_ttest2;
end



% --- Executes on button press in paired_t.
function paired_t_Callback(hObject, eventdata, handles)
% hObject    handle to paired_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.is_matrix,'value')
    NIRS_Matrix_ttest2paired;
else
    NIRS_stat_ttest2paired;
end



% --- Executes on button press in corraltion.
function corraltion_Callback(hObject, eventdata, handles)
% hObject    handle to corraltion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.is_matrix,'value')
    NIRS_Matrix_correlation;
else
    NIRS_stat_correlation;
end



% --- Executes on button press in oneway_anova.
function oneway_anova_Callback(hObject, eventdata, handles)
% hObject    handle to oneway_anova (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.is_matrix,'value')
    NIRS_Matrix_anova;
else
    NIRS_stat_anova;
end



% --- Executes on button press in average.
function average_Callback(hObject, eventdata, handles)
% hObject    handle to average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.is_matrix,'value')
    NIRS_Matrix_average;
else
    NIRS_stat_average;
end


% --- Executes on button press in is_matrix.
function is_matrix_Callback(hObject, eventdata, handles)
% hObject    handle to is_matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of is_matrix
