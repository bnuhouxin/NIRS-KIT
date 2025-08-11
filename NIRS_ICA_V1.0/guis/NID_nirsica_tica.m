function [dataOut]=NID_nirsica_tica(dataIn,numIC,handles)
% perform fastica on individual data for single time
% dataIn: individual data (tp*ch)
% numIC: numIC for ICA decomposition
% dataOut: 

data=dataIn'; % ch*tp
numIC_indiv=numIC;
% ica parameter
% ap = get(handles.advance,'UserData');
% ap1 = ap.advance_p1;
% ap2 = ap.advance_p2;
% ap3 = ap.advance_p3;
% ap4 = ap.advance_p4;
% %
% if strcmp(ap2,'symmetric')
%     ap2 = 'symm';
% else
%     ap2 = 'defl';
% end

% advance_p1 = str2num( ap1 );

% if 1 == ap3
%     advance_p3 = 'pow3';
% elseif 2 == ap3
%     advance_p3 = 'tanh';
% elseif 3 == ap3
%     advance_p3 = 'gauss';
% elseif 4 == ap3
%     advance_p3 = 'skew';
% end

% advance_p4 = str2num( ap4 );

% using FastICA algorithm in FastICA v2.5 toolbox
% outputing IC (tc) and A (spatmap)
% A = zeros(numIC_indiv,36);

[IC_indiv A_indiv W_indiv]=fastica(data,'approach','defl',...
        'numOfIC',numIC_indiv,'g','tanh','finetune','tanh',...
        'stabilization','on',...
        'epsilon',0.00001,'maxNumIterations',10000,...
        'lastEig',numIC_indiv);
    
% calib with sign correction (but don't do z-score calibration)
% for j=1:numIC_indiv
%     maxVal=find(abs(A_indiv(:,j))==max(abs(A_indiv(:,j))));
%     maxVal=A_indiv(maxVal,j);
%     A_indiv(:,j)=A_indiv(:,j)*sign(maxVal);
%     IC_indiv(j,:)=IC_indiv(j,:)*sign(maxVal);
% end



% save tica result for all comp in one struct file.
dataOut.numIC=numIC_indiv;
dataOut.A=A_indiv;
dataOut.IC=IC_indiv;


