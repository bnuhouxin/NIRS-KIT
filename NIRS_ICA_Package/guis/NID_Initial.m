function NID_Initial(handles)

%% Initizialize the gui of grid IC displaying

%% Set control panel
% set(handles.Sorting_Rules_of_ICs,'UserData',[])
TP = get(handles.uipanel6,'UserData'); 
if ~isempty(TP)
    if TP == 1 % preprocessing
        set(handles.radiobutton1,'Value',1);
        
        set(handles.spikelike,'Enable','on','Value',0);
        set(handles.homo,'Enable','on','Value',0);
        set(handles.external,'Enable','on','Value',0);
        
        set(handles.timetemplate,'Enable','off','Value',0);
        set(handles.spatialtemplate,'Enable','off','Value',0);
    elseif TP == 2 % task individual
        set(handles.radiobutton2,'Value',1);

        set(handles.spikelike,'Enable','off','Value',0);
        set(handles.homo,'Enable','off','Value',0);
        set(handles.external,'Enable','off','Value',0);
        
        set(handles.timetemplate,'Enable','on','Value',0);
        set(handles.spatialtemplate,'Enable','on','Value',0);
    elseif TP == 3 % rest individual FC exploration
        set(handles.radiobutton2,'Value',1);

        set(handles.spikelike,'Enable','off','Value',0);
        set(handles.homo,'Enable','off','Value',0);
        set(handles.external,'Enable','off','Value',0);
        
        set(handles.timetemplate,'Enable','off','Value',0);
        set(handles.spatialtemplate,'Enable','on','Value',0);
    end
else
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',0);

    set(handles.spikelike,'Enable','on','Value',0);
    set(handles.homo,'Enable','on','Value',0);
    set(handles.external,'Enable','on','Value',0);
    
    set(handles.timetemplate,'Enable','on','Value',0);
    set(handles.spatialtemplate,'Enable','on','Value',0);
end


set(handles.edit3,'String','','FontWeight','bold','FontUnit','normalized','FontSize',0.7);
set(handles.text7,'String','','FontWeight','bold','FontUnit','normalized','FontSize',0.7);
set(handles.resultView,'Value',0);
set(handles.small,'State','off');
set(handles.mid,'State','off');
set(handles.big,'State','off');
set(handles.pageNoL,'Userdata',[]);
set(handles.pageNoR,'Userdata',[]);
%% load data
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
IC = dataIn.IC;
%% Displaying control
% data source
% NIDFOC=findobj('Tag','NIRS_ICA_open_file_and_ICA_config');
% NIDFOC_handle = guihandles(NIDFOC);
% ds = get(NIDFOC_handle.inpathData,'String');
% Hb_Type
% hb_type = dataIn.hb_type;
hbType = dataIn.hbType;
%edited by Zhaoyang

% display the directory
% set(handles.uipanel2,'Title',strcat('Target Source Identifier',' (',hbType,')--DataSource: ',ds),'Fontweight','bold');

%% Get hbtype to be initiated
temp_struct = getfield(IC,hbType);
temp_struct = getfield(temp_struct,'Sort');

% if ~isempty(temp_struct)
    Sort_selectRule = temp_struct.Sort_selectRule;
    % 
    [xx,zz] = ismember(Sort_selectRule,temp_struct.Sort_icName);
% else sor edited by zhaoyang
%     Sort_selectRule = [];
%     zz = [];
% end
% Set displaying of control pannel 
% if isempty(zz)
%     set(handles.radiobutton1,'Value',0)
%     set(handles.radiobutton2,'Value',0)
%     %
%     set(handles.resultView,'Enable','off')
%     %
% elseif any(zz <= 3)
%     set(handles.radiobutton1,'Value',1)
%     set(handles.radiobutton2,'Value',0)
%     %
%     set(handles.resultView,'Enable','on')
%     %
%     temp = zz(find(zz<=3));
%     for i = 1:length(temp)
%         tag = temp_struct.Sort_icName{temp(i)};
%         tag = strcat('sort_',tag);
%         obj = findobj('Tag',tag);
%         set(obj,'Enable','on','Value',1,'FontWeight','bold')   
%     end
%     temp1 = zz(find(zz>3));
%     for i = 1:length(temp1)
%         tag = temp_struct.Sort_icName{temp1(i)};
%         tag = strcat('sort_',tag);
%         obj = findobj('Tag',tag);
%         set(obj,'Enable','off','Value',0,'FontWeight','bold')   
%     end
% else
%     set(handles.radiobutton1,'Value',0)
%     set(handles.radiobutton2,'Value',1)
%     %
%     set(handles.resultView,'Enable','off')
%     %
%     temp = zz(find(zz>3));
%     for i = 1:length(temp)
%         tag = temp_struct.Sort_icName{temp(i)};
%         tag = strcat('sort_',tag);
%         obj = findobj('Tag',tag);
%         set(obj,'Enable','on','Value',1,'FontWeight','bold')   
%     end
%     temp1 = zz(find(zz<=3));
%     for i = 1:length(temp1)
%         tag = temp_struct.Sort_icName{temp1(i)};
%         tag = strcat('sort_',tag);
%         obj = findobj('Tag',tag);
%         set(obj,'Enable','off','Value',0,'FontWeight','bold')   
%     end
% end

set(handles.Sorting_Rules_of_ICs,'UserData',Sort_selectRule)

%% view the time course
set(handles.popupmenu2,'Value',1);


%% automatically select ics (based on the value of metrics)
[selectIC,muti_labelIC,labelIC,selectIC_R,muti_labelIC_R,labelIC_R] = NID_caculate_UserSelect_IC(handles);
%
[a,b] = size(selectIC);
if a>1
    selectIC = selectIC';
    selectIC_R = selectIC_R';
end

set(handles.edit3,'String',num2str(selectIC),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);
set(handles.text7,'String',num2str(selectIC_R),'FontWeight','bold','FontUnit','normalized','FontSize',0.7);


sIC.selectIC = selectIC;
sIC.muti_labelIC = muti_labelIC;
sIC.labelIC = labelIC;

sIC_Re.selectIC = selectIC_R;
sIC_Re.muti_labelIC = muti_labelIC_R;
sIC_Re.labelIC = labelIC_R;
% load previous results
% if isfield(dataIn,'ic_reserve_icnum')
%     sIC_Re.selectIC = dataIn.ic_reserve_icnum;
% else
%     sIC_Re.selectIC = selectIC_R;
% end

%load prevous results
if isfield(dataIn.IC,'selectedic')
    if get(handles.radiobutton1,'Value')
        sIC.selectIC = dataIn.IC.selectedic;
    else
        sIC_Re.selectIC = dataIn.IC.selectedic;
    end
end
%

set(handles.edit3,'Userdata',sIC);
set(handles.text7,'Userdata',sIC_Re);
%% display mode
set(handles.small,'State','on')
set(handles.mid,'State','off')
set(handles.big,'State','off')
%% get number of pages to display results
Num = NID_Caculate_pageNum(handles);
pageNum.max = Num;
pageNum.now = 1;
set(handles.pageNoL,'Userdata',pageNum,'TooltipString',strcat('Page','( 1/',num2str(Num),' )'))
set(handles.pageNoR,'Userdata',pageNum,'TooltipString',strcat('Page','( 1/',num2str(Num),' )'))
%%
NID_PLOT_Clear_Screen(handles)
NID_PLOT(handles)
end