function NID_Detail_of_IC_Reserve_initial(ax_fig,NIDHandles,DetailHandles,order)
%% 将挑神经成分Detail界面初始化
%% initialise NIRS info.
handlesAll.ax_fig = ax_fig;
handlesAll.NIDHandles = NIDHandles;
handlesAll.DetailHandles = DetailHandles;
set(DetailHandles.NIRS_ICA_Denoiser_Detail_of_IC_Reserve,'Userdata',handlesAll)
%
curicNum = get(ax_fig,'Userdata');
NID_Detail_IC_Set_Reserve(curicNum,DetailHandles,NIDHandles,order)
end