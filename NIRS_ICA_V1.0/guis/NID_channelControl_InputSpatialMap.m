function NID_channelControl_InputSpatialMap(hObject, eventdata, handles,handles_button,k)
%%
% 该函数属于“空间模板设置界面 NID_Input_SpatialMap”中“NID_Input_SpatialMap_CreateFuntion”
% 设置界面中，光极板按键的回调函数
%% set button state
% handles: control pannel's handle
N = length(handles_button);
s = get(handles_button(k), 'BackgroundColor');

if s(1)==0.941 % black, not selected 
    set(handles_button(k), 'BackgroundColor',[0.71,0.71,1],'Value',0);
else % red, selected
    set(handles_button(k), 'BackgroundColor',[0.941,0.941,0.941],'Value',0);
end

%% get all control state and draw
    % 获取已经选中的通道编号
    K = zeros(1,N);
    for i=1:N
        s = get(handles_button(i), 'BackgroundColor');
        if s(1) == 0.71;
            K(i) = 1;
        end
    end
    K = find(K>0);
    
    table_info = get(handles.uitable1,'Userdata'); 
    cur_select = table_info.select;
    spatialMap = get(handles.select_channel_list,'Userdata');
    spatialMap{cur_select} = K;
    
    if isempty(K)
        set(handles.select_channel_list,'string',''); 
    else
        set(handles.select_channel_list,'string',num2str(K));
    end
    
    set(handles.select_channel_list,'Userdata',spatialMap);
end

