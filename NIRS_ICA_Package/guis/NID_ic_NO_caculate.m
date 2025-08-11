function icNum = NID_ic_NO_caculate(handles,parameter)
%% PCA��������ɷ��� or ����ֱ������ɷ���
%% load data
dataIn = get(handles.NIRS_ICA_Denoiser,'Userdata');
nirs_data = dataIn.nirs_data;
%%
select_val = get(handles.ic_num_caculate,'Value');
switch select_val
    case 1    % PCA
        if ~isempty(parameter)&&(parameter>0)&&(parameter<=1)
            power = parameter;
            icNum = NID_ic_NO_caculate_PCA(nirs_data,power);
        else
            errordlg('PCA Parameter is invalid!','Parameter Error')
        end
    case 2    % �û�����
        [sp,ch] = size(nirs_data.oxyData);
        if ~isempty(parameter)&&(parameter>0)&&(parameter<=ch)
            icNum.oxy = parameter;
            icNum.dxy = parameter;
            icNum.total = parameter;
        else
            icNum = [];
            errordlg('Input Parameter is invalid!','Parameter Error')
        end
end
%%
end