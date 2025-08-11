function NID_Detial_IC_drawTimeseries_Reserve(handles,NIDhandles)
% check
icdata = get(handles.ic_data_timeserials,'userdata');

icRaw = icdata.time;

cla(handles.ic_data_timeserials);
hold(handles.ic_data_timeserials,'on');
set(handles.ic_data_timeserials,'YLimMode','auto');
%
datain = get(NIDhandles.NIRS_ICA_Denoiser,'userdata');
nirsdata = datain.nirs_data;
if isfield(nirsdata,'T')
    T =  nirsdata.T;
else
    T =  1/nirsdata.fs;
end
%% Time range or Scan range��
if get(handles.ic_rangeType,'value') == 1
    xAxes=1:length(icRaw);
    xAxes=xAxes*T;
else
    xAxes=1:length(icRaw);
end
rangeLeft = str2num(get(handles.ic_rangeLeft,'string'));
rangeRight = str2num(get(handles.ic_rangeRight,'string'));
set(handles.ic_data_timeserials,'XLim',[rangeLeft,rangeRight]);
%%
h = [];
timeData = icRaw;
h = plot(handles.ic_data_timeserials,xAxes,timeData,'k');
set(h,'DisplayName',['IC ',num2str(icdata.icnum),'(',icdata.hbtype,')']);
%% design info
design_color = {[0.5,0.5,1],[0.851,0.325,0.098],[1,0,1],[0.25,0.25,0.25],[0.855,0.702,1],...
    [0.678,0.922,1],[0.349,0.2,0.329],[0.871,0.49,0]};
button_color = {[0.941,0.941,0.941]};
cnt = 0;
hinck_all = get(handles.uipanel_bl,'Userdata');
h1_all = [];
name_all = {};
if ~isempty(hinck_all)
    for i = 1:length(hinck_all)
        hinck = hinck_all(i);
        name = get(hinck,'String');
        val = get(hinck,'Value');
        datain = get(hinck,'Userdata');
        if isfield(datain.index,'design') %displaying the temporal template
            data = datain.index.design;
            % scale to match the time course of ica
            data = data + mean(timeData);
            data = data.*std(timeData);
            numSort = datain.num;
            %
            if ismember(numSort,[3,4])
                if val == 1
                    cnt = cnt+1;
                    hold(handles.ic_data_timeserials,'on')
                    h1 = plot(handles.ic_data_timeserials,xAxes,data,'Color',design_color{cnt});
                    h1_all = [h1_all,h1];
                    name_all{cnt} = name;
                    set(h1,'DisplayName',name,'Linewidth',2);
                    set(hinck,'BackgroundColor',design_color{cnt})
                else
                    set(hinck,'BackgroundColor',button_color{:})
                end
            end
%         else 
%             %displaying the spatial template 
        end
    end
    if ~isempty(h1_all)
        legend(h1_all,name_all)
    else
        legend(handles.ic_data_timeserials,'off')
    end
    
end

end
