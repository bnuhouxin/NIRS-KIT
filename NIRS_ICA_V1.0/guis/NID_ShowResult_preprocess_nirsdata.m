function NID_ShowResult_preprocess_nirsdata(NIDHandles,SRHandles)
%% �����ڽ��Ԥ��ģ�飬�����ݽ���ICAȥ��
%%
dataIn = get(NIDHandles.NIRS_ICA_Denoiser,'UserData');
hbType = dataIn.hbType;
%
tmp = get(SRHandles.nirs_data_timeserial,'UserData');
nirs_data = tmp.raw;
process_data  = tmp.raw;
color = tmp.color;
%
IC = dataIn.IC;
selectedIC = get(SRHandles.edit28,'String');
%% precessed nirsdata
    sIC = str2num(selectedIC);
    icremove = sIC;
    nirs_data_new_remove = caculate_nirsdata(icremove,IC,hbType);
    if strcmp(hbType,'OXY')
        process_data.oxyData = nirs_data_new_remove;
    elseif strcmp(hbType,'DXY')
        process_data.dxyData = nirs_data_new_remove;
    else
        process_data.totalData = nirs_data_new_remove;
    end
%%
data.raw = nirs_data;
data.color = color;
data.preprocessed = process_data;
set(SRHandles.uipannel_processed_nirsdata,'UserData',data)
end

%% Calculate the data aftering noise sources removed
function nirs_data = caculate_nirsdata(icremove,ic,hbType)
icall = getfield(ic,hbType);
IC = icall.TC;
A = icall.SM;
%
Anew = A;
Anew(:,icremove) = 0;

nirs_data = IC*Anew';
end