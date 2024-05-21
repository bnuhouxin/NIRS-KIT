function NID_channelControl_clear(handles)
%% set button state
% handles: control pannel's handle
handles_button = get(handles.nirs_data_channel_pannel,'UserData');
N = length(handles_button);
for hnd=handles_button
    set(hnd, 'BackgroundColor',[0.941,0.941,0.941]);
end
legend(handles.nirs_data_timeserial,'off');

%% get all control state and draw
    set(handles.nirs_data_oxy,'value',get(handles.nirs_data_oxy,'value'));
    set(handles.nirs_data_dxy,'value',get(handles.nirs_data_dxy,'value'));
    set(handles.nirs_data_total,'value',get(handles.nirs_data_total,'value'));
    set(handles.nirs_data_singlemode,'value',get(handles.nirs_data_singlemode,'value'));
    set(handles.nirs_data_multiplemode,'value',get(handles.nirs_data_multiplemode,'value'));

    K = zeros(1,N);
    for i=1:N
        s = get(handles_button(i), 'BackgroundColor');
        if s(1) == 1;
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

