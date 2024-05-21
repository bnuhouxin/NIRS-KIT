function NR_preview2(handles)

% step1£ºget probe set matrix as the input of preview
probeList = get(handles.probeList,'string');
allMatrix = get(handles.probeList,'userdata');
probeNum = get(handles.probeList,'value');
if isempty(probeList)
    return;
end
if ~iscell(probeList)
    probeName = probeList;
    matrix = allMatrix{1};
else
    probeName = probeList{probeNum};
    probeNum = get(handles.probeList,'value');
    matrix = allMatrix{probeNum};
end

% step2£ºmake circle
% set marker scale
markerSize = 30;
gapSize = markerSize/20;
% set figure size
[M,N] = size(matrix);
markerNumber = sum(sum(matrix~=0));  % marker number
channelNum=[];
markerCenterX=[];
markerCenterY=[];
for i=1:M
    for j=1:N
        if 0 == matrix(i,j)
            continue;
        end
        channelNum = [channelNum matrix(i,j)];
        positionX = markerSize*j+gapSize*j-0.5*markerSize;
        positionY = markerSize*(N-i)+gapSize*(N-i)+0.5*markerSize;
        markerCenterX=[markerCenterX positionX];
        markerCenterY=[markerCenterY positionY];
    end
end

probeMap = figure('NumberTitle', 'off', 'Name',probeName);
xlim1 = min(markerCenterX)-markerSize;
xlim2 = max(markerCenterX)+markerSize+3.5*markerSize;
ylim1 = min(markerCenterY)-markerSize;
ylim2 = max(markerCenterY)+markerSize;
mapSizeX = xlim2-xlim1;
mapSizeY = ylim2-ylim1;
set(probeMap,'position',[10,50,mapSizeX*2,mapSizeY*2]);

hold on;
markerEdgeColor = 'k';
for i=1:length(channelNum);
    if -1999 <= channelNum(i) && channelNum(i) <= -1000  % source
        plot(markerCenterX(i),markerCenterY(i),'o', 'MarkerSize',markerSize,'MarkerFaceColor','r','MarkerEdgeColor',markerEdgeColor);
        if -1999 <= channelNum(i) && channelNum(i) < -1000
            text(markerCenterX(i),markerCenterY(i),num2str(-(channelNum(i)+1000)),'HorizontalAlignment','center','color',[1 1 1]);
        end
    end
    if -2999 <= channelNum(i) && channelNum(i) <= -2000 % detector
        plot(markerCenterX(i),markerCenterY(i),'o', 'MarkerSize',markerSize,'MarkerFaceColor','b','MarkerEdgeColor',markerEdgeColor);
        if -2999 <= channelNum(i) && channelNum(i) < -2000
            text(markerCenterX(i),markerCenterY(i),num2str(-(channelNum(i)+2000)),'HorizontalAlignment','center','color',[1 1 1]);
        end
    end
    if channelNum(i)>=1000 % channel
        plot(markerCenterX(i),markerCenterY(i),'square', 'MarkerSize',markerSize,'MarkerFaceColor',[0.941 0.941 0.941],'MarkerEdgeColor',markerEdgeColor);
        if channelNum(i) > 1000
            text(markerCenterX(i),markerCenterY(i),num2str(channelNum(i)-1000),'HorizontalAlignment','center');
        end
    end
end
set(gca,'xtick',[]);%delect x ticks
set(gca,'ytick',[]); %delect y ticks

grid on

set(gca,'box','on');
xlim([xlim1 xlim2]);
ylim([ylim1 ylim2]);

% maker legend
markerCenterSourceX = max(markerCenterX)+2*markerSize;
markerCenterSourceY = max(markerCenterY);
plot(markerCenterSourceX,markerCenterSourceY,'o', 'MarkerSize',markerSize,'MarkerFaceColor','r','MarkerEdgeColor',markerEdgeColor);
text(markerCenterSourceX+0.6*markerSize,markerCenterSourceY,'Source','HorizontalAlignment','Left','FontSize',0.5*markerSize);

markerCenterDetectorX = max(markerCenterX)+2*markerSize;
markerCenterDetectorY = max(markerCenterY)-markerSize;
plot(markerCenterDetectorX,markerCenterDetectorY,'o', 'MarkerSize',markerSize,'MarkerFaceColor','b','MarkerEdgeColor',markerEdgeColor);
text(markerCenterDetectorX+0.6*markerSize,markerCenterDetectorY,'Detector','HorizontalAlignment','Left','FontSize',0.5*markerSize);

markerCenterDetectorX = max(markerCenterX)+2*markerSize;
markerCenterDetectorY = max(markerCenterY)-2*markerSize;
plot(markerCenterDetectorX,markerCenterDetectorY,'square', 'MarkerSize',markerSize,'MarkerFaceColor',[0.941 0.941 0.941],'MarkerEdgeColor',markerEdgeColor);
text(markerCenterDetectorX+0.6*markerSize,markerCenterDetectorY,'Channel','HorizontalAlignment','Left','FontSize',0.5*markerSize);

end



