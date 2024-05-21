function NR_ttest(handles)
inpath = get(handles.inpath,'string');

h_wait = waitbar(0, 'Please wait... ');

% dependent variable
files = dir(fullfile(inpath,'*.mat'));
depVariable=[];
for i=1:length(files)
    load(fullfile(inpath,files(i).name));
    depVariable = [depVariable;indexdata.index];
end

Base = str2num(get(handles.base,'string'));
depVariable=depVariable-Base;
regressors=ones(size(depVariable,1),1);

% text covariable
otherCovPath = get(handles.otherCovPath,'string');
waitbar(1/3, h_wait, 'Running Single T test ... ...');

if ~isempty(otherCovPath)
    Covariates = load(otherCovPath);
    if ~isempty(Covariates)
        regressors=[regressors,Covariates];
        constrast=zeros(1,size(regressors,2));
        constrast(1,1)=1;
        [Stat_T,Stat_P] =NK_Stat_Regress(depVariable,regressors,constrast,'T');
    end
else
    constrast=zeros(1,size(regressors,2));
    constrast(1,1)=1;
    [Stat_T,Stat_P] =NK_Stat_Regress(depVariable,regressors,constrast,'T');
end

statdata.stat = Stat_T;
statdata.stat(find(isnan(statdata.stat)==1))=0;
statdata.p = Stat_P;
statdata.probe2d = indexdata.probe2d;
statdata.probe3d = indexdata.probe3d;

statdata.discription = 'Single t-test';

waitbar(2/3, h_wait, 'Running Single T test ... ...');
%------------------------------Multiple comparison correction -------------
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
        
        outfileName = ['ttest_None',pStr(3:end),'.mat'];
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
        
        outfileName = ['ttest_FDR',pStr(3:end),'.mat'];
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
        
        outfileName = ['ttest_Bonferroni',pStr(3:end),'.mat'];
end

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
%------------------------------Multiple comparison correction -------------

% save results
outpath = get(handles.outpath,'string');
warning off;mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'Single T-test successfully done !');
pause(1);
close(h_wait);
end
