function currentNum=NR_findCurrentNum(meshN)

    % find current channle\source\detector number of current probe

%debug
%     meshN=[0,0,1001;-1001,-1002,0;-2000,0,0];
%end of debug
    currentNum=[0,0,0];
    range=[-1999,-1000;1000,1999;-2999,-2000];
    for i=1:3
        tmp=meshN(meshN<=range(i,2));
        tmp=tmp(tmp>=range(i,1));
        maxmod=mod(max(abs(tmp)),1000);
        if ~isempty(maxmod)
            currentNum(i)=mod(max(abs(tmp)),1000);
        end
    end
end