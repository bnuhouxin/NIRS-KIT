function RSS = NID_get_aicbic_RSS(handles)
%% load data
dataIn = get(handles.NIRS_ICA_Denoiser_open_file_and_ICA_config,'UserData');
fs = 1/dataIn.nirs_data.T;
ch = dataIn.nirs_data.nch;
sp = length(dataIn.nirs_data.oxyData(:,1));

%% datatype
RSS = zeros(1,ch);
% oxy
if 1 == get(handles.hbty,'Value')
    data = dataIn.nirs_data.oxyData;
    
    for icnum = 1:ch
        h = waitbar(icnum/ch,['Please wait ...(',num2str(icnum),'/',num2str(ch),')']);
        RSS(icnum) = get_RSS(data,icnum,sp,handles);
        close(h) 
    end
    
end
%dxy
if 2 == get(handles.hbty,'Value')
    data = dataIn.nirs_data.dxyData;
    
    for icnum = 1:ch
        h = waitbar(icnum/ch,['Please wait ...(',num2str(icnum),'/',num2str(ch),')']);
        RSS(icnum) = get_RSS(data,icnum,sp,handles);
        close(h)
    end
    
end
%tot
if 3 == get(handles.hbty,'Value')
    data = dataIn.nirs_data.totalData;
    
    for icnum = 1:ch
        h = waitbar(icnum/ch,['Please wait ...(',num2str(icnum),'/',num2str(ch),')']);
        RSS(icnum) = get_RSS(data,icnum,sp,handles);
        close(h)
    end
    
end
%% 

end

function RSS = get_RSS(data,icnum,sp,handles)
%% do ica
[dataOut]=NID_nirsica_tica(data,icnum,handles);
% IC
ICA_Result.IC = (dataOut.IC)';
ICA_Result.A = dataOut.A;
ICA_Result.numIC = dataOut.numIC;
%%
data_new = ICA_Result.IC*(ICA_Result.A)';
%%
deta_data = data-data_new;
RSS = sum(deta_data.^2,2);
RSS = sum(RSS);
end