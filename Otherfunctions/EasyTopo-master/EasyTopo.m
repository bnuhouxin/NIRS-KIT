function varargout = EasyTopo(varargin)
% EASYTOPO 2.0 - GUI version
% EASYTOPO generates and displays topological images of fNIRS on a standard
% brain atlas (ICBM152 nonlinear asymmetric template).
%
% Authors: Eduardo J Velasco and Fenghua Tian <fenghua.tian@gmail.com>
%
% Input parameters: 
%	BrainSurface: a surface mesh of ICBM152 brain atlas
%       vertices: vertex coordinates of the surface mesh (37694 x 3)
%       faces: face list of the surface mesh (75412 x 3)
%	BrainField: radius of brain surface in the default spherical coordinate
%	system [r, theta, phi]
%   user data:
%       mni: mni coordinates of the fNIRS channels
%       df: degree of freedom, usually representing the sample size
%       dConc: channel-wise relative concentrations of HbO2 and Hb
%       beta: channel-wise beta values from general linear model
%       t: channel-wise t-statistics values
%
% Output parameters: 
%	BrainSurface: a surface mesh of ICBM152 brain atlas
%       vertices: vertex coordinates of the surface mesh (37694 x 3)
%       faces: face list of the surface mesh (75412 x 3)
%   img: interpolated fNIRS images on the surface mesh (37694 x 1)
%	map: interpolated fNIRS maps in the [theta phi] space (181 x 201)
% 
% Last modified date: 10-Apr-2016

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EasyTopo_OpeningFcn, ...
                   'gui_OutputFcn',  @EasyTopo_OutputFcn, ...
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

% --- Executes just before EasyTopo is made visible.
function EasyTopo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EasyTopo (see VARARGIN)

% Choose default command line output for EasyTopo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes EasyTopo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = EasyTopo_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

    %Disables Plot Menu
    set(handles.saveData, 'Enable', 'off');
    set(handles.plotConcValues, 'Enable', 'off');
    set(handles.plotBetaValues, 'Enable', 'off');
    set(handles.plotTValues, 'Enable', 'off');
    set(handles.plotProbeGeometry, 'Enable', 'off');
    set(handles.clearPlots, 'Enable', 'off');
    
    %Disables Threshold
    set(handles.checkbox1, 'Enable', 'off');
    set(handles.checkbox2, 'Enable', 'off');
    set(handles.checkbox3, 'Enable', 'off');
    set(handles.edit1, 'Enable', 'off');
    set(handles.edit2, 'Enable', 'off');
    set(handles.edit3, 'Enable', 'off'); 
    set(handles.edit4, 'Enable', 'off');
    set(handles.edit5, 'Enable', 'off');
    set(handles.edit6, 'Enable', 'off'); 
    set(handles.edit7, 'Enable', 'off');

	%Load Data Needed for plotting
    load('BrainField.mat');
    handles.BrainField = BrainField; 
    clear BrainField;
    handles.BrainSurface = load('BrainSurface.mat');
    load cmap_jet; 
    handles.cmap = cmap;

    guidata(hObject, handles);

% ======== Menu Callbacks ========
% --- File Callbacks
function File_Callback(hObject, eventdata, handles)

% --- Open File
function openData_Callback(hObject, eventdata, handles)
    [FileName,PathName] = uigetfile('*.mat','Please select the MATLAB data file');
    load([PathName FileName]);
    handles.PathName = PathName;
    
    if exist('mni')
        set(handles.plotProbeGeometry, 'Enable', 'on');
        set(handles.clearPlots, 'Enable', 'on');        
        %display optodes on surface mesh of the brain
        axes(handles.mniOpt);
        cla(handles.mniOpt);
        set(handles.mniOpt, 'color', 'w', 'visible', 'off');
        h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,mni,3,[0 0 1]);
        
        %generate dConc maps/images
        if exist('HbO2') & exist('Hb')
            set(handles.plotConcValues, 'Enable', 'on');
            
            %[theta phi] maps
            [theta, phi, radius, value, region] = topo_map_rot(mni, HbO2);
            handles.map.HbO2 = value; clear radius value region;
            [theta, phi, radius, value, region] = topo_map_rot(mni, Hb);
            handles.map.Hb = value; clear radius value region;
            handles.map.theta = theta;
            handles.map.phi = phi;
            %topographical images
            handles.img.HbO2 = topo_surf_rot(mni, HbO2, handles.BrainSurface.vertices);
            handles.img.Hb = topo_surf_rot(mni, Hb, handles.BrainSurface.vertices);
        end
        %generate beta-maps/images
        if exist('betaHbO2') & exist('betaHb')
            set(handles.plotBetaValues, 'Enable', 'on');
            
            %[theta phi] maps
            [theta, phi, radius, value, region] = topo_map_rot(mni, betaHbO2);
            handles.map.betaHbO2 = value; clear radius value region;
            [theta, phi, radius, value, region] = topo_map_rot(mni, betaHb);
            handles.map.betaHb = value; clear radius value region;
            handles.map.theta = theta;
            handles.map.phi = phi;        
            %topographical images
            handles.img.betaHbO2 = topo_surf_rot(mni, betaHbO2, handles.BrainSurface.vertices);
            handles.img.betaHb = topo_surf_rot(mni, betaHb, handles.BrainSurface.vertices);
        end
        %generate t-maps/images
        if exist('tHbO2') & exist('tHb')
            set(handles.plotTValues, 'Enable', 'on');
            
            %[theta phi] maps
            [theta, phi, radius, value, region] = topo_map_rot(mni, tHbO2);
            handles.map.tHbO2 = value; clear radius value region;
            [theta, phi, radius, value, region] = topo_map_rot(mni, tHb);
            handles.map.tHb = value; clear radius value region;
            handles.map.theta = theta;
            handles.map.phi = phi;        
            %topographical images
            handles.img.tHbO2 = topo_surf_rot(mni, tHbO2, handles.BrainSurface.vertices);
            handles.img.tHb = topo_surf_rot(mni, tHb, handles.BrainSurface.vertices);
            
            %degree of freedom
            if ~exist('df')
                df = 1;
            end
        end
    end
    
    set(handles.saveData, 'Enable', 'on');
    handles.data = load([PathName FileName]);
    guidata(hObject, handles);
    contextMenuOptodes(h,handles);
       
% --- Save File
function saveData_Callback(hObject, eventdata, handles)
	map = handles.map;
	img = handles.img;
    img.faces = handles.BrainSurface.faces;
    img.vertices = handles.BrainSurface.vertices;
    
    [FileName,PathName] = uiputfile([handles.PathName '*.mat'],'Please select the directory to save file');    
	save([PathName FileName],'map','img');
    
% --- Plot Callbacks
function plot_Callback(hObject, eventdata, handles)

% --- Plot dConc Values
function plotConcValues_Callback(hObject, eventdata, handles)
    %load surface mesh of the brain
    vertices = handles.BrainSurface.vertices;
    faces = handles.BrainSurface.faces;
	%threshold options
    check = get(handles.checkbox1, 'Value');
    if check == 1
        set(handles.edit1, 'Enable','on');
        set(handles.edit2, 'Enable','on');
        cutoff1 = str2num(get(handles.edit1, 'String'));
        cutoff2 = str2num(get(handles.edit2, 'String'));
    end
    
    %HbO: [theta phi] map
    axes(handles.HBOmap);
    map = handles.map.HbO2;
    if exist('cutoff1') && ~isempty(cutoff1)
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-cutoff1 cutoff1]); set(gca,'Ydir','normal');
    else
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
    end  
    hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1); 
 	xlabel('\phi (degree)'); ylabel('\theta (degree)');
    colormap(handles.cmap); colorbar;
    contextMenuMap(h,map,handles); 

    %HbO: 3D image on brain surface
    vertvalue = handles.img.HbO2;
    vertcolor = repmat([1 1 1], length(handles.BrainSurface.vertices), 1);
	if exist('cutoff1') && ~isempty(cutoff1)
        vertplot = vertvalue/cutoff1;
    else
        vertplot = vertvalue/max(abs(vertvalue));
    end    
    regIdx = find(isnan(vertplot)==0);
    cidx = round(31.5*vertplot(regIdx)+32.5);
    cidx(find(cidx>64)) = 64;
    cidx(find(cidx<1)) = 1;
    vertcolor(regIdx,:) = handles.cmap(cidx,:);
	clear vertvalue vertplot regIdx cidx
    axes(handles.HBOimage);    
    h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces, vertcolor, [0 0 1]);    
    colormap(handles.cmap);
    contextMenuImg(h,vertcolor,handles);
    clear vertcolor 
    
	%Hb: [theta phi] map
    axes(handles.HBmap);
    map = handles.map.Hb;
    if exist('cutoff2') && ~isempty(cutoff2)
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-cutoff2 cutoff2]); set(gca,'Ydir','normal');
    else
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
    end    
    hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1); 
    xlabel('\phi (degree)'); ylabel('\theta (degree)'); 
    colormap(handles.cmap); colorbar;
    contextMenuMap(h,map,handles);    
    
    %Hb: 3D image on brain surface
	vertvalue = handles.img.Hb;
    vertcolor = repmat([1 1 1], length(handles.BrainSurface.vertices), 1);
	if exist('cutoff2') && ~isempty(cutoff2)
        vertplot = vertvalue/cutoff2;
    else
        vertplot = vertvalue/max(abs(vertvalue));
    end    
    regIdx = find(isnan(vertplot)==0);
    cidx = round(31.5*vertplot(regIdx)+32.5);
    cidx(find(cidx>64)) = 64;
    cidx(find(cidx<1)) = 1;
    vertcolor(regIdx,:) = handles.cmap(cidx,:);
	clear vertvalue vertplot regIdx cidx
    axes(handles.HBimage);
    h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces, vertcolor, [0 0 1]);    
	colormap(handles.cmap); 
    contextMenuImg(h,vertcolor,handles);
    clear vertcolor 
    
    guidata(hObject, handles);    
    set(handles.checkbox1, 'Enable','on');
    set(handles.checkbox2, 'Enable','off');
    set(handles.checkbox3, 'Enable','off');
	set(handles.edit3, 'Enable','off');
    set(handles.edit4, 'Enable','off');
    set(handles.edit5, 'Enable','off');
    set(handles.edit6, 'Enable','off');
    set(handles.edit7, 'Enable','off');
    
% --- Plot Beta Values
function plotBetaValues_Callback(hObject, eventdata, handles)
    %load surface mesh of the brain
    vertices = handles.BrainSurface.vertices;
    faces = handles.BrainSurface.faces;

    %threshold options
    check = get(handles.checkbox2, 'Value');
    if check == 1
        set(handles.edit3, 'Enable','on');
        set(handles.edit4, 'Enable','on');
        cutoff1 = str2num(get(handles.edit3, 'String'));
        cutoff2 = str2num(get(handles.edit4, 'String'));
    end
    
    %HbO: [theta phi] map
    axes(handles.HBOmap);
    map = handles.map.betaHbO2;
    if exist('cutoff1') && ~isempty(cutoff1)
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-cutoff1 cutoff1]); set(gca,'Ydir','normal');
    else
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
    end    
    hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1); 
    xlabel('\phi (degree)'); ylabel('\theta (degree)');
    colormap(handles.cmap); colorbar;
    contextMenuMap(h,map,handles);
    
    %HbO: 3D image on brain surface
    vertvalue = handles.img.betaHbO2;
    vertcolor = repmat([1 1 1], length(handles.BrainSurface.vertices), 1);
	if exist('cutoff1') && ~isempty(cutoff1)
        vertplot = vertvalue/cutoff1;
    else
        vertplot = vertvalue/max(abs(vertvalue));
    end    
    regIdx = find(isnan(vertplot)==0);
    cidx = round(31.5*vertplot(regIdx)+32.5);
    cidx(find(cidx>64)) = 64;
    cidx(find(cidx<1)) = 1;
    vertcolor(regIdx,:) = handles.cmap(cidx,:);
	clear vertvalue vertplot regIdx cidx
    axes(handles.HBOimage);
    h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces, vertcolor, [0 0 1]);    
    colormap(handles.cmap);
    contextMenuImg(h,vertcolor,handles);
    clear vertcolor
        
    %Hb: [theta phi] map 
    axes(handles.HBmap);
    map = handles.map.betaHb;
    if exist('cutoff2') && ~isempty(cutoff2)
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-cutoff2 cutoff2]); set(gca,'Ydir','normal');
    else
        h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
    end    
    hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1);
    xlabel('\phi (degree)'); ylabel('\theta (degree)');
    colormap(handles.cmap); colorbar;
    contextMenuMap(h,map,handles);
    
       
    %Hb: 3D image on brain surface
    vertvalue = handles.img.betaHb;
    vertcolor = repmat([1 1 1], length(handles.BrainSurface.vertices), 1);
	if exist('cutoff2') && ~isempty(cutoff2)
        vertplot = vertvalue/cutoff2;
    else
        vertplot = vertvalue/max(abs(vertvalue));
    end    
    regIdx = find(isnan(vertplot)==0);
    cidx = round(31.5*vertplot(regIdx)+32.5);
    cidx(find(cidx>64)) = 64;
    cidx(find(cidx<1)) = 1;
    vertcolor(regIdx,:) = handles.cmap(cidx,:);
	clear vertvalue vertplot regIdx cidx
    axes(handles.HBimage);
    h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces, vertcolor, [0 0 1]);    
	colormap(handles.cmap);   
    contextMenuImg(h,vertcolor,handles);
    clear vertcolor 
    
    guidata(hObject, handles);
    set(handles.checkbox1, 'Enable', 'off');
    set(handles.checkbox2, 'Enable', 'on');
    set(handles.checkbox3, 'Enable', 'off');
	set(handles.edit1, 'Enable','off');
    set(handles.edit2, 'Enable','off');
    set(handles.edit5, 'Enable','off');
    set(handles.edit6, 'Enable','off');
    set(handles.edit7, 'Enable','off');

    
% --- Plot T values    
function plotTValues_Callback(hObject, eventdata, handles)
    %load surface mesh of the brain
    vertices = handles.BrainSurface.vertices;
    faces = handles.BrainSurface.faces;
    
    %threshold options
    check = get(handles.checkbox3, 'Value');
    if check == 1
        set(handles.edit5, 'Enable','on');
        set(handles.edit6, 'Enable','on');
        set(handles.edit7, 'Enable','on');
        
        df = str2num(get(handles.edit5, 'String'));
    
        pcutoff1 = str2num(get(handles.edit6, 'String'));
        if ~isempty(pcutoff1)
            tcutoff1 =  tinv(1-pcutoff1,df);
        end
    
        pcutoff2 = str2num(get(handles.edit7, 'String'));
        if ~isempty(pcutoff2)
            tcutoff2 =  tinv(1-pcutoff2,df);
        end
    end
    clear df pcutoff1 pcutoff2

    %HbO: [theta phi] map
    axes(handles.HBOmap);
    map = handles.map.tHbO2;
    if exist('tcutoff1')
        map(find(abs(map)<tcutoff1)) = 0;
    end
    h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
    hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1);
    xlabel('\phi (degree)'); ylabel('\theta (degree)');
    colormap(handles.cmap); colorbar;
    contextMenuMap(h,map,handles);
    
    %HbO: 3D image on brain surface
    vertvalue = handles.img.tHbO2;
    if exist('tcutoff1')
        vertvalue(find(abs(vertvalue)<tcutoff1)) = 0;
    end
    vertcolor = repmat([1 1 1], length(handles.BrainSurface.vertices), 1);
    vertplot = vertvalue/max(abs(vertvalue));
    regIdx = find(isnan(vertplot)==0);
    cidx = round(31.5*vertplot(regIdx)+32.5);
    cidx(find(cidx>64)) = 64;
    cidx(find(cidx<1)) = 1;
    vertcolor(regIdx,:) = handles.cmap(cidx,:);
	clear vertvalue vertplot regIdx cidx
    axes(handles.HBOimage);
    h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces, vertcolor, [0 0 1]);    
    colormap(handles.cmap);   
    contextMenuImg(h,vertcolor,handles);
    clear vertcolor     
    
    %Hb: [theta phi] map
    axes(handles.HBmap);
    map = handles.map.tHb;
    if exist('tcutoff2')
        map(find(abs(map)<tcutoff2)) = 0;
    end
    h = imagesc(handles.map.phi(1,:),handles.map.theta(:,1),map,[-max(abs(map(:))) max(abs(map(:)))]); set(gca,'Ydir','normal');
    hold on; contour(handles.map.phi,handles.map.theta,handles.BrainField,5,'k-','linewidth',1);
    xlabel('\phi (degree)'); ylabel('\theta (degree)');
    colormap(handles.cmap); colorbar;
    contextMenuMap(h,map,handles);
    
    %Hb: 3D image on brain surface
    vertvalue = handles.img.tHb;
    if exist('tcutoff2')
        vertvalue(find(abs(vertvalue)<tcutoff1)) = 0;
    end
    vertcolor = repmat([1 1 1], length(handles.BrainSurface.vertices), 1);
    vertplot = vertvalue/max(abs(vertvalue));
    regIdx = find(isnan(vertplot)==0);
    cidx = round(31.5*vertplot(regIdx)+32.5);
    cidx(find(cidx>64)) = 64;
    cidx(find(cidx<1)) = 1;
    vertcolor(regIdx,:) = handles.cmap(cidx,:);
	clear vertvalue vertplot regIdx cidx
    axes(handles.HBimage);
    h = plotimage(handles.BrainSurface.vertices,handles.BrainSurface.faces, vertcolor, [0 0 1]);    
    colormap(handles.cmap);   
    contextMenuImg(h,vertcolor,handles);
    clear vertcolor 
    
    guidata(hObject, handles);
    set(handles.checkbox1, 'Enable', 'off');
    set(handles.checkbox2, 'Enable', 'off');
    set(handles.checkbox3, 'Enable', 'on');
	set(handles.edit1, 'Enable','off');
    set(handles.edit2, 'Enable','off');
	set(handles.edit3, 'Enable','off');
    set(handles.edit4, 'Enable','off');
    
% --- Plot Probe Geometry
function plotProbeGeometry_Callback(hObject, eventdata, handles)
    axes(handles.mniOpt);
    cla(handles.mniOpt);    
    set(handles.mniOpt, 'color', 'w', 'visible', 'off');
    h = plotoptodes(handles.BrainSurface.vertices,handles.BrainSurface.faces,handles.data.mni,3,[0 0 1]);
    contextMenuOptodes(h,handles);   
    
% --- Clear Plots
function clearPlots_Callback(hObject, eventdata, handles)
    cla(handles.mniOpt);
    cla(handles.HBOmap);
    cla(handles.HBmap);    
    cla(handles.HBOimage);
    cla(handles.HBimage);
    
%     axes(handles.mniOpt)
%     axis on;
%  	axes(handles.HBOimage)
%     axis on;   
%     axes(handles.HBimage)
%     axis on;
%     
%     set(handles.HBOmap,'xtick',[],'ytick',[]);    
%     set(handles.HBmap,'xtick',[],'ytick',[]);
%     set(handles.HBOimage,'xtick',[],'ytick',[]);    
%     set(handles.HBimage,'xtick',[],'ytick',[]);
%     set(handles.mniOpt,'xtick',[],'ytick',[]);

    
% ======== Threshold options ========

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
check = get(handles.checkbox1, 'Value');

if check == 1;    
    set(handles.edit1, 'Enable','on');
    set(handles.edit2, 'Enable','on');
  
	set(handles.edit1,'String',sprintf('%.2f',max(abs(handles.data.HbO2))));
	set(handles.edit2,'String',sprintf('%.2f',max(abs(handles.data.Hb))));
else 
    set(handles.edit1, 'Enable','off');
    set(handles.edit2, 'Enable','off');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
check = get(handles.checkbox2, 'Value');

if check == 1;    
    set(handles.edit3, 'Enable','on');
    set(handles.edit4, 'Enable','on');
  
	set(handles.edit3,'String',sprintf('%.2f',max(abs(handles.data.HbO2))));
	set(handles.edit4,'String',sprintf('%.2f',max(abs(handles.data.Hb))));
else 
    set(handles.edit3, 'Enable','off');
    set(handles.edit4, 'Enable','off');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
check = get(handles.checkbox3, 'Value');

if check == 1;    
    set(handles.edit5, 'Enable','on');
    set(handles.edit6, 'Enable','on');
    set(handles.edit7, 'Enable','on');    
  
	set(handles.edit5,'String',handles.data.df);
	set(handles.edit6,'String',0.05);	%pcutoff = 0.05;
	set(handles.edit7,'String',0.05);	%pcutoff = 0.05;
else 
    set(handles.edit5, 'Enable','off');
    set(handles.edit6, 'Enable','off');
    set(handles.edit7, 'Enable','off');
end


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

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
