function NR_channelControl(hObject, eventdata, handles,handles_button,k,lr)
%% set button state

if strcmp(lr,'leftclick')
    % handles: control pannel's handle while leftclick
    N = length(handles_button);
    s = get(handles_button(k), 'BackgroundColor');
    if get(handles.singleMode,'value') == 1
        for i=1:N
            set(handles_button(i), 'BackgroundColor',[0.941,0.941,0.941]);
        end
        set(handles_button(k), 'BackgroundColor',[0.7,0.7,1]);
    else
        if get(handles.multipleMode,'value') == 1
            if(s(1)==0.941) % black, not selected   
                set(handles_button(k), 'BackgroundColor',[0.7,0.7,1]);
            else % red, selected
                set(handles_button(k), 'BackgroundColor',[0.941,0.941,0.941]);
            end
        end
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
        NR_drawTimeseries(handles);
        NR_drawFreqspectrum(handles);
        
elseif strcmp(lr,'rightclick')
    % handles: control pannel's handle while leftclick
    N = length(handles_button);
    s = get(handles_button(k), 'ForegroundColor');
    
    if s(1) == 0
        choice = questdlg({'Do you want to label this channel';'as an exceptional one?'},'Label an exception','Yes','No','Yes');

        if strcmp(choice,'Yes')
            set(handles_button(k), 'ForegroundColor',[0.753,0.753,0.753]);

            data = get(handles.axestimeseries,'userdata');
            nirsdata = data.raw;
            if ~isfield(data.raw,'exception_channel')                
                nirsdata.exception_channel = zeros(1,nirsdata.nch);
            end
            nirsdata.exception_channel(k) = 1;

            try
                subid=get(handles.sublistbox,'value');
                subname=get(handles.sublistbox,'string');
                inpath=get(handles.addpath,'userdata');
                subfile=fullfile(inpath,[subname{subid},'.mat']);
            catch
                subfile=get(handles.viewer,'userdata');
            end
            save(subfile,'nirsdata');
            data.raw = nirsdata;
            set(handles.axestimeseries,'userdata',data);
        end
    elseif s(1) == 0.753
    
        choice = questdlg({'Do you want to cancel this'; 'exceptional channel?'},'Label an exception','Yes','No','Yes');
        if strcmp(choice,'Yes')
            set(handles_button(k), 'ForegroundColor',[0,0,0]);
            
            data = get(handles.axestimeseries,'userdata');
            nirsdata = data.raw;
            if ~isfield(data.raw,'exception_channel')                
                nirsdata.exception_channel = zeros(1,nirsdata.nch);
            end
            nirsdata.exception_channel(k) = 0;

            try
                subid=get(handles.sublistbox,'value');
                subname=get(handles.sublistbox,'string');
                inpath=get(handles.addpath,'userdata');
                subfile=fullfile(inpath,[subname{subid},'.mat']);
            catch
                subfile=get(handles.viewer,'userdata');
            end
            save(subfile,'nirsdata');
            data.raw = nirsdata;
            set(handles.axestimeseries,'userdata',data);
        end
    end
    
   
end

end

