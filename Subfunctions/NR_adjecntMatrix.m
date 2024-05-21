function NR_adjecntMatrix(handles,file,inpath,outpath)

    wholeFileIn = fullfile(inpath,[file(1:end-4),'_Matrix',file(end-3:end)]);
    wholeFileOut = fullfile(outpath,[file(1:end-4),'_adjecntMatrix',file(end-3:end)]);
    
    networkType = get(handles.networkType,'value');
    thresholdType = get(handles.thresholdType,'value');
    networkCut = get(handles.networkCut,'value');
    Thres = get(handles.thresholdRegion,'string');
    % using gretna to calculate Matrix
    if 1 == networkType
        NType='b';
    else
        NType='w';
    end
    switch thresholdType
        case 1  
            TType = 's';
        case 2  
            TType = 'r';
    end
    switch networkCut
        case 1  
            PType='p';
        case 2  
            PType='a';
    end
    root = which('NIRS_REST.m');
    [rootFolder, ~, ~] = fileparts(root);
    TempDir_oxy = fullfile(rootFolder,'temp',['MAT_',file(1:end-4),'_oxy']);
    TempDir_dxy = fullfile(rootFolder,'temp',['MAT_',file(1:end-4),'_dxy']);
    TempDir_total = fullfile(rootFolder,'temp',['MAT_',file(1:end-4),'_total']);
    
    % reading result file, then generaze new file
    load(wholeFileIn);
    gretna_GUI_SegmentThres(Matrix.Matrix_oxy, PType, NType, TType, Thres, TempDir_oxy);
    load(fullfile(TempDir_oxy,'SegMat.mat'));
    adjecntMatrix.A_oxy = A;
    gretna_GUI_SegmentThres(Matrix.Matrix_dxy, PType, NType, TType, Thres, TempDir_dxy);
    load(fullfile(TempDir_dxy,'SegMat.mat')); 
    adjecntMatrix.A_dxy = A;
    gretna_GUI_SegmentThres(Matrix.Matrix_total, PType, NType, TType, Thres, TempDir_total);
    load(fullfile(TempDir_total,'SegMat.mat'));
    adjecntMatrix.A_total = A;
    
    save(wholeFileOut,'adjecntMatrix');
    
end

