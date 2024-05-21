function [ic_num,ic_value,ic_value_raw,names,thres,dataout] = NID_Auto_Labeling_Timetemplate(handles,ICA_Result)
%% this function labelling sources by correlation them to temporal template
%% ����ο���
data = get(handles.timetemplate,'Userdata');
if isempty(data)
    design = ICA_Result.Sort.Sort_icDetail_data{4};
    names = ICA_Result.Sort.Sort_icName_Detail{4};
    thres = ICA_Result.Sort.Sort_threshold{4};
else
    design = data.design;
    names = data.name;
    thres = data.thres;
end
%% ����ɷ�����ʱ������
ic_timeseries = ICA_Result.TC;
%% ����������
N = length(design);
ic_value = cell(1,N);
ic_value_raw = cell(1,N);
ic_num = cell(1,N);
dataout = cell(1,N);

for i = 1:length(design)
    external_data = design{i};
    [a,b] = size(external_data);
    if b~=1
        external_data = external_data';
    end
    index = corr(external_data,ic_timeseries);
    ic_value_raw{i} = index;
    
    index = abs(index);     % ���������ϵ������
    [ic_value{i},ic_num{i}] = sort(index,'descend');
    
    dataout{i}.design = external_data;
    dataout{i}.onset = data.onset{i};
    dataout{i}.dur=data.dur{i};
end

end