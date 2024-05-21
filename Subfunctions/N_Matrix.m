function N_Matrix(handles)
% | ----------------------------------------------------------------------|
% |                            FC Matrix analysis                         |
% | ----------------------------------------------------------------------|
%% ======================== UI path ==============================
inpathList = get(handles.inpathList,'string');
outpathAll = get(handles.outpath,'string');
%%
% ================= FC correlation matrix, step by step ===================
h_wait = waitbar(0, 'Calculating Matrix ... ');

files =dir(fullfile(inpathList,'*.mat'));

for i=1:length(files)
    % =========================================================================
    % computing correlation matrix
    load(fullfile(inpathList,files(i).name));
    subid=files(i).name(1:end-4); 
    
    
    oxyData = nirsdata.oxyData;
    dxyData = nirsdata.dxyData;
    totalData = nirsdata.totalData;
    
    if isfield(handles,'mask_channels')
        mask_channels = str2num(get(handles.mask_channels,'string'));
        oxyData = oxyData(:,mask_channels);
        dxyData = dxyData(:,mask_channels);
        totalData = totalData(:,mask_channels);
    end
    
    measurementType = get(handles.measurementType,'value');
    
    N = size(oxyData,2);
    RMatrix_oxy = zeros(N,N);
    RMatrix_dxy = zeros(N,N);
    RMatrix_total = zeros(N,N);
    for m=1:N
        for n=1:N
            switch measurementType
                case 1
                    RMatrix_oxy(m,n) = corr(oxyData(:,m),oxyData(:,n));
                    RMatrix_dxy(m,n) = corr(dxyData(:,m),dxyData(:,n));
                    RMatrix_total(m,n) = corr(totalData(:,m),totalData(:,n));
                case 2
            end
        end
    end
    
    % ================ Exclusive the exceptional channels ================
    if isfield(nirsdata,'exception_channel')
       RMatrix_oxy(nirsdata.exception_channel == 1,:) = NaN;
       RMatrix_oxy(:,nirsdata.exception_channel == 1) = NaN;
       
       RMatrix_dxy(nirsdata.exception_channel == 1,:) = NaN;
       RMatrix_dxy(:,nirsdata.exception_channel == 1) = NaN;
       
       RMatrix_total(nirsdata.exception_channel == 1,:) = NaN;
       RMatrix_total(:,nirsdata.exception_channel == 1) = NaN;
    end
    % ================ Exclusive the exceptional channels ================
    
    % ===========set the diagonal value of the matrix = 0==========
    RMatrix_oxy(1:size(RMatrix_oxy,1)+1:end)=0;
    RMatrix_dxy(1:size(RMatrix_dxy,1)+1:end)=0;
    RMatrix_total(1:size(RMatrix_total,1)+1:end)=0;
    
    % ========================= save FC Matrux ====================
    if get(handles.zScore,'value')~=1
        if get(handles.Oxy,'value')
            oxydir=fullfile(outpathAll,'FC_Matrix','Oxy');
            warning off;mkdir(oxydir);
            save(fullfile(oxydir,[subid,'.txt']),'RMatrix_oxy','-ascii');
        end
        
        if get(handles.Dxy,'value')
            dxydir=fullfile(outpathAll,'FC_Matrix','Dxy');
            warning off;mkdir(dxydir);
            save(fullfile(dxydir,[subid,'.txt']),'RMatrix_dxy','-ascii');
        end
        
        if get(handles.Total,'value')
            totaldir=fullfile(outpathAll,'FC_Matrix','Total');
            warning off;mkdir(totaldir);
            save(fullfile(totaldir,[subid,'.txt']),'RMatrix_total','-ascii');
        end
    end
    % ====================================fz===================================
    if get(handles.zScore,'value') % ==========fztransfer==========
        % fisherztrans
        fzRMatrix_oxy=fisherztrans(RMatrix_oxy);
        fzRMatrix_dxy=fisherztrans(RMatrix_dxy);
        fzRMatrix_total=fisherztrans(RMatrix_total);
                
        % ====================== save zFC Matrix ==================
        if get(handles.Oxy,'value')
            zoxydir=fullfile(outpathAll,'zFC_Matrix','Oxy');
            warning off;mkdir(zoxydir);
            save(fullfile(zoxydir,[subid,'.txt']),'fzRMatrix_oxy','-ascii');
        end
        
        if get(handles.Dxy,'value')
            zdxydir=fullfile(outpathAll,'zFC_Matrix','Dxy');
            warning off;mkdir(zdxydir);
            save(fullfile(zdxydir,[subid,'.txt']),'fzRMatrix_dxy','-ascii');
        end
        
        if get(handles.Total,'value')
            ztotaldir=fullfile(outpathAll,'zFC_Matrix','Total');
            warning off;mkdir(ztotaldir);
            save(fullfile(ztotaldir,[subid,'.txt']),'fzRMatrix_total','-ascii');
        end
    end
    % =========================================================================
    waitbar(i/length(files), h_wait, 'Calculating Matrix ... ...');
end

waitbar(1, h_wait, 'Data preprocess finished !');
pause(1);
close(h_wait);
end