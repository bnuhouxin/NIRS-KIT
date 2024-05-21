function matrixData = NR_adjecntMatrix_old(nirsdata,handles)

    oxyData = nirsdata.oxyData;
    dxyData = nirsdata.dxyData;
    totalData = nirsdata.totalData;
    measurementType = get(handles.measurementType,'value');
    networkType = get(handles.networkType,'value');
    thresholdType = get(handles.thresholdType,'value');
    switch thresholdType
        case 1  
            thrType = 'r';
        case 2  
            thrType = 's';
    end
    exceptionalCh = str2num(get(handles.exceptionalCh,'string'));
    thresholdRegion = str2num(get(handles.thresholdRegion,'string'));
    
    N = size(oxyData,2);
    RMatrix_oxy = zeros(N,N);
    RMatrix_dxy = zeros(N,N);
    RMatrix_total = zeros(N,N);
    for i=1:N
        for j=1:N
            switch measurementType
                case 1
                    RMatrix_oxy(i,j) = corr(oxyData(:,i),oxyData(:,j));
                    RMatrix_dxy(i,j) = corr(dxyData(:,i),dxyData(:,j));
                    RMatrix_total(i,j) = corr(totalData(:,i),totalData(:,j));
                case 2
                    %
            end
        end
    end
    RMatrix_oxy = RMatrix_oxy(setdiff(1:N,exceptionalCh),setdiff(1:N,exceptionalCh));
    RMatrix_dxy = RMatrix_dxy(setdiff(1:N,exceptionalCh),setdiff(1:N,exceptionalCh));
    RMatrix_total = RMatrix_total(setdiff(1:N,exceptionalCh),setdiff(1:N,exceptionalCh));
    RMatrix_oxy = RMatrix_oxy-diag(diag(RMatrix_oxy));
    RMatrix_dxy = RMatrix_dxy-diag(diag(RMatrix_dxy));
    RMatrix_total = RMatrix_total-diag(diag(RMatrix_total));
    
    A_oxy=cell(length(thresholdRegion),1);
    A_dxy=cell(length(thresholdRegion),1);
    A_total=cell(length(thresholdRegion),1);
    s=0;
    for threshold = thresholdRegion
        s=s+1;
        [oxy, rthr] = gretna_R2b(RMatrix_oxy,thrType,threshold);
        [dxy, rthr] = gretna_R2b(RMatrix_dxy,thrType,threshold);
        [total, rthr] = gretna_R2b(RMatrix_total,thrType,threshold);
        A_oxy{s} = oxy;
        A_dxy{s} = dxy;
        A_total{s} = total;
    end
    matrixData.A_oxy = A_oxy;
    matrixData.A_dxy = A_dxy;
    matrixData.A_total = A_total;
    
end

