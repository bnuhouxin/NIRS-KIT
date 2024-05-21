function NR_correlation(handles)
inpath = get(handles.inpath,'string');

h_wait = waitbar(0, 'Please wait... ');
% covariable
files = dir(fullfile(inpath,'*.mat'));
depVariable=[];

for i=1:length(files)
    load(fullfile(inpath,files(i).name));
    depVariable = [depVariable;indexdata.index];
end

% text covariable ----------------------- .txt ----------------------------
otherCovPath = get(handles.otherCovPath,'string');
otherCovariates = [];
if ~isempty(otherCovPath)
    otherCovariates = load(otherCovPath);
end

% behavioral data ----------------------- .txt ----------------------------
inpathBehav = get(handles.listTextBehavdata,'string');
BehavData = load(inpathBehav);
N = size(depVariable,2);

% calculation -------------------------------------------------------------
for i = 1:N
    
    % =============== remove the subj with exclusive channel ==============
    dep_X = depVariable(:,i);
    
    dep_X = dep_X(find(~isnan(dep_X)),:);
    beh_D = BehavData(find(~isnan(dep_X)),:);
    % =============== remove the subj with exclusive channel ==============
    
    if isempty(otherCovariates)
        [stat p] = corrcoef(dep_X,beh_D);
    else
        cov_V = otherCovariates(find(~isnan(dep_X)),:);
        [stat p] = partialcorr([dep_X,beh_D],cov_V);
    end
    statdata.stat(i) = stat(1,2); statdata.p(i) = p(1,2);
    waitbar(i/N, h_wait, 'Running correlation analysis ... ...');
end

statdata.stat(find(isnan(statdata.stat)==1))=0;

statdata.probe2d = indexdata.probe2d;
statdata.probe3d = indexdata.probe3d;

%------------------------------Multiple comparison correction -------------
index_dir = findstr(inpath,filesep);
n = length(statdata.p);
pStr=get(handles.pValue,'string');
pValue = str2num(pStr);
method = get(handles.method,'value');

if isfield(indexdata,'roiCh1')
    statdata.roiCh1=indexdata.roiCh1;
end
if isfield(indexdata,'roiCh2')
    statdata.roiCh2=indexdata.roiCh2;
end
statdata.sig = zeros(1,n);

switch method
    case 1
        eval(['statdata.None',pStr(3:end),'_PThrd = pValue']);
        statdata.sig(find(statdata.p <= pValue))=1;
        
        outfileName = ['correlation_None',pStr(3:end),'.mat' ];
    case 2
        str_channels = get(handles.mask_channels,'string');
        mask_channels = str2num(str_channels);
        
        if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
            statdata.mask_channels=mask_channels;
            eval(['statdata.FDR',pStr(3:end),'_PThrd = FDR(statdata.p(mask_channels),pValue)']);
            if ~isempty(FDR(statdata.p(mask_channels),pValue))
                statdata.sig(mask_channels(find(statdata.p(mask_channels) <= FDR(statdata.p(mask_channels),pValue))))=1;
            end
        else
            eval(['statdata.FDR',pStr(3:end),'_PThrd = FDR(statdata.p,pValue)']);
            if ~isempty(FDR(statdata.p,pValue))
                statdata.sig(find(statdata.p <= FDR(statdata.p,pValue)))=1;
            end
        end
        
        outfileName = ['correlation_FDR',pStr(3:end),'.mat' ];
    case 3
        str_channels = get(handles.mask_channels,'string');
        mask_channels = str2num(str_channels);
        
        if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
            n_mask_channels = length(mask_channels);
            statdata.mask_channels=mask_channels;
            pbrf=pValue/n_mask_channels;
            eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
            statdata.sig(mask_channels(find(statdata.p(mask_channels) <= pbrf)))=1;
        else
            pbrf=pValue/length(statdata.p);
            eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
            statdata.sig(find(statdata.p <= pbrf))=1;
        end
        
        outfileName = ['correlation_Bonferroni',pStr(3:end),'.mat' ];
end
%------------------------------Multiple comparison correction -------------
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

waitbar(1, h_wait, 'Correlation analysis successfully done !');
pause(1);
close(h_wait);
end
