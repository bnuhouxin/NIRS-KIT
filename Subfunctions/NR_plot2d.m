function hot2d=NR_plot2d(handles)

% NR_plot2d is a universal 2-d interpolated map plot function
% input:
%   data: data to plot
%   probeSets: probe configuration
%   ylim

%%
    statpath = get(handles.inpath2d,'string');
    load(statpath);
    if exist('statdata','var')
        data=statdata.stat;
    elseif exist('indexdata','var')
        data=indexdata.index;
    end
    % generate 2D map
    
    if exist('statdata','var')
        probeSets = statdata.probe2d;
    elseif exist('indexdata','var')
        probeSets = indexdata.probe2d;
    end
    
    if ~isempty(get(handles.path2d,'string'))
        inpath2d=get(handles.path2d,'userdata');
        name2d = get(handles.path2d,'string');
        load(fullfile(inpath2d,name2d));
    elseif get(handles.isProbe2d,'value') == 1 
        if exist('statdata','var')
            if isempty(statdata.probe2d)
            msgbox('No probeset was selected. Please load corresponding file!!!','Warning');
            end
        elseif exist('indexdata','var')
            if isempty(indexdata.probe2d)
                msgbox('No probeset was selected. Please load corresponding file!!!','Warning');
            end
        end
    end

    min2d=str2num(get(handles.min2d,'string'));
    max2d=str2num(get(handles.max2d,'string'));
    ylimit=[min2d,max2d];
    hot2d=figure('Name','2D-Heatmap','position',[100 100 1500 300]);

    CMap_Str = get(handles.CMap,'string');
    CMap_Typ = get(handles.CMap,'value');
    CMap = CMap_Str{CMap_Typ};
    
    if strcmp(CMap, 'parula')
        parula_cmp = which('parula');
        if ~isempty(parula_cmp)
            CMap = 'parula';
        else
            paruly_cmp = which('paruly');
            if ~isempty(paruly)
               CMap = 'paruly'; 
            else
               CMap = 'jet';
            end
        end
    end
%%
    texts{length(data)}=0;
    for i=1:length(data)
        texts{i}=num2str(i);
    end
% should be adjusted later    
% main process
    for probeSetid = 1:length(probeSets)
        axes1= subplot(1,length(probeSets), probeSetid);
        probesetting=probeSets{probeSetid}.probeSet;
    	%init
        rowlr=getleftright(sum(probesetting>1000,2));
        collr=getleftright(sum(probesetting>1000,1));
        probesetting=probesetting(rowlr(1):rowlr(2),collr(1):collr(2));
        
        [xy,xyid]=findxy(probesetting); % get channel site x && y
        
        if get(handles.isInterpolation,'value')
            % plot with interpolation 
            mapping = topomap(data, probesetting);
            % draw imagesc
            imagesc(mapping,'Parent',axes1,ylimit);
            
            colormap(axes1,CMap);
            colorbar('EastOutside','peer',axes1);
            %set(axes1, 'Visible','off');
            set(axes1,'XTick',[],'YTick',[]);
            title(axes1, ['ProbeSet : ', num2str(probeSetid)]);
            daspect(axes1, [1 1 1]);
            % channel text
            xy(:,1)=xy(:,1)*size(mapping,2)/size(probesetting,2)-size(mapping,2)/size(probesetting,2)/2;
            xy(:,2)=xy(:,2)*size(mapping,1)/size(probesetting,1)-size(mapping,1)/size(probesetting,1)/2;
            text(xy(:,1),xy(:,2),texts(xyid),'Parent',axes1,'HorizontalAlignment','center'); 
        else
            % plot without interpolation
            circle_size=str2num(get(handles.circle_size,'string'));
            
            bgc=str2num(get(handles.gbc_value,'string'))/255;

            datamat=data(xyid)'; %---------------------------------------
            dotmat=[xy,datamat,xyid'];
            
            if exist('statdata','var')
                if isfield(statdata,'roiCh1')
                    [~,roich,~]=intersect(dotmat(:,4),statdata.roiCh1);
                    roi_mat=dotmat(roich,:);
                    [~,chid]=setdiff(dotmat(:,4),statdata.roiCh1);
                    dotmat=dotmat(chid,:);
                end
            elseif exist('indexdata','var')    
                if isfield(indexdata,'roiCh1')
                    [~,roich,~]=intersect(dotmat(:,4),indexdata.roiCh1);
                    roi_mat=dotmat(roich,:);
                    [~,chid]=setdiff(dotmat(:,4),indexdata.roiCh1);
                    dotmat=dotmat(chid,:);
                end
            end
            
            if get(handles.isEdge,'value')
                scatter(dotmat(:,1),dotmat(:,2),400*circle_size,dotmat(:,3),'filled','MarkerEdgeColor',[0 .5 .5]);
            else
                scatter(dotmat(:,1),dotmat(:,2),400*circle_size,dotmat(:,3),'filled');
            end
            
            if exist('statdata','var')
                if isfield(statdata,'roiCh1')
                    hold on;
                    scatter(roi_mat(:,1),roi_mat(:,2),400*circle_size,roi_mat(:,3),'MarkerEdgeColor',[1 0 0],'LineWidth',2);
                end
            elseif exist('indexdata','var')
                if isfield(indexdata,'roiCh1')
                    hold on;
                    scatter(roi_mat(:,1),roi_mat(:,2),400*circle_size,roi_mat(:,3),'MarkerEdgeColor',[1 0 0],'LineWidth',2);
                end
            end

            caxis(ylimit); % colorbar lim
            xlim([min(xy(:,1)-0.5),max(xy(:,1)+0.5)]);
            ylim([min(xy(:,2)-0.5),max(xy(:,2)+0.5)]);
            box on;
            
            colormap(axes1,CMap);
            colorbar('EastOutside','peer',axes1);
            %set(axes1, 'Visible','off');
            set(axes1,'XTick',[],'YTick',[]);
            title(axes1, ['ProbeSet : ', num2str(probeSetid)]);
            daspect(axes1, [1 1 1]);
            % channel text
            text(xy(:,1),xy(:,2),texts(xyid),'Parent',axes1,'HorizontalAlignment','center'); 
            set(gca,'YDir','reverse');
            set(gca,'color',bgc);
        end

    end
    set(hot2d,'color','w');
    set(gcf,'renderer','painters')
end


function [xy,xyid]=findxy(probesetting)
    xy=[];
    xyid=[];
    for rowi = 1:size(probesetting,1)
        for coli = 1:size(probesetting,2)
            if(probesetting(rowi,coli)>1000)
                xy(end+1,:)=[coli,rowi];
                xyid(end+1)=probesetting(rowi,coli)-1000;
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