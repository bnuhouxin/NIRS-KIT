function NID_Detail_IC_drawFreq_Reserve(handles,NIDhandles)
% check
icdata = get(handles.ic_data_timeserials,'userdata');

icRaw = icdata.time;

cla(handles.ic_data_freq);
hold(handles.ic_data_freq,'on');
set(handles.ic_data_freq,'XScale','log');
set(handles.ic_data_freq,'YLimMode','auto');
%
datain = get(NIDhandles.NIRS_ICA_Denoiser,'userdata');
nirsdata = datain.nirs_data;
if isfield(nirsdata,'T')
    T =  nirsdata.T;
else
    T =  1/nirsdata.fs;
end
%%
h=[];
timeData = icRaw;
[freqData,freqAxes] = computeFreq(timeData,T);
% h_oxy = plot(handles.ic_data_freq,freqAxes,freqData,'k');
h_oxy = semilogx(handles.ic_data_freq,freqAxes,freqData,'k');

%% set x-coordinate
% legend(h);
set(handles.ic_data_freq,'XTick',[0,0.01,0.1,1]);
set(handles.ic_data_freq,'XGrid','on');
xlim(handles.ic_data_freq,[0,3]);

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
% button_color = {[0.941,0.941,0.941]};
cnt = 0;
hinck_all = get(handles.uipanel_bl,'Userdata');
if ~isempty(hinck_all)
    for i = 1:length(hinck_all)
        hinck = hinck_all(i);
        name = get(hinck,'String');
        val = get(hinck,'Value');
        datain = get(hinck,'Userdata');
        if isfield(datain.index,'design') %displaying the temporal template
            data = datain.index.design;
            numSort = datain.num;
            [freqData1,freqAxes1] = computeFreq(data,T);
            %
            max_ic_scale = max(freqData);
            max_des_scale = max(freqData1);
            freqData1 = freqData1 ./ max_des_scale .* max_ic_scale;
            %
            if ismember(numSort,[3,4])
                if val == 1
                    cnt = cnt+1;
                    hold(handles.ic_data_freq,'on')
                    h1 = semilogx(handles.ic_data_freq,freqAxes1,freqData1,'Color',design_color{cnt});
                    set(h1,'DisplayName',name,'Linewidth',2);
                end
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
