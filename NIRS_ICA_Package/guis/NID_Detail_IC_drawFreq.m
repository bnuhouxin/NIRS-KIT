function NID_Detail_IC_drawFreq(handles)
%% ������ģʽDetail���棬��IC�ɷ�����Ƶ�׺���

icdata = get(handles.ic_data_timeserials,'userdata');
nirsdata = get(handles.nirs_data_timeserial,'userdata');

icRaw = icdata.time;

cla(handles.ic_data_freq);
hold(handles.ic_data_freq,'on');
set(handles.ic_data_freq,'XScale','log');
set(handles.ic_data_freq,'YLimMode','auto');
T =  nirsdata.raw.T;
%%
h=[];
timeData = icRaw;
[freqData,freqAxes] = computeFreq(timeData,T);
% h_oxy = plot(handles.ic_data_freq,freqAxes,freqData,'k');
h_oxy =semilogx(handles.ic_data_freq,freqAxes,freqData,'k');


%% set x-coordinate
set(handles.ic_data_freq,'XTick',[0,0.01,0.1,1]);
set(handles.ic_data_freq,'XGrid','on');
xlim(handles.ic_data_freq,[0,3]);
% 
% set(handles.ic_data_freq,'XTick',[-2,-1,0]);
% set(handles.ic_data_freq,'XTickLabel',{'0.01','0.1','1'});

ylimAxesf = get(handles.ic_ylimAxesf,'string');
if ~isempty(ylimAxesf)
    if str2num(ylimAxesf) > 0
        ylim(handles.ic_data_freq,[0 str2num(ylimAxesf)]);
    else
        set(handles.ic_ylimAxesf,'string','')
    end
end
hold(handles.ic_data_freq,'off');
%% design info 
design_color = {[0.5,0.5,1],[0.851,0.325,0.098],[1,0,1],[0.25,0.25,0.25],[0.855,0.702,1],...
    [0.678,0.922,1],[0.349,0.2,0.329],[0.871,0.49,0]};

cnt = 0;
hinck_all = get(handles.panel_ic_data,'Userdata');
if ~isempty(hinck_all)
    for i = 1:length(hinck_all)
        hinck = hinck_all(i);
        name = get(hinck,'String');
        val = get(hinck,'Value');
        datain = get(hinck,'Userdata');
        data = datain.index;
        numSort = datain.num;
        %
        if ismember(numSort,[3,4])
            if val == 1
                cnt = cnt+1;
                hold(handles.ic_data_freq,'on')
                % rescale
                mean_timeData = mean(timeData);
                data = ( data-mean(data) )/std(data);
                data = mean_timeData + data;

                [freqData1,freqAxes1] = computeFreq(data,T);
                h1 = plot(handles.ic_data_freq,freqAxes1,freqData1,'Color',design_color{cnt});
                set(h1,'DisplayName',name,'Linewidth',2);
            end
        end
        
    end
end
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