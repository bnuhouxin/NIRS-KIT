function Matrix_ttest2paired(handles)

% dependent variable1
inpath1 = get(handles.inpath1,'string');
inpath2 = get(handles.inpath2,'string');

h_wait = waitbar(0, 'Please wait... ');
files = dir(fullfile(inpath1,'*.txt'));
depVariable1=[];
for i=1:length(files)
    Matrix=load(fullfile(inpath1,files(i).name));
    depVariable1 = [depVariable1;Matrix(:)'];
end

% dependent variable2
files = dir(fullfile(inpath2,'*.txt'));
depVariable2=[];
for i=1:length(files)
    Matrix=load(fullfile(inpath2,files(i).name));
    depVariable2 = [depVariable2;Matrix(:)'];
end

chn=size(Matrix);

depVariable = [depVariable1;depVariable2];
num_sample = size(depVariable,1);
nu_sub = num_sample/2;

regressors = [ones(nu_sub,1);-1*ones(nu_sub,1)];

subregressors = zeros(num_sample, nu_sub);
for i=1:nu_sub
    subregressors(i:nu_sub:num_sample,i) = 1;
end

regressors = [regressors,subregressors];

waitbar(1/3, h_wait, 'Running Paired T-test ... ...');

% text covariable
otherCovPath = get(handles.otherCovPath,'string');

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
statdata.p = Stat_P;

statdata.discription = 'Paired t-test';

waitbar(2/3, h_wait, 'Running Paired T-test ... ...');
%------------------------------Multiple comparison correction -------------
pStr=get(handles.pValue,'string');
pValue = str2num(pStr);
method = get(handles.method,'value');
% ========================== reshape vec2matrix ===========================
statdata.stat = reshape(statdata.stat,chn);
statdata.stat(1:size(statdata.stat,1)+1:end) = 0;
statdata.p = reshape(statdata.p,chn);

str_channels = get(handles.mask_channels,'string');                       %
mask_channels = str2num(str_channels);                                    %

if get(handles.Tex_mask,'value') && ~isempty(mask_channels)
    statdata.mask_channels = mask_channels;                               %
    n_mask_channels = length(mask_channels);                              %
    statdata.stat=statdata.stat(mask_channels,mask_channels);             %
    statdata.p=statdata.p(mask_channels,mask_channels);  
else
    statdata.mask_channels = 1:chn;
    n_mask_channels = chn(1);
end

statdata.sig = zeros(n_mask_channels);                    %---------------%
n=n_mask_channels*(n_mask_channels-1)/2;                  %---------------%
% =========================================================================   
switch method
    case 1
        eval(['statdata.None',pStr(3:end),'_PThrd = pValue']);
        statdata.sig(find(statdata.p <= pValue))=1;
        
        outfileName = ['ttest2paired_None',pStr(3:end),'.mat'];
    case 2
        eval(['statdata.FDR',pStr(3:end),'_PThrd = matrix_fdr(statdata.p,pValue)']);
        
        if ~isempty(matrix_fdr(statdata.p,pValue))
            statdata.sig(find(statdata.p <= matrix_fdr(statdata.p,pValue)))=1;
        end
        
        outfileName = ['ttest2paired_FDR',pStr(3:end),'.mat'];
    case 3
        pbrf=pValue/n;
        eval(['statdata.Bonferroni',pStr(3:end),'_PThrd = pbrf']);
        statdata.sig(find(statdata.p <= pbrf))=1;
        
        outfileName = ['ttest2paired_Bonferroni',pStr(3:end),'.mat'];
end
% =========================================================================    
   
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
