function NID_nirsdata_drawFreq(handles)
% check
K = str2num(get(handles.nirs_data_channel,'string'));
if isempty(K)
    cla(handles.nirs_data_freq);
    return;
end
% if 1 == get(handles.nirs_data_singlemode,'value') && length(K) > 1
%     errordlg('Cannot draw multiple channels in single mode', 'Error');
% end
data = get(handles.uipanel_bl,'userdata');
nirsdataRaw = data.raw;
cla(handles.nirs_data_freq);
hold(handles.nirs_data_freq,'on');
set(handles.nirs_data_freq,'XScale','log');
set(handles.nirs_data_freq,'YLimMode','auto');
T = nirsdataRaw.T;
%% Single channel or multiple channels��
% Draw frequency
K = str2num(get(handles.nirs_data_channel,'string'));
if isempty(K)
    return;
end
h=[];
if 1 == get(handles.nirs_data_singlemode,'value')  % single channels
    if 1==get(handles.show_bl,'value')  % raw data
        if(1==get(handles.nirs_data_oxy,'value'))
            timeData = nirsdataRaw.oxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_oxy = semilogx(handles.nirs_data_freq,freqAxes,freqData,'r');
            h = [h;h_oxy];
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataRaw.dxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_dxy = semilogx(handles.nirs_data_freq,freqAxes,freqData,'b');
            h = [h;h_dxy];
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataRaw.totalData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_total = semilogx(handles.nirs_data_freq,freqAxes,freqData,'g');
            h = [h;h_total];
        end
    end
    if 1 == get(handles.show_bl_remove,'value')  % preprocessed data
        nirsdataPre = data.preprocessed;
        color_oxy = 'r';  color_dxy = 'b';  color_total = 'g';
        if 1==get(handles.show_bl,'value')
            color_oxy = [3/4 3/4 1/4];  color_dxy = 'm';  color_total = 'k';
        end
        if 1 == get(handles.nirs_data_oxy,'value')
            timeData = nirsdataPre.oxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_oxy_preprocessed = semilogx(handles.nirs_data_freq,freqAxes,freqData,'color',color_oxy,'linewidth',2);
            %         set(h_dxy_preprocessed,'DisplayName','Oxy(p)');
            h = [h;h_oxy_preprocessed];
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataPre.dxyData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_dxy_preprocessed = semilogx(handles.nirs_data_freq,freqAxes,freqData,'color',color_dxy,'linewidth',2);
            %         set(h_dxy_preprocessed,'DisplayName','Dxy(p)');
            h = [h;h_dxy_preprocessed];
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataPre.totalData(:,K);
            [freqData,freqAxes] = computeFreq(timeData,T);
            h_total_preprocessed = semilogx(handles.nirs_data_freq,freqAxes,freqData,'color',color_total,'linewidth',2);
            set(h_total_preprocessed,'DisplayName','Total(p)');
            h = [h;h_total_preprocessed];
        end
    end
else  % multiple channel
    color = data.color;
    if 1==get(handles.show_bl,'value')  % raw data
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
            h(i,1) = semilogx(handles.nirs_data_freq,freqAxes,freqData,'color',color(K(i),:));
        end
    end
    if 1==get(handles.nirs_data_singlemode,'value')  % raw data
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
            h(i,1) = semilogx(handles.nirs_data_freq,freqAxes,freqData,'color',color(K(i),:));
        end
    end
end
%% draw mean of not?
% with mean
% if get(handles.multipleMode,'value') == 1 && ( get(handles.mean,'value')==1 || get(handles.meanOnly,'value')==1 )
%     if get(handles.meanOnly,'value')==1   % mean only
%         cla(handles.nirs_data_freq);
%         legend(handles.nirs_data_freq,'off');
%     end
%     K = str2num(get(handles.channel,'string'));
%     if ~isempty(K)
%         if 1==get(handles.show_bl,'value')  % raw data
%             if(1==get(handles.nirs_data_oxy,'value'))
%                 timeData_mean = mean(nirsdataRaw.oxyData(:,K),2);
%                 [freqData,freqAxes] = computeFreq(timeData_mean,T);
%                 h_mean = semilogx(handles.nirs_data_freq,freqAxes,freqData,'Color',[255/255 127/255 0/255]');
%             end
%             if(1==get(handles.nirs_data_dxy,'value'))
%                 timeData_mean = mean(nirsdataRaw.dxyData(:,K),2);
%                 [freqData,freqAxes] = computeFreq(timeData_mean,T);
%                 h_mean = semilogx(handles.nirs_data_freq,freqAxes,freqData,'Color',[255/255 127/255 0/255]);
%             end
%             if(1==get(handles.nirs_data_total,'value'))
%                 timeData_mean = mean(nirsdataRaw.totalData(:,K),2);
%                 [freqData,freqAxes] = computeFreq(timeData_mean,T);
%                 h_mean = semilogx(handles.nirs_data_freq,freqAxes,freqData,'Color',[255/255 127/255 0/255]);
%             end
%             h = [h;h_mean];
%         else
%             nirsdataPre = data.preprocessed;
%             if(1==get(handles.nirs_data_oxy,'value'))
%                 timeData_mean = mean(nirsdataPre.oxyData(:,K),2);
%                 [freqData,freqAxes] = computeFreq(timeData_mean,T);
%                 h_mean_preprocessed = semilogx(handles.nirs_data_freq,freqAxes,freqData,'Color',[255/255 127/255 0/255],'linewidth',2);
%             end
%             if(1==get(handles.nirs_data_dxy,'value'))
%                 timeData_mean = mean(nirsdataPre.dxyData(:,K),2);
%                 [freqData,freqAxes] = computeFreq(timeData_mean,T);
%                 h_mean_preprocessed = semilogx(handles.nirs_data_freq,freqAxes,freqData,'Color',[255/255 127/255 0/255],'linewidth',2);
%             end
%             if(1==get(handles.nirs_data_total,'value'))
%                 timeData_mean = mean(nirsdataPre.totalData(:,K),2);
%                 [freqData,freqAxes] = computeFreq(timeData_mean,T);
%                 h_mean_preprocessed = semilogx(handles.nirs_data_freq,freqAxes,freqData,'Color',[255/255 127/255 0/255],'linewidth',2);
%             end
%             h = [h;h_mean_preprocessed];
%         end
%     end
% end

%% draw block/ER task design and referece wave
% % draw block/ER design
% if isfield(handles,'Task_Opt_Pannel')
%     usd=get(handles.Task_Opt_Pannel,'userdata');
%     handles.usercond=usd{1,1};
%     handles.onset=usd{2,1};
%     handles.dur=usd{3,1};
%     
%     if ~isempty(handles.usercond) && ~isempty(handles.onset) && get(handles.showDesign,'value') == 1
%         numtp=length(nirsdataRaw.vector_onset);
%         condname={};
%         
%         if get(handles.Units,'value')==2
%             for dd=1:length(handles.onset)
%                 handles.onset{dd}=handles.onset{dd}./T;
%                 handles.dur{dd}=handles.dur{dd}./T;
%             end
%         end
%         
%         for ii=1:length(handles.usercond)
%             condname=[condname;['Cond',num2str(handles.usercond(ii))]];
%         end
%         
%         colset={[209,232,208],[65,162,74];[238,228,240],[143,76,154];[178,203,223],[55,120,173];[231,136,137],[214,37,31];[251,221,191],[239,124,28]};
%         if length(handles.usercond) > 5
%             colset=repmat(colset,ceil(length(handles.usercond)/5),1);
%         end
%         
%         for cond_num=1:length(handles.usercond)
%             cond_mtx=zeros(1,numtp);
%             timeOn = handles.onset{handles.usercond(cond_num)};
%             timeDu = handles.dur{handles.usercond(cond_num)};
%             
%             ndesign = length(timeOn);
%             if timeOn(end)+timeDu(end) > numtp
%                 errordlg('The length of the design matrix is beyond the dimension of sub timepoint !!!    Please re-add !!!','Input wrong!');
%             else
%                 for trailn=1:1:ndesign
%                     cond_mtx(1,round(timeOn(trailn)):round(timeOn(trailn)+timeDu(trailn)))=1;
%                 end
%                 [hrf,~] = spm_hrf(T);
%                 refwave=conv(cond_mtx,hrf);
%                 refwave=refwave(1,1:numtp);
%                 
%                 
%                 [freqData,freqAxes] = computeFreq(refwave',T);
%                 h_cond = semilogx(handles.nirs_data_freq,freqAxes,freqData,'--','Color',colset{cond_num,2}/255,'LineWidth',2);
%             end
%         end
%         %     h=[h,h_cond];
%     end
% end
%% set x-coordinate
% legend(h);
set(handles.nirs_data_freq,'XTick',[0,0.01,0.1,1]);
set(handles.nirs_data_freq,'XGrid','on');

xlim(handles.nirs_data_freq,[0,3]);
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

if size(timeData,1)==1
    timeData=timeData';
end

L = size(timeData,1);
Fs=1/T;


paddedLength = rest_nextpow2_one35(L); %2^nextpow2(sampleLength);
timeData = [timeData;zeros(paddedLength -L,size(timeData,2))]; %padded with zero


Y = fft(timeData); %Compute the Fourier transform of the signal.

P2 = abs(Y/L); % two-sided spectrum P2
P1 = P2(1:paddedLength/2+1);
P1(2:end-1) = 2*P1(2:end-1);

freqData=P1;
f = Fs*(0:(paddedLength/2))/paddedLength;
freqAxes = f;


end
