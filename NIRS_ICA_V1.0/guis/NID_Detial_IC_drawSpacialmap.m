function NID_Detial_IC_drawSpacialmap(handles)
%% Draw source spatial map

icdata = get(handles.ic_data_timeserials,'userdata');
nirsdata = get(handles.nirs_data_timeserial,'userdata');

icRaw = icdata.weight;

T =  nirsdata.raw.T;
if isfield(nirsdata.raw,'probe2d')
    probeSets = nirsdata.raw.probe2d;
    probeSetsNum = length(probeSets);
else
    probeSetsNum=-1;
end
%%
h = [];
%% 
% 
if 1 == probeSetsNum
    startx = 0.001;
    starty = 0.01;
    width_ax = 0.999;
    height_ax = 0.99;
    h = axes('Parent',handles.ic_spacialMap,...
         'position',[startx starty width_ax height_ax],...
         'Units','normalized'...
         );
    ylimit = [];
    NID_plot2d(h,icRaw, probeSets, ylimit)
    set(h,'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[1,1,1]);
    
%
elseif 2 == probeSetsNum
    startx = 0.001;
    starty = 0.01;
    width_ax = 0.999;
    height_ax = 0.99;
    width_ax_1probe = 0.499;
    h1 = axes('Parent',handles.ic_spacialMap,...
         'position',[startx starty width_ax_1probe height_ax],...
         'Units','normalized'...
         );
    h2 = axes('Parent',handles.ic_spacialMap,...
        'position',[startx+width_ax_1probe starty width_ax_1probe height_ax],...
        'Units','normalized'...
        );
    set(h2,'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[0,0,0]);
    h = [h1,h2];
    ylimit = [];
    NID_plot2d(h,icRaw, probeSets, ylimit)
    
% 2�����Ϲ⼫�� 
elseif 2 < probeSetsNum
    %-----renew at 2015/3/30-----%
    startx = 0.001;
    starty = 0.01;
    width_ax = 0.999;
    height_ax = 0.99;
    %
    width_ax_1probe = 1/probeSetsNum;
    h = [];
    for ii = 1:probeSetsNum
        h_temp = axes('Parent',handles.ic_spacialMap,...
         'position',[startx+(ii-1)*width_ax_1probe starty width_ax_1probe height_ax],...
         'Units','normalized'...
         );
        h = [h,h_temp];
    end
    ylimit = [];
    NID_plot2d(h,icRaw, probeSets, ylimit)
% 
else
    startx = 0.001;
    starty = 0.01;
    width_ax = 0.999;
    height_ax = 0.99;
    h = axes('Parent',handles.ic_spacialMap,...
         'position',[startx starty width_ax height_ax],...
         'Units','normalized'...
         );
    ylimit = [];
    NID_plot2d_spacialmap(h,icRaw, probeSets, ylimit)
    set(h,'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[1,1,1]);
end

end
