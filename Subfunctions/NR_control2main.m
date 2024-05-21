function NR_control2main(handles)
%% get all control state
handles_button = get(handles.channelPanel,'userdata');
N = length(handles_button);
%% get all control state
if ~isempty(handles)
    K = zeros(1,N);
    for i=1:N
        color = get(handles_button(i), 'ForegroundColor');
        if color(1) == 1;  % red
            K(i) = 1;
        end
    end
    K = find(K>0);
    if get(handles.singleMode,'value') == 1
        if ~isempty(K)
             get(handles_button(i), 'ForegroundColor');
        else
                
        end
    else
        set(handles.multipleCh,'string',num2str(K));
    end
    NR_drawTimeseries(handles);
    NR_drawFreqspectrum(handles);
else
%not find.fig
errordlg('not found NIRS_REST_Datahandles.fig.','Error');

end