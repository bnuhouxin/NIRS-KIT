function NR_topomap_plot(axes1,data,ylimit,probesetting)

% NR_topomap_plot plot 2-D map using data and probeset
% input
% axes1: the axes to plot map
% data: 2-D map data
% ylimit
% probesetting


% init
    if isempty(ylimit) % 'auto',
        y_upper=max(abs(data(:)));
        y_lower=min(abs(data(:)));
    else
        y_upper=ylimit(2); 
        y_lower=ylimit(1);
    end
    rowlr=getleftright(sum(probesetting>1000,2));
    collr=getleftright(sum(probesetting>1000,1));
    probesetting=probesetting(rowlr(1):rowlr(2),collr(1):collr(2));
    
% mapping = topomap(data, probesetting);
    mapping = topomap(data, probesetting);
% draw imagesc
    imagesc(mapping,'Parent',axes1,[-y_upper,y_upper]);
    colormap(axes1,jet);
    colorbar('EastOutside','peer',axes1);
    set(axes1, 'Visible','off');
    daspect([1 1 1]);
% channel text
    num=[min(probesetting(probesetting>1000)), max(probesetting(probesetting>1000))]-1000;
%     num=NR_findCurrentNum(probesetting);
    texts{num(2)}=0;
    for i=1:num(2)
        texts{i}=num2str(i);
    end
    xy=findxy(probesetting,num(2));
    xy(:,1)=xy(:,1)*size(mapping,2)/size(probesetting,2)-size(mapping,2)/size(probesetting,2)/2;
    xy(:,2)=xy(:,2)*size(mapping,1)/size(probesetting,1)-size(mapping,1)/size(probesetting,1)/2;
    text(xy(num(1):num(2),1),xy(num(1):num(2),2),texts(num(1):num(2)),'Parent',axes1,'HorizontalAlignment','center'); 
end
function xy=findxy(probesetting,num)
    xy=zeros(num,2);
    for rowi = 1:size(probesetting,1)
        for coli = 1:size(probesetting,2)
            if(probesetting(rowi,coli)>1000)
                xy(probesetting(rowi,coli)-1000,:)=[coli,rowi];
            end
        end
    end
end
function lr=getleftright(array)
    lr=[length(array),1];
    for i=1:length(array)
        if(array(i)>0)
            lr(1)=i;
            break;
        end
    end
    for i=length(array):-1:1
        if(array(i)>0)
            lr(2)=i;
            break;
        end
    end
end
function mapping = topomap(data, probesetting)
% probesetting fill in
    %origin
    map=zeros(size(probesetting));
    for i = 1:length(data)
        map(find(probesetting==1000+i))=data(i);
    end
    % Nearest-neighour interpolation
    direct=[0,1;0,-1;-1,0;1,0];
    for rowi = 1:size(map,1)
        for coli = 1:size(map,2)
            if(map(rowi,coli)~=0) continue; end
            tot=0;
            toti=0;
            for i = 1:4
                r=rowi+direct(i,1);
                c=coli+direct(i,2);
                if (inside(r,c,size(map)))
                    tot=tot+map(r,c);
                    toti=toti+1;
                end
            end
            map(rowi,coli)=tot/toti;
        end
    end
% map extend
    mapping=interp2(map,4,'cubic');
end

function ok=inside(r,c,sz)
    ok=1;
    if(r<1 || c<1)ok=0;end
    if(r>sz(1) || c>sz(2)) ok=0; end
end

% a debug sample
%    % figure; 
%     axes1=subplot(1,1,1); data=1:22;
%     ylimit=[];
%     load('system_3x5.mat');
%     probesetting=probeSets{1,1}.probeSet;
% end of debug