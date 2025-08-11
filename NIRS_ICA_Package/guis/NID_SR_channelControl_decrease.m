function NID_SR_channelControl_decrease(handles)
%% set button state
% handles: control pannel's handle
if 1==get(handles.nirs_data_multiplemode,'value')
    errordlg('Cannot decrease at multiple mode', 'Error');
    return;
end
handles_button = get(handles.nirs_data_channel_pannel,'UserData');
K = str2num(get(handles.nirs_data_channel,'string'));
KA1 = K-1;
if KA1 == 0
    KA1=length(handles_button);
end
set(handles_button(K),'backgroundcolor',[0.941,0.941,0.941])
set(handles.nirs_data_channel,'string',KA1);
set(handles_button(KA1),'backgroundcolor',[0.7,0.7,1])
NID_SR_nirsdata_drawTimeseries(handles)
NID_SR_nirsdata_drawFreq(handles)
