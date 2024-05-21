function [mtx_id,node_edge]=fc_matrix_plot(handles)

% Pre setting
inpath_mtx=get(handles.inpath_mtx,'string');

if strcmp(inpath_mtx(end-2:end),'mat')
    load(inpath_mtx);
    mtx_raw=statdata.stat;
    if isfield(statdata,'p')
        p_raw=statdata.p;
    end
    
    thres_mtx=str2num(get(handles.mtx_thres_p,'string'));
    
    if ~isempty(thres_mtx)
        mtx_raw(find(p_raw > thres_mtx))=0;
    end
elseif strcmp(inpath_mtx(end-2:end),'txt')
    mtx_raw=load(inpath_mtx);
    statdata.mask_channels=1:size(mtx_raw,1);
end

min_mtx=str2num(get(handles.min_mtx,'string'));
max_mtx=str2num(get(handles.max_mtx,'string'));

 
% Stat Plot

screensize=get(0,'ScreenSize');
fig_size=min(screensize(3:4));
mtx_id = figure('Color',[1 1 1],'Position',[100 50 fig_size-100 fig_size-200]);

if get(handles.is_adv_opt,'userdata') ==2
    xls_name=get(handles.subnet_xls_path,'string');
    xls_path=get(handles.subnet_xls_path,'userdata');
    
    [~, ~, mtx_xls] = xlsread(fullfile(xls_path,xls_name));
    mtx_xls = mtx_xls(2:end,:);
    mtx_xls(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),mtx_xls)) = {''};
    [mm,nn]=size(mtx_xls);
    
    ch_ord=cell2mat(mtx_xls(:,1));
    for ii=1:mm
        re_ord(ii)=find(statdata.mask_channels==ch_ord(ii));
        ch_str{ii,1}=['Ch',num2str(mtx_xls{ii,1})];
    end
    
    mtx_raw=mtx_raw(re_ord,re_ord);
    
    x_label=mtx_xls(:,1)';
    [C,~,~]=unique(cell2mat(mtx_xls(:,2)));
    n_subnet=length(C);
    
    for jj=1:n_subnet
        B(jj,1)=max(find(cell2mat(mtx_xls(:,2))==C(jj)));
    end
    
    B=[0;B];
    
    for ii=1:n_subnet
       y_label(ii,1)=mtx_xls(B(ii+1),3);
       n_subn(ii)=B(ii+1)-B(ii);
       color_subn{ii}=cell2mat(mtx_xls(B(ii+1),4:6))/255;
       tickposy(ii)= B(ii)+(B(ii+1)-B(ii))/2;
    end
    
    % generate node and Edge data -----------------------------------------
    if get(handles.is_node_edge,'value')
        node_edge.Edge=mtx_raw;
        node_edge.Node=mtx_xls(:,7:9);
        node_edge.Node(:,4)=mtx_xls(:,2);
        node_edge.Node(:,5)=mtx_xls(:,10);
        node_edge.Node(:,6)=ch_str;
    else
        node_edge=[];
    end
    % generate node and Edge data -----------------------------------------
    
    if get(handles.is_gridlines,'value')
        mtx_pcolor=flipud(mtx_raw);
        mtx_pcolor(end+1,end+1)=0;
        pcolor(mtx_pcolor);set(gca,'CLim',[min_mtx,max_mtx]);
        
        tickposx=(1:size(mtx_raw))+0.55;
        tickposy=mm-tickposy+1;
        tickposy=fliplr(tickposy);
        y_label=flipud(y_label);        
    else
        imagesc(mtx_raw,[min_mtx,max_mtx]);
        tickposx=(1:size(mtx_raw))+0.2;
        tickposy=tickposy+0.5;
    end
    axis square;            
    
    ax=axis;
    set(gca,'linewidth',1.5); % box linewidth

    set(gca,'XTick',tickposx,'Xlim',[ax(1) ax(2)]); % XTicks position
    set(gca,'YTick',tickposy,'Ylim',[ax(3) ax(4)]); % YTicks position
    set(gca,'XTicklabel',x_label);
    set(gca,'YTicklabel',y_label);
    set(gca,'TickDir','in','TickLength',[0 0]);           
    
    if get(handles.is_gridlines,'value')
        transitions_x=B+1;
        transitions_y=mm-B(2:end)+1;
        hold on
        if get(handles.subnet_type,'value') == 1
            for ii=1:n_subnet
                rectangle('Position',[transitions_x(ii),transitions_y(ii),n_subn(ii),n_subn(ii)],'LineWidth',2.75,'EdgeColor',color_subn{ii});
            end
        elseif get(handles.subnet_type,'value') == 2
            for ii=1:n_subnet-1
                plot([0,max(xlim)],[transitions_y(ii),transitions_y(ii)],'k','linewidth',2.5);
                plot([transitions_x(ii+1),transitions_x(ii+1)],[0,max(ylim)],'k','linewidth',2.5);
            end
        end
    else
        transitions=B+0.5;
        hold on
        if get(handles.subnet_type,'value') == 1
            for ii=1:n_subnet
                rectangle('Position',[transitions(ii),transitions(ii),n_subn(ii),n_subn(ii)],'LineWidth',2.75,'EdgeColor',color_subn{ii});
            end
        elseif get(handles.subnet_type,'value') == 2
            for ii=1:n_subnet-1
                plot([0,max(xlim)],[transitions(ii+1),transitions(ii+1)],'k','linewidth',2.5);
                plot([transitions(ii+1),transitions(ii+1)],[0,max(ylim)],'k','linewidth',2.5);
            end
        end
    end
    
else
    node_edge=[];
    
    if get(handles.is_adv_opt,'userdata') == 0
        for ch_id = 1:length(statdata.mask_channels)
           ch_str{ch_id}=num2str(statdata.mask_channels(ch_id));
        end
        x_label=ch_str;
        y_label=ch_str;
    elseif get(handles.is_adv_opt,'userdata') == 1
        xls_name=get(handles.subnet_xls_path,'string');
        xls_path=get(handles.subnet_xls_path,'userdata');

        [~, ~, mtx_xls] = xlsread(fullfile(xls_path,xls_name));
        mtx_xls = mtx_xls(2:end,:);
        mtx_xls(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),mtx_xls)) = {''};
        [mm,nn]=size(mtx_xls);
        ch_ord=cell2mat(mtx_xls(:,1));
        for ii=1:mm
            re_ord(ii)=find(statdata.mask_channels==ch_ord(ii));
        end

        mtx_raw=mtx_raw(re_ord,re_ord);

        x_label=mtx_xls(:,1)';
        y_label=mtx_xls(:,1)';
    end
    
    if get(handles.is_gridlines,'value')
        mtx_pcolor=flipud(mtx_raw);
        mtx_pcolor(end+1,end+1)=0;
        pcolor(mtx_pcolor);set(gca,'CLim',[min_mtx,max_mtx]);
        
        tickposx=(1:size(mtx_raw))+0.55;
        tickposy=(1:size(mtx_raw))+0.5;
        
        y_label=fliplr(y_label);
    else
        imagesc(mtx_raw,[min_mtx,max_mtx]);
        
        tickposx=(1:size(mtx_raw))+0.2;
        tickposy=1:size(mtx_raw);
    end
        axis square;
        ax=axis;
        set(gca,'linewidth',1.5); % box linewidth

        set(gca,'XTick',tickposx,'Xlim',[ax(1) ax(2)]); % XTicks position
        set(gca,'YTick',tickposy,'Ylim',[ax(3) ax(4)]); % YTicks position
        set(gca,'XTicklabel',x_label);
        set(gca,'YTicklabel',y_label);
        set(gca,'TickDir','in','TickLength',[0 0]);
end
 
rotateXLabels(gca,90);
colorbar;  % colorbar('TickLength',[0 0]);
%
CMap_Str = get(handles.CMap,'string');
CMap_Typ = get(handles.CMap,'value');
CMap = CMap_Str{CMap_Typ};

if strcmp(CMap, 'parula')
    parula_cmp = which('parula');
    if ~isempty(parula_cmp)
        CMap = 'parula';
    else
        paruly_cmp = which('paruly');
        if ~isempty(paruly_cmp)
           CMap = 'paruly'; 
        else
           CMap = 'jet';
        end
    end
end
    
colormap(CMap);

end
