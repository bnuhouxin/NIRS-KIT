function NID_SR_nirsdata_drawTimeseries(handles)
%% 去噪结果预览界面“NID_Preview“中，画出成分时间序列
% check
K = str2num(get(handles.nirs_data_channel,'string'));
if isempty(K)
    cla(handles.nirs_data_timeserial);
    return;
end
if 1 == get(handles.nirs_data_singlemode,'value') && length(K) > 1
    errordlg('Cannot draw multiple channels in single mode', 'Error');
end

data = get(handles.uipannel_processed_nirsdata,'userdata');
nirsdataRaw = data.raw;

cla(handles.nirs_data_timeserial);
hold(handles.nirs_data_timeserial,'on');
set(handles.nirs_data_timeserial,'YLimMode','auto');
T = nirsdataRaw.T;
%% Time range or Scan range？
if get(handles.rangeType,'value') == 1
    xAxes=1:length(nirsdataRaw.oxyData);
    xAxes=xAxes*T;
else
    xAxes=1:length(nirsdataRaw.oxyData);
end
rangeLeft = str2num(get(handles.rangeLeft,'string'));
rangeRight = str2num(get(handles.rangeRight,'string'));
set(handles.nirs_data_timeserial,'XLim',[rangeLeft,rangeRight]);
%% Single channel or multiple channels？
h = [];
if 1 == get(handles.nirs_data_singlemode,'value') == 1  % single mode
    if 1==get(handles.raw_nirsdata,'value')  % raw data
        if 1 == get(handles.nirs_data_oxy,'value')
            timeData = nirsdataRaw.oxyData(:,K);
            h_oxy = plot(handles.nirs_data_timeserial,xAxes,timeData,'r');
            set(h_oxy,'DisplayName','Oxy');
            h = [h;h_oxy];
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataRaw.dxyData(:,K);
            h_dxy = plot(handles.nirs_data_timeserial,xAxes,timeData,'b');
            set(h_dxy,'DisplayName','Dxy');
            h = [h;h_dxy];
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataRaw.totalData(:,K);
            h_total = plot(handles.nirs_data_timeserial,xAxes,timeData,'g');
            set(h_total,'DisplayName','Total');
            h = [h;h_total];
        end
    end
    if 1==get(handles.ics_removed,'value')  % preprocessed data
        nirsdataPre = data.preprocessed;
        xAxesPre = xAxes;
        color_oxy = 'r';  color_dxy = 'b';  color_total = 'g';
        if 1==get(handles.raw_nirsdata,'value')
            color_oxy = [1 0 1];  color_dxy = [1 0 1];  color_total = [1 0 1];
            color_oxy_before = [0 1 1];  color_dxy_before = [0 1 1];  color_total_before = [0 1 1];
        end
        if 1 == get(handles.nirs_data_oxy,'value')
            timeData = nirsdataPre.oxyData(:,K);
            h_oxy_preprocessed = plot(handles.nirs_data_timeserial,xAxesPre,timeData,'color',color_oxy,'linewidth',1);
            set(h_oxy_preprocessed,'DisplayName',' Oxy(After)');
            h = [h;h_oxy_preprocessed];
            %
            if 1==get(handles.raw_nirsdata,'value')
                set(h_oxy,'DisplayName',' Before','Color',color_oxy_before);
                set(h_oxy_preprocessed,'DisplayName',' After');
            end
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataPre.dxyData(:,K);
            h_dxy_preprocessed = plot(handles.nirs_data_timeserial,xAxesPre,timeData,'color',color_dxy,'linewidth',1);
            set(h_dxy_preprocessed,'DisplayName',' Dxy(After)');
            h = [h;h_dxy_preprocessed];
            %
            if 1==get(handles.raw_nirsdata,'value')
                set(h_dxy,'DisplayName',' Before','Color',color_dxy_before);
                set(h_dxy_preprocessed,'DisplayName',' After');
            end
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataPre.totalData(:,K);
            h_total_preprocessed = plot(handles.nirs_data_timeserial,xAxesPre,timeData,'color',color_total,'linewidth',1);
            set(h_total_preprocessed,'DisplayName',' Total(After)');
            h = [h;h_total_preprocessed];
            %
            if 1==get(handles.raw_nirsdata,'value')
                set(h_total,'DisplayName',' Before','Color',color_total_before);
                set(h_total_preprocessed,'DisplayName',' After');
            end
        end
    end
else  % multiple mode 
    color = data.color;
    if 1==get(handles.raw_nirsdata,'value')  % raw data
        if(1==get(handles.nirs_data_oxy,'value'))
            timeData = nirsdataRaw.oxyData(:,K);
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataRaw.dxyData(:,K);
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataRaw.totalData(:,K);
        end
        for i=1:length(K)
            h(i,1) = plot(handles.nirs_data_timeserial,xAxes,timeData(:,i),'color',color(K(i),:));
            set(h(i),'DisplayName',['Ch ' num2str(K(i)),' Before']);
        end
    end
    if 1==get(handles.ics_removed,'value')    % preprocessed data
        nirsdataPre = data.preprocessed;
        xAxesPre = xAxes;
        if(1==get(handles.nirs_data_oxy,'value'))
            timeData = nirsdataPre.oxyData(:,K);
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataPre.dxyData(:,K);
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataPre.totalData(:,K);
        end
        for i=1:length(K)
            h(i,1) = plot(handles.nirs_data_timeserial,xAxesPre,timeData(:,i),'color',color(K(i),:),'linewidth',1);
            set(h(i),'DisplayName',['Ch ' num2str(K(i)) ' After']);
        end
    end
end
%% legend 

children = get(handles.nirs_data_timeserial,'Children');
children = sort(children);
obj = findobj('Tag','nirs_legend');
set(obj,'Value',1)
val = get(obj,'Value');
if ~isempty(children)
    if val == 1
        dispname = get(children,'DisplayName');
        lg = legend(handles.nirs_data_timeserial,dispname);
        set(lg,'FontSize',9)
    else
        legend(handles.nirs_data_timeserial,'off');
    end
else
    set(obj,'Value',0);
end

end
