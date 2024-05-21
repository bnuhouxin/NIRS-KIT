function varargout = NIRS_KIT(varargin)
% NIRS_KIT MATLAB code for NIRS_KIT.fig
%      NIRS_KIT, by itself, creates a new NIRS_KIT or raises the existing
%      singleton*.
%
%      H = NIRS_KIT returns the handle to a new NIRS_KIT or the handle to
%      the existing singleton*.
%
%      NIRS_KIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIRS_KIT.M with the given input arguments.
%
%      NIRS_KIT('Property','Value',...) creates a new NIRS_KIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NIRS_KIT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NIRS_KIT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NIRS_KIT

% Last Modified by GUIDE v2.5 27-Sep-2020 17:43:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NIRS_KIT_OpeningFcn, ...
                   'gui_OutputFcn',  @NIRS_KIT_OutputFcn, ...
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


% --- Executes just before NIRS_KIT is made visible.
function NIRS_KIT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NIRS_KIT (see VARARGIN)

% Choose default command line output for NIRS_KIT

root_path = which('NIRS_KIT.m');
root_f = fileparts(root_path);
icon_path = fullfile(root_f,'NIRS_KIT_Main.jpg');
icon_img = imread(icon_path);

axes(handles.axes_icon);
axis image;
imshow(icon_img);
set(handles.axes_icon,'box','on');

disp('----------------------------------------------------------------------------------------------------------');
disp('   Thank you for using NIRS_KIT.');
disp('   Copyright 2019. All Rights Reserved');
disp('   It is only for academic use! Any unauthorized commercial use is prohibited.'); 
disp('   Programers: Hou Xin; Zhang Zong; Zhao Chen; Zhu Chaozhe.');
disp('   Mail to Initiator: houxin195776@mail.bnu.edu.cn');
disp('   State Key Laboratory of Cognitive Neuroscience and Learning, Beijing Normal University, Beijing, China');
disp('   ');
disp('   Please cite:');
disp('   Hou, X., Zhang, Z., Zhao, C., Duan, L., Gong, Y., Li, Z., & Zhu, C. (2021).');
disp('      NIRS-KIT: a MATLAB toolbox for both resting-state and task fNIRS data analysis.');
disp('      Neurophotonics, 8(01). https://doi.org/10.1117/1.NPh.8.1.010802.');
disp('----------------------------------------------------------------------------------------------------------');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NIRS_KIT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NIRS_KIT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Task_Modular.
function Task_Modular_Callback(hObject, eventdata, handles)
% hObject    handle to Task_Modular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NIRS_KIT_Task;


% --- Executes on button press in Rest_Modular.
function Rest_Modular_Callback(hObject, eventdata, handles)
% hObject    handle to Rest_Modular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NIRS_KIT_Rest;