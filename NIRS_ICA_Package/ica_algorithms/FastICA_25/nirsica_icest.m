function icNum=nirsica_icest(data)
% Estimation of IC number using 99% criteria

data=data';
[E, D]=pcamat(data,1,size(data,1),'off','off');
tempD=flipud(diag(D));
tempVar=zeros(1,length(tempD));
for j=1:length(tempD)
    tempVar(1,j)=sum(tempD(1:j))/sum(tempD);
end
[aa bb]=find(tempVar>=0.99);
icNum=bb(1,1);
