function NR_delete(handles)
    % delete a probe
    meshBoxHandle = handles.meshBox;
    channelNumber = str2num(get(obj,'String'));
    if 0 ~= channelNumber
        return;
    end
    if get(handles.source,'value')
        set(obj,'backgroundcolor','r');
        set(obj,'String','-1');
        return;
    end
    if get(handles.detector,'value')
        set(obj,'backgroundcolor','b');
        set(obj,'String','-2');
        return;
    end
    if get(handles.channel,'value')
        set(obj,'backgroundcolor','g');
        userdata=get(meshBoxHandle,'UserData');
        userdata.currentNum = userdata.currentNum + 1;
        set(meshBoxHandle,'UserData',userdata);
        set(obj,'String',num2str(userdata.currentNum));
        return;
    end
end