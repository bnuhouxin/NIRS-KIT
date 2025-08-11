function [dataOut]=nirsica_tica(dataIn,ob_fuc,numIC)
% perform fastica on individual data for single time
% dataIn: individual data (tp*ch)
% numIC: numIC for ICA decomposition
% dataOut: 

data=dataIn'; % ch*tp
numIC_indiv=numIC;
% using FastICA algorithm in FastICA v2.5 toolbox
% outputing IC (tc) and A (spatmap)
[IC_indiv A_indiv W_indiv]=fastica(data,'approach','defl',...
        'numOfIC',numIC_indiv,'g',ob_fuc,'finetune',ob_fuc,...
        'stabilization','on',...
        'epsilon',0.00001,'maxNumIterations',10000,...
        'lastEig',numIC_indiv);
    
% calib with sign correction (but don't do z-score calibration)
for j=1:numIC_indiv
    maxVal=find(abs(A_indiv(:,j))==max(abs(A_indiv(:,j))));
    maxVal=A_indiv(maxVal,j);
    if length(maxVal) ~= 1
        maxVal = maxVal(1);
    end
    A_indiv(:,j)=A_indiv(:,j)*sign(maxVal);
    IC_indiv(j,:)=IC_indiv(j,:)*sign(maxVal);
end

% z-score transformation (for group-level analysis)
for j=1:numIC_indiv
    zA_indiv(:,j)=(A_indiv(:,j)-repmat(mean(A_indiv(:,j)),...
        size(A_indiv(:,j),1),1))/std(A_indiv(:,j));
    zIC_indiv(j,:)=(IC_indiv(j,:)-repmat(mean(IC_indiv(j,:)),...
        1,size(IC_indiv(j,:),2)))/std(IC_indiv(j,:));
end
%edited by Zhao Yang
% for j=1:numIC_indiv
%     zA_indiv(:,j)=A_indiv(:,j)/std(A_indiv(:,j));
%     zIC_indiv(j,:)=(IC_indiv(j,:)-repmat(mean(IC_indiv(j,:)),...
%         1,size(IC_indiv(j,:),2)))/std(IC_indiv(j,:));
% end


% save tica result for all comp in one struct file.
dataOut.numIC=numIC_indiv;
dataOut.A=A_indiv;
dataOut.IC=IC_indiv;
dataOut.zA=zA_indiv;
dataOut.zIC=zIC_indiv;

