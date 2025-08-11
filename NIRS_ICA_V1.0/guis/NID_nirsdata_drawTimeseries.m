function NID_nirsdata_drawTimeseries(handles)
%% To draw timeseries of the sources

K = str2num(get(handles.nirs_data_channel,'string'));           %

if isempty(K)
    cla(handles.nirs_data_timeserial);
    return;
end

if 1 == get(handles.nirs_data_singlemode,'value') && length(K) > 1
%     errordlg('Cannot draw multiple channels in single mode', 'Error');
    %
    handles_button = get(handles.nirs_data_channel_pannel,'userdata');
    N = length(handles_button);
    for i=1:N
        set(handles_button(i), 'BackgroundColor',[0.941,0.941,0.941]);
    end
    set(handles_button(1), 'BackgroundColor',[0.7,0.7,1]);
    set(handles.nirs_data_channel, 'string','1');
    K = str2num(get(handles.nirs_data_channel,'string'));
end

data = get(handles.uipanel_bl,'userdata');
nirsdataRaw = data.raw;

cla(handles.nirs_data_timeserial);
hold(handles.nirs_data_timeserial,'on');
set(handles.nirs_data_timeserial,'YLimMode','auto');
T = nirsdataRaw.T;
%% Time range or Scan range��
if get(handles.rangeType,'value') == 1
    xAxes=1:length(nirsdataRaw.oxyData);
    xAxes=xAxes*T;
else
    xAxes=1:length(nirsdataRaw.oxyData);
end
rangeLeft = str2num(get(handles.rangeLeft,'string'));
rangeRight = str2num(get(handles.rangeRight,'string'));
set(handles.nirs_data_timeserial,'XLim',[rangeLeft,rangeRight]);
%% Single channel or multiple channels��
h = [];
if 1 == get(handles.nirs_data_singlemode,'value') == 1  % single mode
    if 1==get(handles.show_bl,'value')  % raw data
        if 1 == get(handles.nirs_data_oxy,'value')
            timeData = nirsdataRaw.oxyData(:,K);
            h_oxy = plot(handles.nirs_data_timeserial,xAxes,timeData,'r');
            set(h_oxy,'DisplayName','Oxy');
            h = [h;h_oxy];
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataRaw.dxyData(:,K);
            h_dxy = plot(handles.nirs_data_timeserial,xAxes,timeData,'b');
            set(h_dxy,'DisplayName','Dxy');
            h = [h;h_dxy];
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataRaw.totalData(:,K);
            h_total = plot(handles.nirs_data_timeserial,xAxes,timeData,'g');
            set(h_total,'DisplayName','Total');
            h = [h;h_total];
        end
    end
    if 1==get(handles.show_bl_remove,'value')  % preprocessed data
        nirsdataPre = data.preprocessed;
        xAxesPre = xAxes;
        color_oxy = 'r';  color_dxy = 'b';  color_total = 'g';
        if 1==get(handles.show_bl,'value')
            color_oxy = [1 0 1];  color_dxy = [1 0 1];  color_total = [1 0 1];
            color_oxy_before = [0 1 1];  color_dxy_before = [0 1 1];  color_total_before = [0 1 1];
        end
        if 1 == get(handles.nirs_data_oxy,'value')
            timeData = nirsdataPre.oxyData(:,K);
            h_oxy_preprocessed = plot(handles.nirs_data_timeserial,xAxesPre,timeData,'color',color_oxy,'linewidth',1);
            set(h_oxy_preprocessed,'DisplayName',' Oxy(After)');
            h = [h;h_oxy_preprocessed];
            %
            if 1==get(handles.show_bl,'value')
                set(h_oxy,'DisplayName',' Before','Color',color_oxy_before);
                set(h_oxy_preprocessed,'DisplayName',' After');
            end
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataPre.dxyData(:,K);
            h_dxy_preprocessed = plot(handles.nirs_data_timeserial,xAxesPre,timeData,'color',color_dxy,'linewidth',1);
            set(h_dxy_preprocessed,'DisplayName',' Dxy(After)');
            h = [h;h_dxy_preprocessed];
            %
            if 1==get(handles.show_bl,'value')
                set(h_dxy,'DisplayName',' Before','Color',color_dxy_before);
                set(h_dxy_preprocessed,'DisplayName',' After');
            end
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataPre.totalData(:,K);
            h_total_preprocessed = plot(handles.nirs_data_timeserial,xAxesPre,timeData,'color',color_total,'linewidth',1);
            set(h_total_preprocessed,'DisplayName',' Total(After)');
            h = [h;h_total_preprocessed];
            %
            if 1==get(handles.show_bl,'value')
                set(h_total,'DisplayName',' Before','Color',color_total_before);
                set(h_total_preprocessed,'DisplayName',' After');
            end
        end
    end
else  % multiple mode 
    color = data.color;
    if 1==get(handles.show_bl,'value')  % raw data
        if(1==get(handles.nirs_data_oxy,'value'))
            timeData = nirsdataRaw.oxyData(:,K);
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataRaw.dxyData(:,K);
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataRaw.totalData(:,K);
        end
        for i=1:length(K)
            h(i,1) = plot(handles.nirs_data_timeserial,xAxes,timeData(:,i),'color',color(K(i),:));
            set(h(i),'DisplayName',['Ch ' num2str(K(i)),' Before']);
        end
    end
    if 1==get(handles.show_bl_remove,'value')    % preprocessed data
        nirsdataPre = data.preprocessed;
        xAxesPre = xAxes;
        if(1==get(handles.nirs_data_oxy,'value'))
            timeData = nirsdataPre.oxyData(:,K);
        end
        if(1==get(handles.nirs_data_dxy,'value'))
            timeData = nirsdataPre.dxyData(:,K);
        end
        if(1==get(handles.nirs_data_total,'value'))
            timeData = nirsdataPre.totalData(:,K);
        end
        for i=1:length(K)
            h(i,1) = plot(handles.nirs_data_timeserial,xAxesPre,timeData(:,i),'color',color(K(i),:),'linewidth',1);
            set(h(i),'DisplayName',['Ch ' num2str(K(i)) ' After']);
        end
    end
end
%% legend ͼ����ʾ
children = get(handles.nirs_data_timeserial,'Children');
children = sort(children);
obj = findobj('Tag','nirs_legend');
set(obj,'Value',1)
val = get(obj,'Value');
if ~isempty(children)
    if val == 1
        dispname = get(children,'DisplayName');
        lg = legend(handles.nirs_data_timeserial,dispname);
        set(lg,'FontSize',9)
    else
        legend(handles.nirs_data_timeserial,'off');
    end
else
    set(obj,'Value',0);
end
%

%% Motion Detection ��ʾͷ���������ֵ�ʱ���
button_active_color = {[1,0.6,0.784]};
button_inactive_color = {[0.941,0.941,0.941]};
hinck_all = get(handles.panel_ic_data,'Userdata');
%
for i = 1:length(hinck_all)
    button_name = get(hinck_all(i),'String');
    cur_val = get(hinck_all(i),'Value');
    if strcmp(button_name,'MotionArtifact')
         if cur_val == 1
             set(hinck_all(i),'BackgroundColor',button_active_color{:})
             data = get(hinck_all(i),'Userdata');
             num = data.icnum;
%              num = str2num( get(handles.nirs_data_channel,'String') );
             index = data.index(:,num);
             % find timeOn & timeDu of detection results
             timeOn = [];
             timeDu = [];
             for j = 1:length(index)
                 if j==1
                    if index(j)==1
                        timeOn(1) = 1;
                        timeDu(1) = find_first_zero(index,j);
                    end
                 elseif index(j-1)==0&&index(j)==1
                    dur = find_first_zero(index,j);
                    % make sure the "dur" of MA is at least "5s"
                    % ��ʾ������СΪ5s��ʱ�䴰
                    freq = 1/T;
                    tmp = ceil(freq*5);
                    if dur<tmp
                        p1 = j+ceil(dur/2);
                        ps = p1-ceil(tmp/2);
                        dur = tmp;
                        if ps < 0
                            ps = 0;
                        elseif ps+dur > length(index)
                            dur = length(index)-ps;
                        end
                    else
                        ps = j;
                    end
                    timeOn = [timeOn,ps];
                    timeDu = [timeDu,dur];
                 end
             end
             % combine overlap onset�����ص���ʱ�䴰�ϲ���
             tOn = [];
             tDu = [];
             mark = 0;
             if length(timeOn)>1
                 for k = 1:length(timeOn)-1
                    matrix1 = [timeOn(k):timeOn(k)+timeDu(k)];
                    matrix2 = [timeOn(k+1):timeOn(k+1)+timeDu(k+1)];
                    matrix3 = intersect(matrix1,matrix2);
                    if ~isempty(matrix3)&&mark==0
                        tOn = [tOn,timeOn(k)];
                        tDu = [tDu,length( union(matrix1,matrix2) )];
                        mark = 1;
                    elseif ~isempty(matrix3)&&mark==1
                        len1 = length(matrix3);
                        len2 = timeDu(k+1)-len1;
                        tDu(end) = tDu(end)+len2;
                    elseif isempty(matrix3)&&mark==1
                        mark = 0;
                    else
                        tOn = [tOn,timeOn(k)];
                        tDu = [tDu,timeDu(k)];
                        mark = 0;
                    end
                 end
                 
                 tOn = [tOn,timeOn(end)];
                 tDu = [tDu,timeDu(end)];
             end
             timeOn = tOn;
             timeDu = tDu;
             
             set(gcf,'CurrentAxes',handles.nirs_data_timeserial);

             yLimit = ylim(handles.nirs_data_timeserial);
             % ������ɫ����͸����
             for k = 1:length(timeOn)
                 sss = fill([timeOn(k) timeOn(k)+timeDu(k) timeOn(k)+timeDu(k) timeOn(k)],[yLimit(1) yLimit(1) yLimit(2) yLimit(2)],button_active_color{:},'LineStyle','none');
                 alpha(sss,0.5);
             end
             %% PLOT IC imformation
             NID_Detial_IC_drawTimeseries_MotionDetection(handles)
         else
             set(hinck_all(i),'BackgroundColor',button_inactive_color{:})
         end
         
    end
end

end

function dur = find_first_zero(index,pos)
endp = 0;
for i = pos:length(index)
    if i==length(index)
        endp = i;
        break
    else
        if index(i)==0&&index(i-1)==1
            endp = i-1;
            break
        end
    end
end
dur = endp-pos+1;
end