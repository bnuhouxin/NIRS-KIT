function NID_Input_Design_Info_Plot(handles)
table_info = get(handles.uitable1,'Userdata');
tableData = get(handles.uitable1,'Data');
durData = get(handles.duration,'Userdata');
onsetData = get(handles.onset,'Userdata');

select = table_info.select;
if ~isempty(select)
    datain = get(handles.preview,'Userdata');
    data = datain{select};
    name = tableData{select,1};
    thres = tableData{select,2};
    h = plot(handles.axes1,data,'k');
    set(handles.axes1,'XLim',[1,length(data)],'YLim',[-1,2]);
    set(handles.axes1,'XGrid','on')
    legend(h,['Name:',name,',Threshold:',num2str(thres)]);
    %
%     set(handles.duration,'String',num2str(durData{select}))
%     set(handles.onset,'String',num2str(onsetData{select}))
    set(handles.duration,'String',sprintf('%.0f ' , durData{select}))
    set(handles.onset,'String',sprintf('%.0f ' , onsetData{select}))
end

end