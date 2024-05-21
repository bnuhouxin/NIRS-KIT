function Matrix_average(handles)

inpath = get(handles.inpath,'string');   
    
h_wait = waitbar(0, 'Please wait... ');
% =========================================================================
files = dir(fullfile(inpath,'*.txt'));
for i=1:length(files)
    Matrix=load(fullfile(inpath,files(i).name));
    AllMatrix(:,:,i)=Matrix;
end

chn=size(Matrix);

statdata.stat=nanmean(AllMatrix,3); % =====================================

str_channels = get(handles.mask_channels,'string');                   %
mask_channels = str2num(str_channels);                                %

if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
    statdata.mask_channels = mask_channels;                               %
    statdata.stat=statdata.stat(mask_channels,mask_channels);             %
else
    statdata.mask_channels = 1:chn(1);
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
