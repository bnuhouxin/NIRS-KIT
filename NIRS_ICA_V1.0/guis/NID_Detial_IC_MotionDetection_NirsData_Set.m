function NID_Detial_IC_MotionDetection_NirsData_Set(handles,MA_handles)
%% 在fNIRS数据显示界面标记处头动噪声出现的位置
MA_button_val = get(MA_handles,'Value');
%% find max weight of current IC;
if MA_button_val == 1
    icdata = get(handles.ic_data_timeserials,'userdata');
    weight = icdata.weight;
    [a,pos] = max(weight);
end

%%
if MA_button_val == 1
    set(handles.show_bl,'Value',1)
    set(handles.show_bl_remove,'Value',0)

    set(handles.nirs_data_singlemode,'Value',1,'Enable','on')
    set(handles.nirs_data_multiplemode,'Value',0,'Enable','off')
    set(handles.nirs_data_oxy,'Enable','on','Value',1)
    set(handles.nirs_data_dxy,'Enable','on','Value',1)
    set(handles.nirs_data_total,'Enable','on','Value',0)

    set(handles.increaseCh,'enable','on');
    set(handles.decreaseCh,'enable','on');
    set(handles.allChannel,'enable','off');
    %
    set(handles.nirs_data_channel,'String',num2str(pos));
    channel_handles = get(handles.nirs_data_channel_pannel,'Userdata');
    len = length(channel_handles);
    for i = 1:len
        set(channel_handles(i), 'BackgroundColor',[0.941,0.941,0.941]);
    end
    set(channel_handles(pos), 'BackgroundColor',[0.7,0.7,1]);
else
    set(handles.nirs_data_multiplemode,'Value',0,'Enable','on')
end

%%
NID_nirsdata_drawTimeseries(handles)
NID_nirsdata_drawFreq(handles)
end