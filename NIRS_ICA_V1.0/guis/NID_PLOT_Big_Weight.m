function NID_PLOT_Big_Weight(handles,data,order,ic_interest,numSort)
%% default parameter
%% fs
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
%
probeSets = dataIn.nirs_data.probe2d;
probeSetsNum = length(probeSets);
%%
pn = get(handles.pageNoL,'Userdata');
tot_page = pn.max;
num_page = pn.now;
%% plot
ax_fig = [];
checkbox_fig = [];
%% plot figure
AxesperPage = 4;
if num_page == tot_page
    if 0 == mod(length(order),AxesperPage)
        AxescurPage = length(order);
    else
        AxescurPage = mod(length(order),AxesperPage);
    end
else
    AxescurPage = AxesperPage;
end

firstNum = (num_page-1)*AxesperPage + 1;
endNum = min(length(order),(num_page-1)*AxesperPage+AxescurPage);
%%
width_ax = 0.465;
height_ax = 0.39;
start_ax = [0.03 0.56];
move_y = 0.025;

startx = start_ax(1);
starty = start_ax(2);
if 1 == probeSetsNum
    %-----one probe-----%
    %----- plot axes -----%
    for i = firstNum:endNum
        % num of ax
        ii = i - firstNum + 1;
        %
        ax_fig(ii) = axes('Parent',handles.uipanel2,...
            'position',[startx starty width_ax height_ax],...
            'Units','normalized',...
            'UserData',order(i));
        %----- plot each feature -----%
       ylimit = [];
       NID_plot2d(ax_fig(ii),data(order(i),:), probeSets, ylimit)
    
       set(ax_fig(ii),'XTick',[],'XColor',[1,1,1]);
       set(ax_fig(ii),'YTick',[],'YColor',[1,1,1]);
    
       %
       startx = startx + width_ax + 0.01;
       if mod(i,2) == 0
           starty = starty - height_ax-move_y;
           startx = start_ax(1);
       end
    end
%
    handles.ax_fig = ax_fig;

elseif 2 == probeSetsNum
    %-----two probe-----%
    %----- plot axes -----%
    %
    width_ax_1probe = 0.232;
    %
    for i = firstNum:endNum
        % num of ax
        ii = i - firstNum + 1;
        %-----probe1-----%
        ax_fig1(ii) = axes('Parent',handles.uipanel2,...
            'position',[startx starty width_ax_1probe height_ax],...
            'Units','normalized',...
            'UserData',order(i));
        %-----probe2-----%
        ax_fig2(ii) = axes('Parent',handles.uipanel2,...
            'position',[startx+width_ax_1probe starty width_ax_1probe height_ax],...
            'Units','normalized',...
            'UserData',order(i));
        %----- plot each feature -----%
       ylimit = [];
       NID_plot2d([ax_fig1(ii),ax_fig2(ii)],data(order(i),:), probeSets, ylimit)
    
       set(ax_fig1(ii),'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[1,1,1]);
       set(ax_fig2(ii),'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[0,0,0]);
    
       %
       startx = startx + width_ax + 0.01;
       if mod(i,2) == 0
           starty = starty - height_ax-move_y;
           startx = start_ax(1);
       end
    end
%
    ax_fig = [ax_fig1,ax_fig2];
    handles.ax_fig = ax_fig;
    
elseif 2 < probeSetsNum
    %-----renew at 2015/03/30-----%
    width_ax_1probe = width_ax/probeSetsNum;
    ax_fig_all = [];
    
    for i = firstNum:endNum
        % num of ax
        ii = i - firstNum + 1;
        ax_fig_ic = zeros(1,probeSetsNum);
        
        for jj = 1:probeSetsNum
            ax_fig_temp = axes('Parent',handles.uipanel2,...
            'position',[startx+(jj-1)*width_ax_1probe starty width_ax_1probe height_ax],...
            'Units','normalized',...
            'UserData',order(i));
        
            ax_fig_ic(jj) = ax_fig_temp;
        end
        
        %----- plot each feature -----%
       ylimit = [];
       NID_plot2d(ax_fig_ic,data(order(i),:), probeSets, ylimit)
       
       for jj = 1:probeSetsNum
           if jj == 1
               set(ax_fig_ic(jj),'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[1,1,1]);
           else
               set(ax_fig_ic(jj),'XTick',[],'XColor',[1,1,1],'YTick',[],'YColor',[0,0,0]);
           end
       end   
       %
       startx = startx + width_ax + 0.01;
       if mod(i,2) == 0
           starty = starty - height_ax-move_y;
           startx = start_ax(1);
       end
       
       ax_fig_all = [ax_fig_all,ax_fig_ic];
    end
%
    ax_fig = ax_fig_all;
    handles.ax_fig = ax_fig;
    
else
    %-----3 or more probe-----%
    %----- plot axes -----%
    for i = firstNum:endNum
        % num of ax
        ii = i - firstNum + 1;
        %
        ax_fig(ii) = axes('Parent',handles.uipanel2,...
            'position',[startx starty width_ax height_ax],...
            'Units','normalized',...
            'UserData',order(i));
        %----- plot each feature -----%
       ylimit = [];
       NID_plot2d_spacialmap(ax_fig(ii),data(order(i),:), probeSets, ylimit)
    
       set(ax_fig(ii),'XTick',[],'XColor',[1,1,1]);
       set(ax_fig(ii),'YTick',[],'YColor',[1,1,1]);
    
       %
       startx = startx + width_ax + 0.01;
       if mod(i,2) == 0
           starty = starty - height_ax-0.025;
           startx = start_ax(1);
       end
    end
%
    handles.ax_fig = ax_fig;
end
%%
    %%
    %----- plot checkbox -----%
    stepx = 0.01;
    width_box = 0.465;
    height_box = 0.022;
    start_checkbox = [0.03 0.95];
    move_y = 0.003;
    
    startx = start_checkbox(1);
    starty = start_checkbox(2);

    for i = firstNum:endNum
        % num of checkbox
        ii = i - firstNum + 1;
        %
       hinck    = uicontrol(handles.uipanel2,'Style','checkbox',...
           'String',['NO.',num2str(order(i))],...
           'TooltipString','Labeling',...
           'Units','normalized',...
           'Position',[startx,starty,width_box,height_box],...
           'FontUnit','normalized','FontSize',0.58,...
           'BackgroundColor',[0.941,0.941,0.941],...
            'UserData',order(i));
        handles.hinck = hinck;
        % color
        label_tag = 0;
        if ismember(order(i),ic_interest.muti_labelIC)
           set(handles.hinck,'BackgroundColor',[1,0,0])
        else
            for j = 1:length(numSort)
               temp = numSort(j);
               labeled = ic_interest.labelIC{temp};
               if iscell(labeled)
                    tmp_label = [];
                    for jj = 1:length(labeled)
                        tmp_label = [tmp_label,labeled{jj}];
                    end
                    if ismember(order(i),tmp_label)
                        label_tag = 1;
                    else
                        label_tag = 0;
                    end
               else
                    if ismember(order(i),labeled)
                        label_tag = 1;
                    else
                        label_tag = 0;
                    end
               end
               if label_tag
                   switch temp
                       case 1
                            set(handles.hinck,'BackgroundColor',[1,0.6,0.784]);
                       case 2
                            set(handles.hinck,'BackgroundColor',[0.855,0.702,1]);
                       case 3
                           set(handles.hinck,'BackgroundColor',[0.702,0.78,1]);
                       case 4
                            set(handles.hinck,'BackgroundColor',[0.678,0.922,1]);
                       case 5
                            set(handles.hinck,'BackgroundColor',[0,1,0]);
                       case 6
                            set(handles.hinck,'BackgroundColor',[0,1,0]);
                       case 7
                            set(handles.hinck,'BackgroundColor',[1,1,0]);
                       otherwise
                            set(handles.hinck,'BackgroundColor',[0.941,0.941,0.941]);
                   end
               end
            end
        end
    % text Similarity
    NID_PLOT_Similarity(handles,handles.hinck,order(i),numSort)
    % label
    if ismember(order(i),ic_interest.selectIC)
        set(handles.hinck,'Value',1,'FontSize',0.9,'FontWeight','bold')
    end
    checkbox_fig(ii) = hinck;
    
    startx = startx + width_box + stepx;
    if mod(i,2) == 0
        starty = starty - height_box - height_ax - move_y;
        startx = start_ax(1);
    end
    end
    % callback function
    for i = 1:length(checkbox_fig)
        set(checkbox_fig(i),'Callback',{@label_Callback,checkbox_fig(i),handles});
    end
    handles.checkbox_fig = checkbox_fig;
%%
    %-----detial-----%
    %----------------%
    stepx = 0.461;
    width_box = 0.014;
    height_box = 0.022;
    start_detail = [0.495-width_box 0.95];
    move_y = 0.003;
    
    startx = start_detail(1);
    starty = start_detail(2);

    for i = firstNum:endNum
        % num of checkbox
        ii = i - firstNum + 1;
        %
       hinck1    = uicontrol(handles.uipanel2,'Style','pushbutton',...
           'String','',...
           'TooltipString','Show Details of IC...',...
           'Units','normalized',...
           'Position',[startx,starty,width_box,height_box],...
           'FontSize',8,'FontUnit','normalized',...
           'BackgroundColor',[0.941,0.941,0.941],...
            'UserData',order(i));
        handles.hinck1 = hinck1;
    % label
    
    detail_fig(ii) = hinck1;
    
    startx = startx + width_box + stepx;
    if mod(i,2) == 0
        starty = starty - height_box - height_ax - move_y;
        startx = start_detail(1);
    end
    end
    % callback function
    defaultSetDir = which('NIRS_ICA_v1');
    index_dir=findstr(defaultSetDir,filesep);
    defaultSetDir=[defaultSetDir(1:index_dir(end)-1) filesep 'file' filesep];
    detail_icon = importdata([defaultSetDir,'detail.jpg']);
    for i = 1:length(detail_fig)
        set(detail_fig(i),'Callback',{@ButtonDownFcn_axfig,detail_fig(i),handles,order});
        set(detail_fig(i),'CData',detail_icon);
    end
    handles.detail_fig = detail_fig;
%%
fig_handle.ax_fig = ax_fig;
fig_handle.checkbox_fig = checkbox_fig;
fig_handle.detail_fig = detail_fig;
set(handles.uipanel2,'Userdata',fig_handle)
end

function ButtonDownFcn_axfig(hObject, eventdata,ax_fig,handles,order)
%%
% detail model
%
remove_value = get(handles.radiobutton1,'Value');
reserve_value = get(handles.radiobutton2,'Value');
% remove or reserve
if remove_value == 1 && reserve_value == 0
    NIRS_ICA_Detail_of_Source
    NID_Detail = findobj('Tag','NIRS_ICA_Denoiser_Detail_of_IC');
    if ~isempty(NID_Detail)
        DetailHandles=guihandles(NID_Detail);
        NID_Detail_of_IC_initial(ax_fig,handles,DetailHandles,order)
    end
    %
    NID_nirsdata_drawTimeseries(DetailHandles)
    NID_nirsdata_drawFreq(DetailHandles)
    NID_Detial_IC_drawTimeseries(DetailHandles)
    NID_Detail_IC_drawFreq(DetailHandles)
    NID_Detial_IC_drawSpacialmap(DetailHandles)
    NID_Detail_IC_Spacialmap_colorBar(DetailHandles)
elseif remove_value == 0 && reserve_value == 1
    NIRS_ICA_Detail_of_Source_Retain
    NID_Detail = findobj('Tag','NIRS_ICA_Denoiser_Detail_of_IC_Reserve');
    if ~isempty(NID_Detail)
        DetailHandles=guihandles(NID_Detail);
        NID_Detail_of_IC_Reserve_initial(ax_fig,handles,DetailHandles,order)
    end
    %
    NID_Detial_IC_drawTimeseries_Reserve(DetailHandles,handles)
    NID_Detail_IC_drawFreq_Reserve(DetailHandles,handles)
    NID_Detial_IC_drawSpacialmap_Reserve(DetailHandles,handles)
    NID_Detail_IC_Spacialmap_colorBar_Reserve(DetailHandles,handles)
elseif remove_value == 0 && reserve_value == 0
    errordlg('Removing or Picking a IC ?')
    return
end
%
end

function label_Callback(hObject, eventdata,hinck,handles,selectIC)
%
orderi = get(hinck,'UserData');
curval = get(hinck,'Value');
%
remove_value = get(handles.radiobutton1,'Value');
reserve_value = get(handles.radiobutton2,'Value');
% remove or reserve
if remove_value == 1 && reserve_value == 0
    ic_interest = get(handles.edit3,'Userdata');
    selectIC = ic_interest.selectIC;
elseif remove_value == 0 && reserve_value == 1
    ic_interest = get(handles.text7,'Userdata');
    selectIC = ic_interest.selectIC;
elseif remove_value == 0 && reserve_value == 0
    errordlg('Would you like removing or picking a IC? Please make a choise.')
    set(hinck,'Value',0)
    return
end
%
if 0 == curval
    set(hinck,'Value',0);
    %
    str = get(hinck,'String');
    set(hinck,'String',str,'FontWeight','normal','FontSize',0.58)
    %
    temp = find(selectIC==orderi);
    selectIC(temp) = '';
    %
    ic_interest.selectIC = selectIC;
    
else
    set(hinck,'Value',1);
    %
    str = get(hinck,'String');
    set(hinck,'String',str,'FontWeight','bold','FontSize',0.8)
    %
    selectIC = [selectIC,orderi];
    selectIC = sort(selectIC,'ascend');
    ic_interest.selectIC = selectIC;
end
%
if remove_value == 1 && reserve_value == 0
    set(handles.edit3,'Userdata',ic_interest,'String',num2str(selectIC))
elseif remove_value == 0 && reserve_value == 1
    set(handles.text7,'Userdata',ic_interest,'String',num2str(selectIC))
end

end