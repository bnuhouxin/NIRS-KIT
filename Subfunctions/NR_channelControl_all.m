function NR_channelControl_all(handles)
%% set button state
% handles: control pannel's handle
handles_button = get(handles.channelPanel,'UserData');
N = length(handles_button);
if 1==get(handles.singleMode,'value')
    errordlg('Cannot draw multiple channels in single mode', 'Error');
    return;
end
for hnd=handles_button
    set(hnd, 'BackgroundColor',[0.7,0.7,1]);
end

%% get all control state and draw
    K = zeros(1,N);
    for i=1:N
        s = get(handles_button(i), 'BackgroundColor');
        if s(1) == 0.7;
            K(i) = 1;
        end
    end
    K = find(K>0);
    if isempty(K)
        set(handles.channel,'string',''); 
    else
        set(handles.channel,'string',num2str(K));
    end
    %draw
    viwer_name = get(handles.viewer,'name');
    if ~strcmp(viwer_name,'NIRS_KIT_BlockAverage')
        NR_drawTimeseries(handles);
        NR_drawFreqspectrum(handles);
    else
        BA_drawTimeseries(handles);
    end
end

