function NID_Detail_of_IC_initial(ax_fig,NIDHandles,DetailHandles,order)
%% 将挑噪声Detail界面初始化
%% initialise NIRS info.
handlesAll.ax_fig = ax_fig;
handlesAll.NIDHandles = NIDHandles;
handlesAll.DetailHandles = DetailHandles;
set(DetailHandles.NIRS_ICA_Denoiser_Detail_of_IC,'Userdata',handlesAll)
%
curicNum = get(ax_fig,'Userdata');                                          % 当前选中成分的编号
NID_Detail_NirsData_Set(curicNum,DetailHandles,NIDHandles)                  % 初始化界面中NIRS数据显示部分
NID_Detail_IC_Set(curicNum,DetailHandles,NIDHandles,order)                  % 初始化界面中成分数据显示部分
end