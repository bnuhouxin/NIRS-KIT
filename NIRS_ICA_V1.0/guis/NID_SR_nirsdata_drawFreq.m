function NID_SR_nirsdata_drawFreq(handles)
%% 去噪结果预览界面“NID_Preview“中，画出成分频谱
% check
K = str2num(get(handles.nirs_data_channel,'string'));
if isempty(K)
    cla(handles.nirs_data_freq);
    return;
end
if 1 == get(handles.nirs_data_singlemode,'value') && length(K) > 1
    errordlg('Cannot draw multiple channels in single mode', 'Error');
end
data = get(handles.uipannel_processed_nirsdata,'userdata');
nirsdataRaw = data.raw;
cla(handles.nirs_data_freq);
hold(handles.nirs_data_freq,'on');
% set(handles.nirs_data_freq,'XScale','log');
set(handles.nirs_data_freq,'XGrid','on');
set(handles.nirs_data_freq,'YLimMode','auto');
T = nirsdataRaw.T;
%% Single channel or multiple channels？
% Draw frequency
K = str2num(get(handles.nirs_data_channel,'string'));
if isempty(K)
    return;
end
h=[];
if 1 == get(handles.nirs_data_singlemode,'value')  % single channels
    if 1==get(handles.raw_nirsdata,'value')  % raw data
        if(1==get(handles.nirs_data_oxy,'value'))
            timeData = nirsdataRaw.oxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_oxy = plot(handles.nirs_data_freq,freqAxes,freqData,'r');
            h = [h;h_oxy];
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataRaw.dxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_dxy = plot(handles.nirs_data_freq,freqAxes,freqData,'b');
            h = [h;h_dxy];
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataRaw.totalData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_total = plot(handles.nirs_data_freq,freqAxes,freqData,'g');
            h = [h;h_total];
        end
    end
    if 1 == get(handles.ics_removed,'value')  % preprocessed data
        nirsdataPre = data.preprocessed;
        color_oxy = 'r';  color_dxy = 'b';  color_total = 'g';
        if 1==get(handles.raw_nirsdata,'value')
            color_oxy = [1 0 1];  color_dxy = [1 0 1];  color_total = [1 0 1];
            color_oxy_before = [0 1 1];  color_dxy_before = [0 1 1];  color_total_before = [0 1 1];
        end
        if 1 == get(handles.nirs_data_oxy,'value')
            timeData = nirsdataPre.oxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_oxy_preprocessed = plot(handles.nirs_data_freq,freqAxes,freqData,'color',color_oxy,'linewidth',1);
    %         set(h_dxy_preprocessed,'DisplayName','Oxy(p)');
            h = [h;h_oxy_preprocessed];
            %
            if 1==get(handles.raw_nirsdata,'value')
                set(h_oxy,'DisplayName',' Before','Color',color_oxy_before);
            end
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataPre.dxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_dxy_preprocessed = plot(handles.nirs_data_freq,freqAxes,freqData,'color',color_dxy,'linewidth',1);
    %         set(h_dxy_preprocessed,'DisplayName','Dxy(p)');
            h = [h;h_dxy_preprocessed];
            %
            if 1==get(handles.raw_nirsdata,'value')
                set(h_dxy,'DisplayName',' Before','Color',color_dxy_before);
            end
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataPre.totalData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_total_preprocessed = plot(handles.nirs_data_freq,freqAxes,freqData,'color',color_total,'linewidth',1);
%             set(h_total_preprocessed,'DisplayName','Total(p)');
            h = [h;h_total_preprocessed];
            %
            if 1==get(handles.raw_nirsdata,'value')
                set(h_total,'DisplayName',' Before','Color',color_total_before);
            end
        end
    end
else  % multiple channel
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
            [freqData,freqAxes] = computeFreq(timeData(:,i),T);
            h(i,1) = plot(handles.nirs_data_freq,freqAxes,freqData,'color',color(K(i),:));
        end
    end
    if 1==get(handles.ics_removed,'value')  % raw data
        nirsdataPre = data.preprocessed;
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
            [freqData,freqAxes] = computeFreq(timeData(:,i),T);
            h(i,1) = plot(handles.nirs_data_freq,freqAxes,freqData,'color',color(K(i),:));
        end
    end
end
%% set x-coordinate
% legend(h);
xLimit(1) = min(freqAxes);
xLimit(2) = log10(3);
xlim(handles.nirs_data_freq,[xLimit(1),xLimit(2)]);
set(handles.nirs_data_freq,'XTick',[-2,-1,0]);
set(handles.nirs_data_freq,'XTickLabel',{'0.01','0.1','1'});

ylimAxesf = get(handles.ylimAxesf,'string');
if ~isempty(ylimAxesf)
    if str2num(ylimAxesf) > 0
        ylim(handles.nirs_data_freq,[0 str2num(ylimAxesf)]);
    else
        set(handles.ylimAxesf,'string','')
    end
    
end
hold(handles.nirs_data_freq,'off');

end

function [freqData,freqAxes] = computeFreq(timeData,T)
N = size(timeData,1);
freqData = abs(fft(timeData));
freqData = freqData(1:floor(N/2),:);
freqAxes = 1/T*(0:N-1)/N;
freqAxes = freqAxes(1:floor(N/2));
freqAxes = log10(freqAxes);
end
