function [ic_num,ic_value,ic_value_raw,names,thres,dataout] = NID_Auto_Labeling_SpatialTemplate(handles,ICA_Result)
%% 计算成分与实验空间模板的相似性
% 参考文献：“Default-mode network activity distinguishes Alzheimer's 
% disease from healthy aging: Evidence from functional MRI”
%% 载入实验空间模板
data = get(handles.spatialtemplate,'Userdata');
dataSource = data.SP;
names = data.name;
thres = data.thres;
%% 载入成分在各通道的权值
ic_weigthInfo = ICA_Result.SM;
%%
N = length(dataSource);
ic_value = cell(1,N);
ic_value_raw = cell(1,N);
ic_num = cell(1,N);
dataout = cell(1,N);

for i = 1:length(dataSource)
    external_data = dataSource{i};
    %% 相关系数作为相似性度量参数
%     index = corr(external_data',ic_weigthInfo);
%     index = abs(index);
    
    %% “goodness of fit”作为相似性度量参数
    index = calculate_goodness_of_fit(external_data',ic_weigthInfo);
    
    index_RAW = index;
    thre_new = thres{i}/max(index);
    index = index/max(index);
    
    [ic_value{i},ic_num{i}] = sort(index,'descend');
    
    ic_value_raw{i} = index_RAW;
    thres{i} = thre_new;
    
    dataout{i} = external_data;
end

end

% 计算“Goodness of fit”参数
function index = calculate_goodness_of_fit(external_data,ic_weigthInfo)
[a,b] = size(ic_weigthInfo);
index = zeros(1,b);
for i = 1:b
    wi = ic_weigthInfo(:,i);
    % fisher_z transfer
%     wiz = fisher_z_transfor(wi);
    %edited by Zhaoyang standard_z_transform;
    wiz = (wi - mean2(wi))/std(wi);
    
    inTemplate = find(external_data == 1);
    outTemplate = find(external_data == 0);
    
    index(i) = mean( wiz(inTemplate) ) - mean( wiz(outTemplate) );
end

end
% % fisher-z变换
% function wiz = fisher_z_transfor(wi)
% len = length(wi);
% wiz = zeros(len,1);
% 
% for i = 1:len
%     r = wi(i);
%     wiz(i) = 0.5*exp( (1+r)/(1-r) );
% end
% 
% end