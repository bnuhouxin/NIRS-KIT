function [ic_num,ic_value,ic_value_raw,names,thres,dataout] = NID_Auto_Labeling_Motion_Artifact_Detection(handles,ICA_Result)
%%
% MSTD please reference: How to detect and reduce movement artifacts in 
% near-infrared imaging using moving standard deviation and spline
% interpolation?
%% set motion detection parameters
spikelike_para = get(handles.spikelike,'Userdata');
Wins = spikelike_para.wins; % unit "second"
Thres = spikelike_para.thres;
MA_thres = spikelike_para.ma_thres;
%% get fNIRS data
Data = get(handles.NIRS_ICA_Denoiser,'Userdata');
nirsData = Data.nirs_data;
%% 
Wins = Wins*(1/nirsData.T);
Wins = floor(Wins);                                                         % ���ڴ�СΪ����

if mod(Wins,2)==0
    Wins = Wins+1;                                                          % ���ڳ���Ϊ�������������Ա��ڼ���
end

%% MSTD parameter
window = Wins;
thres_para1 = 4;                                                            % ��һ��Ұ���ж���ֵ�� 4����׼��
thres_para2 = Thres;                                                        % �ڶ���Ұ���ж���ֵ�� �����ֵ
%% initialize
ic_value = {};          
ic_value_raw = {};
ic_num = {};
dataout = {};
names{1} = 'MotionArtifact';
thres{1} = MA_thres;                                                        % ��ͷ��Ӱ�����������������ֵʱ���óɷ��ж�Ϊͷ���ɷ�
%% get "Moving STD(MSTD)" 
[nsample,ntc] = size(ICA_Result.TC);
mstd_all = zeros(nsample,ntc);
%
for n = 1:ntc
    mstd_all(:,n) = caculate_MSTD( ICA_Result.TC(:,n),window );
    mean_mstd = mean(mstd_all(:,n));
    % remove mean std
    mstd_all(:,n) = mstd_all(:,n) - mean_mstd;
end
%% label TC point that exceed the std threshold
Label_data = zeros(nsample,ntc);
threshold = zeros(1,ntc);
index = zeros(1,ntc);
%
for n = 1:ntc
    mstd = mstd_all(:,n);
    % get threshold for current tc
    T = find_thres(mstd,thres_para1,thres_para2);
    threshold(n) = T;
    % label tc
    tmp = find( abs(mstd)>=T );
    index(n) = length(tmp);
    if ~isempty(tmp)
        Label_data(tmp,n) = 1;
    end
end
% value is normalized to the max number of point exceed std threshold
index = index/(max(index));     %normalize
[ic_value{1},ic_num{1}] = sort(index,'descend');
ic_value_raw{1} = index;
%% ------------------------------------------------------------ %%
% find positon where oxy/dxy share the same derection of "spike"
% ��oxy/dxyͬ��仯��ʱ���
%% ------------------------------------------------------------ %%
%% Using "Running Corr" to decide the position of "MA"
% rc_thres = 0;
% [Label_data,RC] = NID_Auto_Labeling_MotionArtifactDetection_RC(handles,nirsData,rc_thres);

%% Using MSTD to decide the position of motion artifact
    
wb = waitbar(0,'Detecting MotionArtifact, Please wait ... ...');

oxydata = nirsData.oxyData;
dxydata = nirsData.dxyData;
%
[nsample,nch] = size(oxydata);
%
mstd_all_oxy = zeros(nsample,nch);
mstd_all_dxy = zeros(nsample,nch);
% ����ÿ��ͨ��fNIRS���ݵ�MSTDֵ
for ch = 1:nch
    waitbar(ch/nch);
    
    mstd_all_oxy(:,ch) = caculate_MSTD( oxydata(:,ch),window );
    mstd_all_dxy(:,ch) = caculate_MSTD( dxydata(:,ch),window );
    
    mean_mstd_oxy = mean(mstd_all_oxy(:,ch));
    mean_mstd_dxy = mean(mstd_all_dxy(:,ch));
    
    mstd_all_oxy(:,ch) = mstd_all_oxy(:,ch) - mean_mstd_oxy;
    mstd_all_dxy(:,ch) = mstd_all_dxy(:,ch) - mean_mstd_dxy;
end
close(wb)
% Ұ���������
Label_data_oxy = zeros(nsample,nch);
threshold_oxy = zeros(1,nch);
Label_data_dxy = zeros(nsample,nch);
threshold_dxy = zeros(1,nch);
thres_para1_oxy = 4;
thres_para2_oxy = 3;
thres_para1_dxy = 4;
thres_para2_dxy = 3;
% ��Ұ��
for ch = 1:nch
    mstd_oxy = mstd_all_oxy(:,ch);
    % get "threshold"
    T_oxy = find_thres(mstd_oxy,thres_para1_oxy,thres_para2_oxy);
    threshold_oxy(ch) = T_oxy;
    
    tmp_oxy = find( abs(mstd_oxy)>=T_oxy );
    if ~isempty(tmp_oxy)
        Label_data_oxy(tmp_oxy,ch) = 1;
    end
    %%
    mstd_dxy = mstd_all_dxy(:,ch);
    % get "threshold"
    T_dxy = find_thres(mstd_dxy,thres_para1_dxy,thres_para2_dxy);
    threshold_dxy(ch) = T_dxy;
    
    tmp_dxy = find( abs(mstd_dxy)>=T_dxy );
    if ~isempty(tmp_dxy)
        Label_data_dxy(tmp_dxy,ch) = 1;
    end
end

% find co-direction "spike"
%% edited by Yang
% Label_data = zeros(nsample,nch);
% for ch = 1:nch
%     ld = Label_data_oxy(:,ch) + Label_data_dxy(:,ch);
%     tmp = find( ld == 2 );
%     if ~isempty(tmp)
%         Label_data(tmp,ch) = 1;
%     end
% end
%% ------------------------------------------------------------ %%
%% output
dataout{1} = Label_data;

end

% caculate "Moving STD(MSTD)"
function mstd = caculate_MSTD(data,window)
len = length(data);
mstd = zeros(1,len);
%
if mod(window,2)==0
    errordlg('window is not a "odd" value.')
    return
end
%
k = (window-1)/2;
%

for i = 1:len
    if i<k+1
        mstd(i) = caculate_wstd( data(1:i+k) );
    elseif i > len-k
        mstd(i) = caculate_wstd( data(i-k:end) );
    else
        mstd(i) = caculate_wstd( data(i-k:i+k) );
    end
end

end

function wstd = caculate_wstd(data)
len = length(data);
squt_value = data.*data;
squt_sum = (sum(data))^2;

wstd = 1/len*sqrt( sum(squt_value)-(1/len)*squt_sum );
end

% caculate "threshold"
function thres = find_thres(mstd,para1,para2)
len = length(mstd);
thres = [];
%
std_mstd1 = std(mstd);
mean_mstd1 = mean(mstd);
%
thres1 = mean_mstd1 + para1*std_mstd1;
%
pos1 = find(mstd>thres1);
if isempty(pos1)
    thres = thres1;
else
    pos2 = setdiff([1:len],pos1);
    mstd2 = mstd(pos2);
    std_mstd2 = std(mstd2);
    mean_mstd2 = mean(mstd2);
    thres2 = mean_mstd2 + para2*std_mstd2;
    %
    thres = thres2;
end
end