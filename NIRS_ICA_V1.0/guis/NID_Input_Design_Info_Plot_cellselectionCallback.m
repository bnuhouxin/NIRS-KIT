function NID_Input_Design_Info_Plot_cellselectionCallback(hObject, eventdata, handles)
% row
mLine = eventdata.Indices(1);
% column
nColumn = eventdata.Indices(2);

val = mLine;
name_all = get(handles.design_name,'Userdata');
if ~isempty(val)
    datain = get(handles.preview,'Userdata');
    data = datain{val};
    name = name_all{val};
    h = plot(handles.axes1,data,'k');
    set(handles.axes1,'XLim',[1,length(data)],'YLim',[-2,2]);
    set(handles.axes1,'XGrid','on')
    legend(h,name);
end

end