function NID_Select_External_Input_Preview(handles,N,inpathList)
%% load
dataIn = load(inpathList{N});
data = dataIn.data;
%%
ax = get(handles.axes1,'Tag');
plot(handles.axes1,data)
set(handles.axes1,'XLim',[0,length(data)],'XGrid','on');
end