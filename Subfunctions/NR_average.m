function NR_average(handles)

inpath = get(handles.inpath,'string');   
    
h_wait = waitbar(0, 'Please wait... ');
% =========================================================================
    files = dir(fullfile(inpath,'*.mat'));
    for i = 1:length(files)
        load(fullfile(inpath,files(i).name));
        Matrix = indexdata.index;
        AllMatrix(:,:,i) = Matrix;
    end

    statdata.stat = nanmean(AllMatrix,3);
    
    statdata.probe2d = indexdata.probe2d;
    statdata.probe3d = indexdata.probe3d;
    
    if isfield(indexdata,'roiCh1')
        statdata.roiCh1 = indexdata.roiCh1;
    end
    if isfield(indexdata,'roiCh2')
        statdata.roiCh2 = indexdata.roiCh2;
    end
% =========================================================================
outfileName = 'average.mat';             
outpath = get(handles.outpath,'string');
files = dir(fullfile(outpath,'*.mat'));
    for k=1:length(files)
        if strcmp(outfileName,files(k).name)
            ifOverwrite  = questdlg('One file already exists. Overwrite?','mode seletion','Yes','No','Yes');
            if strcmp(ifOverwrite,'Yes')
                break;
            else
                return;
            end
        end
    end

% save results
warning off;mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'Average successfully done !');
pause(1);
close(h_wait);
end
