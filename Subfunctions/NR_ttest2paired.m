function NR_ttest2paired(handles)
% dependent variable1
inpath1 = get(handles.inpath1,'string');
inpath2 = get(handles.inpath2,'string');

h_wait = waitbar(0, 'Please wait... ');
files = dir(fullfile(inpath1,'*.mat'));
depVariable1=[];
for i=1:length(files)
    load(fullfile(inpath1,files(i).name));
    depVariable1 = [depVariable1;indexdata.index];
end

% dependent variable2
files = dir(fullfile(inpath2,'*.mat'));
depVariable2=[];
for i=1:length(files)
    load(fullfile(inpath2,files(i).name));
    depVariable2 = [depVariable2;indexdata.index];
end

depVariable = [depVariable1;depVariable2];
num_sample = size(depVariable,1);
nu_sub = num_sample/2;

regressors = [ones(nu_sub,1);-1*ones(nu_sub,1)];

subregressors = zeros(num_sample, nu_sub);
for i=1:nu_sub
    subregressors(i:nu_sub:num_sample,i) = 1;
end

regressors = [regressors,subregressors];

% text covariable
otherCovPath = get(handles.otherCovPath,'string');
waitbar(1/3, h_wait, 'Running Paired T test ... ...');

if ~isempty(otherCovPath)
    Covariates = load(otherCovPath);
    
    Covariates = [Covariates;zeros(size(Covariates))];
    
    regressors=[regressors,Covariates];
    
    constrast=zeros(1,size(regressors,2));
    constrast(1,1)=1;
    [Stat_T,Stat_P] =NK_Stat_Regress(depVariable,regressors,constrast,'T');
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

statdata.discription = 'Paired t-test ';
waitbar(2/3, h_wait, 'Running Paired T test ... ...');
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
        
        outfileName = ['ttest2paired_None',pStr(3:end),'.mat'];
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
        
        outfileName = ['ttest2paired_FDR',pStr(3:end),'.mat'];
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
        
        outfileName = ['ttest2paired_Bonferroni',pStr(3:end),'.mat'];
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
warning off; mkdir(outpath);

[fn,fp]=uiputfile({'*.mat','MAT-files(*.mat)'},'Results File Name',fullfile(outpath,outfileName));
if ischar(fp)
    save(fullfile(fp,fn),'statdata');
end

waitbar(1, h_wait, 'Pired T-test successfully done !');
pause(1);
close(h_wait);
end
