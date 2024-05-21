function BA_channelControl(hObject, eventdata, handles,handles_button,k,lr)
%% set button state

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
        BA_drawTimeseries(handles);
        


end

