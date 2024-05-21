function NR_Network_viewResult(handles)

    statpath = get(handles.statpath,'string');
    outpath = get(handles.outpath,'string');
    load(statpath{1});
    indexList = get(handles.indexList,'string');
    indexValue = get(handles.indexList,'value');
    index = indexList{indexValue};
    indexType = NR_metricType(index);
    thresList = get(handles.thresList,'string');
    thresValue = get(handles.thresList,'value');
    thres = thresList{thresValue};
    % judge whether node or network
    % if network, create report form + group index map
    % if node, creat report form + node map
    switch indexType
        case 'Network' 
            % step one£ºcreate report form
            % get every t value and p value at each step longth
            eval(['p_oxy = statdata.stat_oxy.p_' index ';']);
            eval(['p_dxy = statdata.stat_dxy.p_' index ';']);
            eval(['p_total = statdata.stat_total.p_' index ';']);
            n = length(p_oxy);
            pValue = str2num(get(handles.pValue,'string'));
            method = get(handles.method,'value');
            switch method
                case 1
                    n = length(p_oxy);
                    result_oxy = zeros(1,n);
                    result_oxy(find(p_oxy<pValue))=1;
                    result_dxy = zeros(1,n);
                    result_dxy(find(p_dxy<pValue))=1;
                    result_total = zeros(1,n);
                    result_total(find(p_total<pValue))=1;
                case 2
                    result_oxy = NR_fdr_zc(p_oxy,pValue);
                    result_dxy = NR_fdr_zc(p_dxy,pValue);
                    result_total = NR_fdr_zc(p_total,pValue);
                case 3
                    result_oxy = zeros(1,n);
                    result_oxy(find(p_oxy<pValue/n))=1;
                    result_dxy = zeros(1,n);
                    result_dxy(find(p_dxy<pValue/n))=1;
                    result_total = zeros(1,n);
                    result_total(find(p_total<pValue/n))=1;
            end
            % Title of the table 
            varTitle_pos = {'Threshold'};
            varTitle_oxy = {'t(oxy)','p(oxy)','significant(oxy)'};
            varTitle_dxy = {'t(dxy)','p(dxy)','significant(dxy)'};
            varTitle_total = {'t(dxy)','p(dxy)','significant(total)'};
            % Data and Title
            varData_pos = [1:n]';
            eval(['varData_oxy = [statdata.stat_oxy.stat_' index ''' p_oxy'' result_oxy''];']);
            eval(['varData_dxy = [statdata.stat_dxy.stat_' index ''' p_dxy'' result_dxy''];']);
            eval(['varData_total = [statdata.stat_total.stat_' index ''' p_total'' result_total''];']);
            % create report form
            varTitle = [varTitle_pos,varTitle_oxy,varTitle_dxy,varTitle_total];
            varData = [varData_pos,varData_oxy,varData_dxy,varData_total];
            varOpt= [1,2,2,1,1,2,2,1,1,2,2,1,1];
            if get(handles.isReport,'value') == 1
                warning off;mkdir(outpath); 
                filepath  = makeFilepath(outpath,handles);
                saveFile = saveAsCsv(filepath,varTitle,varData,varOpt);
                try
                    winopen(saveFile);
                catch
                    system(['notepad ' saveFile '&']);
                end
            end
            % step two: make circle
            % select an indicator
            % make group
            groups = fieldnames(statdata.index_oxy);
            % set color
            colors={'r','g','b','m','k','y'};
            figure;  % oxy
            for group_i = 1:length(groups) % select group 
                eval(['this_index=statdata.index_oxy.' groups{group_i} '.' index ';'])   % get all values
                hold on;   % make figure
                NR_drawNetworkMetrics(this_index,str2num(statdata.Thres),colors{group_i},{'Sparsity',[index ' (by oxy)']});
            end
            legend(groups);
            % plot * on top acoording to result
            yLimit = ylim;
            X = str2num(statdata.Thres);
            for i = 1:length(result_oxy) 
                if result_oxy(i) == 1
                    plot(X(i),yLimit(2)*0.95,'*k');
                end
            end
            figure;  % dxy
            for group_i = 1:length(groups) % select group 
                eval(['this_index=statdata.index_dxy.' groups{group_i} '.' index ';'])   % get all values
                hold on;   % make figure
                NR_drawNetworkMetrics(this_index,str2num(statdata.Thres),colors{group_i},{'Sparsity',[index ' (by dxy)']});
            end
            yLimit = ylim;
            X = str2num(statdata.Thres);
            for i = 1:length(result_dxy) 
                if result_dxy(i) == 1
                    plot(X(i),yLimit(2)*0.95,'*k');
                end
            end
            legend(groups);
            figure;  % total
            for group_i = 1:length(groups) % select group
                eval(['this_index=statdata.index_total.' groups{group_i} '.' index ';'])   % get all value
                hold on;   % make figure
                NR_drawNetworkMetrics(this_index,str2num(statdata.Thres),colors{group_i},{'Sparsity',[index ' (by total)']});
            end
            legend(groups);
            yLimit = ylim;
            X = str2num(statdata.Thres);
            for i = 1:length(result_total) 
                if result_total(i) == 1
                    plot(X(i),yLimit(2)*0.95,'*k');
                end
            end

        % node index
        case 'Node'  %creat report form + node map
            
            % get every t value and p value at each step longth
            eval(['p_oxy = statdata.stat_oxy.p_' index '(:,thresValue);']);
            eval(['p_dxy = statdata.stat_dxy.p_' index '(:,thresValue);']);
            eval(['p_total = statdata.stat_total.p_' index '(:,thresValue);']);
            n = length(p_oxy);
            pValue = str2num(get(handles.pValue,'string'));
            method = get(handles.method,'value');
            switch method
                case 1
                    n = length(p_oxy);
                    result_oxy = zeros(1,n);
                    result_oxy(find(p_oxy<pValue))=1;
                    result_dxy = zeros(1,n);
                    result_dxy(find(p_dxy<pValue))=1;
                    result_total = zeros(1,n);
                    result_total(find(p_total<pValue))=1;
                case 2
                    result_oxy = NR_fdr_zc(p_oxy,pValue);
                    result_dxy = NR_fdr_zc(p_dxy,pValue);
                    result_total = NR_fdr_zc(p_total,pValue);
                case 3
                    result_oxy = zeros(1,n);
                    result_oxy(find(p_oxy<pValue/n))=1;
                    result_dxy = zeros(1,n);
                    result_dxy(find(p_dxy<pValue/n))=1;
                    result_total = zeros(1,n);
                    result_total(find(p_total<pValue/n))=1;
            end
            % Title of the table 
            varTitle_pos = {'CH'};
            varTitle_oxy = {'t(oxy)','p(oxy)','significant(oxy)'};
            varTitle_dxy = {'t(dxy)','p(dxy)','significant(dxy)'};
            varTitle_total = {'t(dxy)','p(dxy)','significant(total)'};
            % Data and Title
            varData_pos = [1:n]';
            eval(['varData_oxy = [statdata.stat_oxy.stat_' index '(:,thresValue) p_oxy result_oxy''];']);
            eval(['varData_dxy = [statdata.stat_dxy.stat_' index '(:,thresValue) p_dxy result_dxy''];']);
            eval(['varData_total = [statdata.stat_total.stat_' index '(:,thresValue) p_total result_total''];']);
            % create report form
            varTitle = [varTitle_pos,varTitle_oxy,varTitle_dxy,varTitle_total];
            varData = [varData_pos,varData_oxy,varData_dxy,varData_total];
            varOpt= [1,2,2,1,1,2,2,1,1,2,2,1,1];
            if get(handles.isReport,'value') == 1
                warning off;mkdir(outpath); 
                filepath  = makeFilepath(outpath,handles);
                saveFile = saveAsCsv(filepath,varTitle,varData,varOpt);
                try
                    winopen(saveFile);
                catch
                    system(['notepad ' saveFile '&']);
                end
            end
            if get(handles.isMap2d,'value') == 1
                figure;
                subplot(1,3,1);
                command = ['NR_plotNode(statdata.probe2d,statdata.stat_oxy.stat_' index '(:,thresValue),result_oxy,''r'');'];
                eval(command);   
                name = ['t-map of ' index ' (by oxy, ' 'thres=' thres ')'];
                title(name); 
                subplot(1,3,2);
                command = ['NR_plotNode(statdata.probe2d,statdata.stat_dxy.stat_' index '(:,thresValue),result_dxy,''r'');'];
                eval(command);  
                name = ['t-map of ' index ' (by dxy, ' 'thres=' thres ')'];
                title(name);  
                subplot(1,3,3);
                command = ['NR_plotNode(statdata.probe2d,statdata.stat_total.stat_' index '(:,thresValue),result_total,''r'');'];
                eval(command);  
                name = ['t-map of ' index ' (by total, ' 'thres=' thres ')'];
                title(name);   
            end
            if get(handles.isMap3d,'value')
                probe3d = statdata.probe3d;
                defaultModual = ones(size(probe3d,1),1);
                t_oxy = eval(['statdata.stat_oxy.stat_' index '(:,thresValue)']);
                t_dxy = eval(['statdata.stat_dxy.stat_' index '(:,thresValue)']);
                t_total = eval(['statdata.stat_total.stat_' index '(:,thresValue)']);
                data = [probe3d defaultModual t_oxy defaultModual];
                dlmwrite(fullfile(outpath,'t_oxy.node'), data, 'delimiter','\t','newline', 'pc')
                data = [probe3d defaultModual t_oxy defaultModual];
                dlmwrite(fullfile(outpath,'t_dxy.node'), data, 'delimiter','\t','newline', 'pc')
                data = [probe3d defaultModual t_oxy defaultModual];
                dlmwrite(fullfile(outpath,'t_total.node'), data, 'delimiter','\t','newline', 'pc')
            end
    end
end


function isok = NR_fdr_zc(p,q)
    %sort
    [Y,index]=sort(p);
    %i
    N = length(p);
    I=zeros(1,N);
    for j = 1:length(index)
        I(index(j))=j;
    end
    %q
    isok=zeros(1,N);
    for i = 1:N
        qq=p(i)*N/I(i);
        if qq < q
            isok(i)=1;
        end
    end
end

function saveFile = saveAsCsv(filepath,strings,matx,intOfloat)
    
    fileID = fopen(filepath,'wt');
    backNum = 0;
    [pathstr, name, ext] = fileparts(filepath);
    while fileID == -1
        backNum = backNum+1;
        filepath = fullfile(pathstr,[[name '(' num2str(backNum) ')'] ext]);
        fileID = fopen(filepath,'wt');
    end
    %print column names
    for k=1:length(strings)-1
        if intOfloat(k)
            fprintf(fileID,'%s,   ',strings{k});
        else
            fprintf(fileID,',   ',strings{k});
        end
    end
    fprintf(fileID,'%s\n',strings{end});
    %print data
    for linen=1:size(matx,1)
        for k=1:length(strings)-1
            switch intOfloat(k)
                case 0
                    fprintf(fileID,',   ',matx(linen,k));
                case 1
                    fprintf(fileID,'%g,   ',matx(linen,k));
                case 2
                    fprintf(fileID,'%.4f,   ',matx(linen,k));
            end
        end
        switch intOfloat(end)
            case 0
                fprintf(fileID,'\n',matx(linen,end));
            case 1
                fprintf(fileID,'%g\n',matx(linen,end));
            case 2
                fprintf(fileID,'%.4f\n',matx(linen,end));
        end
    end
    fclose(fileID);
    saveFile = filepath;
end

function filepath  = makeFilepath(outpath,handles)
    indexList = get(handles.indexList,'string');
    indexValue = get(handles.indexList,'value');
    index = indexList{indexValue};
    thresList = get(handles.thresList,'string');
    thresValue = get(handles.thresList,'value');
    thres = thresList{thresValue};
    methodList = get(handles.method,'string');
    methodValue = get(handles.method,'value');
    method = methodList{methodValue};
    pValue = get(handles.pValue,'string');
%     filepath = [outpath '\TestResult(' index ',thres=' thres ',' method ' corrected,p=' num2str(pValue) ').csv'];
    filepath = fullfile(outpath,['TestResult_',index,'_thres_',thres, '_',method,'corrected_p_',num2str(pValue),'.csv']);
end

