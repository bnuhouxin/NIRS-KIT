function ICA_Result = NID_OpenFileInitial_Do_ICA_ica(dataIn,fs,hbtype,handles)
%% num of ic ��ȡ�����ɷ���Ŀ
numIC_all = get(handles.icnum,'Userdata');
numIC = getfield(numIC_all,hbtype);
%% �ж����������Ƿ��Ѿ�����ICA����
if isfield(dataIn,'IC')
    hbType = dataIn.hbType;
    ICA_Result = getfield(dataIn.IC,hbType);
    if ICA_Result.numIC ~= numIC
        if strcmp(hbType,'OXY')
            datain = dataIn.nirs_data.oxyData;
        elseif strcmp(hbType,'DXY')
            datain = dataIn.nirs_data.dxyData;
        elseif strcmp(hbType,'TOT')
            datain = dataIn.nirs_data.totalData;
        end
        %% ����fast-ICA����� ����ICA�ֽ�
        disp('\nTime(sceonds) for ICA ... \n');
        tic
        [dataOut]=NID_nirsica_tica(datain,numIC,handles);
        toc
        % freqInfo
        for j=1:numIC
            [f(:,j),IC_freqInfo(:,j)] = f_fft(dataOut.IC(j,:),fs);
        end

        %% Result
        ICA_Result.IC = (dataOut.IC)';
        ICA_Result.A = dataOut.A;
        ICA_Result.numIC = dataOut.numIC;
        ICA_Result.IC_freqInfo = IC_freqInfo;
        ICA_Result.IC_weigthInfo = dataOut.A;
    end
else   
    %% ����fast-ICA����� ����ICA�ֽ�
    disp('\nTime(sceonds) for ICA ... \n');
    tic
    [dataOut]=NID_nirsica_tica(dataIn,numIC,handles);
    toc
    % freqInfo
    for j=1:numIC
        [f(:,j),IC_freqInfo(:,j)] = f_fft(dataOut.IC(j,:),fs);
    end

    %% Result
    ICA_Result.IC = (dataOut.IC)';              % �ɷ�ʱ������
    ICA_Result.A = dataOut.A;                   % ��Ͼ���
    ICA_Result.numIC = dataOut.numIC;           % �ɷ���
    ICA_Result.IC_freqInfo = IC_freqInfo;       % �ɷ�Ƶ����Ϣ
    ICA_Result.IC_weigthInfo = dataOut.A;       % ��Ͼ���
end

%% Sorting Auto...����Ȥ�ɷ��Զ���Ǻ���
ICA_Result.Sort = NID_OpenFileInitial_Sorting(handles,ICA_Result);
end

function [f Y] = f_fft(data,fs)
 %-----����Ƶ��-----%
Fs = fs;                      % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(data);             % Length of signal
NFFT = 2^nextpow2(L);         % Next power of 2 from length of y ( p = nextpow2(A) That is, p that satisfies 2^p >= abs(A) ).
Y0 = fft(data,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
Y = 2*abs(Y0(1:NFFT/2+1));
end