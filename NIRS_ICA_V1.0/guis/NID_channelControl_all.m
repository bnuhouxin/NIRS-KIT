function NID_channelControl_all(handles)
%% set button state
% handles: control pannel's handle
handles_button = get(handles.nirs_data_channel_pannel,'UserData');
N = length(handles_button);
if 1==get(handles.nirs_data_singlemode,'value')
    errordlg('Cannot draw multiple channels in single mode', 'Error');
    return;
end
for hnd=handles_button
    set(hnd, 'BackgroundColor',[0.7,0.7,1]);
end


%% get all control state and draw
%     set(handles.oxy,'value',get(handles.oxy,'value'));
%     set(handles.dxy,'value',get(handles.dxy,'value'));
%     set(handles.total,'value',get(handles.total,'value'));
%     set(handles.singleMode,'value',get(handles.singleMode,'value'));
%     set(handles.multipleMode,'value',get(handles.multipleMode,'value'));
%     set(handles.mean,'value',get(handles.mean,'value'));
%     set(handles.meanOnly,'value',get(handles.meanOnly,'value'));
    K = zeros(1,N);
    for i=1:N
        s = get(handles_button(i), 'BackgroundColor');
        if s(1) == 0.7;
            K(i) = 1;
        end
    end
    K = find(K>0);
    if isempty(K)
        set(handles.nirs_data_channel,'string',''); 
    else
        set(handles.nirs_data_channel,'string',num2str(K));
    end
    %draw
    NIRS_ICA_nirsdata_drawTimeseries(handles)
    NIRS_ICA_nirsdata_drawFreq(handles)
end

