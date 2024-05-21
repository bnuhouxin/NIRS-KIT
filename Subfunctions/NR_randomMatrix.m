function NR_randomMatrix(handles,file,inpath,outpath)
    
% NR_randomMatrix generate random Matrix
  
    wholeFileIn = fullfile(inpath,[file(1:end-4),'_adjecntMatrix',file(end-3:end)]);
    wholeFileOut = fullfile(outpath,[file(1:end-4),'_randomMatrix',file(end-3:end)]);

    NType = get(handles.networkType,'value');
    RType='1';
    RandNum = get(handles.randomTimes,'string');
    gretna_GUI_GenerateRandNet(SegMat, NType, RType, RandNum, TempDir)
end