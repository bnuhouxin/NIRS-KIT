function [ic_num,ic_value,ic_value_raw,names,thres,dataout] = NID_Auto_Labeling_SpatialHomo(handles,ICA_Result)
%%
% This function evaluate the spatial homogenourse of the separated sources
% please ref Removal of the skin blood flow artifact in functional
% near-infrared spectroscopic imaging data through independent component analysis
thres_data = get(handles.homo,'Userdata');
SH_thres = thres_data.thres;
%% ����ɷ����ݿռ���Ϣ
ic_Spatial = ICA_Result.SM;
%% ��������ʼ��
ic_value = {};
ic_value_raw ={};
ic_num = {};
dataout = {};
names{1} = 'SpatialHomo';
thres{1} = SH_thres;
%% ����ռ�һ����ָ��CSU
[nsample,icnum] = size(ic_Spatial);
CSU_matrix = zeros(1,icnum);

for i = 1:icnum
    spatialdata = ic_Spatial(:,i);
    CSU_matrix(i) = caculate_CSU(spatialdata);
end
CSU_matrix_RAW = CSU_matrix;
%normalize ��һ��
SH_thres_new = SH_thres/max(CSU_matrix);
CSU_matrix = CSU_matrix/max(CSU_matrix);
%% Sorting ���ɷְ�CSU��С����
[ic_value{1},ic_num{1}] = sort(CSU_matrix,'descend');
ic_value_raw{1} = CSU_matrix_RAW;
%%
dataout{1} = CSU_matrix;
thres{1} = SH_thres_new;
end

% ����CSU��ֵ
function csu = caculate_CSU(spatialdata)
sd_std = std(spatialdata);
sd_mean = mean(spatialdata);

csu = abs(sd_mean/sd_std);
end