function NR_channelControl_increase(handles)
%% set button state
% handles: control pannel's handle
if 1==get(handles.multipleMode,'value')
    errordlg('Cannot increase at multiple mode', 'Error');
    return;
end
handles_button = get(handles.channelPanel,'UserData');
K = str2num(get(handles.channel,'string'));
KA1 = K+1;
if KA1==length(handles_button)+1
    KA1=1;
end
set(handles_button(K),'backgroundcolor',[0.941,0.941,0.941])
set(handles.channel,'string',KA1);
set(handles_button(KA1),'backgroundcolor',[0.7,0.7,1])

viwer_name = get(handles.viewer,'name');
if ~strcmp(viwer_name,'NIRS_KIT_BlockAverage')
    NR_drawTimeseries(handles);
    NR_drawFreqspectrum(handles);
else
    BA_drawTimeseries(handles);
end
