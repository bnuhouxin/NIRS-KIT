function NID_Input_SpatialMap_ClearChannel(handles)
%%
% 该函数属于“空间模板设置界面 NID_Input_SpatialMap”
% 用于清空界面中的模板显示区域“channel_pannel”，以便于画出新的模板
%%
% obj = findobj('Tag','NID_Input_SpatialMap');
% SMHandles = guihandles(obj);
button_handles_all = get(handles.channel_pannel,'Userdata');
for i = 1:length(button_handles_all)
    delete(button_handles_all(i));
end
set(handles.channel_pannel,'Userdata','');
set(handles.select_channel_list,'String','');
end