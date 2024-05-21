function NID_Detial_IC_drawTimeseries_MotionDetection(handles)
%% �ڶ����ɷ֣�IC��������ʾ�����Ǵ�ͷ���������ֵ�λ��
% check
icdata = get(handles.ic_data_timeserials,'userdata');
nirsdata = get(handles.nirs_data_timeserial,'userdata');

icRaw = icdata.time;

cla(handles.ic_data_timeserials);
hold(handles.ic_data_timeserials,'on');
set(handles.ic_data_timeserials,'YLimMode','auto');
T =  nirsdata.raw.T;
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
%% Motion Artifact Detection
button_active_color = {[1,0.6,0.784]};
button_inactive_color = {[0.941,0.941,0.941]};
hinck_all = get(handles.panel_ic_data,'Userdata');
%%
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
             
             % combine overlap onset
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
             
             set(gcf,'CurrentAxes',handles.ic_data_timeserials);

             yLimit = ylim(handles.ic_data_timeserials);
             % "color stride" form
             for k = 1:length(timeOn)
                 sss = fill([timeOn(k) timeOn(k)+timeDu(k) timeOn(k)+timeDu(k) timeOn(k)],[yLimit(1) yLimit(1) yLimit(2) yLimit(2)],button_active_color{:},'LineStyle','none');
                 alpha(sss,0.5);
             end
         else
             set(hinck_all(i),'BackgroundColor',button_inactive_color{:})
         end
    else
        set(hinck_all(i),'Value',0,'BackgroundColor',button_inactive_color{:});
        legend off
        NID_Detail_IC_drawFreq(handles)
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
