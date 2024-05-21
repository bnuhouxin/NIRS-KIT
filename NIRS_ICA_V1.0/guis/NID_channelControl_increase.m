function NID_channelControl_increase(handles)
%% set button state
% handles: control pannel's handle
if 1==get(handles.nirs_data_multiplemode,'value')
    errordlg('Cannot increase at multiple mode', 'Error');
    return;
end
handles_button = get(handles.nirs_data_channel_pannel,'UserData');
K = str2num(get(handles.nirs_data_channel,'string'));
KA1 = K+1;
if KA1==length(handles_button)+1
    KA1=1;
end
set(handles_button(K),'backgroundcolor',[0.941,0.941,0.941])
set(handles.nirs_data_channel,'string',KA1);
set(handles_button(KA1),'backgroundcolor',[0.7,0.7,1])
NIRS_ICA_nirsdata_drawTimeseries(handles)
NIRS_ICA_nirsdata_drawFreq(handles)
