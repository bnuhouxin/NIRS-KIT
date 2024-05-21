function varargout = NIRS_KIT_Task(varargin)
%NIRS_KIT_Task M-file for NIRS_KIT_Task.fig
%      NIRS_KIT_Task, by itself, creates a new NIRS_KIT_Task or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_Task returns the handle to a new NIRS_KIT_Task or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_Task('Property','Value',...) creates a new NIRS_KIT_Task using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to NIRS_KIT_Task_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      NIRS_KIT_Task('CALLBACK') and NIRS_KIT_Task('CALLBACK',hObject,...) call the
%      local function named CALLBACK in NIRS_KIT_Task.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_Task

% Last Modified by GUIDE v2.5 11-Sep-2020 13:20:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_Task_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_Task_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before NIRS_KIT_Task is made visible.
function NIRS_KIT_Task_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for NIRS_KIT_Task

% Release='NIRS_KIT_Beta 15-Nov-2019';


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_Task wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_Task_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in DataViewer.
function DataViewer_Callback(hObject, eventdata, handles)
% hObject    handle to DataViewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% NIRS_KIT_Task_Data_Viewer;

handles2(1) = figure('units','norm','position',[.4,.3,.1,.15],'name','DataViewer or BlockAverage','menubar','none','numbertitle','off','color',[.941,.941,.941]);
handles2(2) = uipanel('units','norm','Position',[.075,.1,.85,.8],'shadowcolor',[.5,.5,.5]);
handles2(3) = uicontrol('units','norm','parent',handles2(2),'style','pushbutton','string','Task Data Viewer','Position',[.075,.6,.85,.3],'backgroundcolor',[.86,.86,.86], ...
             'fontSize',12,'fontWeight','bold','foregroundcolor',[.87,.49,0]);
handles2(4) = uicontrol('units','norm','parent',handles2(2),'style','pushbutton','string','Block/Event Average','Position',[.075,.1,.85,.3],'backgroundcolor',[.86,.86,.86],...
             'fontSize',12,'fontWeight','bold','foregroundcolor',[.87,.49,0]);
set(handles2(3),'callback',@NIRS_KIT_Task_Data_Viewer);
set(handles2(4),'callback',@NIRS_KIT_BlockAverage);







% --- Executes on button press in ResultsViewer.
function ResultsViewer_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsViewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_KIT_Result_Viewer;


% --- Executes on button press in preprocess.
function preprocess_Callback(hObject, eventdata, handles)
% hObject    handle to preprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_Preprocessing;



% --- Executes on button press in Rest_Individual_Analysis.
function Rest_Individual_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Rest_Individual_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_Task_Individual_Analysis;



% --- Executes on button press in Rest_Group_Analysis.
function Rest_Group_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Rest_Group_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NIRS_KIT_Stat(1);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_KIT_DataPreparation;
