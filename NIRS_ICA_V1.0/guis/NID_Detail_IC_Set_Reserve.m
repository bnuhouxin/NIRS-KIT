function NID_Detail_IC_Set_Reserve(curicNum,DetailHandles,NIDHandles,order)
%% ���񾭳ɷ�ģʽDetail�����ʼ������
%%
dataIn = get(NIDHandles.NIRS_ICA_Denoiser,'UserData');
hbType = dataIn.hbType;
IC = dataIn.IC;
icnum = curicNum;
selectedIC = get(NIDHandles.text7,'String');
ic_interest = get(NIDHandles.text7,'Userdata');
%
tmp = getfield(IC,hbType);
timeseries = tmp.TC(:,icnum);
weight = tmp.SM(:,icnum);
len = length(timeseries);
%%
set(DetailHandles.panel_ic_data,'Title',['Target Source (','NO.',num2str(icnum),' ',lower(hbType),')'])

set(DetailHandles.ic_data_timeserials,'YLimMode','auto');
% set(DetailHandles.ic_data_timeserials,'XGrid','on');
%edited by ZhaoYang
set(DetailHandles.ic_data_freq,'YLimMode','auto');
% set(DetailHandles.ic_data_freq,'XGrid','on');
%edited by ZhaoYang
set(DetailHandles.ic_rangeLeft,'String',num2str(1));
set(DetailHandles.ic_rangeRight,'String',num2str(len));
set(DetailHandles.ic_rangeType,'Value',2)
set(DetailHandles.ic_ylimAxesf,'String','')
%% IC fliper �����ҷ�ҳ��ť
leftflip.icNum = icnum;
leftflip.order = order;
set(DetailHandles.detail_left,'Userdata',leftflip)

rightflip.icNum = icnum;
rightflip.order = order;
set(DetailHandles.detail_right,'Userdata',rightflip)
%%
data.time = timeseries;
data.weight = weight;
data.icnum = icnum;
data.hbtype = hbType;
data.selectedIC = str2num(selectedIC);
set(DetailHandles.ic_data_timeserials,'Userdata',data)
%% Neuro Activity Component �ο�������ģ����Ϣ����ʾ
Sort = tmp.Sort;
[xx,zz] = ismember(Sort.Sort_selectRule,Sort.Sort_icName);
numSort = zz;
% ��ȡ
remove = get(NIDHandles.radiobutton1,'Value');
reserve = get(NIDHandles.radiobutton2,'Value');

if remove == 1 && reserve == 0
    numSort = numSort(find(numSort==3));
    
elseif remove == 0 && reserve == 1
    numSort = numSort(find(numSort>3));
elseif remove == 0 && reserve == 0
    errordlg('Removing or Picking a IC component? Please choose a mode... ...')
end
%
button_color = {[0.941,0.941,0.941],[0.941,0.941,0.941],[0.941,0.941,0.941],...
    [0.941,0.941,0.941],[0.941,0.941,0.941]};
x_start = 0.25;
x_origin = x_start;
y_start_up = 0.55;
y_start_down = 0.15;
width = 0.18;
height = 0.3;
xstep = 0.05;
hinck_all = [];
if ~isempty(numSort)
    for i = 1:length(numSort)
        temp = Sort.Sort_icName_Detail{numSort(i)};
        temp_data = Sort.Sort_icDetail_data{numSort(i)};
%         temp_value = Sort.Sort_icValue{numSort(i)};
        temp_value = Sort.Sort_icValue_Raw{numSort(i)};
        temp_num = Sort.Sort_icNum{numSort(i)};
        %
        x_start = x_origin;
        %% plot design infomation button
        if numSort(i) == 4
            for j = 1:length(temp)
                dname = temp{j};
                ddata.index = temp_data{j};
                ddata.num = numSort(i);
                
                val = num2str(temp_value{j}(icnum));
                
                if length(val)>=4
                    val = val(1:4);
                end
                
                hinck = uicontrol(DetailHandles.uipanel_bl,'Style','togglebutton',...
                'String',[dname,' (r=',val,')'],'Value',0,...
                'TooltipString',['Show ',dname],...
                'Units','normalized',...
                'Position',[x_start,y_start_up,width,height],...
                'FontSize',12,'FontUnit','normalized',...
                'BackgroundColor',button_color{numSort(i)},...
                'UserData',ddata);
                x_start = x_start + width + xstep;
                
                hinck_all = [hinck_all,hinck];
                %  callback
                set(hinck,'Callback',{@Design_Callback,DetailHandles,NIDHandles,hinck});
%                 set(hinck,'UserData',val);
            end
        %% plot spatial template button
        elseif numSort(i) == 5
            for j = 1:length(temp)
                dname = temp{j};
                ddata.index = temp_data{j};
                ddata.num = numSort(i);
                
                val = num2str(temp_value{j}(icnum));
                
                if length(val) > 4
                    val = val(1:4);
                end
                
                hinck = uicontrol(DetailHandles.uipanel_bl,'Style','togglebutton',...
                'String',[dname,' (GOF=',val,')'],'Value',0,...
                'TooltipString',['Show ',dname],...
                'Units','normalized',...
                'Position',[x_start,y_start_down,width,height],...
                'FontSize',12,'FontUnit','normalized',...
                'BackgroundColor',button_color{numSort(i)},...
                'UserData',ddata);
                x_start = x_start + width + xstep;
            
                hinck_all = [hinck_all,hinck];
                %  callback
                set(hinck,'Callback',{@Design_Callback,DetailHandles,NIDHandles,hinck});
            end
        end
        
    end
    set(DetailHandles.uipanel_bl,'Userdata',hinck_all)
end
end

function Design_Callback(hObject, eventdata,DetailHandles,NIDHandles,hinck)
%
design_color = {[0.5,0.5,1],[0.851,0.325,0.098],[1,0,1],[0.25,0.25,0.25],[0.855,0.702,1],...
    [0.678,0.922,1],[0.349,0.2,0.329],[0.871,0.49,0]};
button_color = {[0.941,0.941,0.941]};
%
hinck_all = get(DetailHandles.uipanel_bl,'Userdata');
val = get(hinck,'Value');
datain = get(hinck,'Userdata');
num = datain.num;
% pos = find(hinck_all == hinck);
if ~isempty(hinck_all)
    for i = 1:length(hinck_all)
        hinck1 = hinck_all(i);
        val1 = get(hinck1,'Value');
        datain1 = get(hinck1,'Userdata');
        num1 = datain1.num;
%         pos1 = find(hinck_all == hinck1);
        if ismember(num,[3,4])&&ismember(num1,[5])
            if val == 1
                set(hinck1,'Value',0,'BackgroundColor',button_color{:});
            end
        elseif ismember(num,[5])&&ismember(num1,[3,4])
            if val == 1
                set(hinck1,'Value',0,'BackgroundColor',button_color{:});
            end
        end
    end
end
%
NID_Detial_IC_drawTimeseries_Reserve(DetailHandles,NIDHandles)
NID_Detail_IC_drawFreq_Reserve(DetailHandles,NIDHandles)
NID_Detial_IC_drawSpacialmap_Reserve(DetailHandles,NIDHandles)
NID_Detail_IC_Spacialmap_colorBar_Reserve(DetailHandles,NIDHandles)
end
