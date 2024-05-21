function N_ROI(handles)
% compute  ROI-based funtional connectivity

inpathList = get(handles.inpathList,'string');
outpathAll = get(handles.outpath,'string');

%% caculate index
roiCh1 = str2num(get(handles.roichannel1,'string'));
roiCh2 = str2num(get(handles.roichannel2,'string'));
method = get(handles.method,'value');
h_wait = waitbar(0, 'Please wait... ');

% =====================================================================
files = dir(fullfile(inpathList,'*.mat'));
n = length(files);
indexmeandata.indexmean_oxy = [];
indexmeandata.indexmean_dxy = [];
indexmeandata.indexmean_total = [];

for i=1:n
    load(fullfile(inpathList,files(i).name)); % =========================
    subid=files(i).name(1:end-4); % ====
    
    indexdata.system = nirsdata.system;
    indexdata.subject = nirsdata.subject;
    indexdata.nch = nirsdata.nch;
    indexdata.roiCh1 = roiCh1;
    indexdata.roiCh2 = roiCh2;
    indexdata.index_discription = 'roi2roi functional connectivity ';
    indexdata.probe2d = nirsdata.probe2d;
    indexdata.probe3d = nirsdata.probe3d;
    if isfield(nirsdata,'exception_channel')
        indexdata.exception_channel = nirsdata.exception_channel;
    else
        indexdata.exception_channel = zeros(1,nirsdata.nch);
    end
       
    
    if method == 1
        indexdata.method = 'Pearson correlation';
        [index_oxy,index_dxy,index_total] = NR_corrROI(nirsdata,roiCh1,roiCh2);
    end
%     if method == 2
%         indexdata.method = 'GLM';
%         index_oxy = NR_glm(nirsdata.oxyData,roiCh1,roiCh2);
%         index_dxy = NR_glm(nirsdata.dxyData,roiCh1,roiCh2);
%         index_total = NR_glm(nirsdata.totalData,roiCh1,roiCh2);
%     end

    waitbar(i/length(files), h_wait, 'Calculating FC ... ...');
    
    % =========================== save FCROI ==========================
    if get(handles.zScore,'value')~=1
        if get(handles.Oxy,'value')
            indexdata.index=index_oxy;
            outpathn=fullfile(outpathAll,'FC_ROI','Oxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Dxy,'value')
            indexdata.index=index_dxy;
            outpathn=fullfile(outpathAll,'FC_ROI','Dxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Total,'value')
            indexdata.index=index_total;
            outpathn=fullfile(outpathAll,'FC_ROI','Total');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
    end
    
    % z-score data ====================================================
    
    if  get(handles.zScore,'value')
        index_oxy = atanh(index_oxy);
        index_dxy = atanh(index_dxy);
        index_total = atanh(index_total);
        
        if get(handles.Oxy,'value')
            indexdata.index=index_oxy;
            outpathn=fullfile(outpathAll,'zFC_ROI','Oxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Dxy,'value')
            indexdata.index=index_dxy;
            outpathn=fullfile(outpathAll,'zFC_ROI','Dxy');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
        
        if get(handles.Total,'value')
            indexdata.index=index_total;
            outpathn=fullfile(outpathAll,'zFC_ROI','Total');warning off;mkdir(outpathn);
            save(fullfile(outpathn,subid),'indexdata');
        end
    end
end

waitbar(1, h_wait, 'FC calculating finished !');
pause(1);
close(h_wait);
end

function [R_oxy,R_dxy,R_total] = NR_corrROI(nirsdata,SeedCh1,SeedCh2)

% Pearson correlation to calculate RSFC
 if isfield(nirsdata,'exception_channel')
    exclusive_SeedCh1 = nirsdata.exception_channel(SeedCh1);
    exclusive_SeedCh2 = nirsdata.exception_channel(SeedCh2);
    
    SeedCh1 = SeedCh1(exclusive_SeedCh1 == 0);
    SeedCh2 = SeedCh2(exclusive_SeedCh2 == 0);
    
    if isempty(SeedCh1) || isempty(SeedCh2) 
        if isempty(SeedCh1)
            warndlg({['Please check the raw data for subject ',nirsdata.subject];'If there are too many excusive channels for ROI1'});
        end
        if isempty(SeedCh2)
            warndlg({['Please check the raw data for subject ',nirsdata.subject];'If there are too many excusive channels for ROI2'});
        end
        R_oxy = NaN;
        R_dxy = NaN;
        R_total = NaN;
    else
        R_oxy = NR_corr2(nirsdata.oxyData,SeedCh1,SeedCh2);
        R_dxy = NR_corr2(nirsdata.dxyData,SeedCh1,SeedCh2);
        R_total = NR_corr2(nirsdata.totalData,SeedCh1,SeedCh2);    
    end
      
 else
    R_oxy = NR_corr2(nirsdata.oxyData,SeedCh1,SeedCh2);
    R_dxy = NR_corr2(nirsdata.dxyData,SeedCh1,SeedCh2);
    R_total = NR_corr2(nirsdata.totalData,SeedCh1,SeedCh2);    
 end
 
end

function R = NR_corr2(data,roi1,roi2)
    Seed1 = nanmean(data(:,roi1),2);
    Seed2 = nanmean(data(:,roi2),2);
    r = corrcoef(Seed1,Seed2);
    R = r(1,2);
end