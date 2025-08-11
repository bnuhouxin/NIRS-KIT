function NID_Input_SpatialMap_ShowChannel(handles)
%%
inpathList = get(handles.listbox1,'string');
name = get(handles.edit2,'Userdata');
thres = get(handles.edit3,'Userdata');
SpatialMap = get(handles.listbox1,'Userdata');

if isempty(inpathList)
    return;
end
k = get(handles.listbox1,'value');
if ischar(inpathList) || 1==length(inpathList)
    inpathList = {};
    name = {};
    thres = {};
    SpatialMap = {};
    %
    set(handles.edit2,'Userdata',name,'String','')
    set(handles.edit3,'Userdata',thres,'String','')
    set(handles.listbox1,'Userdata',SpatialMap);
    NID_Input_SpatialMap_ClearChannel(handles)
    NID_Input_SpatialMap_CreateFuntion(handles)
else
    inpathList = inpathList([1:k-1 k+1:end]);
    name = name([1:k-1 k+1:end]);
    thres = thres([1:k-1 k+1:end]);
    SpatialMap = SpatialMap([1:k-1 k+1:end]);
    %
    M = max(k-1,1);
    set(handles.edit2,'Userdata',name,'String',name{M})
    set(handles.edit3,'Userdata',thres,'String',thres{M})
    set(handles.listbox1,'Userdata',SpatialMap);
end
set(handles.listbox1,'string',inpathList,'value',max(k-1,1));
end