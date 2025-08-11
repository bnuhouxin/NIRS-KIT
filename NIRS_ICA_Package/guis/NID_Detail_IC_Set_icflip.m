function NID_Detail_IC_Set_icflip(curicNum,DetailHandles,NIDHandles,order)
%%
dataIn = get(NIDHandles.NIRS_ICA_Denoiser,'UserData');
hbType = dataIn.hbType;
IC = dataIn.IC;
icnum = curicNum;
selectedIC = get(NIDHandles.edit3,'String');
ic_interest = get(NIDHandles.edit3,'Userdata');
%%
set(DetailHandles.panel_ic_data,'Title',['Target IC (','NO.',num2str(icnum),' ',lower(hbType),')'])
%
set(DetailHandles.ic_data_timeserials,'YLimMode','auto');
set(DetailHandles.ic_data_timeserials,'XGrid','on');
set(DetailHandles.ic_data_freq,'YLimMode','auto');
set(DetailHandles.ic_data_freq,'XGrid','on');
set(DetailHandles.ic_rangeLeft,'String',get(DetailHandles.rangeLeft,'String'))
set(DetailHandles.ic_rangeRight,'String',get(DetailHandles.rangeRight,'String'))
set(DetailHandles.ic_rangeType,'Value',get(DetailHandles.rangeType,'Value'))
% set(DetailHandles.ic_ylimAxesf,'String',get(DetailHandles.ylimAxesf,'String'))
% IC fliper
leftflip.icNum = icnum;
leftflip.order = order;
set(DetailHandles.detail_left,'Userdata',leftflip)

rightflip.icNum = icnum;
rightflip.order = order;
set(DetailHandles.detail_right,'Userdata',rightflip)
%%
tmp = getfield(IC,hbType);
timeseries = tmp.TC(:,icnum);
weight = tmp.SM(:,icnum);
data.time = timeseries;
data.weight = weight;
data.icnum = icnum;
data.hbtype = hbType;
data.selectedIC = str2num(selectedIC);
set(DetailHandles.ic_data_timeserials,'Userdata',data)
%% Noise Component
Sort = tmp.Sort;
[xx,zz] = ismember(Sort.Sort_selectRule,Sort.Sort_icName);
numSort = zz;
%
remove = get(NIDHandles.radiobutton1,'Value');
reserve = get(NIDHandles.radiobutton2,'Value');
if remove == 1 && reserve == 0
    numSort = numSort(find(numSort<=3));
elseif remove == 0 && reserve == 1
    numSort = numSort(find(numSort>3));
elseif remove == 0 && reserve == 0
    errordlg('Removing or Picking a IC component? Please choose a mode... ...')
end
% remove old button
buttonHandles = get(DetailHandles.panel_ic_data,'Userdata');
for i = 1:length(buttonHandles)
    delete(buttonHandles(i))
end
% create mew button
button_color = {[0.941,0.941,0.941],[0.941,0.941,0.941],[0.941,0.941,0.941],...
    [0.941,0.941,0.941],[0.941,0.941,0.941]};
x_start = 0.05;
y_start = 0.49;
width = 0.15;
height = 0.03;
xstep = 0.01;
hinck_all = [];
if ~isempty(numSort)
    for i = 1:length(numSort)
        temp = Sort.Sort_icName_Detail{numSort(i)};
        temp_data = Sort.Sort_icDetail_data{numSort(i)};
        temp_value = Sort.Sort_icValue{numSort(i)};
        temp_num = Sort.Sort_icNum{numSort(i)};
        
        if numSort(i) == 1
            dname = temp{:};
            ddata.index = temp_data{:};
            ddata.num = numSort(i);
            ddata.icnum = data.icnum;
            [bool,pos] = ismember(icnum,temp_num{:});
            val = num2str(temp_value{:}(pos));
            
            if length(val)>=4
                val = val(1:4);
            else
                val = val(1:end);
            end
            
            hinck = uicontrol(DetailHandles.panel_ic_data,'Style','togglebutton',...
            'String',dname,'Value',0,...
            'TooltipString',['Show ',dname],...
            'Units','normalized',...
            'Position',[x_start,y_start,width,height],...
            'FontSize',8,'FontUnit','normalized',...
            'BackgroundColor',button_color{numSort(i)},...
            'UserData',ddata);
            x_start = x_start + width + xstep;
            
            hinck_all = [hinck_all,hinck];
            %  callback function
            set(hinck,'Callback',{@MotionArtifact_Callback,DetailHandles,hinck});
            
        elseif numSort(i) == 2
            
        elseif numSort(i) == 3
            for j = 1:length(temp)
                dname = temp{j};
                ddata.index = temp_data{j};
                ddata.num = numSort(i);
                ddata.icnum = data.icnum;
                [bool,pos] = ismember(icnum,temp_num{j});
                val = num2str(temp_value{j}(pos));
                val = val(1:4);
                hinck = uicontrol(DetailHandles.panel_ic_data,'Style','togglebutton',...
                'String',[dname,' (r=',val,')'],'Value',0,...
                'TooltipString',['Show ',dname],...
                'Units','normalized',...
                'Position',[x_start,y_start,width,height],...
                'FontSize',8,'FontUnit','normalized',...
                'BackgroundColor',button_color{numSort(i)},...
                'UserData',ddata);
                x_start = x_start + width + xstep;
            
                hinck_all = [hinck_all,hinck];
                %  callback
                set(hinck,'Callback',{@Design_Callback,DetailHandles});
            end
        end
    
    end
    set(DetailHandles.panel_ic_data,'Userdata',hinck_all)
end
end

function Design_Callback(hObject, eventdata,DetailHandles)
%
NID_Detial_IC_drawTimeseries(DetailHandles)
NID_Detail_IC_drawFreq(DetailHandles)
NID_Detial_IC_drawSpacialmap(DetailHandles)

end

function MotionArtifact_Callback(hObject, eventdata,DetailHandles,MA_handles)
%
NID_Detial_IC_drawTimeseries_MotionDetection(DetailHandles)
NID_Detial_IC_MotionDetection_NirsData_Set(DetailHandles,MA_handles)

% NID_Detail_IC_drawFreq(DetailHandles)
% NID_Detial_IC_drawSpacialmap(DetailHandles)
% NID_Detail_IC_Spacialmap_colorBar(DetailHandles)
end