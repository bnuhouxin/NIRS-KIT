function [icnum_aic,icnum_bic] = NID_get_aicbic(handles)
%% RSS
RSS = NID_get_aicbic_RSS(handles);
%% load data
dataIn = get(handles.NIRS_ICA_Denoiser_open_file_and_ICA_config,'UserData');
ch = dataIn.nirs_data.nch;
sp = length(dataIn.nirs_data.oxyData(:,1));
%% aicbic
aic_p = cal_aic(RSS,(1:ch)*ch,sp*ones(1,ch));
bic_p = cal_bic(RSS,(1:ch)*ch,sp*ones(1,ch));
% [aic_p,bic_p] = aicbic(RSS,1:ch,sp*ones(1,ch));
%%
[xx1,zz1] = min(aic_p);
icnum_aic = zz1;

[xx2,zz2] = min(bic_p);
icnum_bic = zz2;
end

function aic_data = cal_aic(RSS,K,Sample)
aic_data =  Sample.*log(RSS./Sample) + 2*K + (2*K.*(K+1)./(Sample-K-1));
% aic_data =  Sample.*log(RSS) + 2*K + (2*K.*(K+1)./(Sample-K-1));
end

function bic_data = cal_bic(RSS,K,Sample)
bic_data = Sample.*log(RSS./Sample)+K.*log(Sample);
% bic_data = Sample.*log(RSS)+K.*log(Sample);
end