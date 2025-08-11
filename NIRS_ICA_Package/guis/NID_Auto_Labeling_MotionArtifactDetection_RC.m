function [Label_data,RunningCorr] = NID_Auto_Labeling_MotionArtifactDetection_RC(handles,nirsData,rc_thres)
%% datain
oxydata = nirsData.oxyData;
dxydata = nirsData.dxyData;
%
[nsample,nch] = size(oxydata);
T = nirsData.T;
%% parameter
hw_t = 5;     % unit "second"
hw = hw_t*(1/T);
%%
Label_data = zeros(nsample,nch);
RunningCorr = zeros(nsample,nch);

for ch = 1:nch
    oxyd = oxydata(:,ch);
    dxyd = dxydata(:,ch);
    % preprocessing
    [oxyd, ActualBandFrequency] = nic_BandPassFilter_zyj(oxyd,1/T,[0.01,0.5]);
    [dxyd, ActualBandFrequency] = nic_BandPassFilter_zyj(dxyd,1/T,[0.01,0.5]);
    %
    [Label_data(:,ch),RunningCorr(:,ch)] = Running_Corr(oxyd,dxyd,hw,rc_thres);
end
%%
end

function [lb,rc] = Running_Corr(data1,data2,half_win,rc_thres)
len = length(data1);
lb = zeros(len,1);
rc = zeros(len,1);

for i = 1:len
    if i <= half_win
        rc(i) = corr(data1(1:i+half_win),data2(1:i+half_win));
    elseif i >= len-half_win
        rc(i) = corr(data1(i-half_win:end),data2(i-half_win:end));
    else
        rc(i) = corr(data1(i-half_win:i+half_win),data2(i-half_win:i+half_win));
    end
    
    if rc(i) > rc_thres
        lb(i) = 1;
    end
end

end