function meshN = NR_autoLabelMesh(meshN,K,currentNum)
% %debug
%     meshN=[0,1000,1001;-1001,-1002,-1000;-2000,0,-2001];
% %end of debug
    if nargin<2
        K=1; 
    end
    zes=[-1000;1000;-2000];
    if K==1
        for rowi=1:size(meshN,1)
            for coli=1:size(meshN,2)
                for i=1:3
                    if(meshN(rowi,coli)==zes(i))
                        currentNum(i)=currentNum(i)+1;
                        sign=1;
                        if(zes(i)<0) sign=-1; end
                        meshN(rowi,coli)=sign*(abs(zes(i))+currentNum(i));
                    end
                end
            end
        end
    end
    if K==2
        for coli=1:size(meshN,2)
            for rowi=1:size(meshN,1)
                for i=1:3
                    if(meshN(rowi,coli)==zes(i))
                        currentNum(i)=currentNum(i)+1;
                        sign=1;
                        if(zes(i)<0) sign=-1; end
                        meshN(rowi,coli)=sign*(abs(zes(i))+currentNum(i));
                    end
                end
            end
        end
    end
end