function NID_Detail_Get_BaseLine_NirsData(curicNum,NIDHandles,DetailHandles)
%% �������fNIRS���ݡ�Ӧ����������ģʽDetail��
% �������ݿ����ǣ�1��ԭʼfNIRS���ݣ���2�����ֳɷ֣���Ŀ��ɷ֣��Ƴ����fNIRS����
%%
targetIC = curicNum;            % Ŀ��ɷ�
selectedIC = get(NIDHandles.edit3,'String');        % �û�ѡ�е������ɷ�
dataIn = get(NIDHandles.NIRS_ICA_Denoiser,'UserData');
hbType = dataIn.hbType;
%
tmp = get(DetailHandles.nirs_data_timeserial,'UserData');
nirs_data = tmp.raw;
process_data  = tmp.raw;
color = tmp.color;
%
IC = dataIn.IC;
%% ���¼������
% ����1
if 1 == get(DetailHandles.bl_raw,'Value')
    nirs_data_new_remove = caculate_nirsdata(targetIC,IC,hbType);
    if strcmp(hbType,'OXY')
        process_data.oxyData = nirs_data_new_remove;
    elseif strcmp(hbType,'DXY')
        process_data.dxyData = nirs_data_new_remove;
    else
        process_data.totalData = nirs_data_new_remove;
    end
% ����2
elseif 1 == get(DetailHandles.bl_user,'Value')
    icremove = str2num(get(DetailHandles.edit28,'String'));
    nirs_data_new = caculate_nirsdata(icremove,IC,hbType);
    if strcmp(hbType,'OXY')
        nirs_data.oxyData = nirs_data_new;
    elseif strcmp(hbType,'DXY')
        nirs_data.dxyData = nirs_data_new;
    else
        nirs_data.totalData = nirs_data_new;
    end
    %
    if ~ismember(targetIC,icremove)
        icremove = [icremove,targetIC];
    end
    nirs_data_new_remove = caculate_nirsdata(icremove,IC,hbType);
    if strcmp(hbType,'OXY')
        process_data.oxyData = nirs_data_new_remove;
    elseif strcmp(hbType,'DXY')
        process_data.dxyData = nirs_data_new_remove;
    else
        process_data.totalData = nirs_data_new_remove;
    end
end
%%
data.raw = nirs_data;
data.color = color;
data.preprocessed = process_data;
set(DetailHandles.uipanel_bl,'UserData',data)
end

%% ����ICAȥ��
function nirs_data = caculate_nirsdata(icremove,ic,hbType)
icall = getfield(ic,hbType);
IC = icall.TC;
A = icall.SM;
%
Anew = A;
Anew(:,icremove) = 0;

nirs_data = IC*Anew';
end