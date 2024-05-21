function NID_PLOT(handles)
%% Plot time course or spatial mode in the main window
%%
dataIn = get(handles.NIRS_ICA_Denoiser,'Userdata');
% hbtype
hbType = dataIn.hbType;
%% Plot time course or spatial modes
% 
if 1 == get(handles.popupmenu2,'Value')
    feature = 'TC';
    funf = 'Timeserial';
elseif 2 == get(handles.popupmenu2,'Value')
    feature = 'TC';
    funf = 'Frequency';
elseif 3 == get(handles.popupmenu2,'Value')
    feature = 'SM';
    funf = 'Weight';
end
% get ica data
tmp = dataIn.IC;
tmp = getfield(tmp,hbType);
sort_ic = tmp.Sort;
Sort_selectRule = sort_ic.Sort_selectRule;
numSort_all = cellfun(@(x)find(strcmp(sort_ic.Sort_icName,x)),Sort_selectRule); 
% get application mode
% values1 = get(handles.radiobutton1,'Value');
% values2 = get(handles.radiobutton2,'Value');
% if values1 == 1 && values2 == 0 %for noise reduction
%     numSort = numSort_all(find(numSort_all<=3));
%     ic_interest = get(handles.edit3,'Userdata');
% elseif values1 == 0 && values2 == 1 % for extracting componenet of interest
%     numSort = numSort_all(find(numSort_all>3));
%     ic_interest = get(handles.text7,'Userdata');
% elseif values1 == 0 && values2 == 0
%     numSort = [];
%     ic_interest.selectIC = [];
%     ic_interest.muti_labelIC = [];
%     ic_interest.labelIC = [];
% end
% get the order of ica component
numSort=numSort_all;
ic_interest = get(handles.edit3,'Userdata');
order = NID_caculate_DisplayOrder(sort_ic,numSort,ic_interest,tmp);

%% ��ȡ��ʾ��Ҫ������
data = getfield(tmp,feature);
%% ��ȡ��ʾҳ���С
if strcmp(get(handles.small,'State'),'on')
    psize = 'Small';
elseif strcmp(get(handles.mid,'State'),'on')
    psize = 'Mid';
elseif strcmp(get(handles.big,'State'),'on')
    psize = 'Big';
end
%% ��ͼ
data = data';
prefix = 'NID_PLOT_';
suffix = '(handles,data,order,ic_interest,numSort)';
myfun = strcat(prefix,psize,'_',funf,suffix);           %NID_PLOT_Small_Timeserial
eval(myfun)                                            
end