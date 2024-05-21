function IC = NID_OpenFileInitial_Do_ICA(handles)
%% NIRS ICA run ICA decomposition
dataIn = get(handles.NIRS_ICA_Denoiser,'UserData');
if isfield(dataIn.nirs_data,'T')
    fs = 1/dataIn.nirs_data.T;
    dataIn.nirs_data.fs=1/dataIn.nirs_data.T;
else
    fs = dataIn.nirs_data.fs;
    dataIn.nirs_data.T=1/dataIn.nirs_data.fs;
end

% Determine the number of IC and the hbtype
numIC_all = get(handles.icnum,'Userdata');
hbty_val =  get(handles.hbty,'Value');
ap = get(handles.advance,'UserData');

%% preprocessing step
if isfield(ap,'preprocessSet')
    dataIn.nirs_data=NID_preprocess(dataIn.nirs_data,ap.preprocessSet,hbty_val);
end

if 1 == hbty_val
    numIC = numIC_all.oxy;
    data = dataIn.nirs_data.oxyData;
elseif 2 == hbty_val
    numIC = numIC_all.dxy;
    data = dataIn.nirs_data.dxyData;
elseif 3 == hbty_val
    numIC = numIC_all.total;
    data = dataIn.nirs_data.totalData;
else
    errordlg('Error','Invalid Hemoglobin Type!')
    return
end

%% temporal or spatial ICA
% if get(handles.radiobutton12,'Value');
%     data = data';
% end

%  The default parameters of BSS
% if isempty(ap)
%     ap.advance_ica_alg = 'FastICA';
%     ap.advance_p1 = 'defl';
%     ap.advance_p2 = 'tanh';
%     ap.advance_p3 = '0.00001';
%     ap.advance_p4 = '10000';
%     set(handles.advance,'UserData',ap)
% end
%% temporal or spatial ICA
% if get(handles.radiobutton12,'Value');
%     data = data';
% end
%run BSS algorithms
%output dataOut.A, number of IC (row) x number of channel (column)
%dataOut.IC, number of IC (row) x number of sample (column)

%save the mean value of data of each channel
m_data=mean(data);

switch ap.advance_ica_alg
    case 'FastICA'
         %% fastICA
        disp('\n Performing Fast ICA ... \n');
        %FASTICA25
        if strcmp(ap.advance_p5,'TICA')
            %temporal ICA
            [fIC, fA, ~]=fastica(data','approach',ap.advance_p1,...
                'numOfIC',numIC,'g',ap.advance_p2,'finetune',ap.advance_p2,...
                'stabilization','on',...
                'epsilon',ap.advance_p3,'maxNumIterations',ap.advance_p4,...
                'lastEig',numIC);
            
            ICA_Result.TC = fIC';              % Time course of sources
            ICA_Result.SM = fA;                 % Spatial map of sources
            ICA_Result.numIC = numIC;           % Number of sources
            %mean IC(k,:)~=0, since mean was added back to components by
        else
            %spatial ICA
            [fA, fIC, ~]=fastica(data,'approach',ap.advance_p1,...
                'numOfIC',numIC,'g',ap.advance_p2,'finetune',ap.advance_p2,...
                'stabilization','on',...
                'epsilon',ap.advance_p3,'maxNumIterations',ap.advance_p4,...
                'lastEig',numIC);
            
            ICA_Result.TC = fIC;              % Time course of sources
            ICA_Result.SM = fA';                 % Spatial map of sources
            ICA_Result.numIC = numIC;           % Number of sources
        end
        
        %% std of A and IC have been adjusted (std(IC)=1)
        %%output mean-removed source timecourse and spatial mode

    case 'InfomaxICA'
         %% Infomax ICA
        disp('\nTime(sceonds) for Infomax ICA ... \n');
        tic
        [weight_mat,sphere_mat]=Infomaxica(data','pca',numIC);
        umix_mat = weight_mat * sphere_mat;
        dataOut.A = umix_mat;
        dataOut.IC = umix_mat * data';
        dataOut.numIC = size(umix_mat,1);
        toc
    case 'ERBM'
%         tic
%         hi_kurt_s=1:numIC;   
%         lo_kurt_s=[];
%         hi_kurt_t=1:floor(numIC/2); 
%         lo_kurt_t=[floor(numIC/2)+1:numIC];    
%         alpha = 0.6;
%         W0 = eye(numIC,numIC)+randn(numIC,numIC)*0.9;
%         C1=[]; C2=[];
% 
%         [U, D, V] = svd(data', 0);
%         pcs=U; pct=V; sval=D;
%         pcs 	= pcs(:, 1:numIC); 
%         pct 	= pct(:, 1:numIC); 
%         sval 	= sval(1:numIC, 1:numIC); 
%         P=pcs*sqrt(sval);
%         Q=pct*sqrt(sval);
% 
%         [V1, d, S1, T1, w] = stica(P, Q, alpha, W0, hi_kurt_s,lo_kurt_s,hi_kurt_t,lo_kurt_t,C1,C2);    
%         dataOut.A = S1';
%         dataOut.IC = T1';
%         dataOut.numIC = numIC;
%         toc
        demix_mat=ERBM(data');
        dataOut.IC=demix_mat*data';
        dataOut.A=inv(demix_mat)';
        dataOut.numIC = numIC;
        for i=1:size(dataOut.IC,1)
            dataOut.IC(i,:)=(dataOut.IC(i,:)-mean(dataOut.IC(i,:)))./std(dataOut.IC(i,:));
        end
    case 'SOBI'
        disp('\n Performing SOBI ... \n');
        %defualt correlation matrix 100;
        if isempty(ap.advance_p1)
            [dataOut.A,dataOut.IC]=nirsica_sobi(data',numIC);
        else
            [dataOut.A,dataOut.IC]=nirsica_sobi(data',numIC,ap.advance_p1);
        end
        ICA_Result.numIC = numIC;
        ICA_Result.TC=dataOut.IC';
        ICA_Result.SM=dataOut.A;
        %normalize tc
        std_tc=std(ICA_Result.TC,0,1);
        for n=1:ICA_Result.numIC
            ICA_Result.TC(:,n)=ICA_Result.TC(:,n)./std_tc(n);
            ICA_Result.SM(:,n)=ICA_Result.SM(:,n).*std_tc(n);
         %%%tentative threshold to eliminate small values in A    
%             th=0.5;
%             ret=abs(dataOut.A(n,:))>(max(dataOut.A(n,:))*th);
%             dataOut.A(n,:)=dataOut.A(n,:).*ret;
        end
        %%output mean-removed source timecourse and spatial mode
    case 'PCA'
        [dataOut.A,eigen_mat]=pcamat(data',1,numIC);
        dataOut.A=dataOut.A';
        dataOut.IC = dataOut.A*data';
        dataOut.numIC = numIC;
end
% freqInfo
for j=1:numIC
    [f(:,j),IC_freqInfo(:,j)] = f_fft(ICA_Result.TC(:,j),fs);
end

% %% Result
%     ICA_Result.TC = (dataOut.IC)';              % Time course of sources
%     ICA_Result.SM = dataOut.A';                 % Spatial map of sources
%     ICA_Result.numIC = dataOut.numIC;           % Number of sources
ICA_Result.IC_freqInfo = IC_freqInfo;       % Frequency spectrum of time course
ICA_Result.m_rawdata=m_data;                % mean of raw data to be added back


%% ��ֵ
% oxy
if 1 == hbty_val
    IC.OXY = ICA_Result;
end
%dxy
if 2 == hbty_val
    IC.DXY = ICA_Result;
end
%tot
if 3 == hbty_val
    IC.TOT = ICA_Result;
end
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