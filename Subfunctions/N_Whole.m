function N_Whole(handles)

% compute  ROI2Wholebrain-based funtional connectivity
inpathList = get(handles.inpathList,'string');
outpath = get(handles.outpath,'string');

%% caculate index
roiCh = str2num(get(handles.seedchannel,'string'));


method = get(handles.method,'value');
h_wait = waitbar(0, 'Please wait... ');

files = dir(fullfile(inpathList,'*.mat'));
n = length(files);

% indexmeandata.indexmean_oxy = [];
% indexmeandata.indexmean_dxy = [];
% indexmeandata.indexmean_total = [];

for i=1:n
    load(fullfile(inpathList,files(i).name)); % =========================
    subid=files(i).name(1:end-4); % ====
    
    %indexdata.probeSet = nirsdata.probeSet;
    indexdata.system = nirsdata.system;
    indexdata.subject = nirsdata.subject;
    indexdata.nch = nirsdata.nch;
    indexdata.roiCh = roiCh;
    indexdata.index_discription = 'roi2wholebrain functional connectivity ';
    indexdata.probe2d = nirsdata.probe2d;
    indexdata.probe3d = nirsdata.probe3d;
    if isfield(nirsdata,'exception_channel')
        indexdata.exception_channel = nirsdata.exception_channel;
    else
        indexdata.exception_channel = zeros(1,nirsdata.nch);
    end
    
    if method == 1
        indexdata.method = 'Pearson correlation'; 
        if isfield(nirsdata,'exception_channel')
            exclusive_Ch = nirsdata.exception_channel(indexdata.roiCh);
            used_roiCh = indexdata.roiCh(exclusive_Ch == 0);
            
            if isempty(used_roiCh)
                warndlg({['Please check the raw data for subject ',nirsdata.subject];'If there are too many excusive channels for ROI1'});
            else
                index_oxy = NR_corr(nirsdata.oxyData,used_roiCh);
                index_oxy(nirsdata.exception_channel == 1) = NaN;
                
                index_dxy = NR_corr(nirsdata.dxyData,used_roiCh);
                index_dxy(nirsdata.exception_channel == 1) = NaN;
                
                index_total = NR_corr(nirsdata.totalData,used_roiCh);
                index_total(nirsdata.exception_channel == 1) = NaN;
            end
            

        else
            index_oxy = NR_corr(nirsdata.oxyData,indexdata.roiCh);
            index_dxy = NR_corr(nirsdata.dxyData,indexdata.roiCh);
            index_total = NR_corr(nirsdata.totalData,indexdata.roiCh);
        end        
    end
    
%     if method == 2
%         indexdata.method = 'GLM';
%         index_oxy = NR_glm(nirsdata.oxyData,roiCh1);
%         index_dxy = NR_glm(nirsdata.dxyData,roiCh1);
%         index_total = NR_glm(nirsdata.totalData,roiCh1);
%     end

    waitbar(i/length(files), h_wait, 'Calculating FC ... ...');
    
    % =========================== save FCROI ==========================
    if get(handles.zScore,'value')~=1
        if get(handles.Oxy,'value')
            indexdata.index=index_oxy;
            outpathn=fullfile(outpath,'FC_Whole','Oxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Dxy,'value')
            indexdata.index=index_dxy;
            outpathn=fullfile(outpath,'FC_Whole','Dxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Total,'value')
            indexdata.index=index_total;
            outpathn=fullfile(outpath,'FC_Whole','Total');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
    end
    
    % z-score data ====================================================
    if get(handles.zScore,'value')
        index_oxy = atanh(index_oxy);
        index_dxy = atanh(index_dxy);
        index_total = atanh(index_total);
        
        if get(handles.Oxy,'value')
            indexdata.index=index_oxy;
            outpathn=fullfile(outpath,'zFC_Whole','Oxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Dxy,'value')
            indexdata.index=index_dxy;
            outpathn=fullfile(outpath,'zFC_Whole','Dxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Total,'value')
            indexdata.index=index_total;
            outpathn=fullfile(outpath,'zFC_Whole','Total');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
    end
end

waitbar(1, h_wait, 'FC calculating finished !');
pause(1);
close(h_wait);
end
