function NID_Detial_IC_drawSpacialmap_Reserve(handles,NIDhandles)
% check
icdata = get(handles.ic_data_timeserials,'userdata');

icRaw = icdata.weight;
%
datain = get(NIDhandles.NIRS_ICA_Denoiser,'userdata');
nirsdata = datain.nirs_data;

if isfield(nirsdata,'T')
    T =  nirsdata.T;
else
    T =  1/nirsdata.fs;
end
probeSets = nirsdata.probe2d;
probeSetsNum = length(probeSets);
%%
h = [];
%%
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
%% External Input
design_color = {[0.5,0.5,1],[0.851,0.325,0.098],[1,0,1],[0.25,0.25,0.25],[0.855,0.702,1],...
    [0.678,0.922,1],[0.349,0.2,0.329],[0.871,0.49,0]};
button_color = {[0.941,0.941,0.941]};
cnt = 0;
hinck_all = get(handles.uipanel_bl,'Userdata');
if ~isempty(hinck_all)
    for i = 1:length(hinck_all)
        hinck = hinck_all(i);
        name = get(hinck,'String');
        val = get(hinck,'Value');
        datain = get(hinck,'Userdata');
        data = datain.index;
        numSort = datain.num;
        %
        if ismember(numSort,[5])
            if val == 1
                cnt = cnt+1;
                NID_Detial_IC_SpatialMap_Reserve_Labeling(h, icRaw, probeSets, data, design_color{cnt})

                set(hinck,'BackgroundColor',design_color{cnt})
            else
                set(hinck,'BackgroundColor',button_color{:})
            end
        end
    end
end

end
