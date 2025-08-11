function icNum = NID_ic_NO_caculate_PCA(dataIn,power)
% Estimation of IC number using (power)% criteria
% oxy
data = dataIn.oxyData;
icNum.oxy = PCA(data,power);
% dxy
data = dataIn.dxyData;
icNum.dxy = PCA(data,power);
% total
data = dataIn.totalData;
icNum.total = PCA(data,power);
end

function icnum = PCA(data,power)
% data=data';
% Edited by Zhaoyang, Especially for spatial ICA, need Correction.201507
% Edited by Zhaoyang, Especially for temporal ICA, need Correction.20150819
[E, D]=pcamat(data,1,size(data,1),'off','off');
tempD=flipud(diag(D));
tempVar=zeros(1,length(tempD));
for j=1:length(tempD)
    tempVar(1,j)=sum(tempD(1:j))/sum(tempD);
end
[aa bb]=find(tempVar>=power);
icnum=bb(1,1);
end

