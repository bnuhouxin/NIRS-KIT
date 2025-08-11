function [ic_num,ic_value,ic_value_raw,names,thres,dataout] = NID_Auto_Labeling_External(handles,ICA_Result)
%% This function evaluate the similarity to external input of time series of ic
%% get external input 
data = get(handles.external,'Userdata');
dataSource = data.dataSource;
names = data.name;
thres = data.thres;
%% get timecourse of ICA
ic_timeseries = ICA_Result.TC;
%% 
N = length(dataSource);
ic_value = cell(1,N);
ic_value_raw = cell(1,N);
ic_num = cell(1,N);
dataout = cell(1,N);

for i = 1:length(dataSource)
    external_data = load(dataSource{i});
    index = corr(external_data.data,ic_timeseries);
    ic_value_raw{i} = index;
    
    index = abs(index); % 
    [ic_value{i},ic_num{i}] = sort(index,'descend');
    
    dataout{i} = external_data.data;
end

end