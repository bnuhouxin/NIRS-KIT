function pageNum = NID_Caculate_pageNum(handles)
%% 计算主界面当前显示的页数
pageNum = 0;
%% load data
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
hbtype = dataIn.hbType;
IC = dataIn.IC;
%%
ic_struct = getfield(IC,hbtype);
icnum = ic_struct.numIC;
%%
if  strcmp(get(handles.small,'State'),'on')
    pageNum = ceil(icnum/25);
elseif strcmp(get(handles.mid,'State'),'on')
    pageNum = ceil(icnum/12);
elseif strcmp(get(handles.big,'State'),'on')
    pageNum = ceil(icnum/4);
end
end