function NID_Input_SpatialMap_ClearChannel(handles)
%%
% �ú������ڡ��ռ�ģ�����ý��� NID_Input_SpatialMap��
% ������ս����е�ģ����ʾ����channel_pannel�����Ա��ڻ����µ�ģ��
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