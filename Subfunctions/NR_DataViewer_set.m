function NR_DataViewer_set(handles)
% set path information and load data

    handles_buttons = get(handles.channelPanel,'UserData');
    if ~isempty(handles_buttons)
        for buttonHandle = handles_buttons
            delete(buttonHandle);
        end
    end

    
    % set data source =====================================================
    if isempty(get(handles.axestimeseries,'UserData'))
        dataSource = get(handles.viewer,'UserData');
        load(dataSource);
        data.raw = nirsdata;
        defaultSetDir = which('NIRS_KIT');
        index_dir=fileparts(defaultSetDir);
        defaultSetDir=fullfile(index_dir,'file');
        colortemp = load(fullfile(defaultSetDir,'mycolorTable.mat'));
        data.color = colortemp.mycolorTable;
        set(handles.axestimeseries,'UserData',data);
    else
        data = get(handles.axestimeseries,'UserData');
        nirsdata = data.raw;
    end
    % set data source =====================================================
    
    % set view information
    global rangeType;
    rangeType = 2;
    viwer_name = get(handles.viewer,'name');
    if ~strcmp(viwer_name,'NIRS_KIT_BlockAverage')
        set(handles.rangeType,'value',2);
        set(handles.rangeLeft,'string','1');
        set(handles.rangeRight,'string',num2str(size(nirsdata.oxyData,1)));
    end
    
    set(handles.raw,'value',1);
    set(handles.preprocessed,'value',0,'enable','off');
    set(handles.singleMode,'value',1);
    set(handles.multipleMode,'value',0);
    set(handles.oxy,'value',1);
    set(handles.dxy,'value',0);
    set(handles.total,'value',0);
    set(handles.mean,'value',0,'enable','off');
    set(handles.meanOnly,'value',0,'enable','off');
    set(handles.channel,'string',1);

%     set(handles.step_segment,'value',1);
%     set(handles.step_detrend,'value',2);
%     set(handles.order,'string','1');
%     set(handles.step_motioncorrection,'value',3);
%     set(handles.method_mc,'value',1);
%     set(handles.step_bandpassfilter,'value',4);
%     set(handles.bandlow,'string','0.01');
%     set(handles.bandhigh,'string','0.08');
    
    set(handles.preprocess,'enable','on');
    set(handles.axestimeseries,'YLimMode','auto');
    set(handles.axestimeseries,'XGrid','on');
    set(handles.legnedControl,'state','on');
    try
        set(handles.ylimAxesf,'string','');
    end
    %     ylimAxesf = ylim(handles.axesfreqspectrum);
    %     set(handles.ylimAxesf,'string',ylimAxesf(2));
    % generate button pannel
    N = nirsdata.nch;
    Row = floor(N/10);
    maxM = 6;
    maxN = 10;
    Ratio = 6; 
    ButtonSize=[Ratio*1/(maxN*Ratio+maxN+1),Ratio*1/(maxM*Ratio+maxM+1)];
    GapSize=[1/(maxN*Ratio+maxN+1),1/(maxM*Ratio+maxM+1)];
    
    probe2d = nirsdata.probe2d;
    global Probe2D;
    if ~isempty(Probe2D) 
        probe2d = Probe2D;
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
        
        viwer_name = get(handles.viewer,'name');
        if strcmp(viwer_name,'NIRS_KIT_BlockAverage')
            handles_button = NR_buttons_create(handles.channelPanel, handles, LeftbottomPositon, ButtonSize, @BA_channelControl);
        else
            handles_button = NR_buttons_create(handles.channelPanel, handles, LeftbottomPositon, ButtonSize, @NR_channelControl);
        end
        
        set(handles.channelPanel,'UserData',handles_button);
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
        
        viwer_name = get(handles.viewer,'name');
        if strcmp(viwer_name,'NIRS_KIT_BlockAverage')
            handles_button = NR_buttons_create(handles.channelPanel, handles, LeftbottomPositon, ButtonSize, @BA_channelControl);
        else
            handles_button = NR_buttons_create(handles.channelPanel, handles, LeftbottomPositon, ButtonSize, @NR_channelControl);
        end

        set(handles.channelPanel,'UserData',handles_button);
        set(handles_button(1),'BackgroundColor',[0.7,0.7,1]);        
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
