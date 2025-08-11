function varargout = NID_Save_IC_Reserve(handles)

% save data path
outpath = get(handles.edit7,'String');
subfiln=get(handles.listbox1,'string');
subid=get(handles.listbox1,'value');

%
icreserve = str2num(get(handles.text7,'String'));
%
obj = findobj('Tag','NIRS_ICA_Denoiser');

NIDhandles = guihandles(obj);
data = get(NIDhandles.NIRS_ICA_Denoiser,'Userdata');
hbtype = data.hbType;

raw_icdata = data.IC;
icdata = getfield(raw_icdata,hbtype);
% ic reserved nirsdata
TC = icdata.TC;
SM = icdata.SM;

switch hbtype
    case 'OXY'
        indexdata.signal_type = 'Oxy';
    case 'DXY'
        indexdata.signal_type = 'Dexy';
    case 'TOTAL'
        indexdata.signal_type = 'Total';
end
indexdata.index=SM(:,icreserve)';
%z-transform
indexdata.index=(indexdata.index-mean(indexdata.index))/std(indexdata.index);

indexdata.probe2d=data.nirs_data.probe2d;
if isfield(data.nirs_data,'probe3d')
    indexdata.probe3d=data.nirs_data.probe3d;
end

if isfield(data.nirs_data,'exclusive_channel')
    indexdata.exclusive_channel = data.nirsdata.exclusive_channel;
end

indexdata.subname=subfiln{subid};

IC = data.IC;
IC.selectedic=icreserve;
nirsdata = data.nirs_data;
save([outpath filesep subfiln{subid}],'indexdata','IC','nirsdata')
disp('Successfully saved!')

end
