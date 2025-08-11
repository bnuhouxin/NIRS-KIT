function NID_ShowResult_initial(NIDhandles,handles)
%% initialise NIRS info.
handlesAll.NIDHandles = NIDhandles;
handlesAll.SRHandles = handles;
set(handles.NID_Show_Results,'Userdata',handlesAll)
%
%% 
%% load data
%
selectedIC = get(NIDhandles.edit3,'String');
%
dataIn = get(NIDhandles.NIRS_ICA_Denoiser,'UserData');
%% set "NIRS Data"
% set path information and load data

    handles_buttons = get(handles.nirs_data_channel_pannel,'UserData');
    if ~isempty(handles_buttons)
        for buttonHandle = handles_buttons
            delete(buttonHandle);
        end
    end
    
    data.raw = dataIn.nirs_data;
    
    defaultSetDir = which('NIRS_ICA_v1');
    index_dir=findstr(defaultSetDir,filesep);
    defaultSetDir=[defaultSetDir(1:index_dir(end)-1) filesep 'file' filesep];
    colortemp = load([defaultSetDir 'mycolorTable.mat']);
    data.color = colortemp.mycolorTable;
    
    set(handles.nirs_data_timeserial,'UserData',data);
    
    % set preprocess nirsdata
    set(handles.edit28,'String',selectedIC,'FontUnit','normalize','FontSize',0.7)
    NID_ShowResult_preprocess_nirsdata(NIDhandles,handles)
    
    % set view information
    set(handles.rangeType,'value',2);
    global rangeType;
    rangeType = 2;
    set(handles.rangeLeft,'string','1');
    set(handles.rangeRight,'string',num2str(size(data.raw.oxyData,1)));
    set(handles.raw_nirsdata,'value',1);
    set(handles.ics_removed,'value',0,'enable','on');
    set(handles.nirs_data_singlemode,'value',1);
    set(handles.nirs_data_multiplemode,'value',0);
    set(handles.nirs_data_oxy,'value',1);
    set(handles.nirs_data_dxy,'value',0);
    set(handles.nirs_data_total,'value',0);
    set(handles.nirs_data_channel,'string',1);
    set(handles.nirs_data_timeserial,'YLimMode','auto');
    set(handles.nirs_data_timeserial,'XGrid','on');
%     set(handles.legnedControl,'state','on');
    set(handles.ylimAxesf,'string',' ');
%     ylimAxesf = ylim(handles.nirs_data_freq);
%     set(handles.ylimAxesf,'string',ylimAxesf(2));
    % generate button pannel
    N = data.raw.nch;
    Row = floor(N/10);
    maxM = 6;
    maxN = 10;
    Ratio = 6; 
    ButtonSize=[Ratio*1/(maxN*Ratio+maxN+1),Ratio*1/(maxM*Ratio+maxM+1)];
    GapSize=[1/(maxN*Ratio+maxN+1),1/(maxM*Ratio+maxM+1)];
    if isfield(data.raw,'probe2d')
        probe2d = data.raw.probe2d;
    else
        probe2d = [];
    end
    if isempty(probe2d)
        LeftbottomPositon=[];
        for i = 1:Row
            for j = 1:10
                newPosition = [(GapSize(1)+ButtonSize(1))*(j-1)+ GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
                LeftbottomPositon=[LeftbottomPositon;  newPosition ];
            end
        end
        i = Row+1;
        for j = 1:N-10*Row;
            newPosition=[(GapSize(1)+ButtonSize(1))*(j-1)+ GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
            LeftbottomPositon=[LeftbottomPositon;  newPosition ];
        end
        handles_button = NID_buttons_create(handles.nirs_data_channel_pannel, handles, LeftbottomPositon, ButtonSize, @NID_SR_channelControl);
        set(handles.nirs_data_channel_pannel,'UserData',handles_button);
        set(handles_button(1),'BackgroundColor',[0.7,0.7,1]);
    else
    % probe merge
        mergeprobe=[];
        for i = 1:length(probe2d)
            tprobe=probe2d{i}.probeSet;
            % probe cut edge
            rowlr=getleftright(sum(tprobe>1000,2));
            collr=getleftright(sum(tprobe>1000,1));
            tprobe=tprobe(rowlr(1):rowlr(2),collr(1):collr(2));
            mergeprobe(1:size(tprobe,1), size(mergeprobe,2)+1:size(mergeprobe,2)+size(tprobe,2))=tprobe;
            mergeprobe(:,end+1)=0;
        end
%         mergeprobe=mergeprobe(:,1:end-1);
    % init
        maxM = size(mergeprobe,1);
        maxN = size(mergeprobe,2);
        Ratio = 6; 
        ButtonSize=[Ratio*1/(maxN*Ratio+maxN+1),Ratio*1/(maxM*Ratio+maxM+1)];
        GapSize=[1/(maxN*Ratio+maxN+1),1/(maxM*Ratio+maxM+1)];
    % draw
        LeftbottomPositon=[];
%         beishu=1.75;
%         x=(1+Ratio-Ratio*beishu)/2;
        for id = 1:N
            [i,j]=find(mergeprobe==1000+id);
            newPosition = [(GapSize(1)+ButtonSize(1))*(j-1)+ 2*GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
            LeftbottomPositon=[LeftbottomPositon;  newPosition ];
        end
        ButtonSize(1) = ButtonSize(1)*1.75;
        handles_button = NID_buttons_create(handles.nirs_data_channel_pannel, handles, LeftbottomPositon, ButtonSize, @NID_SR_channelControl);
        set(handles.nirs_data_channel_pannel,'UserData',handles_button);
        set(handles_button(1),'BackgroundColor',[0.7,0.7,1]);        
    end
    
%% legend button
legendobj = findobj('Tag','nirs_legend');

if isempty(legendobj)
    legendbutton = uicontrol(handles.panel_nirs_data,'Style','togglebutton',...
           'String','','Tag','nirs_legend',...
           'TooltipString','Legend Swith',...
           'Units','normalized',...
           'Position',[0.05,0.49,0.028,0.032],...
           'FontUnit','normalized',...
           'BackgroundColor',[0.941,0.941,0.941]...
            );
    defaultSetDir = which('NIRS_ICA_v1');
    index_dir=findstr(defaultSetDir,filesep);
    defaultSetDir=[defaultSetDir(1:index_dir(end)-1) filesep 'file' filesep];
    detail_icon = importdata([defaultSetDir,'tool_legend.jpg']);
    %
    set(legendbutton,'CData',detail_icon,'Value',1);
    set(legendbutton,'Callback',{@legendbutton_Callback,handles,legendbutton});
end
%% change color button
recolorobj = findobj('Tag','reColor');

if isempty(recolorobj)
    recolorbutton = uicontrol(handles.panel_nirs_data,'Style','togglebutton',...
           'String','','Tag','reColor',...
           'TooltipString','Change Color Scheme',...
           'Units','normalized',...
           'Position',[0.08,0.49,0.028,0.032],...
           'FontUnit','normalized',...
           'BackgroundColor',[0.941,0.941,0.941]...
            );
    defaultSetDir = which('NIRS_ICA_v1');
    index_dir=findstr(defaultSetDir,filesep);
    defaultSetDir=[defaultSetDir(1:index_dir(end)-1) filesep 'file' filesep];
    detail_icon = importdata([defaultSetDir,'reColor.jpg']);
    %
    set(recolorbutton,'CData',detail_icon,'Value',1);
    set(recolorbutton,'Callback',{@recolorbutton_Callback,handles,recolorbutton});
end

end

function lr=getleftright(array)
    lr=[length(array),1];
    for i=1:length(array)
        if(array(i)>0)
            lr(1)=i;
            break;
        end
    end
    for i=length(array):-1:1
        if(array(i)>0)
            lr(2)=i;
            break;
        end
    end
end

function legendbutton_Callback(hObject, eventdata,handles,legendbutton)
children = get(handles.nirs_data_timeserial,'Children');
children = sort(children);
val = get(legendbutton,'Value');
if ~isempty(children)
    if val == 1
        dispname = get(children,'DisplayName');
        lg = legend(handles.nirs_data_timeserial,dispname);
        set(lg,'FontSize',9)
    else
        legend(handles.nirs_data_timeserial,'off');
    end
else
    set(legendbutton,'Value',0);
end
end

function recolorbutton_Callback(hObject, eventdata,handles,legendbutton)

if 1 == get(handles.nirs_data_multiplemode,'value')
    % raw NIRS_Data
    data = get(handles.nirs_data_timeserial,'userdata');
    color = data.color;
    n = size(color,1);
    s = randperm(n);
    for i = 1:n
        newcolor(i,:) = color(s(i),:);
    end
    data.color = newcolor;
    set(handles.nirs_data_timeserial,'UserData',data);
    % baseline NIRS Data
    data = get(handles.uipannel_processed_nirsdata,'userdata');
    data.color = newcolor;
    set(handles.uipannel_processed_nirsdata,'UserData',data);
    %
%     NIRS_ICA_nirsdata_drawTimeseries(handles)
%     NIRS_ICA_nirsdata_drawFreq(handles)
    NID_SR_nirsdata_drawTimeseries(handles)
    NID_SR_nirsdata_drawFreq(handles)
end

end