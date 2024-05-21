function NID_Detail_IC_Spacialmap_colorBar_Reserve(handles,NIDhandles)
%%
icdata = get(handles.ic_data_timeserials,'userdata');
icRaw = icdata.weight;
%%
y_upper=max(abs(icRaw(:)));
y_lower=min(abs(icRaw(:)));
y_absmax=max([abs(y_upper),abs(y_lower)]);
y_absmax = round(y_absmax*1000)/1000;

axishandles = findobj('Tag','spatialmap_colorbar');

%%
set(axishandles,'XTick',[],'XColor',[0.941,0.941,0.941],'YTick',[],'YColor',[0.941,0.941,0.941]);
%%
cb = get(axishandles,'Userdata');
if ~isempty(cb)
    colorbar(cb,'delete')
end
%
cb = colorbar('peer',axishandles);
set(cb,'location','South','XAxisLocation','bottom')
set(cb,'XTick',[1,65],'XTickLabel',[-y_absmax,y_absmax])
set(cb,'position',[0.46,0.045,0.51,0.025])
% set(cb,'FontSize',7,'FontUnit','normalize')
%
set(axishandles,'Userdata',cb);
end