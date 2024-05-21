function varargout = NIRS_KIT_Rest(varargin)
%NIRS_KIT_Rest M-file for NIRS_KIT_Rest.fig
%      NIRS_KIT_Rest, by itself, creates a new NIRS_KIT_Rest or raises the existing
%      singleton*.
%
%      H = NIRS_KIT_Rest returns the handle to a new NIRS_KIT_Rest or the handle to
%      the existing singleton*.
%
%      NIRS_KIT_Rest('Property','Value',...) creates a new NIRS_KIT_Rest using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to NIRS_KIT_Rest_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      NIRS_KIT_Rest('CALLBACK') and NIRS_KIT_Rest('CALLBACK',hObject,...) call the
%      local function named CALLBACK in NIRS_KIT_Rest.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT_Rest

% Last Modified by GUIDE v2.5 10-Sep-2020 20:28:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_Rest_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_Rest_OutputFcn, ...
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


% --- Executes just before NIRS_KIT_Rest is made visible.
function NIRS_KIT_Rest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for NIRS_KIT_Rest

% Release='NIRS_KIT_Beta 15-Nov-2019';


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT_Rest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_Rest_OutputFcn(hObject, eventdata, handles)
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
NIRS_KIT_Rest_Data_Viewer


% --- Executes on button press in ResultsViewer.
function ResultsViewer_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsViewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ismatrix = questdlg('Is your input for visulizatioon FC Matrix?','Options','Yes','NO','Cancle','NO');
if strcmp(ismatrix,'NO')
    NIRS_KIT_Result_Viewer;   
elseif strcmp(ismatrix,'Yes')
    NIRS_KIT_Matrix_Viewer;
end



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
NIRS_Rest_Individual_Analysis;

% --- Executes on button press in Rest_Group_Analysis.
function Rest_Group_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Rest_Group_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_KIT_Stat;


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NIRS_KIT_DataPreparation;
