function NID_PLOT_Similarity(handles,fig_handles,num,numSort)
%% plot the value of metrics 
%% load NIRS data
dataIn = get(handles.NIRS_ICA_Denoiser,'Userdata');
IC = dataIn.IC;
hbType = dataIn.hbType;
IC = getfield(IC,hbType);
Sort = IC.Sort;
%% �ҳ�ѡ�еġ�׼��
numSort_a = [];
for k = 1:length(numSort)
    tag = Sort.Sort_icName{numSort(k)};
%     tag = strcat('sort_',tag);
    obj = findobj('Tag',tag);
    tmp = get(obj,'Value');  
    if 1 == tmp
        numSort_a = [numSort_a,numSort(k)];
    end
end
%% ֻ��ѡ��һ��׼��ʱ���ŶԳɷֽ��б��
numSort = numSort_a;
if length(numSort) ~= 1
    return
end
%%
Rules = Sort.Sort_icName{numSort};
%
% tag = strcat('sort_',Rules);
obj = findobj('Tag',Rules);
value = get(obj,'Value');
%%
detail_name = Sort.Sort_icName_Detail{numSort};
% detail_value = Sort.Sort_icValue{numSort};            % ��ʾָ��Ĺ�һ��֮���ֵ
detail_value = Sort.Sort_icValue_Raw{numSort};          % ��ʾָ���ԭʼֵ
%%
str = get(fig_handles,'String');
suffix = ' {';
%%
if value == 1
    if length(detail_name) == 1
        d_name = detail_name{:};
        d_val = detail_value{:};
        val = num2str(d_val(num));
        
        if length(val)>=4
            suffix = [suffix,d_name,'(',val(1:4),')/'];
        else
            suffix = [suffix,d_name,'(',val(1:end),')/'];
        end
        
    else
        for i = 1:length(detail_name)
            d_name = detail_name{i};
            d_val = detail_value{i};
            val = num2str(d_val(num));
            
            if length(val)>=4
                suffix = [suffix,d_name,'(',val(1:4),')/'];
            else
                suffix = [suffix,d_name,'(',val(1:end),')/'];
            end
        end
    end
suffix = [suffix,'}'];
strnew = [str,suffix];
set(fig_handles,'TooltipString',strnew,'String',strnew);

end
end