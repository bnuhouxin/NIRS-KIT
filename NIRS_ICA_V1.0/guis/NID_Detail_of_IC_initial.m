function NID_Detail_of_IC_initial(ax_fig,NIDHandles,DetailHandles,order)
%% ��������Detail�����ʼ��
%% initialise NIRS info.
handlesAll.ax_fig = ax_fig;
handlesAll.NIDHandles = NIDHandles;
handlesAll.DetailHandles = DetailHandles;
set(DetailHandles.NIRS_ICA_Denoiser_Detail_of_IC,'Userdata',handlesAll)
%
curicNum = get(ax_fig,'Userdata');                                          % ��ǰѡ�гɷֵı��
NID_Detail_NirsData_Set(curicNum,DetailHandles,NIDHandles)                  % ��ʼ��������NIRS������ʾ����
NID_Detail_IC_Set(curicNum,DetailHandles,NIDHandles,order)                  % ��ʼ�������гɷ�������ʾ����
end