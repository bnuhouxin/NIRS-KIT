function NR_plotNode(probe2d,t,p,color1,islabel)
% t:
% p:  
%     t=[];
    %% init
    if nargin < 5
        islabel = 0;
    end
    if nargin < 4
        color1 = [0.8,0,0];
    end
    if nargin < 3
        p = zeros(size(t));
    end
    %% debug
%     load('anova_group1_group2.mat');
% %     probe2d1 = statdata.probe2d{1,1}.probeSet;
% %     probe2d2 = statdata.probe2d{1,2}.probeSet;
%     probe2d = statdata.probe2d;
%     t = statdata.stat_oxy;
%     p = statdata.p_oxy;
%     p([1,5,11])=0;
    %% generate channel site
    channel_site = generateChannelSite(probe2d);
    %% generate sizes
    size_min = 20;  % set the marker size: min
    size_amplifier = 30; % set the marker size: amplifier
    t = abs(t);
    t_norm = (t-min(t))/(max(t)-min(t));
    t_size = abs(t_norm*size_amplifier)+size_min;
    %% draw
    color0 = [0.5,0.5,0.5];     %p==0 color
%     color1 = [0.8,0,0];         %p==1 color
%     figure;
    hold on;
    for i = 1:length(t_size)
        if p(i)==0
            color_cur = color0;
        else
            color_cur = color1;
        end
        plot(channel_site(i,1),channel_site(i,2),'MarkerFaceColor',[0 0 0],'MarkerSize',t_size(i),'Marker','.',...
            'LineStyle','none',...
            'Color',color_cur);
    end
    hold off;
    s_max = max(channel_site);
    s_min = min(channel_site);
    s_maxmin = s_max-s_min;
    s_maxmin_f = s_maxmin/6;
    if s_min(1)<s_max(1)
        xlim([s_min(1)-s_maxmin_f(1),s_max(1)+s_maxmin_f(1)]);
    end
    if s_min(2)<s_max(2)
        ylim([s_min(2)-s_maxmin_f(2),s_max(2)+s_maxmin_f(2)]);
    end
    %% label
    if islabel
    end
    
    set(gca,'xtick',[]);%delect x ticks
    set(gca,'ytick',[]); %delect y ticks
    set(gca,'box','on');
end

function channel_site=generateChannelSite(probe2d)
%channel_site : N*2, [x1,y1;x2,y2;...]
    mergeprobe=[];
    for i = 1:length(probe2d)
        tprobe=probe2d{i}.probeSet;
        % probe cut edge
        rowlr=getleftright(sum(tprobe>1000,2));
        collr=getleftright(sum(tprobe>1000,1));
        tprobe=tprobe(rowlr(1):rowlr(2),collr(1):collr(2));
        mergeprobe(1:size(tprobe,1), size(mergeprobe,2)+1:size(mergeprobe,2)+size(tprobe,2))=tprobe;
        mergeprobe(:,end+1)=0;
    end
    mergeprobe=mergeprobe(:,1:end-1);
% init
    maxM = size(mergeprobe,1);
    maxN = size(mergeprobe,2);
    Ratio = 6; 
    ButtonSize=[Ratio*1/(maxN*Ratio+maxN+1),Ratio*1/(maxM*Ratio+maxM+1)];
    GapSize=[1/(maxN*Ratio+maxN+1),1/(maxM*Ratio+maxM+1)];
% draw
    N = max(max(mergeprobe))-1000;
    LeftbottomPositon=[];
    for id = 1:N
        [i,j]=find(mergeprobe==1000+id);
        newPosition = [(GapSize(1)+ButtonSize(1))*(j-1)+ 2*GapSize(1), 1-(GapSize(2)+ButtonSize(2))*i];
        LeftbottomPositon=[LeftbottomPositon;  newPosition ];
    end
    channel_site = LeftbottomPositon;
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
